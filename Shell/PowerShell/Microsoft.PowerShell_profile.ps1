# $profile

# Starshipの起動
Invoke-Expression (&starship init powershell)

# set-alias -Nameの設定
set-alias vi "C:\Program Files\Vim\vim91\vim.exe"
set-alias vim "C:\Program Files\Vim\vim91\vim.exe"
set-alias touch "New-Item"

# ssh-agentの立ち上げ
Start-Service ssh-agent

# 文字コードをUnicodeに
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

# alias用のファイルを読み込む
. ~\pwsh_function.ps1




#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
