with source as (
        select 
          *,
          row_number() over (partition by {{ adapter.quote("ORDER_ID") }} order by {{ adapter.quote("SYS_INGESTION_TS") }}) as rn
        from {{ source('dkv', 'RAW_SALES_ORDERS') }}

  ),
  renamed as (
      select
          {{ adapter.quote("ORDER_ID") }},
        {{ adapter.quote("ORDER_DATE") }},
        {{ adapter.quote("CUSTOMER_ID") }},
        {{ adapter.quote("PRODUCT_ID") }},
        {{ adapter.quote("ORDER_STATUS") }},
        {{ adapter.quote("ORDER_TYPE") }},
        {{ adapter.quote("CURRENCY") }},
        {{ adapter.quote("FX_RATE_TO_EUR") }},
        {{ adapter.quote("QUANTITY") }},
        {{ adapter.quote("GROSS_AMOUNT_LOCAL") }},
        {{ adapter.quote("DISCOUNT_AMOUNT_LOCAL") }},
        {{ adapter.quote("TAX_AMOUNT_LOCAL") }},
        {{ adapter.quote("SALES_CHANNEL") }},
        {{ adapter.quote("SYS_INGESTION_TS") }},
        {{ adapter.quote("RAW_KAFKA_OFFSET_ID") }}

      from source
      where
        rn = 1
  )
  select * from renamed
    