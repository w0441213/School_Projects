# Name: Jamie Lu
# Class: INET 3700 Server Operating Systems and Scripting
# Date: November 29, 2020
# Description: This script contains basic functions useful in the Management of Windows User Accounts.
# This includes a function that can add a windows user, with parameters for UserName, Password, and Local Group.
# It also includes script on changing user password, removing a user, and adding and removing a user from an existing local group.
# This script also creates an entry into the Windows Event Log for each task, and includes some basic validation.

# 1) Add a Local User
function AddWindowsUser {
    [CmdletBinding()]
    param(
    
    [Parameter(Mandatory=$true)]
    [string] $UserName,

    [string] $Password,
    
    [Parameter(Mandatory=$true)]
    [string] $LocalGroup
)

$passwd = (ConvertTo-SecureString $Password -AsPlainText -Force)

New-LocalUser "$UserName" -Password $passwd
}

# Creating a new event log. No longer needed if already created.
New-EventLog -LogName "myApp" -Source "AddWindowsUser"

try
{
    AddWindowsUser "jamelyn" "password123" "users" -ErrorAction Stop
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType SuccessAudit -LogName "myApp" -Source "AddWindowsUser" -EventID 7001 -Message "Windows User Created"
}
catch
{
    Write-Warning -Message "UserName already exists"
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType FailureAudit -LogName "myApp" -Source "AddWindowsUser" -EventID 7002 -Message "Windows User Could Not Be Created"
}


# 2) Changing user password

# Creating a new event log. No longer needed if already created.
New-EventLog -LogName "myApp" -Source "ChangePassword"

try
{
    [Parameter(Mandatory=$true)]
    $NewPassword = ConvertTo-SecureString "psswrd123" -AsPlainText -Force
    Set-LocalUser -Name "jamieL" -Password $NewPassword  -ErrorAction Stop
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType SuccessAudit -LogName "myApp" -Source "ChangePassword" -EventID 7003 -Message "Password updated."
}
catch
{
    Write-Warning -Message "UserName does not exist."
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType FailureAudit -LogName "myApp" -Source "ChangePassword" -EventID 7004 -Message "Password failed to update."
}


# 3) Add a User to an existing Local Group

# Creating a new event log. No longer needed if already created.
New-EventLog -LogName "myApp" -Source "AddUserToGroup"
    
try {
    Add-LocalGroupMember -Group "Guests" -Member "tiny" -ErrorAction Stop
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType SuccessAudit -LogName "myApp" -Source "AddUserToGroup" -EventID 7005 -Message "User added to Local Group."
} catch {
    Write-Warning -Message "Something went wrong. Check group and member names."
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType FailureAudit -LogName "myApp" -Source "AddUserToGroup" -EventID 7006 -Message "User could not be added to Local Group."
}


# 4) Remove a User

# Creating a new event log. No longer needed if already created.
New-EventLog -LogName "myApp" -Source "RemoveUser"

try {
    Remove-LocalUser -Name "EJamie" -ErrorAction Stop
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType SuccessAudit -LogName "myApp" -Source "RemoveUser" -EventID 7007 -Message "Windows User Removed."
} catch {
    Write-Warning -Message "UserName does not exist."
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType FailureAudit -LogName "myApp" -Source "RemoveUser" -EventID 7008 -Message "Windows User could not be removed."
}


# 5) Remove a User from a Local Group

# Creating a new event log. No longer needed if already created.
New-EventLog -LogName "myApp" -Source "RemoveUserFromGroup"

try {
    Remove-LocalGroupMember -Group "Guests" -Member "tiny" -ErrorAction Stop
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType SuccessAudit -LogName "myApp" -Source "RemoveUserFromGroup" -EventID 7009 -Message "User removed from group."
} catch {
    Write-Warning -Message "Something went wrong. Check group and member names."
    Write-EventLog -ComputerName "Jamie-Laptop" -EntryType FailureAudit -LogName "myApp" -Source "RemoveUserFromGroup" -EventID 7010 -Message "User could not be removed from group."
}