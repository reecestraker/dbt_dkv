select distinct
    month_start,
    year,
    quarter,
    month
from
    {{ ref('dim_dates') }}
