with 
    fonte_vendas_motivo_venda as (
        select
            cast(salesreasonid as int) as id_motivo_venda
            , cast(name as string) as motivo_venda
            , cast(reasontype as string) as tipo_motivo_venda
        from {{ source('erp', 'salesreason') }}
    )

select *
from fonte_vendas_motivo_venda