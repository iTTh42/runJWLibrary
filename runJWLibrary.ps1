$configPath = ".\config.json"
$configJson = Get-Content $configPath | ConvertFrom-Json

$x = $configJson.windowPosition.x
$y = $configJson.windowPosition.y
$width = $configJson.windowPosition.width
$height = $configJson.windowPosition.height

$monitorCountCheck = $configJson.monitorCountCheck

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
            Start-Sleep -Seconds 2
        }
    } while ($monitorCount -le 1)
}

Start-Sleep -Seconds 2

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

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
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

    Write-Host "Bringe JW Library in den Vordergrund..."
    [NativeMethods]::SetForegroundWindow($proc.MainWindowHandle)

    Write-Host "Sende Tastenanschläge..."
    #Start-Sleep -Seconds 1
    [System.Windows.Forms.SendKeys]::SendWait("{TAB 5}{DOWN 3}{ENTER}")

    Write-Host "Tastenanschläge gesendet."
    Write-Host "Größe und Position des JW-Library-Fenster angepasst."
} else {
    Write-Host "Konnte das JW-Library-Fenster für die Anpassung nicht finden."
}

Write-Host "Skript abgeschlossen."
