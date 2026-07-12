
insert into silver.crm_prd_info (
    prd_id,         
	cat_id,        
	prd_key,       
	prd_nm,      
	prd_cost,      
	prd_line,     
	prd_start_dt,
	prd_end_dt
)
	

select
prd_id,
replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key,
prd_nm,
isnull(prd_cost,0) as prd_cost,
 case when upper(trim(prd_line))='M' then 'Mountain'
      when upper(trim(prd_line))='R' then 'Road'
	  when upper(trim(prd_line))='S' then 'other Sales'
	  when upper(trim(prd_line))='T' then 'Touring'
	  else 'n/a'
end as prd_line,
cast(prd_start_dt as date) as prd_start_dt,
cast(lead (prd_start_dt) over (partition by prd_key order by prd_start_dt asc)-1 as date) as prd_end_dt
from bronze.crm_prd_info


