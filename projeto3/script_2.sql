SELECT * FROM filiais;

-- 1. Qual é a filial com maior faturamento médio mensal?

SELECT nome, cidade, estado, faturamento_mensal
FROM filiais
ORDER BY faturamento_mensal DESC
LIMIT 1;

-- 2. Quantas filiais existem em cada estado?

SELECT estado, COUNT(*) AS quantidade_filiais
FROM filiais
GROUP BY estado
ORDER BY quantidade_filiais DESC;

-- 3. Qual é a média de faturamento mensal por estado?

SELECT estado, ROUND(AVG(faturamento_mensal), 2) AS media_faturamento
FROM filiais
GROUP BY estado
ORDER BY media_faturamento DESC;

-- 4. Qual é a filial mais antiga?

SELECT nome, cidade, estado, data_abertura
FROM filiais
GROUP BY nome, cidade, estado, data_abertura
ORDER BY data_abertura
LIMIT 1;

-- 5. Qual é a média de funcionários no total?

SELECT ROUND(AVG(numero_funcionarios), 2) AS media_funcionarios
FROM filiais;

-- 6. Quantas filiais têm mais de 10 funcionários?

SELECT COUNT(*) AS filiais_acima_10_funcionarios
FROM filiais
WHERE numero_funcionarios > 10;

-- 7. Quais filiais têm mais de 10 funcionários?

SELECT estado, numero_funcionarios
FROM filiais
WHERE numero_funcionarios > 10
GROUP BY estado, numero_funcionarios
ORDER BY numero_funcionarios DESC;

-- 8. Qual é o total de faturamento mensal de todas as filiais somadas?

SELECT SUM(faturamento_mensal) AS total_faturamento
FROM filiais;

-- 9. Quais filiais foram abertas após 2020?

SELECT nome, cidade, estado, data_abertura
FROM filiais
WHERE data_abertura > '2020-12-31';

-- 10. Qual é o faturamento médio das filiais abertas antes de 2020?

SELECT ROUND(AVG(faturamento_mensal), 2) AS media_faturamento_antes_2020
FROM filiais
WHERE data_abertura < '2020-01-01';

-- 11. Qual o nome e cidade da filial com menor número de funcionários?

SELECT nome, cidade, numero_funcionarios
FROM filiais
GROUP BY nome, cidade, numero_funcionarios
ORDER BY numero_funcionarios
LIMIT 1;





