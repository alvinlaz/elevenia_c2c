

  create view "dbt_dev"."sd_sales_dtls_mon_v__dbt_tmp" as (
    SELECT to_char(ord_dt,'YYYYMMDDHH24') periods
, dateadd(hour,7,getdate()) exec_dt
, count(1)
from dwuser.sd_sales_dtls
where to_char(ord_dt,'YYYYMMDD') >= to_char(dateadd(hour,7,getdate()),'YYYYMMDD')
group by 1
order by 1 desc
  ) ;