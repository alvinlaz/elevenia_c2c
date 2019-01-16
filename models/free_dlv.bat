d:

cd project/elevenia_c2c

dbt compile --models incremental_table.ff_free_delivery_d

dbt run --models incremental_table.ff_free_delivery_d

dbt compile --models incremental_table.sessions_dlv

dbt run --models incremental_table.sessions_dlv

exit

clear