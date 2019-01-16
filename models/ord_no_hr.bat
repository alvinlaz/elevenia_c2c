d:

cd project/elevenia_c2c

dbt compile --models incremental_table.ord_no_hr

dbt run --models incremental_table.ord_no_hr

dbt compile --models incremental_table.sessions_ord_no_hr

dbt run --models incremental_table.sessions_ord_no_hr

exit

clear