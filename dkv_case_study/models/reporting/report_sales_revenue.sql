--This view is for a pbi report.
    --by rolling up to monthly revenue, it will be easier to join and compare to targets in pbi
    --not doing join to targets here to allow more flexibility in pbi model.
with cte_orders as
(
    select
        *,
        date_trunc(month, order_date) as revenue_month
    from
        {{ ref('fct_orders') }}
)
, cte_customers as
(
    select
        *
    from
        {{ ref('dim_customers') }}
)
select
    c.country_code,
    o.revenue_month,
    concat(c.country_code,'|',o.revenue_month) as country_month_key,
    o.order_status,
    o.order_type,
    o.sales_channel,
    o.is_revenue,
    --could add tax/discounts/gross too
    sum(coalesce(o.net_amount_eur,0)) as net_revenue_eur
from
    cte_orders o
    join cte_customers c
        on o.customer_id = c.customer_id
group by
    c.country_code,
    revenue_month,
    o.order_status,
    o.order_type,
    o.sales_channel,
    o.is_revenue
