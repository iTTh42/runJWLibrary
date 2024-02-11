Set objShell = CreateObject("Wscript.Shell")
psScriptPath = ".\runJWLibrary.ps1"

' Bauen Sie den Befehl, um PowerShell verdeckt zu starten
Command = "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & psScriptPath & """"

' Führen Sie den Befehl aus
objShell.Run Command, 0, False
