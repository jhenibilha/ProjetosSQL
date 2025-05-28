SELECT * FROM projeto16.livraria;

-- 1. Qual o total de unidades vendidas por cada funcionário, ao longo dos anos?

SELECT 
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    SUM(unidades_vendidas) OVER (PARTITION BY funcionario) AS total_vendido_funcionario
FROM projeto16.livraria;

-- 2. Qual foi a média de vendas mensal de cada funcionário em cada ano?

SELECT 
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario, ano), 2) AS media_mensal_ano
FROM projeto16.livraria;

-- 3. Qual foi o crescimento percentual das vendas em Setembro de um ano para o ano seguinte, por funcionário?

WITH setembro_vendas AS (
    SELECT 
        funcionario,
        ano,
        unidades_vendidas,
        LAG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano) AS vendas_ano_anterior
    FROM projeto16.livraria
    WHERE mes = 'Setembro'
)
SELECT 
    funcionario,
    ano,
    unidades_vendidas,
    vendas_ano_anterior,
    ROUND(((unidades_vendidas - vendas_ano_anterior) / vendas_ano_anterior) * 100, 2) AS crescimento_percentual
FROM setembro_vendas
WHERE vendas_ano_anterior IS NOT NULL;

-- 4. Quais funcionários apresentaram aumento contínuo de vendas em "Julho" ao longo dos anos?

WITH vendas_julho AS (
    SELECT 
        funcionario,
        ano,
        unidades_vendidas,
        LAG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano) AS vendas_ano_anterior
    FROM projeto16.livraria
    WHERE mes = 'Julho'
)
SELECT funcionario
FROM vendas_julho
WHERE unidades_vendidas > vendas_ano_anterior
GROUP BY funcionario
HAVING COUNT(*) = 2;  -- Houve 3 anos, então dois aumentos consecutivos

-- 5. Qual foi o ranking mensal de vendas por funcionário?

SELECT 
    ano,
    mes,
    funcionario,
    unidades_vendidas,
    RANK() OVER (PARTITION BY ano, mes ORDER BY unidades_vendidas DESC) AS rank_mensal
FROM projeto16.livraria;

-- 6. Qual o total acumulado de vendas por funcionário ao longo do tempo?

SELECT 
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    SUM(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, 
        CASE mes 
            WHEN 'Julho' THEN 1 
            WHEN 'Setembro' THEN 2 
        END
    ) AS acumulado_vendas
FROM projeto16.livraria;

-- 7. Qual foi a maior venda mensal realizada por cada funcionário?

SELECT 
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    MAX(unidades_vendidas) OVER (PARTITION BY funcionario) AS maior_venda
FROM projeto16.livraria;

-- 8. Qual foi a diferença de vendas entre os meses de Julho e Setembro de cada ano, por funcionário?

WITH julho AS (
    SELECT funcionario, ano, unidades_vendidas AS vendas_julho
    FROM projeto16.livraria
    WHERE mes = 'Julho'
),
setembro AS (
    SELECT funcionario, ano, unidades_vendidas AS vendas_setembro
    FROM projeto16.livraria
    WHERE mes = 'Setembro'
)
SELECT 
    j.funcionario,
    j.ano,
    j.vendas_julho,
    s.vendas_setembro,
    s.vendas_setembro - j.vendas_julho AS diferenca
FROM julho j
JOIN setembro s ON j.funcionario = s.funcionario AND j.ano = s.ano;

-- 9. Qual funcionário teve o maior volume de vendas em cada mês do ano?

WITH ranking AS (
    SELECT 
        ano, mes, funcionario, unidades_vendidas,
        ROW_NUMBER() OVER (PARTITION BY ano, mes ORDER BY unidades_vendidas DESC) AS posicao
-- ROW_NUMBER() numera as linhas dentro de uma partição
    FROM projeto16.livraria
)
SELECT 
    ano, mes, funcionario, unidades_vendidas
FROM ranking
WHERE posicao = 1;

-- 10. Qual a média de crescimento ano a ano, por funcionário?

WITH crescimento AS ( -- CTE "crescimento'"
    SELECT 
        funcionario, ano, mes, unidades_vendidas, -- CTE seleciona essas colunas
        LAG(unidades_vendidas) OVER (PARTITION BY funcionario, mes ORDER BY ano) AS vendas_ano_anterior
-- Usa LAG para buscar as unidades vendidas no mesmo mês, porém no ano anterior, para cada funcionário.
    FROM projeto16.livraria
),
crescimento_percentual AS ( -- CTE "crescimento_percentual"
    SELECT 
        funcionario, mes, ano,
        ROUND(((unidades_vendidas - vendas_ano_anterior) / vendas_ano_anterior) * 100, 2) AS crescimento
    FROM crescimento
    WHERE vendas_ano_anterior IS NOT NULL
)
SELECT 
    funcionario, mes,
    ROUND(AVG(crescimento), 2) AS media_crescimento_percentual
FROM crescimento_percentual
GROUP BY funcionario, mes;







