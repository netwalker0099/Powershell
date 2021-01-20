[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module PSWindowsUpdate -force
Set-ExecutionPolicy remotesigned -force
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
