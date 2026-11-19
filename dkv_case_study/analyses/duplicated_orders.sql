with cte_dupes as
(
    select order_id from stg_sales_orders group by order_id having count(*) > 1
)
select
    so.*
from
    cte_dupes d
    join stg_sales_orders so
        on d.order_id = so.order_id