Get-Service -DisplayName "*Dell*" | Stop-Service
Get-Service -Displayname "*Dell*" | Set-Service -StartupType Disabled
