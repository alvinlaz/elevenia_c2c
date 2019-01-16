with all_dlv as (

    select * from "dbt_dev"."ff_free_delivery_d"

),

-- Filter out only the events that have arrived since events have last been processed
new_dlv as (

   select *
   from all_dlv

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
   
        where basic_dd >= ( select max(basic_dd) from "dbt_dev"."sessions_dlv" )
   

)
select * from new_dlv