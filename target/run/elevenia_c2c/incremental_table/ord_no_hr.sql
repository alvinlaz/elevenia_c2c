

  create view "dbt_dev"."ord_no_hr__dbt_tmp" as (
    SELECT to_char(ord_dt,'YYYYMMDD-HH24') ord_dy_conc_hr
--, to_char(ord_stl_end_dt,'YYYYMMDD-HH24') ord_stl_end_dy_conc_hr
--, to_char(pocnfrm_dt,'YYYYMMDD-HH24') pocnfrm_dy_conc_hr
, dateadd(hour,7,getdate()) created_dt
--, t2.en_ord_prd_stat_nm
, max(ord_no) ord_no_max
, max(case when ord_stl_end_dt is not null then ord_no end) ord_no_paid_max
from dwuser.sd_sales_dtls t1
--inner join dwuser.dd_ord_prd_stat t2 on t1.ord_prd_stat = t2.ord_prd_stat_cd
--where to_char(ord_dt,'YYYYMMDD') >= to_char(dateadd(day,-3,getdate()),'YYYYMMDD')
where ord_dt::DATE >= trunc(getdate()) 
group by 1
order by 1 desc--,2 desc, 5 asc
  ) ;