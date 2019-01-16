

  create view "dbt_dev"."dd_member__dbt_tmp" as (
    select * from dwuser.dd_member
  ) ;