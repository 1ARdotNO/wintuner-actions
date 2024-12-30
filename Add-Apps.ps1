param(
    [string]$configPath = "config.json",
    $packagepath="C:\Tools\Packages"
)

. .\init.ps1

$currentapps=Get-WtWin32Apps

$config.apps |Where-Object {($_.type -eq "wintuner") -or {$_.type -eq $null}} | 
Where-Object { $currentapps.PackageId -notcontains $_.name } |
ForEach-Object {
    $foreachcheck = $true

    if($_.version -eq "latest"){
        $_.version = $null
    }
    if(($_.Availablefor -eq $null) -and ($_.RequiredFor -ne "AllUsers")){
        $_ | Add-Member -NotePropertyName Availablefor -NotePropertyValue "AllUsers" -Force
        #$_.Availablefor = "Allusers"
    }
    if($_.RequiredFor -eq $null){
        #$_.RequiredFor = $null
        $_ | Add-Member -NotePropertyName RequiredFor -NotePropertyValue $null -Force
    }

    New-WtWingetPackage -PackageId $_.name -PackageFolder $packagepath -version $_.version | Deploy-WtWin32App -Available $_.Availablefor -RequiredFor $_.RequiredFor
}
#print informational message if the foreaach-object loop is not executed
if(!$foreachcheck){
    Write-Host "No new apps to install"
}


Disconnect-WtWinTuner