with dd_address as (
select * from "dbt_dev"."dd_address"
)
select province
, count(distinct city) no_of_city
from dd_address
group by 1