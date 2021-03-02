# 1 Create comd to open windows calc

& "C:\Windows\System32\calc.exe"

#or

$env:Path
$env:Path += ";C:\Windows\System32\calc.exe"
calc.exe

# 2 Get hidden file items in Windows System 32

Get-ChildItem -Path "C:\Windows\System32" -Hidden

# 3 Search for .dll

Get-ChildItem C:\Windows\System32 *.dll

# 3.5 Search for .dll, with Recursion - "-recurse" tells the PowerShell commands (example: Get-ChildItem) to repeat in the sub directories

Get-ChildItem C:\Windows\System32 *.dll -Recurse -Name

# 4 Write a command to get all dll files in c:\windows\system32 and sort descending by last write time and select last 3 only ADD -recurse -name. Refer to page 44

Get-ChildItem C:\Windows\System32 *.dll -Recurse -Name | Sort-Object -Property LastWriteTime -Descending | Select-Object -last 3

# 5 Show all the aliases for the Set-Location command

Get-Alias | Where-Object {$_.Definition -eq "Set-Location"}

# 6 Create your own alias that will open up calc.exe

Set-Alias calculator calc.exe

# 6.5 To remove alias:
Remove-item Alias:cal
