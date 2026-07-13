insert into silver.erp_loc_a101 (
cid,
cntry)
select 
replace(cid,'-','') as cid,
case when trim(cntry)='DE' then 'Germany'
     when trim(cntry) in ('US','USA') then 'United States'
	 when TRIM(cntry)='' or cntry is null then 'n/a'
	 else TRIM(cntry)
end as cntry
from bronze.erp_loc_a101
