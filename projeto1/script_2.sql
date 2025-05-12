-- Verificar os dados
SELECT * FROM projeto1.clientes;

-- Verificar os dados
SELECT * FROM projeto1.contas;

-- Verificar os dados
SELECT * FROM projeto1.transacoes;


-- 1. Qual é o saldo atual de cada clienteconsiderando o saldo da conta e as transações (créditos e débitos) feitas?

SELECT c.nome, SUM(t.valor) + co.saldo AS saldo_atual
FROM clientes c
INNER JOIN contas co ON c.id = co.cliente_id 
INNER JOIN transacoes t ON co.id = t.conta_id
GROUP BY c.nome, co.saldo;

-- 2. Quantas transações foram feitas por cada cliente?

SELECT c.nome, COUNT(t.id) AS total_transacoes
FROM clientes c
INNER JOIN contas co ON c.id = co.cliente_id 
INNER JOIN transacoes t ON co.id = t.conta_id 
GROUP BY c.nome
ORDER BY total_transacoes DESC;

-- 3. Qual foi o valor total de transações (créditos e débitos) realizadas em 2023?

SELECT SUM(t.valor) AS total_transacoes_2023
FROM transacoes t
WHERE EXTRACT(YEAR FROM t.data_transacao) = 2023;

-- 4. Quais clientes realizaram transações em 2023?

SELECT DISTINCT c.nome, t.data_transacao
FROM clientes c
JOIN contas co ON c.id = co.cliente_id
JOIN transacoes t ON co.id = t.conta_id
WHERE EXTRACT(YEAR FROM t.data_transacao) = 2023;

-- 5. Qual cliente realizou o maior número de transações?

SELECT c.nome, COUNT(t.id) AS total_transacoes
FROM clientes c
JOIN contas co ON c.id = co.cliente_id
JOIN transacoes t ON co.id = t.conta_id
GROUP BY c.nome
ORDER BY total_transacoes DESC
LIMIT 1;

-- 6. Qual é o total de débito e crédito por cliente?

SELECT c.nome, 
       SUM(CASE WHEN t.tipo = 'Débito' THEN t.valor ELSE 0 END) AS total_debito,
       SUM(CASE WHEN t.tipo = 'Crédito' THEN t.valor ELSE 0 END) AS total_credito
FROM clientes c
JOIN contas co ON c.id = co.cliente_id
JOIN transacoes t ON co.id = t.conta_id
GROUP BY c.nome;

-- 7. Qual cliente tem o maior saldo na conta poupança?

SELECT c.nome, co.saldo
FROM clientes c
JOIN contas co ON c.id = co.cliente_id
WHERE co.tipo = 'Poupança'
ORDER BY co.saldo DESC
LIMIT 1;

-- 8. Quais transações foram feitas no dia 2023-05-13?

SELECT c.nome, t.tipo, t.valor, t.data_transacao, t.descricao
FROM transacoes t
JOIN contas co ON t.conta_id = co.id
JOIN clientes c ON co.cliente_id = c.id
WHERE DATE(t.data_transacao) = '2023-05-13';

-- 9. Qual foi o valor total de débito feito pelos clientes no ano de 2023?

SELECT SUM(t.valor) AS total_debito_2021
FROM transacoes t
WHERE t.tipo = 'Débito'
AND EXTRACT(YEAR FROM t.data_transacao) = 2023;

-- 10. Qual cliente tem o maior saldo em conta corrente?

SELECT c.nome, co.saldo
FROM clientes c
JOIN contas co ON c.id = co.cliente_id
WHERE co.tipo = 'Corrente'
ORDER BY co.saldo DESC
LIMIT 1;
