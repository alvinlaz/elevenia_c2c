d:

cd project/elevenia_c2c

dbt compile --models incremental_table.sd_sales_dtls_mon_v

dbt run --models incremental_table.sd_sales_dtls_mon_v

dbt compile --models incremental_table.sd_sales_dtls_mon

dbt run --models incremental_table.sd_sales_dtls_mon

exit

clear