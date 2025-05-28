SELECT * FROM projeto17.lancamentosdsacontabeis;

-- 1. Crie uma query que deve mostrar: contagem_lancamentos, total_valores_lançamentos, media_valores_lançamentos,
-- maior_valor, menor_valor, soma_valores_usd, soma_valores_eur, soma_valores_brl, media_taxa_conversao e mediana_valores

SELECT
    centro_custo,
    COUNT(*) AS contagem_lancamentos,
    SUM(valor) AS total_valores_lançamentos,
    ROUND(AVG(valor), 2) AS media_valores_lançamentos,
    MAX(valor) AS maior_valor,
    MIN(valor) AS menor_valor,
    SUM(CASE WHEN moeda = 'USD' THEN valor ELSE 0 END) AS soma_valores_usd,
    SUM(CASE WHEN moeda = 'EUR' THEN valor ELSE 0 END) AS soma_valores_eur,
    SUM(CASE WHEN moeda = 'BRL' THEN valor ELSE 0 END) AS soma_valores_brl,
    ROUND(AVG(CASE WHEN taxa_conversao IS NOT NULL THEN taxa_conversao ELSE 0 END), 2) AS media_taxa_conversao,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor) AS mediana_valores
-- WITHIN GROUP define como os dados devem ser ordenados antes de calcular o percentil.
FROM projeto17.lancamentosdsacontabeis
GROUP BY centro_custo
ORDER BY total_valores_lançamentos DESC;

-- 2. Crie uma query para mostrar a quantidade_lancamentos, media_valor, desvio_padrao_valor, menor_valor, 
-- maior_valor e primeiro, segundo e terceiro quartil.
-- Faça tudo isso por centro de custo e por moeda.

SELECT
    centro_custo, moeda,
    COUNT(*) AS quantidade_lançamentos,
    ROUND(AVG(valor), 2) AS media_valores_lançamentos,
	ROUND(STDDEV(valor), 2) AS desvio_padrao_valor,
    MAX(valor) AS maior_valor,
    MIN(valor) AS menor_valor,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS primeiro_quartil,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor) AS segundo_quartil,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS terceiro_quartil
FROM projeto17.lancamentosdsacontabeis
GROUP BY centro_custo, moeda
ORDER BY quantidade_lançamentos DESC;


-- 3. Aqui estão os requisitos do relatório:
-- Calcule valor total dos lançamentos, média dos lançamentos, contagem dos lançamentos
-- Calcule a média do valor de taxa de conversão somente se a moeda for diferente de BRL
-- Crie ranking por valor total dos lançamentos, por média do valor dos lançamentos e por média da taxa de conversão
-- Queremos o resultado somente se o centro de custo for Compras ou RH 

SELECT
    centro_custo, moeda,
    SUM(valor) AS total_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY SUM(valor) DESC) AS rank_total_valor, -- ranking da soma
    ROUND(AVG(valor), 2) AS media_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY AVG(valor) DESC) AS rank_media_valor, -- ranking da média de lançamentos
    COUNT(*) AS numero_de_lancamentos,
    COALESCE(ROUND(AVG(taxa_conversao) FILTER (WHERE moeda != 'BRL'), 2), 0) AS media_taxa_conversao,
    DENSE_RANK() OVER (ORDER BY COALESCE(ROUND(AVG(taxa_conversao) FILTER (WHERE moeda != 'BRL'),2), 0) DESC) AS rank_media_taxa
-- ranking da média da taxa de conversão
FROM projeto17.lancamentosdsacontabeis 
WHERE centro_custo IN ('Compras', 'RH')
GROUP BY centro_custo, moeda
ORDER BY rank_total_valor, rank_media_valor, rank_media_taxa;

-- 4. Crie a query que identifique os outliers (se existirem), por centro de custo e moeda.
-- Os valores abaixo de Q1 - 1.5 * IQR ou acima de Q3 + 1.5 * IQR serão considerados outliers.

-- Contagem total de lançamentos
SELECT COUNT(*) FROM projeto17.lancamentosdsacontabeis;

-- Retornando média, mediana, máximo e mínimo
SELECT 
    ROUND(AVG(valor),2) AS media, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS mediana,
    MAX(valor) as maximo,
    MIN(VALOR) as minimo
FROM projeto17.lancamentosdsacontabeis;

-- Verificando outliers por meio de Resumo Estatístico
SELECT 
    centro_custo, moeda,
    MIN(VALOR) as minimo_valor, -- valor mínimo
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1, -- limite inferior ou primeiro quartil
    ROUND(AVG(valor), 2) AS media_valor,  -- média, pode ser afetada por outliers
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2, -- mediana, não é afetada por outliers
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3, -- limite superior ou terceiro quartil
    MAX(valor) as maximo_valor -- valor máximo
FROM projeto17.lancamentosdsacontabeis
GROUP BY centro_custo, moeda;

-- Calculando os limites para detecção de outliers com base no Intervalo Interquartil (IQR).

--							IQR = Q3 - Q1 (mede onde estão os valores "normais")

SELECT 
    centro_custo, moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) - 1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_inferior,
--  Limite inferior
--  PERCENTILE_CONT(0.25) - 1.5 * (Q3 - Q1) AS limite_inferior, ou seja, Q1 - 1.5 * IQR
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1, -- calcula o primeiro quartil
    ROUND(AVG(valor),2) AS media_valor, -- calcula a média
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2, -- calcula a mediana
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3, -- calcula o terceiro quartil
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) + 1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_superior,
-- Limite superior
-- PERCENTILE_CONT(0.75) + 1.5 * (Q3 - Q1) AS limite_superior, ou seja, Q3 + 1.5 * IQR 
   MAX(valor) as maximo_valor
FROM projeto17.lancamentosdsacontabeis
GROUP BY centro_custo, moeda;

-- 5. Crie a query que identifique os outliers (se existirem), por centro de custo e moeda.
-- Os valores abaixo de Q1 - 0.5 * IQR ou acima de Q3 + 0.5 * IQR serão considerados outliers.

SELECT 
    centro_custo, moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) - 0.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_inferior,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) + 0.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_superior,
    MAX(valor) as maximo_valor
FROM projeto17.lancamentosdsacontabeis
GROUP BY centro_custo, moeda;

-- 6. Quais lançamentos contábeis possuem valores fora do intervalo esperado (potenciais outliers),
-- por centro de custo e moeda?

-- CTE para calcular o primeiro e terceiro quartil para cada combinação de centro de custo e moeda
WITH Estatisticas AS (
    SELECT
        centro_custo, moeda,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3
    FROM projeto17.lancamentosdsacontabeis
    GROUP BY centro_custo, moeda
),
-- CTE para calcular os limites inferior e superior com base no intervalo interquartil (IQR)
LimitesOutliers AS (
    SELECT
        centro_custo,
        moeda,
        q1,
        q3,
        q1 - 0.5 * (q3 - q1) AS limite_inferior,
        q3 + 0.5 * (q3 - q1) AS limite_superior
    FROM Estatisticas
)
-- Query para selecionar todos os lançamentos que estão fora dos limites definidos
SELECT
    L.id,
    L.data_lancamento,
    L.centro_custo,
    L.moeda,
    L.valor
FROM projeto17.lancamentosdsacontabeis L
INNER JOIN LimitesOutliers E ON L.centro_custo = E.centro_custo AND L.moeda = E.moeda
WHERE L.valor < E.limite_inferior OR L.valor > E.limite_superior
ORDER BY L.valor, L.centro_custo, L.moeda;

-- 7. Crie uma query que mostre o centro de custo, a conta crédito, a data de lançamento, o valor, a média móvel de 3 dias
-- (considerando 2 dias anteriores e a data atual) e o ranking por média móvel em ordem decrescente.
-- O cálculo da média móvel deve ser particionado por centro de custo, considerando a ordem da data de lançamento
-- O ranking deve ser particionado por data e ordenado pela média móvel em ordem decrescente

-- Identifique o erro de lógica na query abaixo:
WITH LancamentosOrdenados AS (
    SELECT data_lancamento, centro_custo, conta_credito, valor,
		ROW_NUMBER() OVER (PARTITION BY centro_custo ORDER BY data_lancamento) AS ordem
    FROM projeto17.lancamentosdsacontabeis
),
MediaMovel AS (
    SELECT
        centro_custo,
        data_lancamento,
        conta_credito,
        valor,
        ROUND(AVG(valor) OVER (PARTITION BY centro_custo ORDER BY ordem ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2
		) AS media_movel_3dias
    FROM LancamentosOrdenados 
)
SELECT
    centro_custo, conta_credito, data_lancamento, valor, media_movel_3dias,
    DENSE_RANK() OVER (PARTITION BY data_lancamento ORDER BY media_movel_3dias DESC) AS rank_media_movel
FROM MediaMovel 
ORDER BY data_lancamento, rank_media_movel;
