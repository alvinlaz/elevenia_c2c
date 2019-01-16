with all_paid_hr as (

    select * from "dbt_dev"."paid_trx_hourly"

),

-- Filter out only the events that have arrived since events have last been processed
new_paid_hr as (

    select *
    from all_paid_hr

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
    

)
select * from new_paid_hr