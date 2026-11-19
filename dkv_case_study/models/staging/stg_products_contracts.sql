with source as (
        select * from {{ source('dkv', 'RAW_PRODUCTS_CONTRACTS') }}
  ),
  renamed as (
      select
          {{ adapter.quote("PRODUCT_ID") }},
        {{ adapter.quote("PRODUCT_NAME") }},
        {{ adapter.quote("PRODUCT_CATEGORY") }},
        {{ adapter.quote("SERVICE_FEE_PCT") }},
        {{ adapter.quote("STANDARD_UNIT_PRICE_EUR") }},
        {{ adapter.quote("IS_ACTIVE_PRODUCT") }},
        {{ adapter.quote("LEGACY_SAP_MATERIAL_NO") }},
        {{ adapter.quote("SYS_CREATED_TS") }},
        {{ adapter.quote("SYS_BATCH_ID") }}

      from source
  )
  select * from renamed
    