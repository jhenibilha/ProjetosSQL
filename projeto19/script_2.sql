-- Perguntas de Negócio

SELECT * FROM projeto19.categoriasstore;

SELECT * FROM projeto19.clientesstore;

SELECT * FROM projeto19.itens_pedidostore;

SELECT * FROM projeto19.pedidosstore;

SELECT * FROM projeto19.produtosstore;

-- 1. Qual foi o faturamento total da loja considerando apenas pedidos finalizados?

SELECT SUM(ip.quantidade * ip.preco_unitario) AS faturamento_total_finalizado
FROM projeto19.itens_pedidostore ip
INNER JOIN projeto19.pedidosstore p ON p.id = ip.pedido_id
WHERE p.status = 'Finalizado';

-- 2. Quais os 3 produtos mais vendidos em quantidade?

SELECT pr.nome AS nome_produto, SUM(ip.quantidade) AS quantidade_total
FROM projeto19.itens_pedidostore ip
INNER JOIN projeto19.produtosstore pr ON pr.id = ip.produto_id
GROUP BY pr.nome
ORDER BY quantidade_total DESC
LIMIT 3;

-- 3. Qual cliente mais gastou na loja?

SELECT c.nome AS nome_cliente, SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM projeto19.clientesstore c
INNER JOIN projeto19.pedidosstore pe ON c.id = pe.cliente_id
INNER JOIN projeto19.itens_pedidostore ip ON pe.id = ip.pedido_id
WHERE pe.status = 'Finalizado'
GROUP BY c.nome
ORDER BY total_gasto DESC
LIMIT 1;

-- 4. Qual a média de itens por pedido finalizado?

SELECT ROUND(AVG(item_por_pedido.total_itens), 2) AS media_itens_por_pedido
FROM (
    SELECT 
        p.id AS pedido_id,
        SUM(ip.quantidade) AS total_itens
    FROM projeto19.pedidosstore p
    INNER JOIN projeto19.itens_pedidostore ip ON ip.pedido_id = p.id
    WHERE p.status = 'Finalizado'
    GROUP BY p.id
) AS item_por_pedido;

-- 5. Quais categorias mais geraram receita?

SELECT cat.nome AS categoria, SUM(ip.quantidade * ip.preco_unitario) AS receita
FROM projeto19.itens_pedidostore ip
INNER JOIN projeto19.produtosstore pr ON pr.id = ip.produto_id
INNER JOIN projeto19.categoriasstore cat ON cat.id = pr.categoria_id
INNER JOIN projeto19.pedidosstore p ON p.id = ip.pedido_id
WHERE p.status = 'Finalizado'
GROUP BY cat.nome
ORDER BY receita DESC;

-- 6. Qual a taxa de cancelamento de pedidos por estado?
SELECT 
    c.estado,
    COUNT(*) FILTER (WHERE p.status = 'Cancelado')::FLOAT / COUNT(*) AS taxa_cancelamento
FROM projeto19.pedidosstore p
JOIN projeto19.clientesstore c ON c.id = p.cliente_id
GROUP BY c.estado;


-- 7. Em quais cidades os clientes mais compram produtos da categoria "Eletrônicos"?
SELECT 
    c.cidade,
    COUNT(*) AS total_pedidos
FROM projeto19.pedidosstore p
JOIN projeto19.clientesstore c ON c.id = p.cliente_id
JOIN projeto19.itens_pedidostore ip ON ip.pedido_id = p.id
JOIN projeto19.produtosstore pr ON pr.id = ip.produto_id
JOIN projeto19.categoriasstore cat ON cat.id = pr.categoria_id
WHERE cat.nome = 'Eletrônicos' AND p.status = 'Finalizado'
GROUP BY c.cidade
ORDER BY total_pedidos DESC;

-- 8. Qual o ticket médio por cliente?
SELECT 
    c.nome,
    SUM(ip.quantidade * ip.preco_unitario)::DECIMAL / COUNT(DISTINCT p.id) AS ticket_medio
FROM projeto19.clientesstore c
JOIN projeto19.pedidosstore p ON p.cliente_id = c.id
JOIN projeto19.itens_pedidostore ip ON ip.pedido_id = p.id
WHERE p.status = 'Finalizado'
GROUP BY c.nome;


-- 9. Quais clientes fizeram mais de 1 pedido e gastaram acima da média?
WITH total_gasto_por_cliente AS (
    SELECT 
        c.id,
        c.nome,
        COUNT(DISTINCT p.id) AS total_pedidos,
        SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
    FROM projeto19.clientesstore c
    JOIN projeto19.pedidosstore p ON p.cliente_id = c.id
    JOIN projeto19.itens_pedidostore ip ON ip.pedido_id = p.id
    WHERE p.status = 'Finalizado'
    GROUP BY c.id, c.nome
),
media_gasto AS (
    SELECT AVG(total_gasto) AS media FROM total_gasto_por_cliente
)
SELECT 
    tpc.nome,
    tpc.total_pedidos,
    tpc.total_gasto
FROM total_gasto_por_cliente tpc, media_gasto mg
WHERE tpc.total_pedidos > 1 AND tpc.total_gasto > mg.media;

-- 10. Calcule o ranking de clientes por total gasto, usando funções de janela.
SELECT 
    c.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS total_gasto,
    RANK() OVER (ORDER BY SUM(ip.quantidade * ip.preco_unitario) DESC) AS ranking
FROM projeto19.clientesstore c
JOIN projeto19.pedidosstore p ON p.cliente_id = c.id
JOIN projeto19.itens_pedidostore ip ON ip.pedido_id = p.id
WHERE p.status = 'Finalizado'
GROUP BY c.nome;
