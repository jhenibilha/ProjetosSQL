SELECT * FROM projeto11.clientes_roupas;

SELECT * FROM projeto11.produtos_roupas;

SELECT * FROM projeto11.vendas_roupas;

-- 1. Qual é o total de vendas feitas por cliente?

SELECT c.nome, v.quantidade, SUM(p.preco * v.quantidade) AS total_vendas
FROM projeto11.clientes_roupas c
INNER JOIN projeto11.vendas_roupas v ON c.id_cliente = v.id_cliente
INNER JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
GROUP BY c.nome, v.quantidade
ORDER BY v.quantidade DESC;

-- 2. Quais produtos foram vendidos e em que quantidade?

SELECT p.nome_produto, v.quantidade
FROM projeto11.produtos_roupas p
INNER JOIN projeto11.vendas_roupas v ON p.id_produto = v.id_produto
GROUP BY p.nome_produto, v.quantidade;

-- 3. Quais produtos têm o preço superior a R$100,00?

SELECT nome_produto, preco
FROM projeto11.produtos_roupas
WHERE preco > 100
GROUP BY nome_produto, preco;

-- 4. Quais clientes compraram mais de 1 produto em uma única venda?

SELECT c.nome, v.quantidade
FROM projeto11.vendas_roupas v
INNER JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
GROUP BY c.nome, v.quantidade
HAVING v.quantidade > 1
ORDER BY v.quantidade DESC;

-- 5. Qual é o valor total de vendas realizadas no dia 2025-05-02?

SELECT p.preco, v.quantidade, v.data_venda
FROM projeto11.produtos_roupas p
INNER JOIN projeto11.vendas_roupas v ON p.id_produto = v.id_produto
WHERE v.data_venda = '2025-05-02'
GROUP BY p.preco, v.quantidade, v.data_venda;

-- 6. Qual foi o produto mais vendido em quantidade e o total de vendas gerado por ele?
SELECT p.nome_produto, SUM(v.quantidade) AS total_quantidade_vendida, 
       SUM(p.preco * v.quantidade) AS total_vendas
FROM projeto11.vendas_roupas v
JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY total_quantidade_vendida DESC
LIMIT 1;

-- 7. Quais clientes compraram mais de um produto, mas gastaram mais de R$ 200,00 no total?

SELECT c.nome, SUM(p.preco * v.quantidade) AS total_gasto
FROM projeto11.vendas_roupas v
INNER JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
INNER JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING SUM(v.quantidade) > 1 AND SUM(p.preco * v.quantidade) > 200 
ORDER BY total_gasto DESC;

-- 8. Qual o valor médio gasto por cliente?

SELECT c.nome, ROUND(AVG(p.preco * v.quantidade), 2) AS media_total_gasto
FROM projeto11.vendas_roupas v
INNER JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
INNER JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY media_total_gasto DESC;

-- 9. Qual o valor médio gasto total considerando todos os clientes?

SELECT ROUND(AVG(total_gasto), 2) AS media_gasto_cliente
FROM (
    SELECT c.id_cliente, SUM(p.preco * v.quantidade) AS total_gasto
    FROM projeto11.vendas_roupas v
    JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
    JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
    GROUP BY c.id_cliente
) AS cliente_totais;

-- 10. Quais são os 3 produtos mais caros vendidos na loja, com a quantidade vendida e o total gerado por cada um?

SELECT p.nome_produto, SUM(v.quantidade) AS quantidade_vendida, 
       SUM(p.preco * v.quantidade) AS total_vendas
FROM projeto11.vendas_roupas v
JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto, p.preco
ORDER BY p.preco DESC
LIMIT 3;

-- 11. Quantos clientes realizaram compras em todos os produtos (ou seja, compraram pelo menos um de cada tipo de produto)?

SELECT c.nome, COUNT(DISTINCT v.id_produto) AS produtos_comprados
FROM projeto11.vendas_roupas v
INNER JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING COUNT(DISTINCT v.id_produto) = (SELECT COUNT(*) FROM projeto11.produtos_roupas);

-- 12. Quantos clientes compraram Calça Jeans?

SELECT COUNT(DISTINCT v.id_cliente) AS clientes_que_compraram_calca_jeans
FROM projeto11.vendas_roupas v
JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
WHERE p.nome_produto = 'Calça Jeans';

-- 13. Qual a quantidade de Calça Jeans vendida por cliente?

SELECT c.nome, p.nome_produto, SUM(v.quantidade) AS quantidade_comprada
FROM projeto11.vendas_roupas v
JOIN projeto11.produtos_roupas p ON v.id_produto = p.id_produto
JOIN projeto11.clientes_roupas c ON v.id_cliente = c.id_cliente
WHERE p.nome_produto = 'Calça Jeans'
GROUP BY c.nome, p.nome_produto
ORDER BY quantidade_comprada DESC;


SELECT * FROM projeto11.clientes_roupas;

SELECT * FROM projeto11.produtos_roupas;

SELECT * FROM projeto11.vendas_roupas;