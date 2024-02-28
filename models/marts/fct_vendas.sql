with
    localidades as (
        select *
        from {{ ref('dim_localidades') }}
    )

    , produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    , clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , motivos_vendas as (
        select *
        from {{ ref('dim_motivos_vendas') }}
    )

    , cartoes_credito as (
        select *
        from {{ ref('dim_cartoes_credito') }}
    )

    , int_vendas as (
        select *
        from {{ ref('int_vendas__pedido_itens') }}
    )

    , joined_tabelas as (
        select
            int_vendas.sk_venda_item
            , int_vendas.id_venda
            , int_vendas.id_venda_detalhe
            , int_vendas.id_cliente
            , int_vendas.id_endereco
            , int_vendas.id_cartao_credito
            , int_vendas.id_produto

            , int_vendas.data_venda
            , int_vendas.data_envio
            , int_vendas.data_entrega

            , clientes.nome_cliente            
            , localidades.nome_cidade
            , localidades.sigla_estado
            , localidades.nome_estado
            , localidades.nome_pais
            , int_vendas.status_venda
            , motivos_vendas.motivo_venda_agrupado
            , motivos_vendas.tipo_motivo_venda_agrupado
            , cartoes_credito.tipo_cartao_credito
            , produtos.nome_produto
            , produtos.numero_produto
            , produtos.cor_produto
            , produtos.nome_modelo
            , produtos.nome_subcategoria
            , produtos.nome_categoria

            , int_vendas.subtotal_liquido_pedido
            , int_vendas.imposto
            , int_vendas.imposto / count(int_vendas.id_venda) over(partition by int_vendas.id_venda) as imposto_ponderado
            , int_vendas.frete
            , int_vendas.frete / count(int_vendas.id_venda) over(partition by int_vendas.id_venda) as frete_ponderado
            , int_vendas.total_liquido_pedido

            , int_vendas.qtd_produto
            , int_vendas.preco_unitario_bruto
            , int_vendas.preco_total_bruto
            --, (int_vendas.qtd_venda * int_vendas.preco_unitario) as preco_total_bruto
            , int_vendas.desc_preco_unitario
            , int_vendas.preco_unitario_liquido
            , int_vendas.preco_total_liquido
            --, (int_vendas.preco_unitario - int_vendas.desc_preco_unitario) as preco_unitario_liquido
            --, (int_vendas.qtd_venda * (int_vendas.preco_unitario - int_vendas.desc_preco_unitario)) as preco_total_liquido

        from int_vendas
        left join produtos on
            int_vendas.id_produto = produtos.sk_produto
        left join clientes on
            int_vendas.id_cliente = clientes.sk_cliente
        left join localidades on
            int_vendas.id_endereco = localidades.sk_localidade
        left join motivos_vendas on
            int_vendas.id_venda = motivos_vendas.sk_motivo_venda
        left join cartoes_credito on
            int_vendas.id_cartao_credito = cartoes_credito.sk_cartao_credito
    )

    --select sum(preco_total_bruto) as preco_total_bruto, sum(preco_total_liquido) as preco_total_liquido
    select *
    from joined_tabelas
    --where data_venda between '2011-01-01' and '2011-12-31'
    -- vendas brutas no ano de 2011 foram de $12.646.112,16