/* As vendas brutas no ano de 2011 foram de $12.646.112,16 */

with
    vendas_brutas_2011 as (
        select sum(preco_total_bruto) as vendas_brutas
        from {{ ref('fct_vendas') }}
        where data_venda between '2011-01-01' and '2011-12-31'
    )

select vendas_brutas
from vendas_brutas_2011
where vendas_brutas not between 12646112 and 12646113