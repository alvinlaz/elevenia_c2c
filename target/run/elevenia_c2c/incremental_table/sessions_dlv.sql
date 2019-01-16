
       

       delete
  from "dbt_dev"."sessions_dlv"
  where (basic_dd) in (
    select (basic_dd)
    from "sessions_dlv__dbt_incremental_tmp"
  );

       insert into "dbt_dev"."sessions_dlv" ("load_dt", "basic_dd", "paid_gmv", "created_dt")
       (
         select "load_dt", "basic_dd", "paid_gmv", "created_dt"
         from "sessions_dlv__dbt_incremental_tmp"
       );
     