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
cst_id,
count (*)
from bronze.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null
