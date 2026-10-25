@echo off
rem Generate equipment/weapon definitions from the spreadsheet (see README.md).
rem Pass -Offline to generate from data\*.csv without downloading.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0generate.ps1" %*
pause
