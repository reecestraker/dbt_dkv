with source as (
      select * from {{ source('dkv', 'RAW_CUSTOMERS') }}
),
renamed as (
    select
        {{ adapter.quote("CUSTOMER_RAW_ROW_ID") }},
      {{ adapter.quote("CUSTOMER_ID") }},
      {{ adapter.quote("CUSTOMER_NAME") }},
      {{ adapter.quote("COUNTRY_CODE") }},
      {{ adapter.quote("CUSTOMER_SEGMENT") }},
      {{ adapter.quote("PRIMARY_SALES_REP_ID") }},
      {{ adapter.quote("ONBOARDING_DATE") }},
      {{ adapter.quote("VALID_FROM") }},
      {{ adapter.quote("VALID_TO") }},
      {{ adapter.quote("MD_CHANGE_REASON") }},
      {{ adapter.quote("IS_INTERNAL_TEST_ACCOUNT") }},
      {{ adapter.quote("CREDIT_LIMIT_EUR") }},
      {{ adapter.quote("RAW_CRM_GUID") }},
      {{ adapter.quote("SYS_ETL_LOAD_TS") }}

    from source
)
select 
  *
from
  renamed
where
  valid_to is null  --just take the latest row per customer to get correct 1 customer per row grain
                    --segment history would be elsewhere but not needed for now.