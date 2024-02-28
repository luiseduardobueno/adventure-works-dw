with 
    fonte_pessoas as (
        select
            cast(businessentityid as int) as id_pessoa
            , cast(firstname as string) as primeiro_nome
            , cast(lastname as string) as ultimo_nome
        from {{ source('erp', 'person') }}
    )

select * 
from fonte_pessoas