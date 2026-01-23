with

source as (

    select * from {{ source('tpch', 'region') }}

),

renamed as (

    select
        -- 主キー
        r_regionkey as region_key,

        -- 地域属性
        r_name as region_name,

        -- その他
        r_comment as comment

    from source

)

select * from renamed
