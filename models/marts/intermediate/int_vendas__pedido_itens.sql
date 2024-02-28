with
    stg_vendas as(
        select *
        from {{ ref('stg_erp__vendas_cabecalho') }}
    )

    , stg_vendas_detalhes as(
        select *
        from {{ ref('stg_erp__vendas_detalhes') }}
    )

    , joined_tabelas as (
        select
            stg_vendas.id_venda
            , stg_vendas_detalhes.id_venda_detalhe
            , stg_vendas.id_cliente
            , stg_vendas.id_endereco
            , stg_vendas.id_cartao_credito
            , stg_vendas_detalhes.id_produto

            , stg_vendas.data_venda
            , stg_vendas.data_entrega
            , stg_vendas.data_envio

            , case
            --Com base na documentação disponível em https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/tables/Sales_SalesOrderHeader_185.html
                when stg_vendas.status_venda = 1 then 'Em processo'
                when stg_vendas.status_venda = 2 then 'Aprovado'
                when stg_vendas.status_venda = 3 then 'Em espera'
                when stg_vendas.status_venda = 4 then 'Rejeitado'
                when stg_vendas.status_venda = 5 then 'Enviado'
                when stg_vendas.status_venda = 6 then 'Cancelado'
            end status_venda
            
            , stg_vendas.subtotal_liquido_pedido
            , stg_vendas.imposto
            , stg_vendas.frete
            , stg_vendas.total_liquido_pedido
            
            , stg_vendas_detalhes.qtd_produto
            , stg_vendas_detalhes.preco_unitario_bruto
            , (stg_vendas_detalhes.preco_unitario_bruto * stg_vendas_detalhes.qtd_produto) as preco_total_bruto
            , stg_vendas_detalhes.desc_preco_unitario
            , (stg_vendas_detalhes.preco_unitario_bruto * (1 - stg_vendas_detalhes.desc_preco_unitario)) as preco_unitario_liquido
            , (stg_vendas_detalhes.preco_unitario_bruto * (1 - stg_vendas_detalhes.desc_preco_unitario) * stg_vendas_detalhes.qtd_produto) as preco_total_liquido

        from stg_vendas_detalhes
        left join stg_vendas on
            stg_vendas_detalhes.id_venda = stg_vendas.id_venda
    )

    , criar_chave as (
        select
            cast(id_venda as string) || '-' || cast(id_venda_detalhe as string) as sk_venda_item
            , *
        from joined_tabelas
    )

select *
from criar_chave