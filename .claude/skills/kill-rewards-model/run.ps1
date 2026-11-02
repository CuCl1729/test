# Check the kill-reward model against the data pack as it is on disk.
#   powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/kill-rewards-model/run.ps1
# 1. Reads the facts the model depends on from the .mcfunction files (exit 2 if one can't be found).
# 2. Writes them as TLC constants and model-checks KillRewards.tla with 2 enemies.
# Exit 0: both properties hold. Exit 1: a property is violated (the trace is printed). Exit 2: setup or
# extraction problem. Only ASCII in this file (PowerShell 5.1 misreads a BOM-less non-ASCII script).
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Here = $PSScriptRoot
$Fn = (Resolve-Path (Join-Path $Here '..\..\..\data\test\function')).Path
$TlaVersion = '1.7.4'
$TlaSha256 = '936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88'
$Jar = Join-Path $env:LOCALAPPDATA "tlaplus\tla2tools-$TlaVersion.jar"

function Fail2([string]$msg) { Write-Output "SETUP: $msg"; exit 2 }
function Lines([string]$rel) {
  $p = Join-Path $Fn $rel
  if (-not (Test-Path $p)) { Fail2 "missing $rel - the code moved; re-read it and update run.ps1 and the model" }
  return [System.IO.File]::ReadAllLines($p, [System.Text.Encoding]::UTF8)
}
# The single line of $rel that contains $needle (code, not a comment).
function OneLine([string]$rel, [string]$needle) {
  $hits = @(Lines $rel | Where-Object { $_.Contains($needle) -and -not $_.TrimStart().StartsWith('#') })
  if ($hits.Count -ne 1) { Fail2 "expected exactly 1 line with '$needle' in $rel, found $($hits.Count)" }
  return $hits[0]
}
function LineNo([string]$rel, [string]$needle) {
  $ls = Lines $rel
  for ($i = 0; $i -lt $ls.Count; $i++) { if ($ls[$i].Contains($needle) -and -not $ls[$i].TrimStart().StartsWith('#')) { return $i } }
  Fail2 "no line with '$needle' in $rel"
}
function B([bool]$v) { if ($v) { 'TRUE' } else { 'FALSE' } }

# --- facts --------------------------------------------------------------------------------------
$kill = (Lines 'damage\kill.mcfunction') -join "`n"
$fieldKill = OneLine 'tick.mcfunction' 'run function test:reward/field_kill'
$attack = OneLine 'attack\damage.mcfunction' 'run function test:attack/hit_apply'
$projHit = OneLine 'projectile\move.mcfunction' 'run function test:magic/hit'
$aoeHit = OneLine 'magic\aoe\apply.mcfunction' 'run function test:magic/hit'
$magicHit = (Lines 'magic\hit.mcfunction') -join "`n"
# Magic can't reach a battle_member if both hit paths exclude it, if magic/hit returns for it, or if the
# cast entry magic/ refuses casters in a battle (only battle members are in test:arena, where those
# enemies are; a projectile cast before a battle stays in test:turn).
$magicCast = (Lines 'magic\.mcfunction') -join "`n"
$magicSkips = ($projHit.Contains('tag=!battle_member') -and $aoeHit.Contains('tag=!battle_member')) -or
  ($magicHit -match '@s\[[^\]]*tag=battle_member[^\]]*\] run return') -or
  ($magicCast -match '(?m)^execute if score @s test\.battle\.id matches 1\.\. run return fail')
$facts = [ordered]@{
  KillTagsPending            = $kill.Contains('tag=battle_member,tag=!kill] run tag @s add battle_reward_pending')
  KillTagsBattleKilled       = $kill.Contains('tag=battle_member] run tag @s add battle_killed')
  FieldKillSkipsMember       = $fieldKill.Contains('tag=!battle_member')
  FieldKillSkipsBattleKilled = $fieldKill.Contains('tag=!battle_killed')
  AttackSkipsMember          = $attack.Contains('tag=!battle_member')
  MagicSkipsMember           = $magicSkips
  BuffStepBeforeProcAll      = (LineNo 'battle\turn_end.mcfunction' 'function test:buff/step') -lt (LineNo 'battle\turn_end.mcfunction' 'function test:battle/proc_all')
  ProcAllBeforeCheckEnd      = (LineNo 'battle\turn_end.mcfunction' 'function test:battle/proc_all') -lt (LineNo 'battle\turn_end.mcfunction' 'function test:battle/check_end')
}
Write-Output 'facts read from the code:'
foreach ($k in $facts.Keys) { Write-Output ("  {0,-27} {1}" -f $k, (B $facts[$k])) }

# --- tools --------------------------------------------------------------------------------------
if (-not (Test-Path $Jar)) {
  New-Item -ItemType Directory -Force (Split-Path $Jar) | Out-Null
  Write-Output "downloading tla2tools $TlaVersion"
  Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/tlaplus/tlaplus/releases/download/v$TlaVersion/tla2tools.jar" -OutFile $Jar
}
if ((Get-FileHash -Algorithm SHA256 $Jar).Hash.ToLower() -ne $TlaSha256) { Fail2 "checksum mismatch for $Jar (delete it to re-download)" }
$java = $null
$cands = @()
if ($env:JAVA_HOME) { $cands += (Join-Path $env:JAVA_HOME 'bin\java.exe') }
$rt = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.4297127D64EC6_8wekyb3d8bbwe\LocalCache\Local\runtime'
if (Test-Path $rt) { $cands += @(Get-ChildItem -Path $rt -Recurse -Filter java.exe -ErrorAction SilentlyContinue | ForEach-Object FullName) }
$onPath = Get-Command java -ErrorAction SilentlyContinue
if ($onPath) { $cands += $onPath.Source }
foreach ($c in $cands) {
  if (-not (Test-Path $c)) { continue }
  $v = (& cmd /c "`"$c`" -version 2>&1" | Select-Object -First 1)
  if ($v -match '"(\d+)' -and [int]$Matches[1] -ge 11) { $java = $c; break }
}
if (-not $java) { Fail2 'no Java 11+ found (set JAVA_HOME, or install Minecraft Launcher runtimes)' }

# --- run ----------------------------------------------------------------------------------------
$work = Join-Path $env:TEMP 'kill-rewards-model'
New-Item -ItemType Directory -Force $work | Out-Null
Copy-Item (Join-Path $Here 'KillRewards.tla') $work -Force
$cfg = @('CONSTANT Enemies = {e1, e2}')
foreach ($k in $facts.Keys) { $cfg += "CONSTANT $k = $(B $facts[$k])" }
$cfg += 'SPECIFICATION Spec', 'INVARIANT AtMostOnce', 'INVARIANT PaidWhenRemoved'
[System.IO.File]::WriteAllLines((Join-Path $work 'KillRewards.cfg'), [string[]]$cfg)
Push-Location $work
try {
  $out = & cmd /c "`"$java`" -XX:+UseParallelGC -cp `"$Jar`" tlc2.TLC -workers auto -deadlock -cleanup KillRewards 2>&1"
} finally { Pop-Location }
$out | Where-Object { $_ -notmatch '^(Starting|Computing|Implied|Checking|Finished computing|Progress|The depth|The average)' } | ForEach-Object { Write-Output $_ }
if ($out -match 'Invariant \w+ is violated') { exit 1 }
if ($out -match 'Model checking completed. No error has been found') { exit 0 }
Fail2 'TLC did not finish normally (see output above)'
