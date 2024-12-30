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


    connect-wtwintuner -UseDefaultCredentials
