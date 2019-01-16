

  create view "dbt_dev"."dd_tester__dbt_tmp" as (
    select * from dwuser.dd_tester
  ) ;