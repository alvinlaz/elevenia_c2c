with week_ref as (
select t1.basic_week
, t1.week_bgn_dd
, t1.week_end_dd
, t2.basic_dd
, dense_rank() over (order by t1.basic_week desc) week_rn
from dwuser.dd_basic_dd t2
inner join dwuser.dd_basic_week t1 on t2.basic_week = t1.basic_week
where t2.basic_dd <= to_char(getdate(),'YYYYMMDD')
and left(t1.basic_week,4) between left(to_char(dateadd(year,-1,getdate()),'YYYYMMDD'),4) and left(to_char(getdate(),'YYYYMMDD'),4)
)
,
src as (
select a.*
, b.basic_week
, b.basic_dd basic_dd_full
, b.week_bgn_dd
, b.week_end_dd
, b.week_rn
from dwuser.sd_view_prd a --21 columns
left join week_ref b on a.basic_dd = b.basic_dd
--where ((((to_date(a.basic_dd,'YYYYMMDD') ) >= ((DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ))) AND (to_date(a.basic_dd,'YYYYMMDD') ) < ((DATEADD(day,30, DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ) ))))))
--where prd_no in (23217159, 25169895, 25804453, 11339, 24892734)
)
,
src2 as (
select *
, row_number() over(partition by prd_no order by week_rn, basic_dd_full) prd_rn
, count(distinct view_prd_seq) prd_view_cnt
, count(distinct mem_no) prd_viewer_cnt
from src
where week_rn >= 2
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
)
,
sd_sales_dtls as (
select distinct prd_no--, ord_dy
from dwuser.sd_sales_dtls 
where (left(ord_dy,4) between left(to_char(dateadd(year,-1,getdate()),'YYYYMMDD'),4) and left(to_char(getdate(),'YYYYMMDD'),4))
--and ((((to_date(ord_dy,'YYYYMMDD') ) >= ((DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ))) AND (to_date(ord_dy,'YYYYMMDD') ) < ((DATEADD(day,30, DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ) ))))))
)
,
last_30_1 as (
select a.prd_no
, sum(a.prd_view_cnt) prd_view_30
, sum(a.prd_viewer_cnt) prd_viewer_30
from src2 a
left join sd_sales_dtls b on a.prd_no = b.prd_no
--and a.basic_dd_full = b.ord_dy
where b.prd_no is null
and ((((to_date(basic_dd_full,'YYYYMMDD') ) >= ((DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ))) AND (to_date(basic_dd_full,'YYYYMMDD') ) < ((DATEADD(day,30, DATEADD(day,-30, DATE_TRUNC('day',GETDATE()) ) ))))))
group by 1
)
,
prd as (
select a.basic_week
, a.week_bgn_dd
, a.week_end_dd
, a.week_rn
, a.prd_no
, c.prd_nm
, f.meta_ctgr_nm
, d.mem_no sel_mem_no
, d.mem_id
, d.prtbl_tlphn_no
, d.store_nm
, g.am_name
, g.am_backup
, max(e.prd_view_30) prd_view_30
, max(e.prd_viewer_30) prd_viewer_30
, sum(case when prd_rn = 1 then a.sel_prc end) sel_prc
, sum(case when prd_rn = 1 then a.final_dsc_prc end) final_dsc_prc
, sum(prd_view_cnt) prd_view
, sum(prd_viewer_cnt) prd_viewer
from src2 a
left join sd_sales_dtls b on a.prd_no = b.prd_no
--and a.basic_dd_full = b.ord_dy
left join dwuser.dd_product c on a.prd_no = c.prd_no
left join dwuser.dd_disp_ctgr f on c.disp_ctgr_no = f.disp_ctgr_no
left join dwuser.dd_member d on c.seller_no = d.mem_no
left join dwuser.dd_am_sellers_distribution g on c.seller_no = g.seller_no
left join dwuser.dd_tester test on c.seller_no = test.mem_no
inner join last_30_1 e on a.prd_no = e.prd_no 
where b.prd_no is null
and c.sel_stat_cd in ('103')
and c.seller_no <> -1
and d.mem_typ_cd in ('02','03')
and test.mem_no is null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
order by 1 desc
)
select * from prd where week_rn = 2