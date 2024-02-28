with 
    fonte_paises as (
        select 
            cast(countryregioncode as string) as id_pais
            , cast(name as string) as nome_pais 
        from {{ source('erp', 'countryregion') }}
    )

select * 
from fonte_paises