with dd_address as (
select * from {{ref('dd_address')}}
)
select province
, count(distinct city) no_of_city
from dd_address
group by 1