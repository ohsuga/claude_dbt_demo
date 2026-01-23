with

source as (

    select * from {{ source('tpch', 'customer') }}

),

renamed as (

    select
        -- 主キー
        c_custkey as customer_key,

        -- 顧客属性
        c_name as customer_name,
        c_address as address,
        c_phone as phone,
        c_mktsegment as market_segment,

        -- 外部キー
        c_nationkey as nation_key,

        -- 数値指標
        c_acctbal as account_balance,

        -- その他
        c_comment as comment

    from source

)

select * from renamed
