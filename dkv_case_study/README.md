# DKV Case Study — dbt Project

Business logic is defined in dbt (single source of truth); Power BI handles
time filtering and measures via DAX.

**Stack:** Snowflake + dbt + Power BI

## Models
| Layer | Purpose |
|-------|---------|
| staging | Clean, typed source models, 1:1 with correct grain |
| marts | Curated, business-facing models, dims and facts |
| reporing | Curated, business-facing models, specifically for pbi sitting on top of marts |

## Key decisions
- **Revenue grain:** orders (order grain); Also month grain in report_sales_revenue because targets at month grain
- **Gross Revenue:** orders with status `Completed` or `Invoiced`.
- **Net Revenue:** Gross − Discount − Tax.
- **Customers:** one row per customer, latest segment retained
- **Targets:** latest target per region/month

