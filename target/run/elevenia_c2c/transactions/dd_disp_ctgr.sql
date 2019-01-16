

  create view "dbt_dev"."dd_disp_ctgr__dbt_tmp" as (
    select * from dwuser.dd_disp_ctgr
  ) ;