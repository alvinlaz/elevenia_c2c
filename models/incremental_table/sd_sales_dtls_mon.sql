with all_sd_sales_dtls as (

    select * from {{ ref('sd_sales_dtls_mon_v') }}

),

-- Filter out only the events that have arrived since events have last been processed
new_rows as (

   select *
   from all_sd_sales_dtls

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
   {% if adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH %}
        where periods >= ( select max(periods) from {{ this }} )
   {% endif %}

)
select * from new_rows