with 
    fonte_vendas_detalhes as (
        select 
            cast(salesorderid as int) as id_venda
            , cast(salesorderdetailid as int) as id_venda_detalhe
            , cast(productid as int) as id_produto
            
            , cast(orderqty as int) as qtd_produto
            , cast(unitprice as numeric) as preco_unitario_bruto
            , cast(unitpricediscount as numeric) as desc_preco_unitario
        from {{ source('erp', 'salesorderdetail') }}
    )

select * 
from fonte_vendas_detalhes