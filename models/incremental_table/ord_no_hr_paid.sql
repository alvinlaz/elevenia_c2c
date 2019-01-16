SELECT to_char(ord_stl_end_dt,'YYYYMMDD-HH24') ord_stl_end_dy_conc_hr
, dateadd(hour,7,getdate()) created_dt
, max(case when ord_stl_end_dt is not null then ord_no end) ord_no_max
from dwuser.sd_sales_dtls t1
where to_char(ord_stl_end_dt,'YYYYMMDDHH24') >= '{{ var("event_type") }}'
group by 1
order by 1 desc