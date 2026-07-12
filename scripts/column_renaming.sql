--Column Renaming for Bronze and Silver

EXEC sp_rename
    'bronze.crm_cust_info.cst_material_status',
    'cst_marital_status',
    'COLUMN';

	EXEC sp_rename
    'silver.crm_cust_info.cst_material_status',
    'cst_marital_status',
    'COLUMN';
