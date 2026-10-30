# 装備・武器の定義を、Googleスプレッドシート(またはtools/datasheet/data/*.csv)から .mcfunction に生成する。
# 使い方は tools/datasheet/README.md。
#   generate.cmd           … スプレッドシートから取得して生成する(config.json に sheet_id と各タブの gid が必要)
#   generate.cmd -Offline  … 取得せず、data/*.csv から生成する
# 検証で1つでも誤りがあれば、ファイルを1つも書き換えずに終える。

param([switch]$Offline)

$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$utf8Bom = New-Object System.Text.UTF8Encoding($true)

$toolDir = $PSScriptRoot
$repoRoot = (Resolve-Path (Join-Path $toolDir '..\..')).Path
$fnRoot = Join-Path $repoRoot 'data\test\function'
$dataDir = Join-Path $toolDir 'data'

$Header = '# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)'

# タブのキー(data/<キー>.csv、config.jsonのtabs.<キー>)と、スプレッドシート上のタブ名
$Tabs = [ordered]@{
  stats            = 'ステータス'
  materials        = '素材'
  weapons          = '武器'
  forge_recipes    = '鍛冶場レシピ'
  equipment        = '防具'
  sets             = 'シリーズ'
  set_effects      = '4部位効果'
  workshop_recipes = '防具工房レシピ'
  runes            = 'ルーン'
  consumables      = '消耗品'
  enemies          = '敵'
  enemy_gimmicks   = '敵のギミック'
  enemy_drops      = '敵のドロップ'
  jobs             = '職業'
  job_skills       = '職業スキル'
  magic_values     = '魔法の数値'
  buff_values      = 'バフの数値'
  player_base      = 'プレイヤー初期値'
  config           = '定数'
  ores             = '原石'
  mines            = '鉱山'
  veins            = '鉱脈'
  pickaxes         = 'ツルハシ'
}

# ---------------------------------------------------------------- 取得

if (-not $Offline) {
  $configPath = Join-Path $toolDir 'config.json'
  if (-not (Test-Path $configPath)) {
    Write-Host 'config.json がありません。config.example.json をコピーして config.json を作り、sheet_id と各タブの gid を書いてください(config.json はgitの管理外です)。' -ForegroundColor Red
    exit 1
  }
  $config = Get-Content $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
  if (-not $config.sheet_id) {
    Write-Host 'config.json の sheet_id が空です。スプレッドシートを用意して設定するか、-Offline を付けて data/*.csv から生成してください。' -ForegroundColor Red
    exit 1
  }
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $client = New-Object Net.WebClient
  foreach ($key in $Tabs.Keys) {
    $gid = $config.tabs.$key
    # gid が無いタブは取得を飛ばし、手元の data/<key>.csv を使う(タブを作るのを少しずつ進められるように)
    if ($null -eq $gid -or "$gid" -eq '') {
      Write-Host "タブ「$($Tabs[$key])」は config.json に gid が無いので、取得せずに data/$key.csv を使います。" -ForegroundColor Yellow
      continue
    }
    $url = "https://docs.google.com/spreadsheets/d/$($config.sheet_id)/export?format=csv&gid=$gid"
    try {
      $bytes = $client.DownloadData($url)
    } catch {
      Write-Host "タブ「$($Tabs[$key])」を取得できませんでした: $($_.Exception.Message)" -ForegroundColor Red
      Write-Host '  シートが「リンクを知っている全員が閲覧可」になっているか、sheet_id と gid が正しいか確認してください。' -ForegroundColor Red
      exit 1
    }
    $text = $utf8.GetString($bytes)
    if ($text.TrimStart().StartsWith('<')) {
      Write-Host "タブ「$($Tabs[$key])」の取得結果がCSVではありません(共有設定でログインを求められている可能性があります)。" -ForegroundColor Red
      exit 1
    }
    [IO.File]::WriteAllText((Join-Path $dataDir "$key.csv"), $text, $utf8Bom)
  }
  Write-Host 'スプレッドシートから取得しました。' -ForegroundColor Cyan
}

# ---------------------------------------------------------------- 読み込み

$Errors = New-Object System.Collections.Generic.List[string]
function Add-Err([string]$tab, [int]$row, [string]$msg) {
  if ($row -gt 0) { $script:Errors.Add("[$tab] $row 行目: $msg") } else { $script:Errors.Add("[$tab] $msg") }
}
# 警告: 表示するが、生成は止めない
$Warnings = New-Object System.Collections.Generic.List[string]
function Add-Warn([string]$tab, [int]$row, [string]$msg) {
  if ($row -gt 0) { $script:Warnings.Add("[$tab] $row 行目: $msg") } else { $script:Warnings.Add("[$tab] $msg") }
}

function Read-Tab([string]$key) {
  $path = Join-Path $dataDir "$key.csv"
  if (-not (Test-Path $path)) { Add-Err $Tabs[$key] 0 "data/$key.csv がありません"; return @() }
  $text = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
  $rows = @($text | ConvertFrom-Csv)
  $result = @()
  for ($i = 0; $i -lt $rows.Count; $i++) {
    $r = $rows[$i]
    $blank = $true
    foreach ($p in $r.PSObject.Properties) { if ("$($p.Value)".Trim() -ne '') { $blank = $false } }
    if ($blank) { continue }
    # 行番号はスプレッドシート上の行(1行目が見出し)
    $r | Add-Member -NotePropertyName __row -NotePropertyValue ($i + 2)
    $result += $r
  }
  return $result
}

function Cell($row, [string]$name) {
  $p = $row.PSObject.Properties[$name]
  if ($null -eq $p) { return '' }
  return "$($p.Value)".Trim()
}

$data = @{}
foreach ($key in $Tabs.Keys) { $data[$key] = Read-Tab $key }

# 見出しが揃っているか
$RequiredHeaders = @{
  stats            = @('種類','アイコン','名前','色','単位','抽選値','武器','成長')
  materials        = @('id','元アイテム','名前','種類','部位')
  enemies          = @('id','名前','色','HP','MP','攻撃','防御','防御係数','会心率','会心ダメージ','経験値','攻撃属性','物理耐性','火耐性','水耐性','木耐性','金耐性','土耐性','フィールドAI','防御の重み','命中時バフ','装備ドロップ')
  enemy_gimmicks   = @('敵','id','重み','HP以下','クールダウン','params')
  enemy_drops      = @('敵','素材','最小','最大')
  jobs             = @('id','名前','色','前提','経験値係数','成長')
  job_skills       = @('職業','id','名前','必要レベル','前提スキル','コスト','種類','params')
  magic_values     = @('要素','コスト','params')
  buff_values      = @('バフ','時間','最大段数','間隔','params')
  player_base      = @('ステータス','値')
  config           = @('キー','値','説明')
  weapons          = @('id','元アイテム','名前','基礎ステ','基礎ステ値','ボーナス','ボーナス値','最大レベル','ティア','射程','魔法ダメージ%','物理','火','水','木','金','土')
  forge_recipes    = @('素材','触媒','武器id')
  equipment        = @('id','元アイテム','名前','部位','シリーズ','メイン','メイン値','最大レベル','色')
  sets             = @('id','名前','2部位ボーナス')
  set_effects      = @('シリーズ','event','kind','params','説明')
  workshop_recipes = @('素材','部位','装備id')
  runes            = @('id','元アイテム','名前','能力')
  consumables      = @('id','元アイテム','名前','every','効果','params')
  ores             = @('id','名前','アイテム')
  mines            = @('id','名前','範囲','入口','リセット間隔')
  veins            = @('id','鉱石ブロック','原石','必要ランク','レア度の重み','構造物')
  pickaxes         = @('id','名前','アイテム','ランク','採掘速度')
}
foreach ($key in $Tabs.Keys) {
  $path = Join-Path $dataDir "$key.csv"
  if (-not (Test-Path $path)) { continue }
  $first = ([IO.File]::ReadAllText($path, [Text.Encoding]::UTF8).TrimStart([char]0xFEFF) -split "`r?`n")[0]
  $heads = @($first | ConvertFrom-Csv -Header (1..64) | ForEach-Object { $_.PSObject.Properties.Value } | Where-Object { $_ })
  foreach ($h in $RequiredHeaders[$key]) { if ($heads -notcontains $h) { Add-Err $Tabs[$key] 1 "見出し「$h」の列がありません" } }
}

# ---------------------------------------------------------------- 検証に使う一覧

# ステータスの種類($StatTypes)は「ステータス」タブのうち、成長があるもの(成長の表に無い種類は強化台で伸びないため)。
# 下の「ステータスの表」で作る

function Read-Fn([string]$rel) { return [IO.File]::ReadAllText((Join-Path $fnRoot $rel), [Text.Encoding]::UTF8) }
# 関数の中の $(…) の名前の一覧(必要な params を知るため)
function Macro-Args([string]$body) { return @([regex]::Matches($body, '\$\(([a-z_]+)\)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique) }

# 4部位効果のkind: equip/effect/<kind>.mcfunction があるもの。必要なparamsはその関数の $(…) から読む
$EffectParams = @{}
foreach ($f in Get-ChildItem (Join-Path $fnRoot 'equip\effect') -Filter *.mcfunction) {
  $body = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
  $EffectParams[$f.BaseName] = @([regex]::Matches($body, '\$\(([a-z_]+)\)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique)
}
# 消耗品の効果の種類: consumable/effect/<kind>.mcfunction があるもの(説明文の consumable/lore/<kind>.mcfunction も要る)。
# 必要なparamsはその関数の $(…) から読む
$ConsumableParams = @{}
$consumableEffectDir = Join-Path $fnRoot 'consumable\effect'
if (Test-Path $consumableEffectDir) {
  foreach ($f in Get-ChildItem $consumableEffectDir -Filter *.mcfunction) {
    $body = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
    $ConsumableParams[$f.BaseName] = @([regex]::Matches($body, '\$\(([a-z_]+)\)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique)
  }
}
# 割合(percent)と固定値(flat)を組み合わせる回復の効果。無い方は0で補う
$HealKinds = @('heal_hp','heal_mp')

$Events = @('magic_cast','attack_hit','damaged')
$Parts = @('head','chest','legs','feet','accessory')

$IdPattern = '^[a-z0-9_]+$'
$ItemPattern = '^([a-z0-9_.-]+:)?[a-z0-9_./-]+$'
$NumPattern = '^-?\d+(\.\d+)?$'

function Esc([string]$s) { return $s.Replace('\', '\\').Replace('"', '\"') }
function Json-Str([string]$s) { return '"' + $s.Replace('\', '\\').Replace('"', '\"') + '"' }

function Check-Id($tab, $row, $col, $value) {
  if ($value -eq '') { Add-Err $tab $row "「$col」が空です"; return $false }
  if ($value -cnotmatch $IdPattern) { Add-Err $tab $row "「$col」($value) は半角英小文字・数字・_ だけで書いてください"; return $false }
  return $true
}
function Check-Num($tab, $row, $col, $value, [bool]$required) {
  if ($value -eq '') { if ($required) { Add-Err $tab $row "「$col」が空です" }; return }
  if ($value -notmatch $NumPattern) { Add-Err $tab $row "「$col」($value) が数値ではありません" }
}
function Check-Stat($tab, $row, $col, $value) {
  if ($value -eq '') { Add-Err $tab $row "「$col」が空です"; return }
  if ($StatTypes -notcontains $value) { Add-Err $tab $row "「$col」の $value は「ステータス」タブに成長のあるステータスとしてありません" }
}

# 「a=1; b=x」の形を {キー=値} の順序付き表にする
function Parse-Pairs($tab, $row, $col, [string]$text, [string]$sep) {
  $map = [ordered]@{}
  if ($text -eq '') { return $map }
  foreach ($part in ($text -split $sep)) {
    $p = $part.Trim()
    if ($p -eq '') { continue }
    $kv = $p -split '=', 2
    if ($kv.Count -ne 2 -or $kv[0].Trim() -eq '') { Add-Err $tab $row "「$col」の「$p」は キー=値 の形で書いてください"; continue }
    $map[$kv[0].Trim()] = $kv[1].Trim()
  }
  return $map
}
function Snbt-Value([string]$v) { if ($v -match $NumPattern) { return $v } else { return "`"$(Esc $v)`"" } }

# 表示の単位(装備の説明文と同じ)の値を、内部の値(×100の整数)にする。整数にならなければ誤り
function To-Internal($tab, $row, $col, [string]$value) {
  if ($value -notmatch $NumPattern) { Add-Err $tab $row "「$col」($value) が数値ではありません"; return '0' }
  $d = [decimal]::Parse($value, [Globalization.CultureInfo]::InvariantCulture) * 100
  if ($d -ne [decimal]::Truncate($d)) { Add-Err $tab $row "「$col」($value) は小数第2位までにしてください(内部では×100の整数で持つため)"; return '0' }
  return ([long]$d).ToString()
}
function Check-Int($tab, $row, $col, [string]$value, [int]$min) {
  if ($value -notmatch '^-?\d+$' -or [long]$value -lt $min) { Add-Err $tab $row "「$col」($value) は$min 以上の整数にしてください"; return $false }
  return $true
}
# ---------------------------------------------------------------- ステータスの表(サブステータスの抽選・成長・説明文の表示)

$StatTypes = @()
$substatWeapon = New-Object System.Collections.Generic.List[string]
$substatArmor = New-Object System.Collections.Generic.List[string]
$statDisplay = New-Object System.Collections.Generic.List[string]
$statGrow = New-Object System.Collections.Generic.List[string]
$statSeen = @{}
foreach ($r in $data.stats) {
  $tab = $Tabs.stats; $n = $r.__row
  $t = Cell $r '種類'
  if ($t -cnotmatch '^[a-z_]+$') { Add-Err $tab $n "「種類」($t) は半角英小文字と _ で書いてください(例: atk_add)"; continue }
  if ($statSeen.ContainsKey($t)) { Add-Err $tab $n "種類「$t」が重複しています"; continue }
  $statSeen[$t] = $true
  $icon = Cell $r 'アイコン'; $label = Cell $r '名前'; $color = Cell $r '色'; $unit = Cell $r '単位'
  if ($icon -eq '' -or $label -eq '' -or $color -eq '') { Add-Err $tab $n '「アイコン」「名前」「色」は空にできません' }
  $statDisplay.Add("{type:`"$t`",icon:`"$(Esc $icon)`",label:`"$(Esc $label)`",color:`"$color`",unit:`"$(Esc $unit)`"}")

  $roll = Cell $r '抽選値'; $weapon = Cell $r '武器'; $grow = Cell $r '成長'
  if ($weapon -ne '' -and $weapon -ne '1') { Add-Err $tab $n "「武器」($weapon) は 1 か空にしてください(1 なら武器でも抽選に出る)" }
  if ($roll -ne '') {
    Check-Num $tab $n '抽選値' $roll $true
    $entry = "{type:`"$t`",value:$($roll)d}"
    if ($weapon -eq '1') { $substatWeapon.Add($entry) } else { $substatArmor.Add($entry) }
  } elseif ($weapon -eq '1') { Add-Err $tab $n '「武器」が 1 なのに「抽選値」が空です' }
  if ($grow -ne '') {
    Check-Num $tab $n '成長' $grow $true
    $statGrow.Add("{type:`"$t`",value:$($grow)d}")
    $StatTypes += $t
  }
}
if ($substatWeapon.Count -eq 0) { Add-Err $Tabs.stats 0 '武器でも抽選に出るステータス(「武器」が 1)が1つもありません' }

# ---------------------------------------------------------------- 素材(鍛冶場・工房の材料、触媒、特殊素材、型紙)

$MaterialRoles = [ordered]@{ '素材' = 'material'; '触媒' = 'catalyst'; '特殊' = 'special'; '型紙' = 'pattern' }
$materials = [ordered]@{}
$materialDecls = New-Object System.Collections.Generic.List[string]
$forgeCraftBody = Read-Fn 'craft\weapon\forge\craft.mcfunction'
foreach ($r in $data.materials) {
  $tab = $Tabs.materials; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($materials.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $item = Cell $r '元アイテム'; $name = Cell $r '名前'; $roleJa = Cell $r '種類'; $part = Cell $r '部位'
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「元アイテム」($item) がアイテムidの形ではありません" }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  if (-not $MaterialRoles.Contains($roleJa)) { Add-Err $tab $n "「種類」($roleJa) は $(@($MaterialRoles.Keys) -join ' / ') のどれかにしてください"; continue }
  $role = $MaterialRoles[$roleJa]
  if ($role -eq 'pattern') {
    if ($Parts -notcontains $part) { Add-Err $tab $n "型紙の「部位」($part) は $($Parts -join ' / ') のどれかにしてください" }
    $snbt = "pattern:{part:`"$part`"}"
  } else {
    if ($part -ne '') { Add-Err $tab $n '「部位」は型紙のときだけ書いてください' }
    $snbt = "material:{kind:`"$id`"}"
  }
  # 特殊素材の効果はコードにある(鍛冶場が kind で探し、asset/weapon/ が効果を付ける)
  if ($role -eq 'special' -and $forgeCraftBody -notmatch "kind:`"$id`"") { Add-Err $tab $n "特殊素材「$id」の効果がコード(craft/weapon/forge/craft)にありません" }
  $materials[$id] = @{ role = $role; item = $item; name = $name }
  $materialDecls.Add("data modify storage test: asset.material.$id set value {item:`"$item`",name:`"$(Esc $name)`",role:`"$role`",data:{$snbt}}")
  $materialDecls.Add("data modify storage test: asset.material_ids append value `"$id`"")
}

# ---------------------------------------------------------------- 武器

$weaponIds = @{}
$weaponDecls = New-Object System.Collections.Generic.List[string]
$DamageCols = [ordered]@{ '物理'='physics'; '火'='fire'; '水'='water'; '木'='wood'; '金'='metal'; '土'='earth' }
$DamageKeys = @('atk','hp_max','def','base')

foreach ($r in $data.weapons) {
  $tab = $Tabs.weapons; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($weaponIds.ContainsKey($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $weaponIds[$id] = $true

  $item = Cell $r '元アイテム'; $name = Cell $r '名前'
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「元アイテム」($item) がアイテムidの形ではありません" }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }

  $cd = New-Object System.Collections.Generic.List[string]
  foreach ($pair in @(@('ボーナス','ボーナス値','status_bonus'), @('基礎ステ','基礎ステ値','base_status'))) {
    $t = Cell $r $pair[0]; $v = Cell $r $pair[1]
    if ($t -eq '' -and $v -eq '') { continue }
    Check-Stat $tab $n $pair[0] $t; Check-Num $tab $n $pair[1] $v $true
    $cd.Add("$($pair[2]):{type:`"$t`",value:$v}")
  }
  $maxLevel = Cell $r '最大レベル'; Check-Num $tab $n '最大レベル' $maxLevel $true
  $cd.Add("level:0,max_level:$maxLevel")
  $tier = Cell $r 'ティア'; Check-Num $tab $n 'ティア' $tier $false
  if ($tier -ne '') { $cd.Add("tier:$tier") }
  $reach = Cell $r '射程'; Check-Num $tab $n '射程' $reach $false
  if ($reach -ne '') { $cd.Add("weapon:[{type:`"reach`",value:$reach}]") }
  $mdb = Cell $r '魔法ダメージ%'; Check-Num $tab $n '魔法ダメージ%' $mdb $false
  if ($mdb -ne '') { $cd.Add("magic_damage_bonus:$mdb") }

  $dmg = New-Object System.Collections.Generic.List[string]
  foreach ($col in $DamageCols.Keys) {
    $spec = Parse-Pairs $tab $n $col (Cell $r $col) ','
    if ($spec.Count -eq 0) { continue }
    $terms = New-Object System.Collections.Generic.List[string]
    foreach ($k in $spec.Keys) {
      if ($DamageKeys -notcontains $k) { Add-Err $tab $n "「$col」の $k は使えません(atk / hp_max / def / base)"; continue }
      Check-Num $tab $n $col $spec[$k] $true
      $terms.Add("$($k):$($spec[$k])")
    }
    $dmg.Add("$($DamageCols[$col]):{$($terms -join ',')}")
  }
  if ($dmg.Count -gt 0) { $cd.Add("damage:{$($dmg -join ',')}") }

  $nameSnbt = "[{italic:0b,text:`"$(Esc $name) `"},{color:gray,text:`"Level`"},{color:aqua,text:`"0`"}]"
  $weaponDecls.Add("data modify storage test: asset.$id set value {item:`"$item`",components:{`"minecraft:custom_name`":$nameSnbt,`"minecraft:custom_data`":{$($cd -join ',')}}}")
}

# 鍛冶場レシピ: 素材ごとに1ファイル
$forgeByMaterial = [ordered]@{}
foreach ($r in $data.forge_recipes) {
  $tab = $Tabs.forge_recipes; $n = $r.__row
  $mat = Cell $r '素材'; $cat = Cell $r '触媒'; $wid = Cell $r '武器id'
  if (-not (Check-Id $tab $n '素材' $mat)) { continue }
  if (-not (Check-Id $tab $n '触媒' $cat)) { continue }
  if (-not $materials.Contains($mat) -or $materials[$mat].role -ne 'material') { Add-Err $tab $n "素材「$mat」が「素材」タブに種類「素材」としてありません"; continue }
  if ($cat -ne 'none' -and (-not $materials.Contains($cat) -or $materials[$cat].role -ne 'catalyst')) { Add-Err $tab $n "触媒「$cat」が「素材」タブに種類「触媒」としてありません(触媒なしは none)"; continue }
  if (-not $weaponIds.ContainsKey($wid)) { Add-Err $tab $n "武器id「$wid」が「武器」タブにありません"; continue }
  if (-not $forgeByMaterial.Contains($mat)) { $forgeByMaterial[$mat] = [ordered]@{} }
  if ($forgeByMaterial[$mat].Contains($cat)) { Add-Err $tab $n "素材 $mat × 触媒 $cat の組み合わせが重複しています"; continue }
  $forgeByMaterial[$mat][$cat] = $wid
}

# ---------------------------------------------------------------- シリーズ・4部位効果

$setIds = [ordered]@{}
foreach ($r in $data.sets) {
  $tab = $Tabs.sets; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($setIds.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $label = Cell $r '名前'
  if ($label -eq '') { Add-Err $tab $n '「名前」が空です' }
  $bonus = Parse-Pairs $tab $n '2部位ボーナス' (Cell $r '2部位ボーナス') ';'
  $b2 = New-Object System.Collections.Generic.List[string]
  foreach ($k in $bonus.Keys) {
    if ($StatTypes -notcontains $k) { Add-Err $tab $n "「2部位ボーナス」の $k は「ステータス」タブに成長のあるステータスとしてありません" }
    Check-Num $tab $n '2部位ボーナス' $bonus[$k] $true
    $b2.Add("{type:`"$k`",value:$($bonus[$k])}")
  }
  $setIds[$id] = @{ label = $label; bonus2 = $b2; bonus4 = (New-Object System.Collections.Generic.List[string]) }
}

foreach ($r in $data.set_effects) {
  $tab = $Tabs.set_effects; $n = $r.__row
  $sid = Cell $r 'シリーズ'; $event = Cell $r 'event'; $kind = Cell $r 'kind'; $desc = Cell $r '説明'
  if (-not $setIds.Contains($sid)) { Add-Err $tab $n "シリーズ「$sid」が「シリーズ」タブにありません"; continue }
  if ($Events -notcontains $event) { Add-Err $tab $n "event「$event」は $($Events -join ' / ') のどれかにしてください"; continue }
  if (-not $EffectParams.ContainsKey($kind)) { Add-Err $tab $n "kind「$kind」の関数 equip/effect/$kind.mcfunction がありません(今あるもの: $(@($EffectParams.Keys) -join ' / '))"; continue }
  if ($desc -eq '') { Add-Err $tab $n '「説明」が空です(説明文に出す文)' }
  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  foreach ($need in $EffectParams[$kind]) { if (-not $params.Contains($need)) { Add-Err $tab $n "kind「$kind」には params の $need が必要です" } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(Snbt-Value $params[$_])" }) -join ','
  $setIds[$sid].bonus4.Add("{event:`"$event`",kind:`"$kind`",params:{$ps},desc:`"$(Esc $desc)`"}")
}

# ---------------------------------------------------------------- 防具・アクセサリー

$equipIds = @{}
$equipDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.equipment) {
  $tab = $Tabs.equipment; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($equipIds.ContainsKey($id) -or $weaponIds.ContainsKey($id)) { Add-Err $tab $n "id「$id」が重複しています(武器のidとも重ねられません)"; continue }
  $equipIds[$id] = $true

  $item = Cell $r '元アイテム'; $name = Cell $r '名前'; $part = Cell $r '部位'; $sid = Cell $r 'シリーズ'
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「元アイテム」($item) がアイテムidの形ではありません" }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  if ($Parts -notcontains $part) { Add-Err $tab $n "「部位」($part) は $($Parts -join ' / ') のどれかにしてください" }
  if ($sid -ne '' -and -not $setIds.Contains($sid)) { Add-Err $tab $n "シリーズ「$sid」が「シリーズ」タブにありません" }
  $mt = Cell $r 'メイン'; $mv = Cell $r 'メイン値'
  Check-Stat $tab $n 'メイン' $mt; Check-Num $tab $n 'メイン値' $mv $true
  $maxLevel = Cell $r '最大レベル'; Check-Num $tab $n '最大レベル' $maxLevel $true

  $equip = "slot:`"$part`""
  if ($sid -ne '') { $equip += ",set:`"$sid`"" }
  $comps = New-Object System.Collections.Generic.List[string]
  $comps.Add("`"minecraft:custom_name`":[{italic:0b,text:`"$(Esc $name) `"},{color:gray,text:`"Level`"},{color:aqua,text:`"0`"}]")
  $color = Cell $r '色'
  if ($color -ne '') {
    if ($color -notmatch '^#[0-9a-fA-F]{6}$') { Add-Err $tab $n "「色」($color) は #RRGGBB の形で書いてください" }
    else { $comps.Add("`"minecraft:dyed_color`":$([Convert]::ToInt32($color.Substring(1), 16))") }
  }
  # 防具はバニラの防具点を消す(防御はこのパックのステータスで扱うため)
  if ($part -ne 'accessory') { $comps.Add('"minecraft:attribute_modifiers":[]') }
  $comps.Add("`"minecraft:custom_data`":{equip:{$equip},status_bonus:{type:`"$mt`",value:$mv},level:0,max_level:$maxLevel}")
  $equipDecls.Add("data modify storage test: asset.equip.items.$id set value {item:`"$item`",components:{$($comps -join ',')}}")
}

# 防具工房レシピ: 素材ごとに1ファイル
$workshopByMaterial = [ordered]@{}
foreach ($r in $data.workshop_recipes) {
  $tab = $Tabs.workshop_recipes; $n = $r.__row
  $mat = Cell $r '素材'; $part = Cell $r '部位'; $eid = Cell $r '装備id'
  if (-not (Check-Id $tab $n '素材' $mat)) { continue }
  if (-not $materials.Contains($mat) -or $materials[$mat].role -ne 'material') { Add-Err $tab $n "素材「$mat」が「素材」タブに種類「素材」としてありません"; continue }
  if ($Parts -notcontains $part) { Add-Err $tab $n "「部位」($part) は $($Parts -join ' / ') のどれかにしてください"; continue }
  if (-not $equipIds.ContainsKey($eid)) { Add-Err $tab $n "装備id「$eid」が「防具」タブにありません"; continue }
  if (-not $workshopByMaterial.Contains($mat)) { $workshopByMaterial[$mat] = [ordered]@{} }
  if ($workshopByMaterial[$mat].Contains($part)) { Add-Err $tab $n "素材 $mat × 部位 $part の組み合わせが重複しています"; continue }
  $workshopByMaterial[$mat][$part] = $eid
}

# ---------------------------------------------------------------- ルーン(付与台で装備の自動発動の枠に入れ、常に能力を上げる)

$runeIds = @{}
$runeDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.runes) {
  $tab = $Tabs.runes; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($runeIds.ContainsKey($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $runeIds[$id] = $true

  $item = Cell $r '元アイテム'; $name = Cell $r '名前'
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「元アイテム」($item) がアイテムidの形ではありません" }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }

  $stats = Parse-Pairs $tab $n '能力' (Cell $r '能力') ';'
  if ($stats.Count -eq 0) { Add-Err $tab $n '「能力」が空です(例: atk_m=5; def_add=20)' }
  $parts = @()
  foreach ($k in $stats.Keys) {
    Check-Stat $tab $n '能力' $k
    Check-Num $tab $n '能力' $stats[$k] $true
    $parts += "{type:`"$k`",value:$($stats[$k])}"
  }
  $runeDecls.Add("data modify storage test: asset.rune.$id set value {item:`"$item`",name:`"$(Esc $name)`",status:[$($parts -join ',')]}")
  $runeDecls.Add("data modify storage test: asset.rune_ids append value `"$id`"")
}

# ---------------------------------------------------------------- 消耗品(付与台で装備の自動発動の枠に設定し、イベント every 回ごとに1個自動で使う)

$consumableIds = @{}
$consumableDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.consumables) {
  $tab = $Tabs.consumables; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($consumableIds.ContainsKey($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $consumableIds[$id] = $true

  $item = Cell $r '元アイテム'; $name = Cell $r '名前'; $every = Cell $r 'every'; $kind = Cell $r '効果'
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「元アイテム」($item) がアイテムidの形ではありません" }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  if ($every -notmatch '^\d+$' -or [int]$every -lt 1) { Add-Err $tab $n "「every」($every) は1以上の整数にしてください(イベントが何回起きるごとに1個使うか)" }

  if (-not $ConsumableParams.ContainsKey($kind)) { Add-Err $tab $n "効果「$kind」の関数 consumable/effect/$kind.mcfunction がありません(今あるもの: $(@($ConsumableParams.Keys) -join ' / '))"; continue }
  if (-not (Test-Path (Join-Path $fnRoot "consumable\lore\$kind.mcfunction"))) { Add-Err $tab $n "効果「$kind」の説明文の関数 consumable/lore/$kind.mcfunction がありません"; continue }

  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  if ($HealKinds -contains $kind) {
    foreach ($k in @('percent','flat')) {
      if (-not $params.Contains($k)) { $params[$k] = '0' }
      if ($params[$k] -notmatch '^\d+$') { Add-Err $tab $n "効果「$kind」の params の $k ($($params[$k])) は0以上の整数にしてください" }
    }
    if ($params['percent'] -match '^\d+$' -and $params['flat'] -match '^\d+$' -and ([int]$params['percent'] + [int]$params['flat']) -lt 1) {
      Add-Err $tab $n "効果「$kind」の params は percent(最大値の何%)か flat(固定値)のどちらかを1以上にしてください"
    }
  }
  # 蘇生: 倒れた味方のHPを最大値の percent% で戻す
  if ($kind -eq 'revive' -and $params.Contains('percent') -and ($params['percent'] -notmatch '^\d+$' -or [int]$params['percent'] -lt 1 -or [int]$params['percent'] -gt 100)) {
    Add-Err $tab $n "効果「revive」の params の percent ($($params['percent'])) は1〜100の整数にしてください"
  }
  foreach ($need in $ConsumableParams[$kind]) { if (-not $params.Contains($need)) { Add-Err $tab $n "効果「$kind」には params の $need が必要です" } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(Snbt-Value $params[$_])" }) -join ','

  $consumableDecls.Add("data modify storage test: asset.consumable.$id set value {item:`"$item`",name:`"$(Esc $name)`",every:$every,effect:{kind:`"$kind`",params:{$ps}}}")
  $consumableDecls.Add("data modify storage test: asset.consumable_ids append value `"$id`"")
}

# ---------------------------------------------------------------- 敵(ステータス・耐性・命中時バフ・装備ドロップ・ギミック・素材のドロップ)

$buffsBody = Read-Fn 'init\asset\buff\buffs.mcfunction'
$BuffIds = @([regex]::Matches($buffsBody, 'asset\.buff\.types append value \{id:"([a-z_]+)"') | ForEach-Object { $_.Groups[1].Value })
# ギミック: battle/enemy_ai/gimmick/<id>.mcfunction があるもの(サブフォルダは補助の関数なので数えない)。
# 必要な params はその関数の $(…) から読む
$GimmickParams = @{}
foreach ($f in Get-ChildItem (Join-Path $fnRoot 'battle\enemy_ai\gimmick') -Filter *.mcfunction) { $GimmickParams[$f.BaseName] = Macro-Args ([IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)) }
# ギミックの params のうち、値を確かめるもの
$ElementIds = @($DamageCols.Values)
$GimmickTargets = @('one','all')
# 表示の単位で書き、×100して内部の値にする列
$EnemyStatCols = [ordered]@{ 'HP' = 'hp'; 'MP' = 'mp'; '攻撃' = 'atk'; '防御' = 'def'; '防御係数' = 'coef'; '会心率' = 'crit_rate'; '会心ダメージ' = 'crit_damage' }
$ResistCols = [ordered]@{ '物理耐性' = 'physics'; '火耐性' = 'fire'; '水耐性' = 'water'; '木耐性' = 'wood'; '金耐性' = 'metal'; '土耐性' = 'earth' }

$enemies = [ordered]@{}
foreach ($r in $data.enemies) {
  $tab = $Tabs.enemies; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($enemies.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $e = @{ name = (Cell $r '名前'); color = (Cell $r '色'); gimmicks = (New-Object System.Collections.Generic.List[string]); drops = (New-Object System.Collections.Generic.List[object]) }

  $stats = New-Object System.Collections.Generic.List[string]
  foreach ($col in $EnemyStatCols.Keys) {
    $v = Cell $r $col
    if ($v -eq '') { if ($col -eq 'HP') { Add-Err $tab $n '「HP」が空です'; continue }; $v = '0' }
    $stats.Add("$($EnemyStatCols[$col]):$(To-Internal $tab $n $col $v)")
  }
  $exp = Cell $r '経験値'; if ($exp -eq '') { $exp = '0' }
  if (Check-Int $tab $n '経験値' $exp 0) { $stats.Add("exp:$exp") }
  $e.stats = $stats -join ','

  # 攻撃属性: 物理/火/水/木/金/土(空なら物理)
  $el = Cell $r '攻撃属性'; if ($el -eq '') { $el = '物理' }
  if (-not $DamageCols.Contains($el)) { Add-Err $tab $n "「攻撃属性」($el) は $(@($DamageCols.Keys) -join ' / ') のどれかにしてください"; $el = '物理' }
  $e.element = $DamageCols[$el]

  $resist = New-Object System.Collections.Generic.List[string]
  foreach ($col in $ResistCols.Keys) {
    $v = Cell $r $col; if ($v -eq '') { $v = '0' }
    if (Check-Int $tab $n $col $v -1000) { $resist.Add("$($ResistCols[$col]):$v") }
  }
  $e.resist = $resist -join ','

  $field = Cell $r 'フィールドAI'
  if ($field -ne '' -and $field -ne '1') { Add-Err $tab $n "「フィールドAI」($field) は 1 か空にしてください" }
  $e.field = ($field -eq '1')
  $e.defend = Cell $r '防御の重み'
  if ($e.defend -ne '') { [void](Check-Int $tab $n '防御の重み' $e.defend 0) }

  # 命中時バフ: 「バフのid 段数 確率%; …」(確率は省くと必ず)
  $buffs = New-Object System.Collections.Generic.List[string]
  foreach ($part in ((Cell $r '命中時バフ') -split ';')) {
    $p = $part.Trim(); if ($p -eq '') { continue }
    $tk = @($p -split '\s+')
    if ($tk.Count -lt 2 -or $tk.Count -gt 3) { Add-Err $tab $n "「命中時バフ」の「$p」は「バフのid 段数 確率%」の形で書いてください(例: poison 1 50)"; continue }
    if ($BuffIds -notcontains $tk[0]) { Add-Err $tab $n "「命中時バフ」のバフ「$($tk[0])」が init/asset/buff/buffs にありません"; continue }
    if (-not (Check-Int $tab $n '命中時バフの段数' $tk[1] 1)) { continue }
    $b = "{id:`"$($tk[0])`",stacks:$($tk[1])"
    if ($tk.Count -eq 3) { if (-not (Check-Int $tab $n '命中時バフの確率' $tk[2] 1)) { continue }; $b += ",chance:$($tk[2])" }
    $buffs.Add("$b}")
  }
  $e.buffs = $buffs -join ','

  # 装備ドロップ: 「装備のid=確率%; …」
  $edrops = New-Object System.Collections.Generic.List[string]
  $ed = Parse-Pairs $tab $n '装備ドロップ' (Cell $r '装備ドロップ') ';'
  foreach ($k in $ed.Keys) {
    if (-not $equipIds.ContainsKey($k)) { Add-Err $tab $n "「装備ドロップ」の装備「$k」が「防具」タブにありません"; continue }
    Check-Num $tab $n '装備ドロップ' $ed[$k] $true
    $edrops.Add("{id:`"$k`",chance:$($ed[$k])}")
  }
  $e.edrops = $edrops -join ','
  $enemies[$id] = $e
}

foreach ($r in $data.enemy_gimmicks) {
  $tab = $Tabs.enemy_gimmicks; $n = $r.__row
  $eid = Cell $r '敵'; $gid = Cell $r 'id'
  if (-not $enemies.Contains($eid)) { Add-Err $tab $n "敵「$eid」が「敵」タブにありません"; continue }
  if (-not $GimmickParams.ContainsKey($gid)) { Add-Err $tab $n "ギミック「$gid」の関数 battle/enemy_ai/gimmick/$gid.mcfunction がありません(今あるもの: $(@($GimmickParams.Keys) -join ' / '))"; continue }
  $w = Cell $r '重み'; $hb = Cell $r 'HP以下'; $cd = Cell $r 'クールダウン'
  if ($hb -eq '') { $hb = '100' }
  if (-not (Check-Int $tab $n '重み' $w 1)) { continue }
  if (-not (Check-Int $tab $n 'HP以下' $hb 0)) { continue }

  # params: 「キー=値; …」。ギミックの関数の $(…) がすべて要る。値はそのまま(内部の値)
  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  foreach ($need in $GimmickParams[$gid]) { if (-not $params.Contains($need)) { Add-Err $tab $n "ギミック「$gid」には params の $need が必要です" } }
  if ($params.Contains('buff') -and $BuffIds -notcontains $params['buff']) { Add-Err $tab $n "params の buff「$($params['buff'])」が init/asset/buff/buffs にありません" }
  if ($params.Contains('element') -and $ElementIds -notcontains $params['element']) { Add-Err $tab $n "params の element「$($params['element'])」は $($ElementIds -join ' / ') のどれかにしてください" }
  if ($params.Contains('target') -and $GimmickTargets -notcontains $params['target']) { Add-Err $tab $n "params の target「$($params['target'])」は $($GimmickTargets -join ' / ') のどちらかにしてください" }
  foreach ($k in @('stacks','power','percent','chance')) { if ($params.Contains($k)) { [void](Check-Int $tab $n "params の $k" $params[$k] 1) } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(Snbt-Value $params[$_])" }) -join ','

  $g = "{id:`"$gid`",weight:$w,hp_below:$hb"
  if ($cd -ne '') { if (-not (Check-Int $tab $n 'クールダウン' $cd 0)) { continue }; $g += ",cooldown:$cd" }
  $g += ",params:{$ps}"
  $enemies[$eid].gimmicks.Add("$g}")
}

foreach ($r in $data.enemy_drops) {
  $tab = $Tabs.enemy_drops; $n = $r.__row
  $eid = Cell $r '敵'; $mat = Cell $r '素材'; $min = Cell $r '最小'; $max = Cell $r '最大'
  if (-not $enemies.Contains($eid)) { Add-Err $tab $n "敵「$eid」が「敵」タブにありません"; continue }
  if (-not $materials.Contains($mat)) { Add-Err $tab $n "素材「$mat」が「素材」タブにありません"; continue }
  if (-not (Check-Int $tab $n '最小' $min 0)) { continue }
  if (-not (Check-Int $tab $n '最大' $max 1)) { continue }
  if ([int]$min -gt [int]$max) { Add-Err $tab $n "「最小」($min) が「最大」($max) より大きいです"; continue }
  $enemies[$eid].drops.Add(@{ mat = $mat; min = $min; max = $max })
}

$enemyDecls = New-Object System.Collections.Generic.List[string]
foreach ($id in $enemies.Keys) {
  $e = $enemies[$id]
  $parts = New-Object System.Collections.Generic.List[string]
  if ($e.name -ne '') {
    $nm = "name:{text:`"$(Esc $e.name)`""
    if ($e.color -ne '') { $nm += ",color:`"$($e.color)`"" }
    $parts.Add("$nm}")
  }
  $parts.Add("stats:{$($e.stats)}")
  $parts.Add("resist:{$($e.resist)}")
  $dp = New-Object System.Collections.Generic.List[string]
  $dp.Add("attack_element:`"$($e.element)`"")
  if ($e.buffs -ne '') { $dp.Add("buff_on_hit:[$($e.buffs)]") }
  # 素材のドロップ: 1行が1回の抽選(test:battle/grant_reward が rng/roll で最小〜最大個を決める)。
  # ルートテーブルは使わない(抽選を rng/roll に通すため)
  $mdrops = New-Object System.Collections.Generic.List[string]
  foreach ($d in $e.drops) { $mdrops.Add("{id:`"$($d.mat)`",min:$($d.min),max:$($d.max)}") }
  if ($mdrops.Count -gt 0) { $dp.Add("material_drops:[$($mdrops -join ',')]") }
  if ($e.edrops -ne '') { $dp.Add("equip_drops:[$($e.edrops)]") }
  if ($e.field) { $dp.Add('ai_field_enabled:1b') }
  $ai = New-Object System.Collections.Generic.List[string]
  if ($e.gimmicks.Count -gt 0) { $ai.Add("gimmicks:[$($e.gimmicks -join ',')]") }
  if ($e.defend -ne '') { $ai.Add("defend_weight:$($e.defend)") }
  if ($ai.Count -gt 0) { $dp.Add("ai:{$($ai -join ',')}") }
  $parts.Add("data:{$($dp -join ',')}")
  $enemyDecls.Add("data modify storage test: asset.enemy.$id set value {$($parts -join ',')}")
  $enemyDecls.Add("data modify storage test: asset.enemy_ids append value `"$id`"")
}

# ---------------------------------------------------------------- 職業(前提・経験値・成長)と職業スキル

$JobStats = @([regex]::Matches((Read-Fn 'init\scoreboard.mcfunction'), 'test\.job_bonus\.([a-z_]+) dummy') | ForEach-Object { $_.Groups[1].Value })
$SkillParams = @{}
foreach ($f in Get-ChildItem (Join-Path $fnRoot 'job\skill\handler') -Filter *.mcfunction) { $SkillParams[$f.BaseName] = Macro-Args ([IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)) }

$jobs = [ordered]@{}
foreach ($r in $data.jobs) {
  $tab = $Tabs.jobs; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($jobs.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $label = Cell $r '名前'; $color = Cell $r '色'; $coef = Cell $r '経験値係数'
  if ($label -eq '' -or $color -eq '') { Add-Err $tab $n '「名前」「色」は空にできません' }
  # 経験値係数が0だと必要経験値が0になり、レベルアップが止まらなくなる
  [void](Check-Int $tab $n '経験値係数' $coef 1)
  $growth = New-Object System.Collections.Generic.List[string]
  $gp = Parse-Pairs $tab $n '成長' (Cell $r '成長') ';'
  foreach ($k in $gp.Keys) {
    if ($JobStats -notcontains $k) { Add-Err $tab $n "「成長」の $k は職業で伸ばせるステータスではありません(使えるもの: $($JobStats -join ' / '))"; continue }
    $growth.Add("{stat:`"$k`",per_level:$(To-Internal $tab $n '成長' $gp[$k])}")
  }
  $jobs[$id] = @{ row = $n; label = $label; color = $color; coef = $coef; growth = ($growth -join ','); requires = (Parse-Pairs $tab $n '前提' (Cell $r '前提') ';'); skills = [ordered]@{} }
}
foreach ($jid in $jobs.Keys) {
  foreach ($k in $jobs[$jid].requires.Keys) {
    if (-not $jobs.Contains($k)) { Add-Err $Tabs.jobs $jobs[$jid].row "「前提」の職業「$k」が「職業」タブにありません" }
    [void](Check-Int $Tabs.jobs $jobs[$jid].row '前提のレベル' $jobs[$jid].requires[$k] 1)
  }
}
foreach ($r in $data.job_skills) {
  $tab = $Tabs.job_skills; $n = $r.__row
  $jid = Cell $r '職業'; $id = Cell $r 'id'
  if (-not $jobs.Contains($jid)) { Add-Err $tab $n "職業「$jid」が「職業」タブにありません"; continue }
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($jobs[$jid].skills.Contains($id)) { Add-Err $tab $n "職業「$jid」のスキル「$id」が重複しています"; continue }
  $label = Cell $r '名前'; $lv = Cell $r '必要レベル'; $cost = Cell $r 'コスト'; $kind = Cell $r '種類'
  if ($label -eq '') { Add-Err $tab $n '「名前」が空です' }
  [void](Check-Int $tab $n '必要レベル' $lv 1)
  [void](Check-Int $tab $n 'コスト' $cost 0)
  if (-not $SkillParams.ContainsKey($kind)) { Add-Err $tab $n "種類「$kind」の関数 job/skill/handler/$kind.mcfunction がありません(今あるもの: $(@($SkillParams.Keys) -join ' / '))"; continue }
  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  foreach ($need in $SkillParams[$kind]) { if (-not $params.Contains($need)) { Add-Err $tab $n "種類「$kind」には params の $need が必要です" } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(Snbt-Value $params[$_])" }) -join ','
  $reqs = @(((Cell $r '前提スキル') -split ';') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' })
  $jobs[$jid].skills[$id] = @{ row = $n; reqs = $reqs; snbt = "label:`"$(Esc $label)`",requires_level:$lv,requires_nodes:[REQS],cost:$cost,kind:`"$kind`",params:{$ps}" }
}
$jobDecls = New-Object System.Collections.Generic.List[string]
# 職業・スキルの数に上限は無い(Jobステーションは7つずつページを送って表示する)
foreach ($jid in $jobs.Keys) {
  $j = $jobs[$jid]
  $sk = New-Object System.Collections.Generic.List[string]
  foreach ($sid in $j.skills.Keys) {
    $s = $j.skills[$sid]
    foreach ($q in $s.reqs) { if (-not $j.skills.Contains($q)) { Add-Err $Tabs.job_skills $s.row "前提スキル「$q」が職業「$jid」のスキルにありません" } }
    $rq = @($s.reqs | ForEach-Object { "`"$_`"" }) -join ','
    $sk.Add("{id:`"$sid`"," + $s.snbt.Replace('[REQS]', "[$rq]") + '}')
  }
  $req = @($j.requires.Keys | ForEach-Object { "{job:`"$_`",level:$($j.requires[$_])}" }) -join ','
  $jobDecls.Add("data modify storage test: asset.job.jobs append value {id:`"$jid`",label:`"$(Esc $j.label)`",color:`"$($j.color)`",requires:[$req],exp_coefficient:$($j.coef),growth:[$($j.growth)],skills:[$($sk -join ',')]}")
}

# ---------------------------------------------------------------- 魔法の数値(要素ごとのコストと、要素の関数に渡す params)

$magicReg = [ordered]@{}
foreach ($list in @('types', 'effects')) {
  foreach ($m in [regex]::Matches((Read-Fn "init\asset\magic\$list.mcfunction"), 'asset\.magic\.' + $list + ' append value \{id:"([a-z_]+)"[^\r\n]*?folder:"([a-z_]+)"')) {
    $mid = $m.Groups[1].Value; $folder = $m.Groups[2].Value
    $body = Read-Fn "asset\magic\$folder\$mid.mcfunction"
    $magicReg[$mid] = @{ list = $list; params = @(Macro-Args $body | Where-Object { $_ -ne 'cost' }) }
  }
}
$magicDecls = New-Object System.Collections.Generic.List[string]
$magicSeen = @{}
foreach ($r in $data.magic_values) {
  $tab = $Tabs.magic_values; $n = $r.__row
  $id = Cell $r '要素'; $cost = Cell $r 'コスト'
  if (-not $magicReg.Contains($id)) { Add-Err $tab $n "要素「$id」が魔法の一覧(init/asset/magic/types・effects)にありません"; continue }
  if ($magicSeen.ContainsKey($id)) { Add-Err $tab $n "要素「$id」が重複しています"; continue }
  $magicSeen[$id] = $true
  [void](Check-Int $tab $n 'コスト' $cost 0)
  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  foreach ($need in $magicReg[$id].params) { if (-not $params.Contains($need)) { Add-Err $tab $n "要素「$id」には params の $need が必要です" } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(Snbt-Value $params[$_])" }) -join ','
  $magicDecls.Add("data modify storage test: asset.magic.$($magicReg[$id].list)[{id:`"$id`"}] merge value {cost:$cost,params:{$ps}}")
}
foreach ($id in $magicReg.Keys) { if (-not $magicSeen.ContainsKey($id)) { Add-Err $Tabs.magic_values 0 "要素「$id」の行がありません(すべての要素に コスト と params が要ります)" } }

# ---------------------------------------------------------------- バフの数値(時間・最大段数・間隔と、効果の関数に渡す params)

$buffDecls = New-Object System.Collections.Generic.List[string]
$buffSeen = @{}
foreach ($r in $data.buff_values) {
  $tab = $Tabs.buff_values; $n = $r.__row
  $id = Cell $r 'バフ'
  if ($BuffIds -notcontains $id) { Add-Err $tab $n "バフ「$id」が init/asset/buff/buffs にありません"; continue }
  if ($buffSeen.ContainsKey($id)) { Add-Err $tab $n "バフ「$id」が重複しています"; continue }
  $buffSeen[$id] = $true
  $dur = Cell $r '時間'; $max = Cell $r '最大段数'; $iv = Cell $r '間隔'
  [void](Check-Int $tab $n '時間' $dur 1)
  [void](Check-Int $tab $n '最大段数' $max 1)
  $vals = "duration:$dur,max_stacks:$max"
  # 一覧で interval のイベントを宣言しているバフは、間隔が要る(使わないバフはキーごと書かない決まり)
  $needsInterval = $buffsBody -match ('\{id:"' + $id + '"[^\r\n]*events:\{[^}]*interval:1b')
  if ($iv -ne '') { if (Check-Int $tab $n '間隔' $iv 1) { $vals += ",interval:$iv" } }
  elseif ($needsInterval) { Add-Err $tab $n "バフ「$id」は一定時間ごとの効果(interval)があるので「間隔」が要ります" }
  # 効果の関数(buff/on/<event>/<id>)の $(…) が必要な params。値は表示の単位で書き、×100して渡す
  $need = @()
  foreach ($f in Get-ChildItem (Join-Path $fnRoot 'buff\on') -Recurse -Filter "$id.mcfunction") { $need += Macro-Args ([IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)) }
  $params = Parse-Pairs $tab $n 'params' (Cell $r 'params') ';'
  foreach ($k in ($need | Select-Object -Unique)) { if (-not $params.Contains($k)) { Add-Err $tab $n "バフ「$id」には params の $k が必要です" } }
  $ps = @($params.Keys | ForEach-Object { "$($_):$(To-Internal $tab $n 'params' $params[$_])" }) -join ','
  $buffDecls.Add("data modify storage test: asset.buff.types[{id:`"$id`"}] merge value {$vals,params:{$ps}}")
}
foreach ($id in $BuffIds) { if (-not $buffSeen.ContainsKey($id)) { Add-Err $Tabs.buff_values 0 "バフ「$id」の行がありません(すべてのバフに 時間 と 最大段数 が要ります)" } }

# ---------------------------------------------------------------- プレイヤー初期値(初めて入ったときの能力値。表示の単位)

$BaseStats = @([regex]::Matches((Read-Fn 'init\scoreboard.mcfunction'), 'test\.status\.base\.([a-z_]+) dummy') | ForEach-Object { $_.Groups[1].Value })
$baseLines = New-Object System.Collections.Generic.List[string]
$baseSeen = @{}
foreach ($r in $data.player_base) {
  $tab = $Tabs.player_base; $n = $r.__row
  $s = Cell $r 'ステータス'; $v = Cell $r '値'
  if ($BaseStats -notcontains $s) { Add-Err $tab $n "ステータス「$s」はありません(使えるもの: $($BaseStats -join ' / '))"; continue }
  if ($baseSeen.ContainsKey($s)) { Add-Err $tab $n "ステータス「$s」が重複しています"; continue }
  $baseSeen[$s] = $true
  $baseLines.Add("scoreboard players set @s test.status.base.$s $(To-Internal $tab $n '値' $v)")
}
foreach ($s in $BaseStats) { if (-not $baseSeen.ContainsKey($s)) { Add-Err $Tabs.player_base 0 "ステータス「$s」の行がありません" } }

# ---------------------------------------------------------------- 定数(キーは決まっていて、すべて必須)

$ConfigKeys = [ordered]@{ turn_time = 1; turn_warn = 0; enemy_delay = 1; accessory_limit = 0 }   # キー => 最小値
$constCfg = [ordered]@{}
foreach ($r in $data.config) {
  $tab = $Tabs.config; $n = $r.__row
  $k = Cell $r 'キー'; $v = Cell $r '値'
  if (-not $ConfigKeys.Contains($k)) { Add-Err $tab $n "キー「$k」はありません(使えるもの: $(@($ConfigKeys.Keys) -join ' / '))"; continue }
  if ($constCfg.Contains($k)) { Add-Err $tab $n "キー「$k」が重複しています"; continue }
  if (Check-Int $tab $n $k $v $ConfigKeys[$k]) { $constCfg[$k] = $v }
}
foreach ($k in $ConfigKeys.Keys) { if (-not $constCfg.Contains($k)) { Add-Err $Tabs.config 0 "キー「$k」の行がありません" } }
if ($constCfg.Contains('turn_time') -and $constCfg.Contains('turn_warn') -and [int]$constCfg.turn_warn -ge [int]$constCfg.turn_time) { Add-Err $Tabs.config 0 'turn_warn(予告の残り秒数)は turn_time(制限時間)より小さくしてください' }

# ---------------------------------------------------------------- 採掘(原石・鉱山・ツルハシ)

# 「1 2 3」のように空白で区切った整数を $count 個読む。誤りなら $null
function Parse-Ints($tab, $row, $col, [string]$text, [int]$count, [string]$example) {
  $parts = @($text.Trim() -split '\s+' | Where-Object { $_ -ne '' })
  if ($parts.Count -ne $count) { Add-Err $tab $row "「$col」は整数を $count 個、空白で区切って書いてください(例: $example)"; return $null }
  foreach ($p in $parts) { if ($p -notmatch '^-?\d+$') { Add-Err $tab $row "「$col」の $p が整数ではありません"; return $null } }
  return ,([long[]]$parts)
}

# 原石: asset.ore.<id> = {item, name}
$ores = [ordered]@{}
$oreDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.ores) {
  $tab = $Tabs.ores; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($ores.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $name = Cell $r '名前'; $item = Cell $r 'アイテム'
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「アイテム」($item) がアイテムidの形ではありません" }
  $ores[$id] = @{ name = $name; item = $item }
  $oreDecls.Add("data modify storage test: asset.ore.$id set value {item:`"$item`",name:`"$(Esc $name)`"}")
  $oreDecls.Add("data modify storage test: asset.ore_ids append value `"$id`"")
}

# 鉱山: asset.mine.<id> = {name, area, entrance, interval}。鉱山は場所(範囲・入口・リセット間隔)だけを持つ。
# 中で掘れるものは、範囲の中に置いた鉱脈のアマスタ(tag=mine_vein, data.vein)が決め、リセットでその位置に鉱脈を置き直す
$mines = [ordered]@{}
$mineDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.mines) {
  $tab = $Tabs.mines; $n = $r.__row
  $errBefore = $Errors.Count
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($mines.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $name = Cell $r '名前'; $iv = Cell $r 'リセット間隔'; if ($iv -eq '') { $iv = '0' }
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  [void](Check-Int $tab $n 'リセット間隔' $iv 0)

  $area = Parse-Ints $tab $n '範囲' (Cell $r '範囲') 6 '100 30 200 140 70 240'
  $ent = Parse-Ints $tab $n '入口' (Cell $r '入口') 3 '98 40 220'

  if ($Errors.Count -gt $errBefore) { continue }
  # 範囲は小さい方の角と、そこからの幅(セレクターの dx/dy/dz)にしておく
  $x1 = [Math]::Min($area[0], $area[3]); $y1 = [Math]::Min($area[1], $area[4]); $z1 = [Math]::Min($area[2], $area[5])
  $dx = [Math]::Abs($area[3] - $area[0]); $dy = [Math]::Abs($area[4] - $area[1]); $dz = [Math]::Abs($area[5] - $area[2])
  $mines[$id] = $true
  $mineDecls.Add("data modify storage test: asset.mine.$id set value {name:`"$(Esc $name)`",area:{x1:$x1,y1:$y1,z1:$z1,dx:$dx,dy:$dy,dz:$dz},entrance:{x:$($ent[0]),y:$($ent[1]),z:$($ent[2])},interval:$iv}")
  $mineDecls.Add("data modify storage test: asset.mine_ids append value `"$id`"")
}

# 鉱脈: asset.vein.<id> = {block, ore, rank, weights:[{rare,weight}], weight_total, structure}。どの鉱山にでも、いくつでも置ける
# (置くのは鉱脈のアマスタ。鉱山をリセットすると、アマスタの位置に structure を置き直す)。
# 鉱石ブロックは鉱脈ごとに別のもの(そのブロックのルートテーブルを上書きするため、マップ全体に効く)
$BlockPattern = '^(minecraft:)?[a-z0-9_]+$'
$StructurePattern = '^[a-z0-9_.-]+:[a-z0-9_./-]+$'
$veins = [ordered]@{}
$veinDecls = New-Object System.Collections.Generic.List[string]
$blockOwner = @{}
$blockLoot = [ordered]@{}   # data/minecraft 配下の相対パス => JSON
foreach ($r in $data.veins) {
  $tab = $Tabs.veins; $n = $r.__row
  $errBefore = $Errors.Count
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($veins.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $block = Cell $r '鉱石ブロック'; $ore = Cell $r '原石'; $rank = Cell $r '必要ランク'; $struct = Cell $r '構造物'
  if ($struct -notmatch $StructurePattern) { Add-Err $tab $n "「構造物」($struct) は <名前空間>:<パス> の形で書いてください(例: test:vein/copper_vein)" }

  $bid = ''
  if ($block -notmatch $BlockPattern) { Add-Err $tab $n "「鉱石ブロック」($block) はバニラのブロックのid(例: deepslate_copper_ore)にしてください" }
  else {
    $bid = $block -replace '^minecraft:', ''
    if ($bid -eq 'red_shulker_box') { Add-Err $tab $n '「鉱石ブロック」に red_shulker_box は使えません(アイテムを渡す仕組みで使っているため)' }
    elseif ($blockOwner.ContainsKey($bid)) { Add-Err $tab $n "鉱石ブロック「$bid」は鉱脈「$($blockOwner[$bid])」でも使われています(1つのブロックは1つの鉱脈だけ)" }
    else { $blockOwner[$bid] = $id }
  }
  if (-not $ores.Contains($ore)) { Add-Err $tab $n "原石「$ore」が「原石」タブにありません" }
  [void](Check-Int $tab $n '必要ランク' $rank 1)

  # レア度の重み: 「レア度=重み; …」(レア度は1〜5)
  $weights = New-Object System.Collections.Generic.List[string]
  $total = 0
  $wp = Parse-Pairs $tab $n 'レア度の重み' (Cell $r 'レア度の重み') ';'
  foreach ($k in $wp.Keys) {
    if ($k -notmatch '^[1-5]$') { Add-Err $tab $n "「レア度の重み」のレア度 $k は1〜5にしてください"; continue }
    if (-not (Check-Int $tab $n "レア度 $k の重み" $wp[$k] 0)) { continue }
    $weights.Add("{rare:$k,weight:$($wp[$k])}"); $total += [int]$wp[$k]
  }
  if ($total -lt 1) { Add-Err $tab $n '「レア度の重み」の合計を1以上にしてください(例: 1=60; 2=25; 3=10; 4=4; 5=1)' }

  if ($Errors.Count -gt $errBefore) { continue }
  # 鉱石ブロックのルートテーブル(data/minecraft/loot_table/blocks/<ブロック>.json)。抽選はせず、目印を1個だけ落とす。
  # 目印は custom_data に鉱脈のidを持ち、見た目と名前は原石と同じ。持ち物に入ると test:mine/token/convert が原石に変える
  $o = $ores[$ore]
  $oreItem = if ($o.item -match ':') { $o.item } else { "minecraft:$($o.item)" }
  $blockLoot["loot_table\blocks\$bid.json"] = @"
{
  "type": "minecraft:block",
  "pools": [
    {
      "rolls": 1,
      "entries": [
        {
          "type": "minecraft:item",
          "name": "$oreItem",
          "modifier": [
            {
              "type": "minecraft:set_components",
              "components": {
                "minecraft:custom_data": {"test": {"ore_token": "$id"}},
                "minecraft:custom_name": {"text": $(Json-Str $o.name), "italic": false}
              }
            }
          ]
        }
      ]
    }
  ]
}
"@ -replace "`r", ''
  $veins[$id] = @{ row = $n; block = $bid; rank = [int]$rank }
  $veinDecls.Add("data modify storage test: asset.vein.$id set value {block:`"minecraft:$bid`",ore:`"$ore`",rank:$rank,weights:[$($weights -join ',')],weight_total:$total,structure:`"$struct`"}")
  $veinDecls.Add("data modify storage test: asset.vein_ids append value `"$id`"")
}

# ツルハシ: asset.pickaxe.<id> = {item, name, rank, speed, blocks}。blocks は必要ランクがこのランク以下の鉱脈の鉱石ブロック
$pickaxes = [ordered]@{}
$pickaxeDecls = New-Object System.Collections.Generic.List[string]
foreach ($r in $data.pickaxes) {
  $tab = $Tabs.pickaxes; $n = $r.__row
  $id = Cell $r 'id'
  if (-not (Check-Id $tab $n 'id' $id)) { continue }
  if ($pickaxes.Contains($id)) { Add-Err $tab $n "id「$id」が重複しています"; continue }
  $name = Cell $r '名前'; $item = Cell $r 'アイテム'; $rank = Cell $r 'ランク'; $speed = Cell $r '採掘速度'
  if ($name -eq '') { Add-Err $tab $n '「名前」が空です' }
  if ($item -notmatch $ItemPattern) { Add-Err $tab $n "「アイテム」($item) がアイテムidの形ではありません" }
  if (-not (Check-Int $tab $n 'ランク' $rank 1)) { continue }
  if ($speed -notmatch '^\d+(\.\d+)?$' -or [double]::Parse($speed, [Globalization.CultureInfo]::InvariantCulture) -le 0) { Add-Err $tab $n "「採掘速度」($speed) は0より大きい数にしてください"; continue }
  $blocks = @($veins.Values | Where-Object { $_.rank -le [int]$rank } | ForEach-Object { "`"minecraft:$($_.block)`"" })
  if ($blocks.Count -eq 0) { Add-Err $tab $n "このツルハシ(ランク $rank)で掘れる鉱脈がありません"; continue }
  $pickaxes[$id] = @{ rank = [int]$rank }
  $pickaxeDecls.Add("data modify storage test: asset.pickaxe.$id set value {item:`"$item`",name:`"$(Esc $name)`",rank:$rank,speed:$($speed)f,blocks:[$($blocks -join ',')]}")
  $pickaxeDecls.Add("data modify storage test: asset.pickaxe_ids append value `"$id`"")
}
# どのツルハシでも掘れない鉱脈は警告(生成は止めない)
$maxRank = 0; foreach ($p in $pickaxes.Values) { if ($p.rank -gt $maxRank) { $maxRank = $p.rank } }
foreach ($vid in $veins.Keys) {
  if ($veins[$vid].rank -gt $maxRank) { Add-Warn $Tabs.veins $veins[$vid].row "鉱脈「$vid」(必要ランク $($veins[$vid].rank))は、どのツルハシでも掘れません" }
}

# ---------------------------------------------------------------- 誤りがあれば何も書かずに終える

foreach ($w in $Warnings) { Write-Host "  警告: $w" -ForegroundColor Yellow }
if ($Errors.Count -gt 0) {
  Write-Host "誤りが $($Errors.Count) 件あります。ファイルは書き換えていません。" -ForegroundColor Red
  foreach ($e in $Errors) { Write-Host "  $e" -ForegroundColor Red }
  exit 1
}

# ---------------------------------------------------------------- 生成

$outputs = [ordered]@{}   # 相対パス(function配下) => 中身

function Fn-Name([string]$rel) { return 'test:' + ($rel -replace '\\', '/' -replace '\.mcfunction$', '') }

$rel = 'init\asset\generated\weapons.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)", '# 武器の宣言(スプレッドシートの「武器」タブ)。asset.<id> に置き、test:asset/weapon/sword/apply {material:<id>} が読む', '')
$outputs[$rel] = $lines + $weaponDecls

foreach ($mat in $forgeByMaterial.Keys) {
  $rel = "craft\weapon\forge\recipe\$mat.mcfunction"
  $lines = @($Header, "#> $(Fn-Name $rel)", "# 素材 $mat のレシピ(スプレッドシートの「鍛冶場レシピ」タブ)。スロット10の触媒(catalyst_kind)ごとに作る武器", '')
  foreach ($cat in $forgeByMaterial[$mat].Keys) {
    $lines += "execute if data storage test: {loot:{catalyst_kind:`"$cat`"}} run function test:asset/weapon/sword/apply {material:`"$($forgeByMaterial[$mat][$cat])`"}"
  }
  $outputs[$rel] = $lines
}

$rel = 'init\asset\equip\generated\items.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)", '# 防具・アクセサリーの宣言(スプレッドシートの「防具」タブ)。asset.equip.items.<id> に置き、test:asset/equip/apply {id} が読む', '')
$outputs[$rel] = $lines + $equipDecls

$rel = 'init\asset\equip\generated\sets.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 防具のシリーズ(スプレッドシートの「シリーズ」「4部位効果」タブ)。test:equip/recalcが着ている部位数を数え、',
  '#   2部位以上: bonus2 のステータス({type,value})を足す / 4部位: bonus4 の特殊効果を有効にする',
  '# bonus4 の1件は {event, kind, params, desc}:',
  '#   event: いつ動くか(magic_cast / attack_hit / damaged。発火場所と文脈はtest:equip/event参照)',
  '#   kind:  何をするか。test:equip/effect/<kind> がparamsをマクロ引数として受け取る',
  '#   desc:  説明文(test:item/weapon/lore/)に出す文',
  '# 新しい効果を作るときは equip/effect/<kind>.mcfunction を1つ書き、スプレッドシートに1行足して再生成する', '')
foreach ($sid in $setIds.Keys) {
  $s = $setIds[$sid]
  $lines += "data modify storage test: asset.equip.sets append value {id:`"$sid`",label:`"$(Esc $s.label)`",bonus2:[$($s.bonus2 -join ',')],bonus4:[$($s.bonus4 -join ',')]}"
}
$outputs[$rel] = $lines

foreach ($mat in $workshopByMaterial.Keys) {
  $rel = "craft\equip\recipe\$mat.mcfunction"
  $lines = @($Header, "#> $(Fn-Name $rel)", "# 素材 $mat のレシピ(スプレッドシートの「防具工房レシピ」タブ)。スロット10の型紙の部位(loot.equip_part)ごとに作る装備", '')
  foreach ($part in $workshopByMaterial[$mat].Keys) {
    $lines += "execute if data storage test: {loot:{equip_part:`"$part`"}} run return run function test:asset/equip/apply {id:`"$($workshopByMaterial[$mat][$part])`"}"
  }
  $outputs[$rel] = $lines
}

$rel = 'init\asset\rune\generated\runes.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# ルーンの宣言(スプレッドシートの「ルーン」タブ)。asset.rune.<id> = {item, name, status:[{type,value}…]}。',
  '# 付与台(craft/equip_magic/)で装備の自動発動の枠に入れると、statusが枠に写され、常に能力を上げる。',
  '# asset.rune_ids は全種類のidの一覧(デバッグで配るときに使う)', '')
$outputs[$rel] = $lines + $runeDecls

$rel = 'init\asset\consumable\generated\consumables.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 消耗品の宣言(スプレッドシートの「消耗品」タブ)。asset.consumable.<id> = {item, name, every, effect:{kind, params}}。',
  '# 効果は test:consumable/use {id} が test:consumable/effect/<kind> にparamsを渡して実行する。',
  '# 付与台で装備の自動発動の枠に設定すると、イベントが every 回起きるごとに1個自動で使う。',
  '# asset.consumable_ids は全種類のidの一覧(デバッグで配るときに使う)', '')
$outputs[$rel] = $lines + $consumableDecls

$rel = 'init\asset\generated\stats.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# ステータスの表(スプレッドシートの「ステータス」タブ)。test:init/set_table が呼ぶ。',
  '#   loot.table.substatus:   サブステータスの抽選表(抽選値が添字)。武器でも出るものが先(0..substatus_weapon_max)、',
  '#                           防具・アクセサリーは 0..substatus_armor_max を引く',
  '#   loot.table.stat_display: 説明文の表示(アイコン・名前・色・単位)',
  '#   loot.table.grow:         レベルアップ1回ぶんの伸び', '',
  "data modify storage test: loot.table.substatus set value [$((@($substatWeapon) + @($substatArmor)) -join ',')]",
  "data modify storage test: loot.table.substatus_weapon_max set value $($substatWeapon.Count - 1)",
  "data modify storage test: loot.table.substatus_armor_max set value $($substatWeapon.Count + $substatArmor.Count - 1)",
  "data modify storage test: loot.table.stat_display set value [$($statDisplay -join ',')]",
  "data modify storage test: loot.table.grow set value [$($statGrow -join ',')]")
$outputs[$rel] = $lines

$rel = 'init\asset\material\generated\materials.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 素材の宣言(スプレッドシートの「素材」タブ)。asset.material.<id> = {item, name, role, data}。',
  '# data はアイテムの custom_data.test に入る({material:{kind}} か、型紙なら {pattern:{part}})。作るのは test:item/material/build {id}', '')
$outputs[$rel] = $lines + $materialDecls

$rel = 'init\asset\enemy\generated\enemies.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 敵の宣言(スプレッドシートの「敵」「敵のギミック」タブ)。asset.enemy.<id> = {name?, stats, resist, data}。',
  '# stats は内部の値(×100済み)。出すのは test:asset/enemy/spawn {id}(test:asset/enemy/load が #enemy と storage test: enemy を作る)', '')
$outputs[$rel] = $lines + $enemyDecls

$rel = 'init\asset\job\generated\jobs.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 職業の宣言(スプレッドシートの「職業」「職業スキル」タブ)。asset.job.jobs に1職業ずつ足す。',
  '# スキルの効果は job/skill/handler/<kind> が params を受け取る', '')
$outputs[$rel] = $lines + $jobDecls

$rel = 'init\asset\magic\generated\values.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 魔法の要素の数値(スプレッドシートの「魔法の数値」タブ)。手書きの一覧(init/asset/magic/types・effects)に cost と params を足す。',
  '# test:asset/magic/run が params と cost を asset/magic/<folder>/<id> にマクロ引数として渡す', '')
$outputs[$rel] = $lines + $magicDecls

$rel = 'init\asset\buff\generated\values.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# バフの数値(スプレッドシートの「バフの数値」タブ)。手書きの一覧(init/asset/buff/buffs)に duration・max_stacks・interval・params を足す。',
  '# params は内部の値(×100済み)で、test:buff/fire_entry が buff/on/<event>/<id> にマクロ引数として渡す', '')
$outputs[$rel] = $lines + $buffDecls

$rel = 'init\asset\status\generated\base.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# @s = プレイヤー。初期の能力値(スプレッドシートの「プレイヤー初期値」タブ。内部の値)。',
  '# test:init/asset/status/vanilla(初めて入ったとき)と test:init/(/reload のとき今いるプレイヤー全員)が呼ぶ', '')
$outputs[$rel] = $lines + $baseLines

$rel = 'init\asset\generated\config.mcfunction'
$cfgSnbt = @($constCfg.Keys | ForEach-Object { "$($_):$($constCfg[$_])" }) -join ','
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 定数(スプレッドシートの「定数」タブ)。asset.config.<キー>',
  '#   turn_time: 手番の制限時間(秒) / turn_warn: 予告を出す残り時間(秒) / enemy_delay: 敵が行動するまで(tick) / accessory_limit: 効くアクセサリーの数', '',
  "data modify storage test: asset.config set value {$cfgSnbt}")
$outputs[$rel] = $lines

$rel = 'init\asset\ore\generated\ores.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 原石の種類(スプレッドシートの「原石」タブ)。asset.ore.<id> = {item, name}。作るのは test:item/ore/build {id, rare}。',
  '# asset.ore_ids は全種類のidの一覧(デバッグで配るときに使う)', '')
$outputs[$rel] = $lines + $oreDecls

$rel = 'init\asset\mine\generated\mines.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 鉱山(スプレッドシートの「鉱山」タブ)。asset.mine.<id> = {name, area:{x1,y1,z1,dx,dy,dz}(小さい方の角とセレクターの幅),',
  '#   entrance:{x,y,z}, interval(秒)}。中で掘れるものは、範囲の中に置いた鉱脈のアマスタ(tag=mine_vein)が決める。',
  '# asset.mine_ids は全鉱山のidの一覧(test:mine/tick_second が毎秒見回る)', '')
$outputs[$rel] = $lines + $mineDecls

$rel = 'init\asset\mine\generated\veins.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# 鉱脈(スプレッドシートの「鉱脈」タブ)。asset.vein.<id> = {block, ore, rank, weights:[{rare,weight}], weight_total, structure}。',
  '# 鉱山をリセットすると、範囲の中の鉱脈のアマスタ(data.vein)の位置に structure を置き直す(test:mine/place_vein)。',
  '# 鉱石ブロック(block)を掘ると、鉱脈のidを持つ目印が落ちる(生成したブロックのルートテーブル)。asset.vein_ids は全鉱脈のid', '')
$outputs[$rel] = $lines + $veinDecls

$rel = 'init\asset\pickaxe\generated\pickaxes.mcfunction'
$lines = @($Header, "#> $(Fn-Name $rel)",
  '# ツルハシ(スプレッドシートの「ツルハシ」タブ)。asset.pickaxe.<id> = {item, name, rank, speed, blocks}。',
  '# blocks は必要ランクがこのランク以下の鉱脈の鉱石ブロック(生成時に計算)。作るのは test:item/pickaxe/build {id}', '')
$outputs[$rel] = $lines + $pickaxeDecls

# 管理しているフォルダから、今回作らない古い生成ファイル(見出し付きのものだけ)を消す
$managedDirs = @('init\asset\generated', 'init\asset\equip\generated', 'craft\weapon\forge\recipe', 'craft\equip\recipe', 'init\asset\rune\generated', 'init\asset\consumable\generated',
  'init\asset\material\generated', 'init\asset\enemy\generated', 'init\asset\job\generated', 'init\asset\magic\generated', 'init\asset\buff\generated', 'init\asset\status\generated',
  'init\asset\ore\generated', 'init\asset\mine\generated', 'init\asset\pickaxe\generated')
$removed = @()
foreach ($d in $managedDirs) {
  $dir = Join-Path $fnRoot $d
  if (-not (Test-Path $dir)) { continue }
  foreach ($f in Get-ChildItem $dir -Filter *.mcfunction) {
    $relPath = "$d\$($f.Name)"
    if ($outputs.Contains($relPath)) { continue }
    $firstLine = ([IO.File]::ReadAllLines($f.FullName, [Text.Encoding]::UTF8) | Select-Object -First 1)
    if ($firstLine -eq $Header) { Remove-Item $f.FullName; $removed += $relPath }
  }
}

foreach ($relPath in $outputs.Keys) {
  $path = Join-Path $fnRoot $relPath
  $dir = Split-Path $path -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
  [IO.File]::WriteAllText($path, (($outputs[$relPath] -join "`n") + "`n"), $utf8)
}

# 鉱石ブロックのルートテーブル(JSON)。JSONには見出しを書けないので、古いファイルの掃除はしない
# (鉱山を消したり鉱石ブロックを変えたりしたときは、古いJSONを手で消す)
$dataMcRoot = Join-Path $repoRoot 'data\minecraft'
foreach ($relPath in $blockLoot.Keys) {
  $path = Join-Path $dataMcRoot $relPath
  $dir = Split-Path $path -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
  [IO.File]::WriteAllText($path, $blockLoot[$relPath], $utf8)
}

# 全鉱脈の鉱石ブロックのタグ(#test:mine_ores)。mine/rescue が、リセットで戻った鉱石に埋まった人を探すのに使う。
# 鉱脈が無くても空のタグを書く。毎回まるごと書き直すので、鉱脈を消しても古い内容は残らない(手で消す必要は無い)
$mineOresPath = Join-Path $repoRoot 'data\test\tags\block\mine_ores.json'
$oreBlockLines = @($veins.Values | ForEach-Object { "    `"minecraft:$($_.block)`"" })
$mineOresJson = if ($oreBlockLines.Count -gt 0) { "{`n  `"values`": [`n$($oreBlockLines -join ",`n")`n  ]`n}`n" } else { "{`n  `"values`": []`n}`n" }
$mineOresDir = Split-Path $mineOresPath -Parent
if (-not (Test-Path $mineOresDir)) { New-Item -ItemType Directory -Path $mineOresDir | Out-Null }
[IO.File]::WriteAllText($mineOresPath, $mineOresJson, $utf8)

Write-Host "生成しました($($outputs.Count + $blockLoot.Count + 1) ファイル)。ゲーム内で /reload してください(ルートテーブルやタグを変えたときはワールドの読み直し)。" -ForegroundColor Green
foreach ($relPath in $outputs.Keys) { Write-Host "  data/test/function/$($relPath -replace '\\','/')" }
if ($blockLoot.Count -gt 0) { Write-Host '  鉱石ブロックのルートテーブル(古いものは自動で消さないので、鉱山を消したときは手で消す):' }
foreach ($relPath in $blockLoot.Keys) { Write-Host "  data/minecraft/$($relPath -replace '\\','/')" }
Write-Host '  鉱石ブロックのタグ(毎回まるごと書き直す):'
Write-Host '  data/test/tags/block/mine_ores.json'
foreach ($relPath in $removed) { Write-Host "  (削除) data/test/function/$($relPath -replace '\\','/')" -ForegroundColor Yellow }
