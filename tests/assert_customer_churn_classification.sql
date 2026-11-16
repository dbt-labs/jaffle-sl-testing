-- Eval for churn answers: churn occurs after 90 days without an order as of data_as_of_at.
select
    customer_id,
    last_ordered_at,
    churned_at,
    data_as_of_at,
    is_churned
from {{ ref('customers') }}
where
    churned_at is distinct from last_ordered_at + interval '90 days'
    or is_churned != coalesce(churned_at <= data_as_of_at, false)
