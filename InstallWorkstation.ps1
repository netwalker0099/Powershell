# author: https://github.com/bradhawkins85
$innosetup = 'winagent-v1.1.12.exe'
$api = '"https://api.rkbcloud.net"'
$clientid = '14'
$siteid = '19'
$agenttype = '"workstation"'
$power = 1
$rdp = 1
$ping = 1
$auth = '"1eea9581feb603931be6dd8264f4a911216868223e09837e2b15658681037b41"'
$downloadlink = 'https://www.dropbox.com/s/k7r56ln3mds96rm/winagent-v1.1.12.exe?dl=1'

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
