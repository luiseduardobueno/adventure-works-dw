with 
    fonte_vendas_cabecalho as (
        select 
            cast(salesorderid as int) as id_venda
            , cast(customerid as int) as id_cliente
            , cast(shiptoaddressid as int) as id_endereco
            , cast(creditcardid as int) as id_cartao_credito
            
            , cast(cast(orderdate as datetime) as date) as data_venda
            , cast(cast(duedate as datetime) as date) as data_entrega
            , cast(cast(shipdate as datetime) as date) as data_envio

            , cast(status as int) as status_venda
            
            , cast(subtotal as numeric) as subtotal_liquido_pedido
            , cast(taxamt as numeric) as imposto
            , cast(freight as numeric) as frete
            , cast(totaldue as numeric) as total_liquido_pedido --subtotal + imposto + frete
        from {{ source('erp', 'salesorderheader') }}
    )

select * 
from fonte_vendas_cabecalho