with

source as (

    select * from {{ source('tpch', 'nation') }}

),

renamed as (

    select
        -- 主キー
        n_nationkey as nation_key,

        -- 国属性
        n_name as nation_name,

        -- 外部キー
        n_regionkey as region_key,

        -- その他
        n_comment as comment

    from source

)

select * from renamed
