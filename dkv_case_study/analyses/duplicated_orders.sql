with cte_dupes as
(
    select order_id from {{ source('dkv', 'RAW_SALES_ORDERS') }} group by order_id having count(*) > 1
)
select
    so.*
from
    cte_dupes d
    join {{ source('dkv', 'RAW_SALES_ORDERS') }} so
        on d.order_id = so.order_id
--clear duplicates -- everything is the same except ingestion time.
-- run agani on staging model
-- 0 rows -- successfully removed duplicates at staging level