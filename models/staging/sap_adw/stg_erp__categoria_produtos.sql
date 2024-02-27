with 
    fonte_categoria_produtos as (
        select
            cast(productcategoryid as int) as id_categoria
            , cast(name as string) as nome_categoria
        from {{ source('erp', 'productcategory') }}
    )

select * 
from fonte_categoria_produtos