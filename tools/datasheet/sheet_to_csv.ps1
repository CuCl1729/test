param([Parameter(Mandatory)][string]$JsonDir)
# Claude Sheet の readCells の結果(<key>.json、value のまま)を data/<key>.csv に書き出す
$ErrorActionPreference = 'Stop'
$inv = [Globalization.CultureInfo]::InvariantCulture
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
$dataDir = Join-Path $PSScriptRoot 'data'

function Cell($v) {
  if ($null -eq $v) { return '' }
  if ($v -is [double] -or $v -is [int] -or $v -is [long] -or $v -is [decimal]) { return ([double]$v).ToString('R', $inv) }
  if ($v -is [bool]) { if ($v) { return 'TRUE' } else { return 'FALSE' } }
  if ($v -isnot [string]) { throw "読めないセル: $($v | ConvertTo-Json -Compress)" }
  $s = $v
  if ($s.StartsWith("'")) { $s = $s.Substring(1) }
  if ($s -match '[",\r\n]') { $s = '"' + $s.Replace('"', '""') + '"' }
  return $s
}

foreach ($f in Get-ChildItem $JsonDir -Filter *.json) {
  $j = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8) | ConvertFrom-Json
  $rows = @($j.rows.PSObject.Properties | Sort-Object { [int]$_.Name })
  $width = ($rows | ForEach-Object { @($_.Value).Count } | Measure-Object -Maximum).Maximum
  $lines = foreach ($r in $rows) {
    $cells = @($r.Value)
    (0..($width - 1) | ForEach-Object { if ($_ -lt $cells.Count) { Cell $cells[$_] } else { '' } }) -join ','
  }
  $out = Join-Path $dataDir "$($f.BaseName).csv"
  # 末尾の改行は今のファイルに合わせる(差分を出さないため)
  $nl = (Test-Path $out) -and ([IO.File]::ReadAllText($out, [Text.Encoding]::UTF8).EndsWith("`n"))
  $text = ($lines -join "`n") + $(if ($nl) { "`n" } else { '' })
  [IO.File]::WriteAllText($out, $text, $utf8Bom)
  Write-Host "$($f.BaseName).csv: $($rows.Count) 行"
}
