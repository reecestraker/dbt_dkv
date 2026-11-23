SELECT s.*
FROM fct_orders o
    left join dim_customers c
        on o.customer_id = c.customer_id
    join stg_customers s
        on o.customer_id = s.customer_id

WHERE c.customer_id IS NULL
--CUST-10689
-- select * from stg_customers where customer_id > 'CUST-10600'

