-- Eval for repeat-purchase answers: repeat status is governed by lifetime order count.
select
    customer_id,
    count_lifetime_orders,
    is_repeat_buyer,
    customer_type
from {{ ref('customers') }}
where
    is_repeat_buyer != (count_lifetime_orders > 1)
    or customer_type != case
        when count_lifetime_orders > 1 then 'returning'
        when count_lifetime_orders = 1 then 'new'
        else 'prospect'
    end
