with orders as (

    select
        order_id,
        location_id,
        customer_id,
        order_total,
        tax_paid,
        ordered_at
    from {{ ref('stg_orders') }}

),

order_items as (

    select
        order_id,
        product_id
    from {{ ref('stg_order_items') }}

),

products as (

    select
        product_id,
        is_food_item,
        is_drink_item
    from {{ ref('stg_products') }}

),

supplies as (

    select
        product_id,
        supply_cost
    from {{ ref('stg_supplies') }}

),

order_item_rollup as (

    select
        order_items.order_id,
        sum(supplies.supply_cost) as order_cost,
        sum(products.is_food_item) as count_food_items,
        sum(products.is_drink_item) as count_drink_items
    from order_items
    left join products
        on order_items.product_id = products.product_id
    left join supplies
        on order_items.product_id = supplies.product_id
    group by 1

),

final as (

    select
        orders.order_id,
        orders.location_id,
        orders.customer_id,
        orders.order_total,
        orders.tax_paid,
        orders.ordered_at,
        coalesce(order_item_rollup.count_food_items, 0) > 0 as is_food_order,
        coalesce(order_item_rollup.count_drink_items, 0) > 0 as is_drink_order,
        order_item_rollup.order_cost
    from orders
    left join order_item_rollup
        on orders.order_id = order_item_rollup.order_id

)

select * from final
