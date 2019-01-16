

  create view "dbt_dev"."dd_product__dbt_tmp" as (
    select * from dwuser.dd_product
  ) ;