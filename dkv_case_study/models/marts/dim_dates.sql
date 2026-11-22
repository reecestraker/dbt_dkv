with recursive cte_dates(date) as (
    select cast('2023-01-01'  as date)
  union all
    select dateadd(day, 1, date) from cte_dates where date < '2027-12-31'::date
)
select
  date,
  date_trunc('month', date) as month_start,
  extract(year from date) as year,
  extract(quarter from date) as quarter,
  extract(month from date) as month,
  extract(day from date) as day
from
  cte_dates