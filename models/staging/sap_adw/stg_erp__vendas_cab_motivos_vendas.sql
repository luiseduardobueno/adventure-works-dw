with 
    fonte_vendas_cab_motivo_venda as (
        select 
            cast(salesorderid as int) as id_venda
            , cast(salesreasonid as int) as id_motivo_venda
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )

select *
from fonte_vendas_cab_motivo_venda 
