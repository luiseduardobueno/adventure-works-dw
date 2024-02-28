with
    stg_vendas as (
        select
            distinct id_endereco
        from {{ ref('stg_erp__vendas_cabecalho') }}
    )
    
    , stg_enderecos as (
        select
            *
        from {{ ref('stg_erp__enderecos') }}
    )

    , stg_estados as (
        select
            *
        from {{ ref('stg_erp__estados') }}
    )

    , stg_paises as (
        select
            *
        from {{ ref('stg_erp__paises') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by stg_vendas.id_endereco) as sk_localidade --surrogate key auto incremental
            , stg_vendas.id_endereco
            , stg_estados.id_estado
            , stg_paises.id_pais
            , stg_enderecos.endereco
            , stg_enderecos.nome_cidade
            , stg_estados.sigla_estado
            , stg_estados.nome_estado
            , stg_paises.nome_pais
        from stg_vendas
        left join stg_enderecos on
            stg_vendas.id_endereco = stg_enderecos.id_endereco
        left join stg_estados on
            stg_enderecos.id_estado = stg_estados.id_estado
        left join stg_paises on
            stg_paises.id_pais = stg_estados.id_pais
        
    )

select *
from joined_tabelas