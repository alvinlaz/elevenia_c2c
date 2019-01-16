select trunc(load_dt) load_dt
, basic_dd
, paid_gmv
, dateadd(hour,7,getdate()) created_dt
from DWUSER.FF_FREE_DELIVERY 
where basic_dd = to_char(dateadd(day,-1,getdate()),'YYYYMMDD')