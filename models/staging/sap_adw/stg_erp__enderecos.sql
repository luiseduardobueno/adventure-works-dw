with 
    fonte_enderecos as (
        select
            cast(addressid as int) as id_endereco
            , cast(stateprovinceid as int) as id_estado
            , cast(addressline1 as string) as endereco
            , cast(city as string) as nome_cidade
        from {{ source('erp', 'address') }}
    )

select * 
from fonte_enderecos