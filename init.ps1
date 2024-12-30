try {
    Import-Module WinTuner
} catch {
    # Code to handle the exception
    Write-Error "Module import failed!"
}


try {
    $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json
} catch {
    # Code to handle the exception
    Write-Error "Config import failed!"
}


#Error handeling for crendtials
if( !$ENV:AZURE_CLIENT_ID){
    Write-Error "AZURE_CLIENT_ID env MISSING!"
}
elseif( !$ENV:AZURE_CLIENT_SECRET){
    Write-Error "AZURE_CLIENT_SECRET env MISSING!"
}
elseif( !$ENV:AZURE_TENANT_ID){
    Write-Error "AZURE_TENANT_ID env MISSING!"
}else {
    connect-wtwintuner -UseDefaultCredentials
}
