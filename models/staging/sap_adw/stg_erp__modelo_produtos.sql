with 
    fonte_modelo_produtos as (
        select 
            cast(productmodelid as int) as id_modelo
            , cast(name as string) as nome_modelo
        from {{ source('erp', 'productmodel') }}
    )

select * 
from fonte_modelo_produtos