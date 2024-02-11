# Lade die System.Windows.Forms-Assembly
Add-Type -AssemblyName System.Windows.Forms

# Gib die Anzahl der angeschlossenen Monitore aus
[System.Windows.Forms.Screen]::AllScreens.Count
