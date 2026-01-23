with

source as (

    select * from {{ source('tpch', 'orders') }}

),

renamed as (

    select
        -- 主キー
        o_orderkey as order_key,

        -- 外部キー
        o_custkey as customer_key,

        -- 注文属性
        o_orderstatus as order_status,
        o_orderdate as order_date,
        o_orderpriority as order_priority,
        o_clerk as clerk,
        o_shippriority as ship_priority,

        -- 数値指標
        o_totalprice as total_price,

        -- その他
        o_comment as comment

    from source

)

select * from renamed
