select * from {{ ref('ord_trx_hourly') }}
{% if adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH %}
where ord_dt_hour_of_day >= (select max(ord_dt_hour_of_day) from {{ this }})
{% endif %}