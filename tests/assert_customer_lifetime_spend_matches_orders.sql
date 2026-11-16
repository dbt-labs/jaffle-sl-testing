-- Eval for lifetime-value answers: each order total must contribute exactly once.
with expected as (
    select
        customer_id,
        sum(order_total) as lifetime_spend
    from {{ ref('orders') }}
    group by 1
),

actual as (
    select
        customer_id,
        lifetime_spend
    from {{ ref('customers') }}
)

select
    actual.customer_id,
    actual.lifetime_spend as actual_lifetime_spend,
    expected.lifetime_spend as expected_lifetime_spend
from actual
inner join expected using (customer_id)
where abs(actual.lifetime_spend - expected.lifetime_spend) > 0.001
