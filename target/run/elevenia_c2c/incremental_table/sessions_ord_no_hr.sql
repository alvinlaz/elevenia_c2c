
       

       delete
  from "dbt_dev"."sessions_ord_no_hr"
  where (ord_dy_conc_hr) in (
    select (ord_dy_conc_hr)
    from "sessions_ord_no_hr__dbt_incremental_tmp"
  );

       insert into "dbt_dev"."sessions_ord_no_hr" ("ord_dy_conc_hr", "created_dt", "ord_no_max", "ord_no_paid_max")
       (
         select "ord_dy_conc_hr", "created_dt", "ord_no_max", "ord_no_paid_max"
         from "sessions_ord_no_hr__dbt_incremental_tmp"
       );
     