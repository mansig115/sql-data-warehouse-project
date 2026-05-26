/*
=====================================================================
Stored Procedure: Load Bronze Layer (Source - > Bronze)
=====================================================================

Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV filed.
  It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Used the BULK INSERT' command to load data from scv files to bronze tables.

Parameters:
  None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze

=============================================================

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,
 @batch_end_time DATETIME;
   
BEGIN TRY
   SET @batch_start_time = GETDATE();

PRINT '====================================';
PRINT 'Loading Bronze Layer';
PRINT '====================================';

PRINT '====================================';
PRINT 'Loading CRM Tables';
PRINT '====================================';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_cust_info'

TRUNCATE TABLE bronze.crm_cust_info;

PRINT '>> Inserting Table: bronze.crm_cust_info'
BULK INSERT bronze.crm_cust_info
FROM 'D:\Data Warehouse SQL\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';

--SELECT COUNT(*) FROM bronze.crm_cust_info;
-- SELECT * FROM bronze.crm_cust_info;
 
SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_prod_info'
TRUNCATE TABLE bronze.crm_prod_info;

PRINT '>> Inserting Table: bronze.crm_prod_info'
BULK INSERT bronze.crm_prod_info
FROM 'D:\Data Warehouse SQL\source_crm\prd_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';
--SELECT COUNT(*) FROM bronze.crm_prod_info;
--SELECT * FROM bronze.crm_prod_info;

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_sales_details'

TRUNCATE TABLE bronze.crm_sales_details;
PRINT '>> Inserting Table: bronze.crm_sales_details'
BULK INSERT bronze.crm_sales_details
FROM 'D:\Data Warehouse SQL\source_crm\sales_details.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';
--SELECT COUNT(*) FROM bronze.crm_sales_details;
--SELECT * FROM bronze.crm_sales_details;

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_local_a101'
TRUNCATE TABLE bronze.erp_local_a101;
PRINT '>> Inserting Table: bronze.erp_local_a101'
BULK INSERT bronze.erp_local_a101
FROM 'D:\Data Warehouse SQL\source_erp\LOC_A101.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';
--SELECT COUNT(*) FROM bronze.erp_cust_az12;
--SELECT * FROM bronze.erp_cust_az12;

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_cust_az12'
TRUNCATE TABLE bronze.erp_cust_az12;
PRINT '>> Inserting Table: bronze.erp_cust_az12'
BULK INSERT bronze.erp_cust_az12
FROM 'D:\Data Warehouse SQL\source_erp\CUST_AZ12.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';
--SELECT COUNT(*) FROM bronze.erp_cust_az12;
--SELECT * FROM bronze.erp_cust_az12;

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'D:\Data Warehouse SQL\source_erp\PX_CAT_G1V2.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '>> ----------------';

SET @batch_end_time = GETDATE();
PRINT '===================================================='
PRINT 'Loading Bronze Layer is Completed';
PRINT'   -Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
PRINT '===================================================='
--SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
--SELECT * FROM bronze.erp_px_cat_g1v2;
END TRY 
BEGIN CATCH
    PRINT '=================================================='
    PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
    PRINT 'Error Message' + ERROR_MESSAGE();
    PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
    PRINT '==================================================='
END CATCH

END
