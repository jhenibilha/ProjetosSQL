-- Verificar se há valores ausentes na tabela campanhas
SELECT
    COUNT(CASE WHEN campanha_id IS NULL THEN 1 END) AS null_count_coluna1,
    COUNT(CASE WHEN nome IS NULL THEN 1 END) AS null_count_coluna2,
    COUNT(CASE WHEN data_inicio IS NULL THEN 1 END) AS null_count_coluna3,
	COUNT(CASE WHEN data_fim IS NULL THEN 1 END) AS null_count_coluna4,
	COUNT(CASE WHEN status IS NULL THEN 1 END) AS null_count_coluna5
FROM projeto10.campanhas_mkt;

-- Verificar se há valores ausentes na tabela clientes
SELECT
	COUNT(CASE WHEN cliente_id IS NULL THEN 1 END) AS contanulos1,
	COUNT(CASE WHEN nome IS NULL THEN 1 END) AS contanulos2,
	COUNT(CASE WHEN email IS NULL THEN 1 END) AS contanulos3,
	COUNT(CASE WHEN campanha_id IS NULL THEN 1 END) AS contanulos4
FROM projeto10.clientes_mkt;

-- Verificar se há valores ausentes na tabela vendas
SELECT
	COUNT(CASE WHEN venda_id IS NULL THEN 1 END) AS contanulos1,
	COUNT(CASE WHEN cliente_id IS NULL THEN 1 END) AS contanulos2,
	COUNT(CASE WHEN data_venda IS NULL THEN 1 END) AS contanulos3,
	COUNT(CASE WHEN valor IS NULL THEN 1 END) AS contanulos4
FROM projeto10.vendas_mkt;

-- Verificar os dados das tabelas

SELECT * FROM projeto10.campanhas_mkt;

SELECT * FROM projeto10.clientes_mkt;

SELECT * FROM projeto10.vendas_mkt;

-- Não funciona por causa da chave estrangeira no início da criação das tabelas

UPDATE projeto10.clientes_mkt
SET campanha_id = 0  
WHERE campanha_id IS NULL;

-- Verificar os valores distintos da coluna 'nome-campanha

SELECT DISTINCT nome
FROM projeto10.campanhas_mkt;

-- PERGUNTAS DE NEGÓCIO

-- 1. Quais clientes participaram da campanha "Promoção de Verão" e realizaram vendas?

SELECT cl.nome, ve.valor
FROM projeto10.clientes_mkt cl
INNER JOIN projeto10.campanhas_mkt ca ON cl.campanha_id = ca.campanha_id
INNER JOIN projeto10.vendas_mkt ve ON ve.cliente_id = ve.cliente_id
WHERE ca.nome = 'Promoção de Verão';

-- 2. Liste os clientes que se inscreveram na campanha "Campanha de Natal", mas não realizaram vendas até agora.
SELECT cl.nome, ve.valor
FROM projeto10.clientes_mkt cl
INNER JOIN projeto10.campanhas_mkt ca ON cl.campanha_id = ca.campanha_id
LEFT JOIN projeto10.vendas_mkt ve ON ve.cliente_id = ve.cliente_id
WHERE ca.nome = 'Campanha de Natal' AND ve.venda_id IS NULL;

-- obs: todos os clientes que se inscreveram na "Campanha de Natal" realizaram vendas

-- 3. Quais foram os valores totais de vendas gerados por cada campanha de marketing?

SELECT ca.nome AS campanha, SUM(v.valor) AS total_vendas
FROM projeto10.campanhas_mkt ca
LEFT JOIN projeto10.clientes_mkt c ON ca.campanha_id = c.campanha_id
LEFT JOIN projeto10.vendas_mkt v ON c.cliente_id = v.cliente_id
GROUP BY ca.nome;

-- 4. Quantos clientes participaram de cada campanha?

SELECT ca.nome AS campanha, COUNT(c.cliente_id) AS total_clientes
FROM projeto10.campanhas_mkt ca
LEFT JOIN projeto10.clientes_mkt c ON ca.campanha_id = c.campanha_id
GROUP BY ca.nome;

-- 5. Quais clientes participaram da campanha "Desconto do Mês" e qual foi o valor total de suas compras?

SELECT cl.nome AS cliente, ca.nome AS campanha, ve.valor
FROM projeto10.clientes_mkt cl
INNER JOIN projeto10.campanhas_mkt ca ON cl.campanha_id = ca.campanha_id
LEFT JOIN projeto10.vendas_mkt ve ON cl.cliente_id = ve.cliente_id
WHERE ca.nome = 'Desconto do Mês'
GROUP BY cl.nome, ca.nome, ve.valor;


-- 6. Preencher os valores nulos da coluna campanha_nome sem venda registrada

SELECT 
    cl.cliente_id,  
    cl.nome,        
    COALESCE(ca.nome, 'Não especificado') AS campanha_nome,  
    CASE 
        WHEN ve.valor IS NULL THEN 'sem venda'  
        ELSE CAST(ve.valor AS VARCHAR)  
    END AS valor_venda
FROM projeto10.clientes_mkt cl
LEFT JOIN projeto10.campanhas_mkt ca ON cl.campanha_id = ca.campanha_id  
LEFT JOIN projeto10.vendas_mkt ve ON cl.cliente_id = ve.cliente_id  
ORDER BY cl.cliente_id;








