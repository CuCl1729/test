# バフ・デバフの「効果」の書き方を読み解いて、正規化した記録(順序付き表)にする。
# ドットソースしても何も起きない(関数を足すだけ)。数は generate.ps1 と同じく内部では×100の整数で持つ。
# 書き方:
#   stat     +atk_add=hp_max*10+atk*20+100; max=1000   /  -atk_m=20; max=50
#   function test:buff/custom/foo  /  #test:buff/custom/group
#   heal     amount=hp_max*10+100; resource=hp
#   damage   amount=atk*50; resource=hp; type=fire

# 表示の単位の数(0以上・小数第2位まで)を内部の値(×100の整数)にする
function ConvertTo-BuffNumber([string]$text, [string]$label) {
  if ($text -cnotmatch '^\d+(\.\d{1,2})?$') { throw "「$label」($text) は0以上の、小数第2位までの数にしてください" }
  if ($text.Length -gt 15) { throw "「$label」($text) が大きすぎます(内部では×100の整数で持つため $([int]::MaxValue) まで)" }
  $v = [decimal]::Parse($text, [Globalization.CultureInfo]::InvariantCulture) * 100
  if ($v -gt [int]::MaxValue) { throw "「$label」($text) が大きすぎます(内部では×100の整数で持つため $([int]::MaxValue) まで)" }
  return [int]$v
}

function Assert-BuffInt32([decimal]$value, [string]$label) {
  if ($value -gt [int]::MaxValue) { throw "「$label」の合計が大きすぎます(内部では×100の整数で持つため $([int]::MaxValue) まで)" }
  return [int]$value
}

# 「a=1; b=x」の形を {キー=値} の順序付き表にする。重複・形の誤りはその場で誤りにする
function Split-BuffOption([string]$text) {
  $map = [ordered]@{}
  foreach ($part in ($text -split ';')) {
    $p = $part.Trim()
    if ($p -eq '') { continue }
    $kv = $p -split '='
    if ($kv.Count -ne 2) { throw "「$p」は キー=値 の形で書いてください(= はちょうど1つ)" }
    $k = $kv[0].Trim(); $v = $kv[1].Trim()
    if ($k -eq '') { throw "「$p」のキーが空です" }
    if ($v -eq '') { throw "「$k」の値が空です" }
    if ($map.Contains($k)) { throw "「$k」が重複しています" }
    $map[$k] = $v
  }
  if ($map.Count -eq 0) { throw '効果が空です' }
  return $map
}

# 「hp_max*10+atk*20+100」を {terms=@({stat;percent}…); flat=…} にする。
# * の右は掛け算ではなく割合(%)。同じステータスの項は最初に出てきた順にまとめ、定数は足し合わせる
function ConvertFrom-BuffExpression([string]$text, [string[]]$stats, [string]$label) {
  $percent = [ordered]@{}
  $flat = [decimal]0
  foreach ($part in ($text -split '\+')) {
    $t = $part.Trim()
    if ($t -eq '') { throw "「$label」($text) に空の項があります" }
    $mul = $t -split '\*'
    if ($mul.Count -eq 1) {
      $flat += (ConvertTo-BuffNumber $t $label)
    }
    elseif ($mul.Count -eq 2) {
      $s = $mul[0].Trim()
      if ($stats -cnotcontains $s) { throw "「$label」の「$s」は「ステータス」にありません" }
      $p = ConvertTo-BuffNumber $mul[1].Trim() "$label の $s の割合"
      if ($percent.Contains($s)) { $percent[$s] = [decimal]$percent[$s] + $p } else { $percent[$s] = [decimal]$p }
      $null = Assert-BuffInt32 $percent[$s] "$label の $s の割合"
    }
    else { throw "「$label」の「$t」は ステータス*割合 か 数 で書いてください" }
  }
  $terms = @()
  foreach ($s in @($percent.Keys)) {
    if ($percent[$s] -ne 0) { $terms += , ([ordered]@{ stat = $s; percent = [int]$percent[$s] }) }
  }
  return [ordered]@{ terms = $terms; flat = (Assert-BuffInt32 $flat $label) }
}

function ConvertFrom-BuffStatEffect([string]$param, [string[]]$stats) {
  $opts = Split-BuffOption $param
  $keys = @($opts.Keys)
  $target = $keys[0]
  $m = [regex]::Match($target, '^([+-])\s*([a-z0-9_]+)_(add|m)$')
  if (-not $m.Success) {
    throw "「$target」は +ステータス_add / -ステータス_m のように書いてください(+ か - と、add か m が要ります)"
  }
  $sign = if ($m.Groups[1].Value -eq '+') { 1 } else { -1 }
  $stat = $m.Groups[2].Value
  $mode = $m.Groups[3].Value
  # 今のHP・MPそのものは stat では動かさない(増減は heal / damage で書く)。hp_max・mp_max は stat でよい
  if (@('hp', 'mp') -ccontains $stat) { throw "「$target」の「$stat」は stat では使えません(今のHP・MPの増減は heal / damage で書いてください)" }
  if ($stats -cnotcontains $stat) { throw "「$target」の「$stat」は「ステータス」にありません" }

  $expr = ConvertFrom-BuffExpression $opts[$target] $stats $target
  $rec = [ordered]@{ kind = 'stat'; stat = $stat; mode = $mode; sign = $sign; terms = $expr.terms; flat = $expr.flat }
  foreach ($k in @($keys | Select-Object -Skip 1)) {
    if ($k -ne 'max') { throw "「$k」は使えません(stat で使えるのは max だけです)" }
    $rec['max'] = ConvertTo-BuffNumber $opts[$k] 'max'
  }
  # 他のステータスを見ない、ただの足し算だけのとき真(ゲーム中に参照しなくてよい)
  $rec['reference_flat'] = ($mode -eq 'add' -and $expr.terms.Count -eq 0)
  return $rec
}

function ConvertFrom-BuffFunctionEffect([string]$param, [bool]$checkIds, [string[]]$functionIds, [bool]$checkTagIds, [string[]]$functionTagIds) {
  $path = $param
  $tag = $false
  if ($path.StartsWith('#')) { $tag = $true; $path = $path.Substring(1) }
  # Minecraftのidで使える字だけ(名前空間は / を含まない)。test:magic/ のような終わりが / のものもある(magic/.mcfunction)
  if ($path -cnotmatch '^[a-z0-9_.\-]+:[a-z0-9_.\-/]+$') {
    throw "「$param」は test:buff/custom/foo か #test:buff/custom/group のように書いてください(半角英小文字・数字・_ - . / だけ)"
  }
  if ($tag) {
    if ($checkTagIds -and ($functionTagIds -cnotcontains $path)) { throw "関数タグ「#$path」がありません" }
  }
  else {
    if ($checkIds -and ($functionIds -cnotcontains $path)) { throw "関数「$path」がありません" }
  }
  return [ordered]@{ kind = 'function'; path = $path; tag = $tag }
}

function ConvertFrom-BuffAmountEffect([string]$kind, [string]$param, [string[]]$stats) {
  $damage = ($kind -eq 'damage')
  $allowed = if ($damage) { @('amount', 'resource', 'type') } else { @('amount', 'resource') }
  $opts = Split-BuffOption $param
  foreach ($k in @($opts.Keys)) {
    if ($allowed -cnotcontains $k) { throw "「$k」は使えません($kind で使えるのは $($allowed -join ' / ') だけです)" }
  }
  if (-not $opts.Contains('amount')) { throw "「amount」が要ります" }
  if (-not $opts.Contains('resource')) { throw "「resource」が要ります" }
  $resource = $opts['resource']
  if (@('hp', 'mp') -cnotcontains $resource) { throw "「resource」($resource) は hp か mp にしてください" }

  $expr = ConvertFrom-BuffExpression $opts['amount'] $stats 'amount'
  $rec = [ordered]@{ kind = $kind; resource = $resource; terms = $expr.terms; flat = $expr.flat }
  if ($damage) {
    if (-not $opts.Contains('type')) { throw "damage には「type」が要ります" }
    $types = @('physics', 'fire', 'water', 'wood', 'metal', 'earth', 'true')
    if ($types -cnotcontains $opts['type']) { throw "「type」($($opts['type'])) は $($types -join ' / ') のどれかにしてください" }
    $rec['type'] = $opts['type']
  }
  return $rec
}

# 効果ひとつを正規化した記録にする。書き方が誤っていれば throw する
function ConvertFrom-BuffEffect {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)][ValidateSet('stat', 'function', 'heal', 'damage')][string]$Kind,
    [Parameter(Mandatory)][AllowEmptyString()][string]$Param,
    [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Stats,
    [string[]]$FunctionIds,
    [string[]]$FunctionTagIds
  )
  $text = $Param.Trim()
  if ($text -eq '') { throw "「$Kind」の効果が空です" }
  switch ($Kind) {
    'stat' { return ConvertFrom-BuffStatEffect $text $Stats }
    'function' {
      return ConvertFrom-BuffFunctionEffect $text `
        $PSBoundParameters.ContainsKey('FunctionIds') $FunctionIds `
        $PSBoundParameters.ContainsKey('FunctionTagIds') $FunctionTagIds
    }
    default { return ConvertFrom-BuffAmountEffect $Kind $text $Stats }
  }
}
