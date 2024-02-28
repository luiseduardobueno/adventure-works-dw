with
    stg_vendas_detalhes as (
        select
            distinct id_produto
        from {{ ref('stg_erp__vendas_detalhes') }}
    )

    , stg_modelos as (
        select
            *
        from {{ ref('stg_erp__modelo_produtos') }}
    )

    , stg_subcategorias as (
        select
            *
        from {{ ref('stg_erp__subcategoria_produtos') }}
    )

    , stg_categorias as (
        select
            *
        from {{ ref('stg_erp__categoria_produtos') }}
    )

    , stg_produtos as (
        select
            *
        from {{ ref('stg_erp__produtos') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by stg_vendas_detalhes.id_produto) as sk_produto --surrogate key auto incremental
            , stg_produtos.id_produto
            --, stg_produtos.id_modelo
            --, stg_produtos.id_subcategoria
            --, stg_subcategorias.id_categoria
            , stg_produtos.nome_produto
            , stg_produtos.numero_produto
            , stg_produtos.cor_produto
            , stg_modelos.nome_modelo
            , stg_subcategorias.nome_subcategoria
            , stg_categorias.nome_categoria
        from stg_vendas_detalhes
        join stg_produtos on
            stg_vendas_detalhes.id_produto = stg_produtos.id_produto
        left join stg_modelos on
            stg_produtos.id_modelo = stg_modelos.id_modelo
        left join stg_subcategorias on
            stg_produtos.id_subcategoria = stg_subcategorias.id_subcategoria
        left join stg_categorias on
            stg_subcategorias.id_categoria = stg_categorias.id_categoria
    )

select *
from joined_tabelas