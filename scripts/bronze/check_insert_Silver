--check for unwanted Spaces
--other columns do not have spaces

select cst_firstname
from bronze.crm_cust_info
where cst_firstname!=trim(cst_firstname)
go

select cst_lastname
from bronze.crm_cust_info
where cst_lastname!=trim(cst_lastname)


--Checking Nulls and dups for primary key


--checkinh Nulls
select
cst_id,
count (*)
from bronze.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null

--removing duplications,spaces,Nulls adding new columns for short abrivations and insert in Bronze

insert into silver.crm_cust_info(
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_marital_status,
  cst_gndr,
  cst_create_date)

select
	cst_id,
	cst_key,
	trim(cst_firstname) as cst_firstname,
	trim(cst_lastname) as cst_lastname,
case when upper(trim(cst_marital_status))='S' then 'Single'
     when upper(trim(cst_marital_status))='M' then 'Married'
	 Else 'n/a'
End cst_marital_status,
case when upper(trim(cst_gndr))='F' then 'Female'
     when upper(trim(cst_gndr))='M' then 'Male'
	 Else 'n/a'
End cst_gndr,
    cst_create_date
from
	(select
	    *,
	row_number() over (partition by cst_id order by cst_create_date desc) as flag_last
	from bronze.crm_cust_info
	where cst_id is not null ) as t--finding dupd and cut the nulls
where flag_last=1--removing dups






