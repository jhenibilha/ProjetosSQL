SELECT * FROM projeto7.tratamentos_dentarios;

-- 1. Quantos registros há na tabela?

SELECT COUNT(*) FROM projeto7.tratamentos_dentarios;

-- 2. Qual o número de pacientes diferentes?

SELECT DISTINCT paciente_nome FROM projeto7.tratamentos_dentarios;

-- 3. Faça a binarização da variável cancer 

SELECT
	CASE
		WHEN cancer = 'não' THEN 0
		WHEN cancer = 'sim' THEN 1
 	END AS cancer
FROM projeto7.tratamentos_dentarios;

-- 4. Faça a categorização da variável classe 

SELECT
	CASE
		WHEN classe = 'adulto' THEN 'A'
		WHEN classe = 'criança' THEN 'C'
		WHEN classe = 'idoso' THEN 'I'
	END AS classe
FROM projeto7.tratamentos_dentarios;

-- 5. Faça o Label Encoding da variável pagamento 

SELECT
	CASE
		WHEN pagamento = 'pago' THEN 1
		WHEN pagamento = 'em aberto' THEN 2
	END AS pagamento
FROM projeto7.tratamentos_dentarios;

-- 6. Faça o Label Encoding da variável tipo_tratamento

SELECT
	CASE
		WHEN tipo_tratamento = 'Limpeza' THEN 1
		WHEN tipo_tratamento = 'Obturação' THEN 2
		WHEN tipo_tratamento = 'Extração' THEN 3
		WHEN tipo_tratamento = 'Canal' THEN 4
		WHEN tipo_tratamento = 'Clareamento' THEN 5
		WHEN tipo_tratamento = 'Prótese' THEN 6
		WHEN tipo_tratamento = 'Aparelho ortodôntico' THEN 7
		WHEN tipo_tratamento = 'Avaliação' THEN 8
		WHEN tipo_tratamento = 'Implante' THEN 9
	END AS tipo_tratamento
FROM projeto7.tratamentos_dentarios;

-- 7. Qual o total de custos por tratamento?

SELECT tipo_tratamento, SUM(custo) AS total_custo
FROM projeto7.tratamentos_dentarios
GROUP BY tipo_tratamento
ORDER BY total_custo DESC;

-- 8. Qual o total de tratamentos por dentista?

SELECT dentista_nome, COUNT(*) total_tratamentos
FROM projeto7.tratamentos_dentarios
GROUP BY dentista_nome;

-- 9. Quantos adultos fizeram tratamentos em Março de 2025?

SELECT COUNT(*) total_pacientes, data_tratamento
FROM projeto7.tratamentos_dentarios
WHERE data_tratamento BETWEEN '2025-03-01' AND '2025-03-31'
AND classe = 'adulto'
GROUP BY data_tratamento;

-- 10. Exclua a coluna 'pago' pois ela não será utilizada

ALTER TABLE projeto7.tratamentos_dentarios
DROP COLUMN pago;

-- 11. Salve o resultados das modificações em uma nova tabela
CREATE TABLE projeto7.tratamentos_dentarios_resultado
AS
SELECT 
	id,
	paciente_nome,
    dentista_nome,
    data_tratamento,
    custo,
	observacoes,
	CASE 
		WHEN cancer = 'não' THEN 0
		WHEN cancer = 'sim' THEN 1
 	END AS cancer,
	CASE 
		WHEN classe = 'adulto' THEN 'A'
		WHEN classe = 'criança' THEN 'C'
		WHEN classe = 'idoso' THEN 'I'
	END AS classe,
	CASE WHEN pagamento = 'pago' THEN 1
		 WHEN pagamento = 'em aberto' THEN 2
	END AS pagamento,
	CASE
		WHEN tipo_tratamento = 'Limpeza' THEN 1
		WHEN tipo_tratamento = 'Obturação' THEN 2
		WHEN tipo_tratamento = 'Extração' THEN 3
		WHEN tipo_tratamento = 'Canal' THEN 4
		WHEN tipo_tratamento = 'Clareamento' THEN 5
		WHEN tipo_tratamento = 'Prótese' THEN 6
		WHEN tipo_tratamento = 'Aparelho ortodôntico' THEN 7
		WHEN tipo_tratamento = 'Avaliação' THEN 8
		WHEN tipo_tratamento = 'Implante' THEN 9
	END AS tipo_tratamento
FROM projeto7.tratamentos_dentarios;		


-- Consulta a tabela
SELECT * FROM projeto7.tratamentos_dentarios_resultado;

