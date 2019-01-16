with all_sd_sales_dtls as (

    select * from "dbt_dev"."sd_sales_dtls_mon_v"

),

-- Filter out only the events that have arrived since events have last been processed
new_rows as (

   select *
   from all_sd_sales_dtls

    -- This conditional is executed just before the model is
    -- executed and returns either True or False
    -- The enclosed `where` filter will be conditionally applied
    -- only if this model exists in the current schema
   
        where periods >= ( select max(periods) from "dbt_dev"."sd_sales_dtls_mon" )
   

)
select * from new_rows