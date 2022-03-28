class Login{
    [string]$userName
    [string]$time
    [string]$ipAddr
}
$logins = @()
$events = get-vievent -username cloudadmin@vsphere.local | where-object FullFormattedMessage -Match "^Successful login.*"
foreach ($event in $events){
    $userName = $event.Arguments[0].value
    $time = $event.Arguments[3].value
    $ipAddr = $event.Arguments[2].value
    $logins = $logins + [Login]@{userName = $userName; time = $time; ipAddr = $ipAddr}
}
$logins | Format-Table