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
  weapons          = '武器'
  forge_recipes    = '鍛冶場レシピ'
  equipment        = '防具'
  sets             = 'シリーズ'
  set_effects      = '4部位効果'
  workshop_recipes = '防具工房レシピ'
}

# ---------------------------------------------------------------- 取得

if (-not $Offline) {
  $config = Get-Content (Join-Path $toolDir 'config.json') -Raw -Encoding UTF8 | ConvertFrom-Json
  if (-not $config.sheet_id) {
    Write-Host 'config.json の sheet_id が空です。スプレッドシートを用意して設定するか、-Offline を付けて data/*.csv から生成してください。' -ForegroundColor Red
    exit 1
  }
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $client = New-Object Net.WebClient
  foreach ($key in $Tabs.Keys) {
    $gid = $config.tabs.$key
    if ($null -eq $gid -or "$gid" -eq '') {
      Write-Host "config.json の tabs.$key(タブ「$($Tabs[$key])」の gid)が空です。" -ForegroundColor Red
      exit 1
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
  weapons          = @('id','元アイテム','名前','基礎ステ','基礎ステ値','ボーナス','ボーナス値','最大レベル','ティア','射程','魔法ダメージ%','物理','火','水','木','金','土')
  forge_recipes    = @('素材','触媒','武器id')
  equipment        = @('id','元アイテム','名前','部位','シリーズ','メイン','メイン値','最大レベル','色')
  sets             = @('id','名前','2部位ボーナス')
  set_effects      = @('シリーズ','event','kind','params','説明')
  workshop_recipes = @('素材','部位','装備id')
}
foreach ($key in $Tabs.Keys) {
  $path = Join-Path $dataDir "$key.csv"
  if (-not (Test-Path $path)) { continue }
  $first = ([IO.File]::ReadAllText($path, [Text.Encoding]::UTF8).TrimStart([char]0xFEFF) -split "`r?`n")[0]
  $heads = @($first | ConvertFrom-Csv -Header (1..64) | ForEach-Object { $_.PSObject.Properties.Value } | Where-Object { $_ })
  foreach ($h in $RequiredHeaders[$key]) { if ($heads -notcontains $h) { Add-Err $Tabs[$key] 1 "見出し「$h」の列がありません" } }
}

# ---------------------------------------------------------------- 検証に使う一覧

# ステータスの種類: init/set_table.mcfunction の loot.table.grow にあるもの(成長の表に無い種類は強化炉で伸びないため)
$setTable = [IO.File]::ReadAllText((Join-Path $fnRoot 'init\set_table.mcfunction'), [Text.Encoding]::UTF8)
$growBlock = [regex]::Match($setTable, 'loot\.table\.grow set value(?s)(.*?)\]\s*(\r?\n|$)').Groups[1].Value
$StatTypes = @([regex]::Matches($growBlock, 'type:"([a-z_]+)"') | ForEach-Object { $_.Groups[1].Value })
if ($StatTypes.Count -eq 0) { Add-Err 'init/set_table' 0 'loot.table.grow からステータスの種類を読み取れませんでした' }

# 4部位効果のkind: equip/effect/<kind>.mcfunction があるもの。必要なparamsはその関数の $(…) から読む
$EffectParams = @{}
foreach ($f in Get-ChildItem (Join-Path $fnRoot 'equip\effect') -Filter *.mcfunction) {
  $body = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
  $EffectParams[$f.BaseName] = @([regex]::Matches($body, '\$\(([a-z_]+)\)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique)
}
$Events = @('magic_cast','attack_hit','damaged')
$Parts = @('head','chest','legs','feet','accessory')

$IdPattern = '^[a-z0-9_]+$'
$ItemPattern = '^([a-z0-9_.-]+:)?[a-z0-9_./-]+$'
$NumPattern = '^-?\d+(\.\d+)?$'

function Esc([string]$s) { return $s.Replace('\', '\\').Replace('"', '\"') }

function Check-Id($tab, $row, $col, $value) {
  if ($value -eq '') { Add-Err $tab $row "「$col」が空です"; return $false }
  if ($value -notmatch $IdPattern) { Add-Err $tab $row "「$col」($value) は半角英小文字・数字・_ だけで書いてください"; return $false }
  return $true
}
function Check-Num($tab, $row, $col, $value, [bool]$required) {
  if ($value -eq '') { if ($required) { Add-Err $tab $row "「$col」が空です" }; return }
  if ($value -notmatch $NumPattern) { Add-Err $tab $row "「$col」($value) が数値ではありません" }
}
function Check-Stat($tab, $row, $col, $value) {
  if ($value -eq '') { Add-Err $tab $row "「$col」が空です"; return }
  if ($StatTypes -notcontains $value) { Add-Err $tab $row "「$col」の $value は init/set_table の成長の表(loot.table.grow)にないステータスです" }
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
    if ($StatTypes -notcontains $k) { Add-Err $tab $n "「2部位ボーナス」の $k は init/set_table の成長の表(loot.table.grow)にないステータスです" }
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
  if ($Parts -notcontains $part) { Add-Err $tab $n "「部位」($part) は $($Parts -join ' / ') のどれかにしてください"; continue }
  if (-not $equipIds.ContainsKey($eid)) { Add-Err $tab $n "装備id「$eid」が「防具」タブにありません"; continue }
  if (-not $workshopByMaterial.Contains($mat)) { $workshopByMaterial[$mat] = [ordered]@{} }
  if ($workshopByMaterial[$mat].Contains($part)) { Add-Err $tab $n "素材 $mat × 部位 $part の組み合わせが重複しています"; continue }
  $workshopByMaterial[$mat][$part] = $eid
}

# ---------------------------------------------------------------- 誤りがあれば何も書かずに終える

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

# 管理しているフォルダから、今回作らない古い生成ファイル(見出し付きのものだけ)を消す
$managedDirs = @('init\asset\generated', 'init\asset\equip\generated', 'craft\weapon\forge\recipe', 'craft\equip\recipe')
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

Write-Host "生成しました($($outputs.Count) ファイル)。ゲーム内で /reload してください。" -ForegroundColor Green
foreach ($relPath in $outputs.Keys) { Write-Host "  data/test/function/$($relPath -replace '\\','/')" }
foreach ($relPath in $removed) { Write-Host "  (削除) data/test/function/$($relPath -replace '\\','/')" -ForegroundColor Yellow }
