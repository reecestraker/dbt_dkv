with cte_targets as
(
    select 
        *
    from 
        {{ ref('stg_sales_targets') }}
)
select
    target_id,
    target_month,
    country_code,
    concat(country_code,'|',target_month) as country_month_key, --for joining smoothly in PBI
    target_net_revenue_eur,
    target_new_customers,
    target_version,
    approved_by
from
    cte_targets
where
    target_version = 'v2_Approved'      --always this one, sometimes also v1_Draft, remove dupes
