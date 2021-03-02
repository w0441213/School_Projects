# 1. Create a Docker MSSQL container named “sqlprod”, using port 1555, with user: sa and password: Password123# (3pts)
docker run --name sqlprod -e 'ACCEPT_EULA=Y' -e SA_PASSWORD=Password123# -p 1555:1433 -d mcr.microsoft.com/mssql/server:latest

# 2. List the available Docker containers (1pt)
docker ps -a

# 3. Copy the “AdventureWorksLT2019.bak” file to the “/var/opt/mssql/” directory (2pts)
docker cp "C:\temp\AdventureWorksLT2019.bak" sqlprod:/var/opt/mssql

# 4. Connect to the sqlcmd tool using Docker and restores the AdventureWorksLT2019 database to the database name “MyAdventureWorksDB” (4pts)
docker exec -it sqlprod /opt/mssql-tools/bin/sqlcmd -S localhost -U  SA -P Password123#
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'/var/opt/mssql/backup/AdventureWorksLT2019Rev1.bak' WITH  FILE = 1,  MOVE 'AdventureWorksLT2012_Data' TO '/var/opt/mssql/data/AdventureWorksLT2019VRev2.mdf'

# 5. Using the sqlcmd tool displays all databases (1pt)
#running sqlcmd using docker:
docker exec -it sqlprod /opt/mssql-tools/bin/sqlcmd -S localhost -U  SA -P Password123#
SELECT name FROM sys.sysdatabases
Go
#running using powershell:
sqlcmd
SELECT name FROM sys.sysdatabases
Go

# 6. Create a new folder called “MyBackups” in the following path: “/var/opt/mssql/” (2pts)
docker exec -it sqlprod mkdir /var/opt/mssql/MyBackups

# 7. Connect to the sqlcmd tool using Docker and create a Backup of MyAdventureWorksDB in the “/var/opt/mssql/ MyBackups” directory, naming it MyAdventureWorksDB.bak (4pts)
docker exec -it sqlprod /opt/mssql-tools/bin/sqlcmd -S localhost -U  SA -P 'Password123#' 
BACKUP DATABASE [AdventureWorksLT2019] TO DISK=N'/var/opt/mssql/MyBackups/MyAdventureWorksDB.bak' WITH NOFORMAT, NOINIT, NAME = 'AdventureWorks-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10

# 8. Using the sqlcmd tool using Docker add a user called “myadmin” and has the role of “sysadmin” (3pts)
CREATE LOGIN myadmin WITH PASSWORD = 'Password123!';
EXEC master..sp_addsrvrolemember @loginame = N'myadmin', @rolename = N'sysadmin'