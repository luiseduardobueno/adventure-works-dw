with 
    fonte_subcategoria_produtos as (
        select 
            cast(productsubcategoryid as int) as id_subcategoria
            , cast(productcategoryid as int) as id_categoria

            , cast(name as string) as nome_subcategoria
        from {{ source('erp', 'productsubcategory') }}
    )

select * 
from fonte_subcategoria_produtos