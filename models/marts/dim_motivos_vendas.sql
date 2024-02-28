with
    stg_vendas_cab_motivo as(
        select *
        from {{ ref('stg_erp__vendas_cab_motivos_vendas') }}
    )

    , stg_motivo_venda as(
        select *
        from {{ ref('stg_erp__vendas_motivos_vendas') }}
    )

    , joined_tabelas as (
        select
            stg_vendas_cab_motivo.id_venda
            , stg_motivo_venda.motivo_venda
            , stg_motivo_venda.tipo_motivo_venda
        from stg_vendas_cab_motivo
        left join stg_motivo_venda on
            stg_vendas_cab_motivo.id_motivo_venda = stg_motivo_venda.id_motivo_venda
    )

    , agrupamento as (
        select 
            id_venda as sk_motivo_venda
            , id_venda
            , string_agg(distinct motivo_venda, ', ') as motivo_venda_agrupado
            , string_agg(distinct tipo_motivo_venda, ', ') as tipo_motivo_venda_agrupado
        from joined_tabelas
        group by id_venda
    )

select *
from agrupamento