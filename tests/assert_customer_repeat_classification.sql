-- Eval for repeat-purchase answers: repeat status is governed by lifetime order count.
select
    customer_id,
    count_lifetime_orders,
    is_repeat_buyer,
    customer_type
from {{ ref('customers') }}
where
    is_repeat_buyer != (coalesce(count_lifetime_orders, 0) > 1)
    or customer_type != case
        when coalesce(count_lifetime_orders, 0) > 1 then 'returning'
        else 'new'
    end
