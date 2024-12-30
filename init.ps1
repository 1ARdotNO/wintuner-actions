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


try {
    connect-wtwintuner -UseManagedIdentity
} catch {
    # Code to handle the exception
    Write-Error "Authenitication failed!"
}

