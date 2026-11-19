with cte_customers as
(
    select 
        *
    from 
        {{ ref('stg_customers') }}
)
select
    customer_id,
    customer_name,
    country_code,
    customer_segment,
    PRIMARY_SALES_REP_ID,
    onboarding_date,
    valid_from,
    --valid_to, --always null on active accounts. Easier? for filter
    md_change_reason,
    credit_limit_eur
from
    cte_customers
where
    valid_to is null  --just take the latest row per customer to get a unique per customer table -- easier this way than rn --unique test on id anyway
    and IS_INTERNAL_TEST_ACCOUNT = 0    --remove test accounts here. Chosen to do here instead of staging.