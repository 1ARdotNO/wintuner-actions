param(
    [string]$configPath = "config.json",
    $packagepath="C:\Tools\Packages"
)

. .\init.ps1

#Update apps
$updatedApps = Get-WtWin32Apps -Update $true -Superseded $false
$donoupdatelist=$config.apps | Where-Object {$_.version -ne "latest"} | Where-Object {$_.version} #Exclude apps with version specified from updates
$updatedApps= $updatedApps | Where-Object { $_.PackageId -notin $donoupdatelist.name }
foreach($app in $updatedApps) { New-WtWingetPackage -PackageId $($app.PackageId) -PackageFolder $packagepath -Version $($app.LatestVersion) | Deploy-WtWin32App -GraphId $($app.GraphId) }
#Remove superseeded apps
$oldApps = Get-WtWin32Apps -Superseded $true
foreach($app in $oldApps) { Remove-WtWin32App -AppId $app.GraphId }