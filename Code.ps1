function showSimpleNtwInfo {
    Clear-Host
    Get-NetAdapter | ft -AutoSize
}

function showDetailNtwInfo {
    Clear-Host
    Write-Host "Mostrando todos los adaptadores de red: " -BackgroundColor White -ForegroundColor Black
    Write-Host ""
    (Get-NetAdapter).Name
    Write-Host ""
    $specificAdapter = Read-Host "Selecciona un adaptador"
    Get-NetAdapter -Name $specificAdapter | fl
}

function toggleAdapter {
    Clear-Host
    Write-Host "Mostrando todos los adaptadores y sus estados: " -BackgroundColor White -ForegroundColor Black
    Write-Host ""
    Get-Netadapter | Ft -Property Name, Status
    Write-Host ""
    $specificAdapter = Read-Host "Selecciona un adaptador"
    $adapter = Get-NetAdapter -Name $specificAdapter
    if ($adapter.Status -eq "Up"){
        Disable-NetAdapter -Name $specificAdapter
        Write-Host "Adaptador $specificAdapter ha sido desactivado"
    }else{
        Enable-NetAdapter -Name $specificAdapter
        Write-Host "Adaptador $specificAdapter ha sido activado"
    }
}

function ipConfig {
    Clear-Host
    Write-Host "Mostrando todos los adaptadores de red: " -BackgroundColor White -ForegroundColor Black
    Write-Host ""
    (Get-NetAdapter).Name
    Write-Host ""
    $adapterName = Read-Host "Introduce el adaptador"
    $ipAddress = Read-Host "Introduce la dirección IP"
    $subnetMask = Read-Host "Introduce la máscara de red"
    $gateway = Read-Host "Introduce la puerta de enlace"
    $adapter = Get-NetAdapter -Name $adapterName
    Clear-Host
    New-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $gateway
}

do {
    Clear-Host
    Write-Host ""
    Write-Host "Menú de gestión de red" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Mostrar Información simple de los adaptadores de red"
    Write-Host "2. Mostrar Información completa de los adaptadores"
    Write-Host "3. Activar/Desactivar adaptadores"
    Write-Host "4. Configuración IP"
    Write-Host "5. Salir"
    Write-Host ""
    $optionSelected = Read-Host "Selecciona una opción"
    switch ($optionSelected) {
        1 {showSimpleNtwInfo}
        2 {showDetailNtwInfo}
        3 {toggleAdapter}
        4 {ipConfig}
        5 {Break}
        Default {Write-Host "Opción no válida."}
    }
    Read-Host "Presiona Enter para continuar..."
} while ($optionSelected -ne 5)
