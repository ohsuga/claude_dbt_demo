with

orders_with_customer as (

    select * from {{ ref('int_orders__with_customer') }}

),

customer_order_summary as (

    select
        -- 顧客キー
        customer_key,

        -- 顧客属性（各顧客で一意のため、MAX/MINで取得）
        max(customer_name) as customer_name,
        max(market_segment) as market_segment,
        max(nation_name) as nation_name,
        max(region_key) as region_key,

        -- 集計指標
        count(distinct order_key) as total_orders,
        sum(total_price) as total_revenue,
        avg(total_price) as avg_order_value,

        -- 日付指標
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        datediff(day, min(order_date), max(order_date)) as customer_lifetime_days

    from orders_with_customer

    group by customer_key

),

final as (

    select
        -- 顧客識別
        customer_key,
        customer_name,
        market_segment,
        nation_name,
        region_key,

        -- 注文集計指標
        total_orders,
        total_revenue,
        avg_order_value,

        -- 日付指標
        first_order_date,
        last_order_date,
        customer_lifetime_days

    from customer_order_summary

)

select * from final
