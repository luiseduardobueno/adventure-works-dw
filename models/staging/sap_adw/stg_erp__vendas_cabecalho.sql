with 
    fonte_vendas_cabecalho as (
        select 
            cast(salesorderid as int) as id_venda
            , orderdate as data_venda
            , duedate as data_entrega
            , shipdate as data_envio
            , cast(status as int) as status_venda
            , cast(customerid as int) as id_cliente
            , cast(shiptoaddressid as int) as id_endereco
            , cast(creditcardid as int) as id_cartao_credito
            , cast(subtotal as numeric) as subtotal_venda
            , cast(taxamt as numeric) as tx_imposto
            , cast(freight as numeric) as frete
            , cast(totaldue as numeric) as total_venda
        from {{ source('erp', 'salesorderheader') }}
    )

select * 
from fonte_vendas_cabecalho