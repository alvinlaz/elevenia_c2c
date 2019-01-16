with all_paid_hr as (

    select * from {{ ref('paid_trx_hourly') }}

),

-- Filter out only the events that have arrived since events have last been processed
new_paid_hr as (

    select *
    from all_paid_hr

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
    {% if adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH %}
        where ord_stl_end_dt_hour_of_day >= (select max(ord_stl_end_dt_hour_of_day) from {{ this }})
    {% endif %}

)
select * from new_paid_hr