
       

       delete
  from "dbt_dev"."sd_sales_dtls_mon"
  where (periods) in (
    select (periods)
    from "sd_sales_dtls_mon__dbt_incremental_tmp"
  );

       insert into "dbt_dev"."sd_sales_dtls_mon" ("periods", "exec_dt", "count")
       (
         select "periods", "exec_dt", "count"
         from "sd_sales_dtls_mon__dbt_incremental_tmp"
       );
     