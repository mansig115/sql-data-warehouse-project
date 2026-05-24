/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/



USE master; -- master is a system db in SQL server where you can create other databases
Go

--Drop and recreate the 'DataWarehouse' db
/*"If this database already exists, 
force everyone out of it, then delete it — 
so we can recreate it fresh."
*/
IF EXISTS (Select 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;



GO
-- Create Database 'DataWarehouse'
Create Database DataWarehouse;
GO
USE DataWarehouse;
GO

--Create Schemas
Create Schema bronze;-- Go is used to separate batches when working with multiple SQL statements
Go
Create Schema silver;
Go
Create Schema gold;
Go
