--are there any customers who are no longer active?
with cte_closed as
(
    select distinct c.customer_id
    from stg_customers c
        left join stg_customers c2
            on c.customer_id = c2.customer_id
            and c.customer_raw_row_id < c2.customer_raw_row_id
    where
        c.valid_to is not null
        and c2.customer_id is null
)
select c.* 
from 
    cte_closed cc
    join stg_customers c
        on c.customer_id = cc.customer_id
order by 2,1
--0 rows -- so no, but something to be aware of. I'd expect that could change and would need to account for it