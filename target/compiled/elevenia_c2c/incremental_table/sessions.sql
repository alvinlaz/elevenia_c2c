with all_ord_hr as (

    select * from "dbt_dev"."ord_trx_hourly"

),

-- Filter out only the events that have arrived since events have last been processed
new_ord_hr as (

    select *
    from all_ord_hr

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
    

)
select * from new_ord_hr