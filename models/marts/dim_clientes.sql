with
    stg_clientes as (
        select
            id_cliente
            , id_pessoa
            , id_loja
        from {{ ref('stg_erp__clientes') }}
    )

    , stg_pessoas as (
        select
            id_pessoa
            , primeiro_nome || ' ' || ultimo_nome as nome_pessoa
        from {{ ref('stg_erp__pessoas') }}
    )

    , stg_lojas as (
        select
            id_loja
            , nome_loja
        from {{ ref('stg_erp__lojas') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by stg_clientes.id_cliente) as sk_cliente --surrogate key auto incremental
            , stg_clientes.id_cliente
            , stg_pessoas.id_pessoa
            , stg_lojas.id_loja
            , case
                when stg_pessoas.nome_pessoa is null
                    then stg_lojas.nome_loja
                else stg_pessoas.nome_pessoa
            end as nome_cliente
        from stg_clientes
        left join stg_pessoas on
            stg_clientes.id_pessoa = stg_pessoas.id_pessoa
        left join stg_lojas on
            stg_clientes.id_loja = stg_lojas.id_loja
    )

select *
from joined_tabelas