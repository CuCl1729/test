# Drive the running Minecraft 26.3 client for verification.
# Every input action re-checks that Minecraft is the foreground window and sends nothing otherwise
# (exit 2), so keys never land in another app. Only the Minecraft window is ever listed or captured.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File mc.ps1 -Doctor
#   ... -Cmd "/function test:debug/menu"     open chat, type the command, Enter
#   ... -Keys "{ESC}"                         raw SendKeys syntax
#   ... -Text "abc"                           literal text (SendKeys specials escaped)
#   ... -Fly                                  double-tap Space (creative flight toggle)
#   ... -Sneak 1500                           hold left Shift for N ms
#   ... -Shot C:\path\shot.png                capture the Minecraft window only
#   ... -Click 120,340 [-Right]               click at pixel (x,y) of the LAST -Shot image
#   ... -Mark                                 print the current line count of latest.log
#   ... -Since 1234 [-Save C:\path\proof.txt] print (and save) the [CHAT] lines after that line
param(
  [switch]$Doctor, [string]$Cmd, [string]$Keys, [string]$Text, [switch]$Fly, [int]$Sneak = 0,
  [string]$Shot, [string]$Click, [switch]$Right, [switch]$Mark, [int]$Since = -1, [string]$Save
)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$TitlePattern = 'Minecraft 26.3*'
$Repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
$Log = Join-Path $Repo '..\..\..\..\logs\latest.log'
$WorkDir = Join-Path $env:TEMP 'mc-verify'
$OffsetFile = Join-Path $WorkDir 'last-shot-offset.txt'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type @'
using System; using System.Runtime.InteropServices; using System.Text;
public static class McWin {
  [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
  [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern void keybd_event(byte vk, byte scan, uint flags, UIntPtr extra);
}
'@

function Test-Foreground {
  $sb = New-Object System.Text.StringBuilder 256
  [void][McWin]::GetWindowText([McWin]::GetForegroundWindow(), $sb, 256)
  return ($sb.ToString() -like $TitlePattern)
}
function Assert-Foreground {
  if (-not (Test-Foreground)) { Write-Output 'NOT_FOREGROUND: Minecraft is not the active window; nothing was sent'; exit 2 }
}
function Send([string]$k) { Assert-Foreground; [System.Windows.Forms.SendKeys]::SendWait($k) }
function Escape([string]$t) { [regex]::Replace($t, '[+^%~(){}\[\]]', { param($m) '{' + $m.Value + '}' }) }
function Get-McWindow {
  $raw = (& agent-desktop list-windows 2>$null) -join "`n"
  $w = ($raw | ConvertFrom-Json).data | Where-Object { $_.title -like $TitlePattern } | Select-Object -First 1
  return $w
}
# The running game keeps latest.log open for writing, so open it with shared read/write access.
function Read-LogLines {
  $fs = New-Object System.IO.FileStream((Resolve-Path $Log).Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
  $sr = New-Object System.IO.StreamReader($fs, [System.Text.Encoding]::UTF8)
  try { return $sr.ReadToEnd().TrimEnd("`n").Split("`n") | ForEach-Object { $_.TrimEnd("`r") } } finally { $sr.Dispose() }
}

if ($Doctor) {
  $w = Get-McWindow
  if ($w) { Write-Output ("window: {0} bounds x={1} y={2} w={3} h={4} minimized={5}" -f $w.id, $w.bounds.x, $w.bounds.y, $w.bounds.width, $w.bounds.height, $w.minimized) }
  else { Write-Output 'window: NONE (start Minecraft 26.3 and open the world "test")' }
  Write-Output ("foreground: {0}" -f (Test-Foreground))
  if (Test-Path $Log) {
    $lines = Read-LogLines
    Write-Output ("log: {0} lines, last write {1}" -f $lines.Count, (Get-Item $Log).LastWriteTime)
    # A world start, or the server's own "/reload" chat line (Japanese locale: saiyomikomi, built from
    # char codes so this file stays ASCII; PowerShell 5.1 misreads non-ASCII in a BOM-less script).
    $jpReload = -join [char[]](0x518d, 0x8aad, 0x307f, 0x8fbc, 0x307f)
    $reload = ($lines | Select-String -Pattern ('Starting integrated minecraft server|System chat: .*(' + $jpReload + '|Reloading)') | Select-Object -Last 1)
    $from = if ($reload) { $reload.LineNumber - 1 } else { 0 }
    if ($reload) { Write-Output ("last load/reload: line {0}" -f $reload.LineNumber) }
    $errs = @($lines[$from..($lines.Count - 1)] | Where-Object { $_ -match 'Failed to load function|Registry loading errors' })
    Write-Output ("errors since last reload: {0}" -f $errs.Count)
    $errs | Select-Object -First 5 | ForEach-Object { Write-Output ("  " + $_) }
    $login = ($lines | Where-Object { $_ -match 'logged in with entity id' } | Select-Object -Last 1)
    if ($login) { Write-Output ("login: " + ($login -replace ' at \(.*$', '')) }
  } else { Write-Output ("log: MISSING at " + $Log) }
  exit 0
}

if ($Mark) { Write-Output (Read-LogLines).Count; exit 0 }

if ($Since -ge 0) {
  $lines = Read-LogLines
  $out = @($lines[$Since..($lines.Count - 1)] | Where-Object { $_ -match '\[CHAT\]' } | ForEach-Object { $_ -replace '^.*?\[CHAT\] ', '' })
  if ($Save) { New-Item -ItemType Directory -Force (Split-Path $Save) | Out-Null; [System.IO.File]::WriteAllLines($Save, [string[]]$out, (New-Object System.Text.UTF8Encoding $false)) }
  $out
  exit 0
}

if ($Shot) {
  $w = Get-McWindow
  if (-not $w) { Write-Output 'NO_WINDOW'; exit 3 }
  & agent-desktop screenshot --window-id $w.id $Shot | Out-Null
  $img = [System.Drawing.Image]::FromFile((Resolve-Path $Shot).Path)
  $border = [int](($w.bounds.width - $img.Width) / 2)
  $ox = [int]$w.bounds.x + $border; $oy = [int]$w.bounds.y
  $img.Dispose()
  New-Item -ItemType Directory -Force $WorkDir | Out-Null
  Set-Content -Path $OffsetFile -Value "$ox $oy" -Encoding ASCII
  Write-Output "SHOT $Shot offset=$ox,$oy (screen = offset + pixel)"
  exit 0
}

if ($Click) {
  if (-not (Test-Path $OffsetFile)) { Write-Output 'NO_OFFSET: take a -Shot first'; exit 3 }
  $o = (Get-Content $OffsetFile).Split(' ')
  $p = $Click.Split(',')
  $sx = [int]$o[0] + [int]$p[0]; $sy = [int]$o[1] + [int]$p[1]
  Assert-Foreground
  if ($Right) { & agent-desktop mouse-click --headed --xy "$sx,$sy" --button right | Out-Null }
  else { & agent-desktop mouse-click --headed --xy "$sx,$sy" | Out-Null }
  Write-Output "CLICK $sx,$sy"
  exit 0
}

if ($Cmd) {
  Send 't'; Start-Sleep -Milliseconds 600
  Send (Escape $Cmd); Start-Sleep -Milliseconds 300
  Send '{ENTER}'; Start-Sleep -Milliseconds 900
  Write-Output "CMD $Cmd"; exit 0
}
if ($Keys) { Send $Keys; Write-Output 'SENT'; exit 0 }
if ($Text) { Send (Escape $Text); Write-Output 'SENT'; exit 0 }
# Jump is read once per game tick, so each press must stay down for more than a tick (50 ms);
# a SendKeys tap can fall between two ticks and be missed.
function Tap-Space {
  Assert-Foreground
  [McWin]::keybd_event(0x20, 0x39, 0, [UIntPtr]::Zero); Start-Sleep -Milliseconds 90
  [McWin]::keybd_event(0x20, 0x39, 2, [UIntPtr]::Zero)
}
if ($Fly) { Tap-Space; Start-Sleep -Milliseconds 110; Tap-Space; Write-Output 'FLY'; exit 0 }
if ($Sneak -gt 0) {
  Assert-Foreground
  [McWin]::keybd_event(0xA0, 0x2A, 0, [UIntPtr]::Zero); Start-Sleep -Milliseconds $Sneak
  [McWin]::keybd_event(0xA0, 0x2A, 2, [UIntPtr]::Zero)
  Write-Output "SNEAK $Sneak"; exit 0
}
Write-Output 'usage: see the header of this file'; exit 1
