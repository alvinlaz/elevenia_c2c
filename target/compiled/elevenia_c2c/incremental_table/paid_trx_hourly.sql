SELECT DATE(sd_sales_dtls.ord_stl_end_dt ) AS ord_stl_end_dt_date
, DATE_PART(hour, sd_sales_dtls.ord_stl_end_dt )::integer AS ord_stl_end_dt_hour_of_day
, dateadd(hour,7,getdate()) created_dt
, COUNT(DISTINCT case when (DATE(sd_sales_dtls.ord_stl_end_dt )) is not null then concat(sd_sales_dtls.ord_no,sd_sales_dtls.prd_no) end ) paid_item_cnt
FROM dwuser.sd_sales_dtls AS sd_sales_dtls
LEFT JOIN dwuser.dd_tester  AS dd_tester_byr ON sd_sales_dtls.buy_mem_no = dd_tester_byr.mem_no 
LEFT JOIN dwuser.dd_tester  AS dd_tester_slr ON sd_sales_dtls.seller_mem_no = dd_tester_slr.mem_no 
LEFT JOIN dwuser.dd_product  AS dd_product ON sd_sales_dtls.prd_no = dd_product.prd_no 
LEFT JOIN dwuser.dd_prd_typ  AS dd_prd_typ ON dd_product.prd_typ_cd = dd_prd_typ.prd_typ_cd 
WHERE ((((sd_sales_dtls.ord_stl_end_dt ) >= ((DATE_TRUNC('day',GETDATE()))) AND (sd_sales_dtls.ord_stl_end_dt ) < ((DATEADD(day,1, DATE_TRUNC('day',GETDATE()) )))))) AND (dd_prd_typ.en_prd_typ_nm <> 'B2B Order' OR dd_prd_typ.en_prd_typ_nm IS NULL) AND (dd_tester_byr.mem_no is null and dd_tester_slr.mem_no is null)
GROUP BY 1,2,3