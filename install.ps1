Set-ExecutionPolicy Bypass -Scope CurrentUser -Force
powershell "iwr -useb get.scoop.sh | iex"
scoop install git ruby
cmd /c "git clone https://codeberg.org/brahma/emerald.git $Home\.emerald"
Write-Output @"
@echo off
ruby $Home\.emerald\main.rb %1
"@ | Set-Content -Encoding ASCII -Path $Home\scoop\shims\emerald.cmd