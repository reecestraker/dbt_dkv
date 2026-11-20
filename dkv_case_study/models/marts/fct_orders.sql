with cte_orders as
(
    select 
        *,
        cast(gross_amount_local*fx_rate_to_eur as decimal(18, 2)) as gross_amount_eur,
        cast(discount_amount_local*fx_rate_to_eur as decimal(18, 2)) as discount_amount_eur,
        cast(tax_amount_local*fx_rate_to_eur as decimal(18, 2)) as tax_amount_eur,
    from 
        {{ ref('stg_sales_orders') }}
)
select
    o.order_id,
    o.order_date,
    o.customer_id,
    o.product_id,
    o.order_status,
    case when o.order_status in ('Completed','Invoiced') then 1 else 0 end as is_revenue,
    o.order_type,
    --convert amounts to euros here once and not downstream (local regions can convert back in pbi if needed?)
    o.gross_amount_eur,
    o.discount_amount_eur,
    o.tax_amount_eur,
    o.gross_amount_eur - o.discount_amount_eur - o.tax_amount_eur as net_amount_eur,
    o.currency as original_currency, --to be clear it's not original anymore
    o.sales_channel,
    case when c.customer_id is not null then 1 else 0 end as is_real_customer --useful flag maybe
from
    cte_orders o
    left join {{ ref('dim_customers') }} c
        on o.customer_id = c.customer_id   
where
    o.order_status <> 'Internal_Test'   --remove these