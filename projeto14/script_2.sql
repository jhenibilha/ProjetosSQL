SELECT * FROM projeto14.vendasrc;

-- 1. Qual é o faturamento total por ano?

SELECT ano, SUM(faturamento) AS total_faturamento
FROM projeto14.vendasrc
GROUP BY ano;

-- 2. Qual é o faturamento total por ano e total geral?

SELECT ano,SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY ROLLUP(ano);

-- 3. Qual é o faturamento total por ano e total geral, substituindo o "null"?

SELECT COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano, SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY ROLLUP(ano)
ORDER BY ano;

-- 4. Qual é o faturamento total por ano e pais e total geral?

SELECT 
	COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY ROLLUP(ano, pais)
ORDER BY ano, pais;

-- 5. Qual é o faturamento total por ano e pais e total geral do ano e do país?

SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY CUBE(ano, pais)
ORDER BY ano, pais;

-- 6. Qual é o faturamento total por ano e produto e total geral?

SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY CUBE(ano, produto);

-- 7. Qual é o faturamento total por ano e produto e total geral?

SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM projeto14.vendasrc
GROUP BY ROLLUP(ano, produto)
ORDER BY GROUPING(produto), ano, faturamento_total;


-- 8. Qual é o faturamento total por ano e país e total geral com agrupamento do resultado?

SELECT
    CASE 
        WHEN GROUPING(ano) = 1 THEN 'Total de Todos os Anos'
        ELSE CAST(ano AS VARCHAR)
    END AS ano,
    CASE 
        WHEN GROUPING(pais) = 1 THEN 'Total de Todos os Países'
        ELSE pais
    END AS pais,
    CASE 
        WHEN GROUPING(produto) = 1 THEN 'Total de Todos os Produtos'
        ELSE produto
    END AS produto,
    SUM(faturamento) AS faturamento_total 
FROM projeto14.vendasrc
GROUP BY ROLLUP(ano, pais, produto)
ORDER BY GROUPING(produto, ano, pais), faturamento_total; -- ordenado pelo faturamento_total

-- 9. Qual é o faturamento total por país em 2024 mostrando todos os produtos vendidos como uma lista?

SELECT 
    pais,
    STRING_AGG(produto, ', ') AS produtos_vendidos,
    SUM(faturamento) AS faturamento_total 
FROM projeto14.vendasrc
WHERE ano = 2024
GROUP BY pais;


