select * from dwuser.sd_sales_dtls where ord_dy = to_char(dateadd(day,-1,getdate()),'YYYYMMDD')