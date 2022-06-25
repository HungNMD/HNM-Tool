$host.UI.RawUI.WindowTitle = "Unblock File"
$P = Read-Host -Prompt 'Input your file path'
dir -Path $P -Recurse | Unblock-File