{{
    config(
        materialized='table'
    )
}}

with

customers as (

    select * from {{ ref('stg_customers') }}

),

orders_mart as (

    select * from {{ ref('orders') }}

),

order_items_mart as (

    select * from {{ ref('order_items') }}

),

order_summary as (

    select
        customer_id,
        count(*) as count_lifetime_orders,
        min(ordered_at) as first_ordered_at,
        max(ordered_at) as last_ordered_at,
        sum(order_total) as lifetime_spend

    from orders_mart

    group by 1

),

order_item_summary as (

    select
        orders_mart.customer_id,
        sum(order_items_mart.subtotal) as lifetime_spend_pretax

    from orders_mart

    inner join order_items_mart
        on orders_mart.order_id = order_items_mart.order_id

    group by 1

),

joined as (

    select
        customers.*,
        order_summary.count_lifetime_orders,
        order_summary.first_ordered_at,
        order_summary.last_ordered_at,
        order_item_summary.lifetime_spend_pretax,
        order_summary.lifetime_spend,
        coalesce(order_summary.count_lifetime_orders, 0) > 1 as is_repeat_buyer,

        case
            when coalesce(order_summary.count_lifetime_orders, 0) > 1 then 'returning'
            else 'new'
        end as customer_type

    from customers

    left join order_summary
        on customers.customer_id = order_summary.customer_id

    left join order_item_summary
        on customers.customer_id = order_item_summary.customer_id

)

select * from joined
