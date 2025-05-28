SELECT * FROM projeto15.assinaturas_saas;

SELECT * FROM projeto15.clientes_saas;

-- 1. Qual a média de valor mensal por plano e o valor individual comparado a essa média?

SELECT plano, valor_mensal,
    ROUND(AVG(valor_mensal) OVER(PARTITION BY plano), 2) AS media_plano
FROM projeto15.assinaturas_saas;

-- 2. Qual o valor total por cliente e o total acumulado por cliente ao longo das assinaturas?

SELECT cliente_id, plano, valor_mensal,
    SUM(valor_mensal) OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS acumulado_cliente
FROM projeto15.assinaturas_saas;

-- 3. O cliente de id = 1 fez uma nova assinatura com outro plano, como incluir na tabela?

INSERT INTO projeto15.assinaturas_saas (cliente_id, plano, valor_mensal, status, data_inicio, data_fim)
VALUES (1, 'Pro', 199.90, 'ativa', '2024-02-15', NULL);

-- 4. O cliente de id = 2 fez uma nova assinatura com o mesmo plano, como incluir na tabela?

INSERT INTO projeto15.assinaturas_saas (cliente_id, plano, valor_mensal, status, data_inicio, data_fim)
VALUES (2, 'Basic', 79.90, 'ativa', '2024-06-01', NULL);

-- Deleção de registro e posteriormente inserção dos registros anteriores novamente

DELETE FROM projeto15.assinaturas_saas
WHERE cliente_id = 1
  AND plano = 'Pro'
  AND valor_mensal = 199.90
  AND status = 'ativa'
  AND data_inicio = '2024-05-21'
  AND data_fim IS NULL;

DELETE FROM projeto15.assinaturas_saas
WHERE cliente_id = 2
  AND plano = 'Basic'
  AND valor_mensal = 79.90
  AND status = 'ativa'
  AND data_inicio = '2024-05-20'
  AND data_fim IS NULL;

DELETE FROM projeto15.assinaturas_saas
WHERE cliente_id = 2
  AND plano = 'Basic'
  AND valor_mensal = 199.90
  AND status = 'ativa'
  AND data_inicio = '2024-05-20'
  AND data_fim IS NULL;

-- 5. Qual a data da próxima assinatura por cliente (lead time)?

SELECT cliente_id, data_inicio,
    LEAD(data_inicio) OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS proxima_assinatura
FROM projeto15.assinaturas_saas;

-- 6. Qual a data da assinatura anterior por cliente?

SELECT cliente_id, data_inicio,
    LAG(data_inicio) OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS assinatura_anterior
FROM projeto15.assinaturas_saas;

-- 7. Qual a classificação da assinatura mais cara dentro de cada plano?
-- (Como os planos têm o mesmo valor, a classificação foi igual para todos os planos)

SELECT plano, valor_mensal,
    RANK() OVER(PARTITION BY plano ORDER BY valor_mensal DESC) AS rank_valor
FROM projeto15.assinaturas_saas;

-- 8. Quantas assinaturas existem por cliente até o momento?

SELECT cliente_id, data_inicio,
    COUNT(*) OVER (
        PARTITION BY cliente_id 
        ORDER BY data_inicio 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS numero_assinaturas
FROM projeto15.assinaturas_saas
ORDER BY cliente_id, data_inicio;


-- 9. Qual o valor médio das assinaturas até o momento atual para cada cliente (média acumulada)?

SELECT  cliente_id, data_inicio, valor_mensal,
    ROUND(
		AVG(valor_mensal) OVER(
		PARTITION BY cliente_id ORDER BY data_inicio ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		), 2) AS media_acumulada
FROM projeto15.assinaturas_saas;

-- 10. Qual o primeiro plano assinado por cada cliente?

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS ordem
    FROM projeto15.assinaturas_saas
) AS subquery
WHERE ordem = 1;

-- 11. Qual o tempo entre cada assinatura para um cliente?

SELECT cliente_id, data_inicio,
    LAG(data_inicio) OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS data_anterior,
    data_inicio - LAG(data_inicio) OVER(PARTITION BY cliente_id ORDER BY data_inicio) AS dias_entre
FROM projeto15.assinaturas_saas;

-- 12. Qual o valor total mensal por cliente comparado ao total geral?

SELECT cliente_id,
    SUM(valor_mensal) OVER(PARTITION BY cliente_id) AS total_cliente,
    SUM(valor_mensal) OVER() AS total_geral
FROM projeto15.assinaturas_saas;

-- 13. Quais os 3 maiores valores de assinatura por cliente?

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY cliente_id ORDER BY valor_mensal DESC) AS rank_valor
    FROM projeto15.assinaturas_saas
) AS subquery
WHERE rank_valor <= 3;

-- 14. Quantos clientes únicos assinaram por plano?

SELECT
    plano,
    COUNT(DISTINCT cliente_id) AS clientes_por_plano
FROM projeto15.assinaturas_saas
GROUP BY plano;




