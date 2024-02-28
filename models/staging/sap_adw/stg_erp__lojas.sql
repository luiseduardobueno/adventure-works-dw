with 
    fonte_lojas as (
        select
            cast(businessentityid as int) as id_loja
            , cast(name as string) as nome_loja
        from {{ source('erp', 'store') }}
    )

select * 
from fonte_lojas