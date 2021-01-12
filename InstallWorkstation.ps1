# author: https://github.com/bradhawkins85
$innosetup = 'winagent-v1.1.12.exe'
$api = '"https://api.rkbcloud.net"'
$clientid = '24'
$siteid = '34'
$agenttype = '"workstation"'
$power = 1
$rdp = 1
$ping = 1
$auth = '"407e4ff5edcaea1b76940de8f38e9f9233af667c573cd3b6efdfb4172a3a92ce"'
$downloadlink = 'https://github.com/wh1te909/rmmagent/releases/download/v1.1.12/winagent-v1.1.12.exe'

$serviceName = 'tacticalagent'
If (Get-Service $serviceName -ErrorAction SilentlyContinue) {
    write-host ('Tactical RMM Is Already Installed')
} Else {
    $OutPath = $env:TMP
    $output = $innosetup

    $installArgs = @('-m install --api ', "$api", '--client-id', $clientid, '--site-id', $siteid, '--agent-type', "$agenttype", '--auth', "$auth")

    if ($power) {
        $installArgs += "--power"
    }

    if ($rdp) {
        $installArgs += "--rdp"
    }

    if ($ping) {
        $installArgs += "--ping"
    }

    Try
    {
        Invoke-WebRequest -Uri $downloadlink -OutFile $OutPath\$output
        Start-Process -FilePath $OutPath\$output -ArgumentList ('/VERYSILENT /SUPPRESSMSGBOXES') -Wait
        write-host ('Extracting...')
        Start-Sleep -s 10
        Start-Process -FilePath "C:\Program Files\TacticalAgent\tacticalrmm.exe" -ArgumentList $installArgs -Wait
        exit 0
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName
        Write-Error -Message "$ErrorMessage $FailedItem"
        exit 1
    }
    Finally
    {
        Remove-Item -Path $OutPath\$output
    }
}
