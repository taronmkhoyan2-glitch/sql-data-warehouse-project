
--DATA BULK IMPORT via Store Procedure


--FIRST SECTION IMPORTS

create or alter procedure bronze.load_bronze as 

begin
Declare @start_time datetime , @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
 begin try 
    SET @batch_start_time=GETDATE();
    print '============================';
    Print 'Loading Bronze layer' ;
    print '============================';

	print '-----------------------------';
	print 'Loading CRM Tables';
	print '-----------------------------';


	set @start_time=GETDATE();
	print '>> Truncating Table:bronze.crm_cust_info';
	truncate table bronze.crm_cust_info;

    print '>> Inserting Data Into:bronze.crm_cust_info';
	bulk insert bronze.crm_cust_info
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);
	set @end_time=GETDATE();
	print '>> Load Duration: '+ cast (datediff(second,@start_time,@end_time) as nvarchar)+' seconds';


	truncate table bronze.crm_prd_info;
	bulk insert bronze.crm_prd_info
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);

	truncate table bronze.crm_sales_details;
	bulk insert bronze.crm_sales_details
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);



	--SECOND SECTION IMPORTS

	

	print '-----------------------------';
	print 'Loading ERP Tables';
	print '-----------------------------';

	truncate table bronze.erp_loc_a101;
	bulk insert bronze.erp_loc_a101
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);


	truncate table bronze.erp_cust_az12;
	bulk insert bronze.erp_cust_az12
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);


	truncate table bronze.erp_px_cat_g1v2;
	bulk insert bronze.erp_px_cat_g1v2
	from 'C:\DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	with (
		firstrow=2,
		fieldterminator =',',
		tablock
	);
	set @batch_end_time=GETDATE();
	
	print 'Total Load Duration: ' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) +' seconds';
	
	
	end try

    begin catch
	print '=================='
	print'ERROR OCCURED'
	print'ERROR Message'+error_message();
	print'ERROR Message'+cast(error_number() as nvarchar);
	print'ERROR Message'+cast(error_state() as nvarchar);
	print '=================='
	end catch

end
