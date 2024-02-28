with 
    fonte_estados as (
        select
            cast(stateprovinceid as int) as id_estado 
            , cast(territoryid as int) as id_territorio
            , cast(countryregioncode as string) as id_pais
            , cast(stateprovincecode as string) as sigla_estado
            , cast(name as string) as nome_estado 
        from {{ source('erp', 'stateprovince') }}
    )

select * 
from fonte_estados