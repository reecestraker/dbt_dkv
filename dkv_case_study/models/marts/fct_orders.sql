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
    order_id,
    order_date,
    customer_id,
    product_id,
    order_status,
    case when order_status in ('Completed','Invoiced') then 1 else 0 end as is_revenue,
    order_type,
    --convert amounts to euros here once and not downstream (local regions can convert back in pbi if needed?)
    gross_amount_eur,
    discount_amount_eur,
    tax_amount_eur,
    gross_amount_eur - discount_amount_eur - tax_amount_eur as net_amount_eur,
    currency as original_currency, --to be clear it's not original anymore
    sales_channel
    
from
    cte_orders