with 
    fonte_clientes as (
        select
            cast(customerid as int) as id_cliente,
            cast(personid as int) as id_pessoa,
            cast(storeid as int) as id_loja
        from {{ source('erp', 'customer') }}
    )

select * 
from fonte_clientes