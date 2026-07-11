--Create Database 'Datawarehouse'
use master;

 create database DataWarehouse;

 use DataWarehouse;
--Create Schema  
  create schema bronze;
  go

  create schema silver;
  go

  create schema gold;
  go
