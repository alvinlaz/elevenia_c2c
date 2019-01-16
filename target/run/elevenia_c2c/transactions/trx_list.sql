

  create view "dbt_dev"."trx_list__dbt_tmp" as (
    with dd_member as (
  select * from "dbt_dev"."dd_member"
),
dd_member_slr as (
  select * from "dbt_dev"."dd_member"
),
dd_tester as (
  select * from "dbt_dev"."dd_tester"
),
dd_product as (
  select * from "dbt_dev"."dd_product"
)
,
dd_disp_ctgr as (
  select * from "dbt_dev"."dd_disp_ctgr"
)
,
sd_sales_dtls as (
  select * from "dbt_dev"."sd_sales_dtls"
)
,
daily_paid_gmv_list as (
  select t1.ord_stl_end_dt
  , t1.ord_no
  , t2.prd_no
  , t2.disp_ctgr_no
  , t3.dept_cd
  , t3.meta_ctgr_nm
  , t3.disp_ctgr_big_cls_nm
  , t3.disp_ctgr_mid_cls_nm
  , t3.disp_ctgr_small_cls_nm
  , t2.prd_nm
  , t1.buy_mem_no
  , dd_member_buyer.mem_id byr_id
  , t1.seller_mem_no
  , dd_member_slr.store_nm
  , COALESCE(SUM(((t1.paid_qty * t1.sel_prc) + t1.paid_opt_won_stl + t1.paid_tiket_trans_fee) ), 0) AS paid_gmv
  , COALESCE(SUM((((t1.paid_qty * t1.sel_prc) + t1.paid_opt_won_stl + t1.paid_tiket_trans_fee)
    - (t1.paid_seller_disc_amt_add + t1.paid_seller_disc_amt_dirct + t1.paid_seller_disc_amt_dup)) ), 0) AS paid_gmv_seller
  , COALESCE(SUM((((t1.paid_qty * t1.sel_prc) + t1.paid_opt_won_stl + t1.paid_tiket_trans_fee)
    - (t1.paid_seller_disc_amt_add + t1.paid_seller_disc_amt_dirct + t1.paid_seller_disc_amt_dup)
    + (t1.paid_dlv_cst + t1.paid_11st_disc_amt_dlv_crm + t1.paid_11st_disc_amt_dlv_cs + t1.paid_11st_disc_amt_dlv_md + t1.paid_11st_disc_amt_dlv_mkt + t1.paid_11st_disc_amt_dlv_sm)) ), 0) AS paid_gmv_seller_dlv
  from sd_sales_dtls t1
  left join dd_tester test_buy on t1.buy_mem_no = test_buy.mem_no
  left join dd_tester test_sel on t1.seller_mem_no = test_sel.mem_no
  left join dd_product t2 on t1.prd_no = t2.prd_no
  left join dd_disp_ctgr t3 on t2.disp_ctgr_no = t3.disp_ctgr_no
  left join dd_member dd_member_buyer on t1.buy_mem_no = dd_member_buyer.mem_no
  left join dd_member dd_member_slr on t1.seller_mem_no = dd_member_slr.mem_no
  where (test_buy.mem_no is null and test_sel.mem_no is null)
  and ord_stl_end_dt is not null
  group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
)
select * from daily_paid_gmv_list
  ) ;