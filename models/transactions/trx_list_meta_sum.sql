select trunc(ord_stl_end_dt) ord_stl_end_dt
, meta_ctgr_nm
, sum(paid_gmv) paid_gmv
, sum(paid_gmv_seller_dlv) paid_gmv_seller_dlv
from {{ ref('trx_list') }} t1 
where meta_ctgr_nm is not null
group by 1,2