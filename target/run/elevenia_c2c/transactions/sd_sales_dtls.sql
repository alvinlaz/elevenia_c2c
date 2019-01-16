

  create view "dbt_dev"."sd_sales_dtls__dbt_tmp" as (
    select * from dwuser.sd_sales_dtls where ord_dy = to_char(dateadd(day,-1,getdate()),'YYYYMMDD')
  ) ;