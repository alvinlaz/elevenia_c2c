

  create view "dbt_dev"."dd_member_tester__dbt_tmp" as (
    select * from dwuser.dd_member_tester
  ) ;