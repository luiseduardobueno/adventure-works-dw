with
    stg_vendas as (
        select distinct 
            id_cartao_credito
        from {{ ref('stg_erp__vendas_cabecalho') }}
        where id_cartao_credito is not null
    )

    , stg_cartao as (
        select *
        from {{ ref('stg_erp__cartoes_credito') }}
    )
       
    , joined_tabelas as (
        select
            stg_vendas.id_cartao_credito as sk_cartao_credito
            , stg_cartao.id_cartao_credito
            , stg_cartao.tipo_cartao_credito
            , stg_cartao.num_cartao_credito
            , stg_cartao.mes_exp_cartao_credito
            , stg_cartao.ano_exp_cartao_credito
        from stg_vendas
        left join stg_cartao on
            stg_vendas.id_cartao_credito = stg_cartao.id_cartao_credito        
    )

select *
from joined_tabelas