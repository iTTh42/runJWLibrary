# Lese die Konfiguration aus der Datei
$configPath = ".\config.json"
$configJson = Get-Content $configPath | ConvertFrom-Json

# Fensterposition und -größe aus der Konfiguration lesen
$x = $configJson.windowPosition.x
$y = $configJson.windowPosition.y
$width = $configJson.windowPosition.width
$height = $configJson.windowPosition.height

# Überprüfung der Monitoranzahl aus der Konfiguration lesen
$monitorCountCheck = $configJson.monitorCountCheck

# Lade die benötigte Assembly für die Arbeit mit Fenstern und Monitoren
Add-Type -AssemblyName System.Windows.Forms

if ($monitorCountCheck -eq $true) {
    Write-Host "Überprüfe die Anzahl der Monitore..."
    do {
        $monitorCount = [System.Windows.Forms.Screen]::AllScreens.Count
        if ($monitorCount -gt 1) {
            Write-Host "Mehr als ein Monitor gefunden. Fortfahren..."
            break
        } else {
            Write-Host "Warte auf zweiten Monitor..."
            Start-Sleep -Seconds 5
        }
    } while ($monitorCount -le 1)
}

Start-Sleep -Seconds 5

Write-Host "Öffne JW Library"
Start-Process "explorer.exe" "shell:appsFolder\WatchtowerBibleandTractSo.45909CDBADF3C_5rz59y55nfz3e!App"

Start-Sleep -Seconds 3

Write-Host "JW Library wird gestartet"
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public static class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  }
"@

Write-Host "Suche nach dem JW-Library-Fenster..."
$jwProcessFound = $false
do {
    Start-Sleep -Seconds 1
    $jwProcesses = Get-Process | Where-Object { $_.MainWindowTitle -like "*JW Library*" }
    foreach ($proc in $jwProcesses) {
        if ($proc.MainWindowHandle -ne 0) {
            Write-Host "JW-Library-Fenster gefunden. Bereite vor für die Anpassung."
            $jwProcessFound = $true
            break
        }
    }
} while (-not $jwProcessFound)

if ($jwProcessFound -and $proc.MainWindowHandle -ne 0) {
    Write-Host "Passe Größe und Position des JW-Library-Fenster an..."
    [NativeMethods]::MoveWindow($proc.MainWindowHandle, $x, $y, $width, $height, $true)
    Write-Host "Größe und Position des JW-Library-Fenster angepasst."
} else {
    Write-Host "Konnte das JW-Library-Fenster für die Anpassung nicht finden."
}

Write-Host "Skript abgeschlossen."
