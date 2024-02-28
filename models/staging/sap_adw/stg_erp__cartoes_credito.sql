with 
    fonte_cartao_credito as (
        select
            cast(creditcardid as int) as id_cartao_credito
            , cast(cardtype as string) as tipo_cartao_credito
            , cast(cardnumber as int) as num_cartao_credito
            , cast(expmonth as int) as mes_exp_cartao_credito
            , cast(expyear as int) as ano_exp_cartao_credito
        from {{ source('erp', 'creditcard') }}
    )

select *
from fonte_cartao_credito