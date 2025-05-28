-- 1. Qual é o total de clientes?

SELECT COUNT(*) AS total_clientes
FROM projeto13.clientesABC;

-- 2. Qual é o total de clientes por cidade?

SELECT cidade_cliente, COUNT(*) AS total_clientes
FROM projeto13.clientesABC
GROUP BY cidade_cliente
ORDER BY total_clientes DESC;

-- 3. Quais clientes fizeram pedidos?

SELECT c.nome_cliente, COUNT(p.id_pedido) AS total_pedidos
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.nome_cliente
ORDER BY total_pedidos DESC;

-- 4. Qual a contagem de pedidos de clientes do estado do RJ ou SP?

SELECT c.estado_cliente, COUNT(p.id_pedido) AS total_pedido
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
WHERE estado_cliente = 'SP' OR estado_cliente = 'RJ'
GROUP BY c.estado_cliente;

-- 5. Qual é o maior valor de pedidos?

SELECT MAX(valor_pedido) AS max_valor_pedido
FROM projeto13.pedidosABC;

-- 6. Qual é o menor valor de pedidos?

SELECT MIN(valor_pedido) AS min_valor_pedido
FROM projeto13.pedidosABC;

-- 7. Quais clientes fizeram e não fizeram pedidos?

SELECT c.nome_cliente, COUNT(p.id_pedido) AS total_pedidos
FROM projeto13.clientesABC c
LEFT JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.nome_cliente
ORDER BY total_pedidos DESC;

-- 8. Qual é a média dos valores pedidos?

SELECT ROUND(AVG(valor_pedido), 2) AS media_valor_pedido
FROM projeto13.pedidosABC;

-- 9. Qual é a média dos valores pedidos por cidade?

SELECT c.cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media_valor_pedido
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.cidade_cliente
ORDER BY media_valor_pedido;

-- 10. Qual é a média dos valores pedidos e não pedidos por cidade?

SELECT c.cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media_valor_pedido
FROM projeto13.clientesABC c
LEFT JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.cidade_cliente
ORDER BY media_valor_pedido;

-- 11. Coloque "sem pedido" para as cidades sem pedido

SELECT c.cidade_cliente, 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 'Não Houve Pedido' 
        ELSE CAST(ROUND(AVG(valor_pedido), 2) AS VARCHAR)
    END AS media_valor_pedido
FROM projeto13.clientesABC c
    LEFT JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.cidade_cliente
ORDER BY media_valor_pedido DESC;

-- 12. Coloque "0" para as cidades sem pedido

SELECT c.cidade_cliente, 
    CASE 
        WHEN ROUND(AVG(valor_pedido), 2) IS NULL THEN 0
        ELSE ROUND(AVG(valor_pedido), 2)
    END AS media_valor_pedido
FROM projeto13.clientesABC c
    LEFT JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.cidade_cliente
ORDER BY media_valor_pedido DESC;

-- 13. Qual foi o produto mais pedido?

SELECT pr.nome_produto, SUM(p.valor_pedido) AS total_valor_pedido
FROM projeto13.produtosABC pr
INNER JOIN projeto13.pedidosABC p ON pr.id_prod = p.id_produto
GROUP BY pr.nome_produto
LIMIT 1;

-- 14. Qual é a soma total do valor dos pedidos por cidade?

SELECT c.cidade_cliente, SUM(valor_pedido) AS total_valor_pedido
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.cidade_cliente
ORDER BY total_valor_pedido DESC;

-- 15. Qual é a soma total do valor dos pedidos por estado?

SELECT c.estado_cliente, SUM(valor_pedido) AS total_valor_pedido
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
GROUP BY c.estado_cliente
ORDER BY total_valor_pedido DESC;

-- 16. Qual é a soma total do valor dos pedidos por cidade e estado?

SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total_valor_pedido
FROM projeto13.pedidosABC p, projeto13.clientesABC c
WHERE p.id_cliente = c.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total_valor_pedido DESC;

-- 17. Qual é a soma total do valor dos pedidos por cidade e estado dos que fizeram e não fizeram pedidos?

SELECT c.estado_cliente, SUM(valor_pedido) AS total_valor_pedido
FROM projeto13.pedidosABC p
RIGHT JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
GROUP BY c.estado_cliente
ORDER BY total_valor_pedido ASC;

-- 18. Altere a tabela de produtos e acrescenta uma coluna chamada de custos

ALTER TABLE IF EXISTS projeto13.produtosABC
ADD COLUMN custo DECIMAL(10, 2) NULL;

-- 19. Atualize a coluna de custos e inclua valores fictícios

UPDATE  projeto13.produtosABC
SET custo = 40 + (id_prod - 1) * 0.9
WHERE id_prod BETWEEN 10101 AND 12100;

-- 20. Qual é o custo total dos pedidos por estado?

SELECT c.estado_cliente, SUM(pr.custo) AS custo_total
FROM projeto13.clientesABC c
INNER JOIN projeto13.pedidosABC p ON c.id_cli = p.id_cliente
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
GROUP BY c.estado_cliente
ORDER BY custo_total DESC;

-- 21. Qual é o custo total considerando todos os estados?

SELECT SUM(custo) AS custo_total
FROM projeto13.produtosABC;

-- 22. Os produtos vendidos para os clientes do estado do RS tiveram um aumento de custo de 15%.
-- Demonstre isso no relatório sem modificar os dados na tabela.

SELECT c.estado_cliente,
    SUM(
        CASE 
            WHEN c.estado_cliente = 'RS' THEN pr.custo * 1.5
            ELSE pr.custo
        END
    ) AS custo_total
FROM projeto13.pedidosABC p
INNER JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
GROUP BY c.estado_cliente
ORDER BY custo_total DESC;

-- 23. Qual é o custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Pipelines' no nome?

SELECT c.estado_cliente, SUM(pr.custo) AS custo_total
FROM projeto13.pedidosABC p
INNER JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Pipelines%' 
GROUP BY c.estado_cliente
ORDER BY custo_total DESC;

-- 24. Retorne as seguintes informações:

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Pipelines' no nome
-- Somente se o custo total for menor do que 110000
-- Demonstre no relatório o aumento de 15% no custo para pedidos de clientes do RS

SELECT c.estado_cliente,
    SUM(
        CASE 
            WHEN c.estado_cliente = 'RS' THEN pr.custo * 1.5
            ELSE pr.custo
        END
    ) AS custo_total
FROM projeto13.pedidosABC p
INNER JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Pipelines%' 
GROUP BY c.estado_cliente
HAVING SUM(pr.custo) < 110000
ORDER BY custo_total DESC;

-- 25. Retorne as seguintes informações:

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Pipelines' no nome
-- Somente se o custo total estiver entre 150000 e 300000
-- Demonstre no relatório o aumento de 15% no custo para pedidos de clientes do RS

SELECT c.estado_cliente,
	SUM(
		CASE 
			WHEN c.estado_cliente = 'RS' THEN pr.custo * 1.5
			ELSE pr.custo
    	END
	) AS custo_total
FROM projeto13.pedidosABC p
INNER JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Pipelines%'
GROUP BY c.estado_cliente
HAVING SUM(pr.custo) BETWEEN 10000 AND 50000
ORDER BY custo_total DESC;


-- 26. Retorne as seguintes informações:

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Pipelines' no nome
-- Somente se o custo total estiver entre 150000 e 300000
-- Demonstre no relatório o aumento de 15% no custo para pedidos de clientes do RS
-- Inclua no relatório uma coluna chamada status_aumento com o texto 'Com Aumento de Custo' se o estado for RS e o texto
-- 'Sem Aumento de Custo' se for qualquer outro estado

SELECT c.estado_cliente,
    SUM(
        CASE 
            WHEN c.estado_cliente = 'RS' THEN pr.custo * 1.5
            ELSE pr.custo
        END
    ) AS custo_total,
    CASE 
        WHEN c.estado_cliente = 'RS' THEN 'Com Aumento de Custo'
        ELSE 'Sem Aumento de Custo'
    END AS status_aumento
FROM projeto13.pedidosABC p
INNER JOIN projeto13.clientesABC c ON p.id_cliente = c.id_cli
INNER JOIN projeto13.produtosABC pr ON p.id_produto = pr.id_prod
WHERE nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Pipelines%'
GROUP BY c.estado_cliente
HAVING SUM(pr.custo) BETWEEN 10000 AND 50000
ORDER BY custo_total DESC;







SELECT * FROM projeto13.clientesABC;

SELECT * FROM projeto13.pedidosABC;

SELECT * FROM projeto13.produtosABC;