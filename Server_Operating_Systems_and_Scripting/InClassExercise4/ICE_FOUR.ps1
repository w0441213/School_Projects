# Name: Jamie Lu
# Class: INET 3700 Server Operating Systems and Scripting
# Date: November 29, 2020
# Description: Create a PowerShell script that will perform the following tasks:
# 1.	Create a Scheduled Task called: “Scheduled Backup” (10 pts)
# 2.	Run the “BackupMyFiles.ps1” script  (3 pts)
# 3.	On a schedule every 12 hours (2 pts)
# 4.	The “BackupMyFiles.ps1” script should take in two parameters (10 pts)
# a.	Files to backup
# b.	Destination of the backups
# c.	The number of backups that must be saved before overwritten

$principal = New-ScheduledTaskPrincipal -UserID "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Sta = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" –Argument '-ExecutionPolicy Bypass -Command "C:\Users\Asus\OneDrive - Nova Scotia Community College\INET3700 Server_Operating_Systems_and_Scripting\Powershell Scripts\BackupMyFiles.ps1"
-Destination C:\TempBkp2\ -BackupDirs C:\temp\,C:\temp1\  -Versions 1; exit $LASTEXITCODE"'

$Stt = New-ScheduledTaskTrigger -Once -At $(get-date)-RepetitionInterval $([timespan]::FromHours("12")) 

Register-ScheduledTask -TaskName "Scheduled Backup" -Action $Sta -Trigger $Stt -Principal $principal




