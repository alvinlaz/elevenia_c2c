

  create view "dbt_dev"."trx_list_pulsa_sum__dbt_tmp" as (
    select trunc(ord_stl_end_dt) ord_stl_end_dt
, meta_ctgr_nm
, sum(paid_gmv) paid_gmv
, sum(paid_gmv_seller_dlv) paid_gmv_seller_dlv
from "dbt_dev"."trx_list" t1 
where lower(disp_ctgr_small_cls_nm) = 'phone credit'
group by 1,2
  ) ;