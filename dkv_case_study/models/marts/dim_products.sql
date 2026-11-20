with cte_products as
(
    select 
        *
    from 
        {{ ref('stg_products_contracts') }}
)
select
    product_id,
    product_name,
    product_category,
    service_fee_pct,
    standard_unit_price_eur,
    is_active_product
from
    cte_products