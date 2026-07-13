--check for unwanted Spaces

select cst_key
from bronze.crm_cust_info
where cst_key!=trim(cst_key)
go

select cst_lastname
from bronze.crm_cust_info
where cst_lastname!=trim(cst_lastname)

--other columns do not have spaces


--Checking Nulls and dups
select
prd_id,
count (*)
from bronze.crm_prd_info
group by prd_id
having count(*)>1
go

--cheking for crm_prd_info table
select
prd_cost
from bronze.crm_prd_info
where prd_cost <0 or prd_cost is null
go

--cheking for crm_sales_details
select
nullif(sls_ship_dt,0)

from bronze.crm_sales_details
where sls_due_dt<=0
or LEN(sls_due_dt)!=8
or sls_due_dt>20500101
or sls_due_dt<19000101
go
--cheking for crm_sales_details
select distinct
sls_sales as old_sls_sales ,
sls_quantity,
sls_price as old_sls_price,
case when sls_sales is null or sls_sales<=0 or sls_sales!= sls_quantity*abs(sls_price)
     then sls_quantity*abs(sls_price)
	 else sls_sales
end as sls_sales,
case when sls_price is null or sls_price<=0
     then sls_sales/nullif(sls_quantity,0)
	 else sls_price
end as sls_price
from bronze.crm_sales_details
where sls_sales!=sls_quantity*sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales<=0 or sls_quantity<=0 or sls_price<=0
order by sls_sales,sls_quantity,sls_price


--Checking bdate in bronze.erp_cust_az12
select distinct 
bdate
from bronze.erp_cust_az12
where bdate <'1924-01-01' or bdate > getdate()

-- Gender
select distinct
gen
from bronze.erp_cust_az12



--cheching the bronze.erp_loc_a101
select distinct cntry,
case when trim(cntry)='DE' then 'Germany'
     when trim(cntry) in ('US','USA') then 'United States'
	 when TRIM(cntry)='' or cntry is null then 'n/a'
	 else TRIM(cntry)
end as cntry
from bronze.erp_loc_a101
