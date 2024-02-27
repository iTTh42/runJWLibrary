# JW Library Automatisierungsskript

Dieses Repository enthält ein PowerShell-Skript zur Automatisierung der Fensterpositionierung und -größe der JW Library auf Windows-Systemen. Es liest Konfigurationsdaten aus einer JSON-Datei, überprüft optional die Anzahl der angeschlossenen Monitore und passt das JW Library-Fenster entsprechend an. Weiterhin wird beschrieben, wie man eine VBScript-Verknüpfung zur vereinfachten Skriptausführung erstellt und den gesamten Ordner in `C:\opt\` verschiebt.

## Voraussetzungen

- Windows 10 oder höher
- PowerShell 5.1 oder höher
- JW Library App installiert

## Setup

### Projektordner vorbereiten

- Stellen Sie sicher, dass der Ordner `C:\opt\` auf Ihrem System existiert. Erstellen Sie ihn, falls notwendig.
- Kopieren Sie den Projektordner in `C:\opt\`.

### Konfigurationsdatei

Konfigurieren Sie die `config.json` im Hauptverzeichnis des Projekts mit folgendem Inhalt:

```json
{
  "windowPosition": {
    "x": -9,
    "y": 430,
    "width": 1000,
    "height": 600
  },
  "monitorCountCheck": false
}
```
### Desktop-Verknüpfung erstellen

- Erstellen Sie eine Verknüpfung auf dem Desktop, die auf das PowerShell Script `runJWLibrary.ps1` zeigt.
- Geben Sie der Verknüpfung einen aussagekräftigen Namen, z.B. `Start JW Library`.

## Benutzung

Doppelklicken Sie auf die Desktop-Verknüpfung, um die JW Library mit den vordefinierten Fensterpositionen und -größen zu starten. Das Skript führt auch eine Überprüfung der Monitoranzahl durch, falls dies in der Konfiguration festgelegt wurde.

## Sicherheitshinweise

Beim Ausführen von Skripten, die Konfigurationsdaten aus externen Dateien lesen, ist Vorsicht geboten. Stellen Sie sicher, dass die `config.json` und das Skript selbst in einem sicheren Verzeichnis gespeichert sind, um unbefugten Zugriff zu verhindern.

## Lizenz

Dieses Projekt ist unter einer Open-Source-Lizenz veröffentlicht. Weitere Informationen zur Lizenzierung finden Sie in der `LICENSE`-Datei des Projekts.
