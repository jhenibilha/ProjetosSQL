-- 1. Qual é o nome e email dos clientes que possuem conta do tipo "Poupança"?

SELECT nome, email
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
WHERE tipo_conta = 'Poupança'
GROUP BY nome, email;

-- 2. Quais clientes realizaram transações após 01/04/2024?

SELECT DISTINCT cl.nome, data_transacao
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin ct ON cl.cliente_id = ct.cliente_id
INNER JOIN projeto9.transacoes_fin t ON ct.conta_id = t.conta_id
WHERE t.data_transacao > '2024-04-01';

-- 3. Qual o saldo das contas e o nome dos respectivos donos?

SELECT cl.nome, co.saldo
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
ORDER BY saldo DESC;

-- 4. Quais contas realizaram transações do tipo "Saque"?

SELECT cl.nome, co.tipo_conta, tr.tipo_transacao
FROM projeto9.contas_fin co 
INNER JOIN projeto9.clientes_fin cl ON co.cliente_id = cl.cliente_id
INNER JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
WHERE tipo_transacao = 'Saque'
GROUP BY nome, tipo_conta, tipo_transacao;

-- 5. Qual é a soma de transações por cada cliente?

SELECT cl.nome, SUM(tr.valor) AS total_movimentado
FROM projeto9.clientes_fin cl
JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
GROUP BY cl.nome
ORDER BY total_movimentado DESC;

-- 6. Quais clientes não realizaram nenhuma transação?

SELECT cl.nome, tr.tipo_transacao
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
LEFT JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
GROUP BY cl.nome, tr.tipo_transacao;

SELECT cl.nome
FROM projeto9.clientes_fin cl
JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
LEFT JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
WHERE tr.transacao_id IS NULL;

-- obs: estão corretas as respostas, pois todos os clientes fizeram transações.

-- 7. Qual o número de transações por tipo (Depósito ou Saque)?

SELECT tipo_transacao, COUNT(*) AS total_transacoes
FROM projeto9.transacoes_fin
GROUP BY tipo_transacao;

-- 8. Qual cliente tem o maior saldo em conta?

SELECT cliente_id, saldo
FROM projeto9.contas_fin
GROUP BY cliente_id, saldo
ORDER BY saldo DESC
LIMIT 1;

-- 9. Liste todos os clientes com o tipo da conta e data da última transação.

SELECT cl.nome, co.tipo_conta, MAX(tr.data_transacao) AS ultima_transacao
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
INNER JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
GROUP BY cl.nome, co.tipo_conta;

-- 10. Qual a média de valor das transações por cliente?

SELECT cl.nome, ROUND(AVG(tr.valor), 2) AS media_valor_transacoes
FROM projeto9.clientes_fin cl
INNER JOIN projeto9.contas_fin co ON cl.cliente_id = co.cliente_id
INNER JOIN projeto9.transacoes_fin tr ON co.conta_id = tr.conta_id
GROUP BY cl.nome
ORDER BY media_valor_transacoes DESC;

---

SELECT * FROM projeto9.clientes_fin;

SELECT * FROM projeto9.contas_fin;

SELECT * FROM projeto9.transacoes_fin;