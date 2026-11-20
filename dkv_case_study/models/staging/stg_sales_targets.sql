with source as (
        select * from {{ source('dkv', 'RAW_SALES_TARGETS') }}
  ),
  renamed as (
      select
          {{ adapter.quote("TARGET_ROW_ID") }} as target_id,
        {{ adapter.quote("TARGET_MONTH") }},
        {{ adapter.quote("COUNTRY_CODE") }},
        {{ adapter.quote("TARGET_NET_REVENUE_EUR") }},
        {{ adapter.quote("TARGET_NEW_CUSTOMERS") }},
        {{ adapter.quote("TARGET_VERSION") }},
        {{ adapter.quote("APPROVED_BY") }},
        {{ adapter.quote("SYS_UPDATED_AT") }}

      from source
  )
  select * from renamed
    