SELECT * FROM projeto2.clientes_loja_piscina;

SELECT * FROM projeto2.produtos_loja_piscina;

SELECT * FROM projeto2.vendas_loja_piscina;

-- 1. Qual é o total de vendas por cliente?
SELECT c.nome, SUM(v.total) AS total_vendas
FROM clientes_loja_piscina c
INNER JOIN vendas_loja_piscina v ON c.id = v.cliente_id
GROUP BY c.nome
ORDER BY total_vendas;

-- 2. Quais foram os produtos com quantidades mais vendidas?
SELECT p.nome, SUM(v.quantidade) AS total_vendido
FROM vendas_loja_piscina v
JOIN produtos_loja_piscina p ON v.produto_id = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC;

-- 3. Qual é o produto mais caro?
SELECT nome, preco
FROM produtos_loja_piscina
GROUP BY nome, preco
ORDER BY preco DESC
LIMIT 1;

-- 4. Qual cliente comprou a maior quantidade de produtos?
SELECT c.nome, SUM(v.quantidade) AS total_comprado
FROM vendas_loja_piscina v
JOIN clientes_loja_piscina c ON v.cliente_id = c.id
GROUP BY c.nome
ORDER BY total_comprado DESC
LIMIT 1;

-- 5. Qual foi o total de vendas no mês de maio de 2023?
SELECT SUM(v.total) AS total_vendas_maio
FROM vendas_loja_piscina v
WHERE v.data_venda BETWEEN '2023-05-01' AND '2023-05-31';

-- 6. Quais clientes compraram a piscina de 3x2 (o produto mais barato)?
SELECT c.nome, v.total
FROM vendas_loja_piscina v
INNER JOIN clientes_loja_piscina c ON v.cliente_id = c.id
INNER JOIN produtos_loja_piscina p ON v.produto_id = p.id
WHERE p.nome = 'Piscina de Chão 3x2'
GROUP BY c.nome, v.total;

-- 7. Qual é o estoque total de todas as piscinas?
SELECT nome, COUNT(estoque) AS contagem_estoque_total
FROM produtos_loja_piscina
GROUP BY nome
ORDER BY contagem_estoque_total DESC;

SELECT SUM(estoque) AS total_estoque
FROM produtos_loja_piscina;

-- 8. Qual é o valor total de todas as vendas realizadas em 2023?
SELECT SUM(v.total) AS total_vendas_2023
FROM vendas_loja_piscina v
WHERE EXTRACT(YEAR FROM v.data_venda) = 2023;
