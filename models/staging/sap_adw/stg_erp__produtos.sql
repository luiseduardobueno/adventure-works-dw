with 
    fonte_produtos as (
        select
            cast(productid as int) as id_produto
            , cast(productsubcategoryid as int) as id_subcategoria
            , cast(productmodelid as int) as id_modelo

            , cast(productnumber as string) as numero_produto
            , cast(name as string) as nome_produto
            , cast(color as string) as cor_produto
        from {{ source('erp', 'product') }}
    )

select * 
from fonte_produtos