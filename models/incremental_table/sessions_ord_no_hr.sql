with all_ord_no_hr as (

    select * from {{ ref('ord_no_hr') }}

),

-- Filter out only the events that have arrived since events have last been processed
new_ord_no_hr as (

    select *
    from all_ord_no_hr

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
    {% if adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH %}
        where ord_dy_conc_hr >= (select max(ord_dy_conc_hr) from {{ this }})
        --OR ISNULL(ord_stl_end_dy_conc_hr,'-') >= (select max(ISNULL(ord_stl_end_dy_conc_hr,'-')) from {{ this }})
        --OR ISNULL(pocnfrm_dy_conc_hr,'-') >= (select max(ISNULL(pocnfrm_dy_conc_hr,'-')) from {{ this }})
        --OR en_ord_prd_stat_nm >= (select max(en_ord_prd_stat_nm) from {{ this }})
        --ord_dt_date >= (select max(ord_dt_date) from {{ this }})
        --OR ord_dt_hr >= (select max(ord_dt_hr) from {{ this }})
    {% endif %}

)
select * from new_ord_no_hr