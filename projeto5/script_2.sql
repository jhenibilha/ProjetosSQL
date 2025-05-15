SELECT * FROM projeto5.clientes;

SELECT * FROM projeto5.vendas_loja;

-- 1. Qual é o produto mais vendido?

SELECT nome_produto, SUM(unidades_vendidas) AS total_vendido
FROM projeto5.vendas_loja
GROUP BY nome_produto
ORDER BY total_vendido DESC
LIMIT 1;

-- 2. Qual foi o total de vendas por categoria de produto?

SELECT categoria_produto, SUM(unidades_vendidas*valor_unitario_venda) AS total_vendas
FROM projeto5.vendas_loja
GROUP BY categoria_produto
ORDER BY total_vendas DESC;

-- 3. Qual foi o faturamento total de cada cliente?

SELECT c.nome_cliente, SUM(v.unidades_vendidas * v.valor_unitario_venda) AS total_vendas
FROM projeto5.clientes c
INNER JOIN projeto5.vendas_loja v ON v.id_cliente = c.id_cliente
GROUP BY c.nome_cliente
ORDER BY total_vendas DESC;

-- 4. Quais produtos foram vendidos em agosto de 2023?

SELECT nome_produto, unidades_vendidas,data_venda
FROM projeto5.vendas_loja
WHERE data_venda BETWEEN '2023-08-01' AND '2023-08-31'
GROUP BY nome_produto, unidades_vendidas, data_venda;

-- 5. Qual é a média de unidades vendidas por produto?

SELECT nome_produto, ROUND(AVG(unidades_vendidas), 2) AS media_unidades_vendidas
FROM projeto5.vendas_loja
GROUP BY nome_produto
ORDER BY media_unidades_vendidas DESC;

-- 6. Quais clientes compraram o produto "Produto A"?

SELECT c.nome_cliente, v.nome_produto
FROM projeto5.clientes c
INNER JOIN projeto5.vendas_loja v ON c.id_cliente = v.id_cliente
WHERE v.nome_produto = 'Produto A'
GROUP BY c.nome_cliente, v.nome_produto;

-- 7. Qual é o valor total de vendas de cada produto, considerando a quantidade vendida?

SELECT nome_produto, SUM(unidades_vendidas * valor_unitario_venda) AS total_vendas
FROM projeto5.vendas_loja
GROUP BY nome_produto
ORDER BY total_vendas DESC;

-- 8. Qual foi o produto mais vendido em setembro de 2023?

SELECT nome_produto, unidades_vendidas, data_venda
FROM projeto5.vendas_loja
WHERE data_venda BETWEEN '2023-09-01' AND '2023-09-30'
GROUP BY nome_produto, unidades_vendidas, data_venda
LIMIT 1;

-- 9. Qual é o total de vendas por mês?

SELECT EXTRACT(MONTH FROM data_venda) AS Mes, SUM(Unidades_Vendidas * Valor_Unitario_Venda) AS total_vendas
FROM projeto5.vendas_loja
GROUP BY Mes
ORDER BY Mes;

-- 10. Quais produtos tiveram vendas no mês de novembro de 2023?

SELECT data_venda, nome_produto, SUM(Unidades_Vendidas * Valor_Unitario_Venda) AS total_vendas
FROM projeto5.vendas_loja
WHERE data_venda BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY nome_produto, data_venda
ORDER BY data_venda;

-- 11. Qual é o total de vendas de cada produto que foi vendido mais de 5 vezes?

SELECT nome_produto, 
       (SELECT SUM(unidades_vendidas * valor_unitario_venda) -- início da subquery 1
        FROM projeto5.vendas_loja v -- apelido para referenciar a subquery principal
        WHERE v.nome_produto = p.nome_produto) AS total_vendas -- fim da subquery 1
FROM projeto5.vendas_loja p -- apelido da subquery principal
GROUP BY nome_produto
HAVING (SELECT SUM(unidades_vendidas) -- início da subquery 2
        FROM projeto5.vendas_loja v
        WHERE v.nome_produto = p.nome_produto) > 5; -- fim da subquery 2

-- 12. Quais são os produtos da "Categoria 3" que tiveram a maior quantidade de unidades vendidas em uma única venda?

SELECT nome_produto, unidades_vendidas
FROM projeto5.vendas_loja
WHERE categoria_produto = 'Categoria 3' 
AND unidades_vendidas = (
    SELECT MAX(unidades_vendidas) 
    FROM projeto5.vendas_loja 
    WHERE categoria_produto = 'Categoria 3'
);

-- 13. Qual é o produto da "Categoria 1" que gerou o maior valor total de vendas no mês de setembro?

SELECT nome_produto, SUM(unidades_vendidas * valor_unitario_venda) AS total_vendas
FROM projeto5.vendas_loja
WHERE categoria_produto = 'Categoria 1'
AND EXTRACT(MONTH FROM data_venda) = 9
GROUP BY nome_produto
HAVING SUM(unidades_vendidas * valor_unitario_venda) = ( -- início da subquery 1
    SELECT MAX(total_vendas) -- fim da subquery 1
    FROM ( -- início da subquery 2
        SELECT SUM(unidades_vendidas * valor_unitario_venda) AS total_vendas
        FROM projeto5.vendas_loja
        WHERE categoria_produto = 'Categoria 1'
        AND EXTRACT(MONTH FROM data_venda) = 9
        GROUP BY nome_produto
    ) AS subquery -- fim da subquery 2
);

