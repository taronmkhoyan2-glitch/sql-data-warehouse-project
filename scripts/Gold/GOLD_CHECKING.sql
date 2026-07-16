--checkings for GOld

select distinct

 ci.cst_gndr,
 
 ca.gen,
case when ci.cst_gndr!='n/a'  then ci.cst_gndr        
      else coalesce(gen,'n/a') 
end as new_gen
 
 from silver.crm_cust_info as ci
 left join silver.erp_cust_az12 as ca
           on ci.cst_key=ca.cid
left join silver.erp_loc_a101 as la
           on ci.cst_key=la.cid
order by  1,2

-------------selecting the view

select 
*
from
gold.dim_customers

------------Cheking the uniqunes in Product dimenshon


Select prd_key, count(*) from (

select
pn.prd_id,
pn.prd_key,
pn.prd_nm,
pn.cat_id,
pc.cat,
pc.subcat,
pc.maintenance,
pn.prd_cost,
pn.prd_line,
pn.prd_start_dt

from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
on pn.cat_id=pc.id

where prd_end_dt is null--Filter out historical data
) t group by prd_key
having count(*) >1 


-----Checking the data issues based on Joining the views

select * from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key=f.customer_key
left join gold.dim_products p
on p.product_key=f.product_key
where c.customer_key is null 
or p.product_key is null

----if we get the result it means we have no match
