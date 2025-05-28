-- Executa a SP
CALL projeto18.inserir_dados_campanha_mkt();


-- Verifica os dados
SELECT * FROM projeto18.campanha_mkt;

-- 1. Qual foi a campanha com o maior orçamento?

SELECT nome_campanha, orcamento
FROM projeto18.campanha_mkt
ORDER BY orcamento DESC NULLS LAST
LIMIT 1;

-- 2. Qual campanha teve o maior número de impressões?

SELECT nome_campanha, impressoes
FROM projeto18.campanha_mkt
ORDER BY impressoes DESC NULLS LAST
LIMIT 1;

-- 3. Qual foi a taxa de conversão média de todas as campanhas?

SELECT ROUND(AVG(taxa_conversao), 2) AS media_taxa_conversao_todas_campanhas
FROM projeto18.campanha_mkt;

-- 4. Quais campanhas foram divulgadas em canais específicos, como "Redes Sociais"?

SELECT nome_campanha, canais_divulgacao
FROM projeto18.campanha_mkt
WHERE canais_divulgacao = 'Redes Sociais';

-- 5. Quantas campanhas ocorreram em 2024?

SELECT COUNT(*) AS total_campanhas_2024
FROM projeto18.campanha_mkt
WHERE EXTRACT(YEAR FROM data_inicio) = 2024;

-- 6. Qual é a média de impressões por tipo de campanha?

SELECT tipo_campanha, ROUND(AVG(impressoes), 2) AS media_tipo_campanha
FROM projeto18.campanha_mkt
GROUP BY tipo_campanha
ORDER BY media_tipo_campanha DESC NULLS LAST;

-- 7. Qual campanha teve o melhor desempenho em termos de taxa de conversão?

SELECT nome_campanha, taxa_conversao
FROM projeto18.campanha_mkt
ORDER BY taxa_conversao DESC
LIMIT 1;

-- 8. Quais campanhas têm orçamento ou taxa de conversão faltando?

SELECT nome_campanha, orcamento
FROM projeto18.campanha_mkt
WHERE nome_campanha IS NULL OR orcamento IS NULL;

-- 9. Qual foi o orçamento total das campanhas de um público-alvo específico?

SELECT publico_alvo, SUM(orcamento) AS total_orcamento
FROM projeto18.campanha_mkt
WHERE publico_alvo = 'Publico Alvo 2'
GROUP BY publico_alvo;

-- 10. Quais campanhas tiveram um orçamento abaixo de R$80000 e qual a média de conversão delas?

SELECT nome_campanha, orcamento, ROUND(AVG(taxa_conversao), 2) AS media_taxa_conversao
FROM projeto18.campanha_mkt
WHERE orcamento < 80000
GROUP BY nome_campanha, orcamento; 

-- 11. Quais campanhas foram veiculadas em "Google" ou "Redes Sociais"?

SELECT DISTINCT COUNT (nome_campanha) AS campanhas, canais_divulgacao
FROM projeto18.campanha_mkt
WHERE canais_divulgacao = 'Google' OR canais_divulgacao = 'Redes Sociais'
GROUP BY canais_divulgacao;

-- 12. Qual o público-alvo teve mais campanhas?

SELECT publico_alvo, COUNT(*) AS total_campanhas
FROM projeto18.campanha_mkt
WHERE publico_alvo IS NOT NULL AND publico_alvo != '?'
GROUP BY publico_alvo
ORDER BY total_campanhas DESC
LIMIT 1;

-- 13. Qual foi o tipo de campanha mais comum?

SELECT COUNT(*) AS total_registros, tipo_campanha
FROM projeto18.campanha_mkt
GROUP BY tipo_campanha;

-- 14. Quantas campanhas foram realizadas em 2023 e qual o orçamento médio delas?

SELECT COUNT(*) AS total_campanhas_2023, ROUND(AVG(orcamento), 2) AS media_orcamento
FROM projeto18.campanha_mkt
WHERE EXTRACT(YEAR FROM data_inicio) = 2023
ORDER BY media_orcamento DESC;

-- 15. Quais campanhas têm uma taxa de conversão acima de 20%?

SELECT DISTINCT nome_campanha, taxa_conversao
FROM projeto18.campanha_mkt
WHERE taxa_conversao > 20
ORDER BY taxa_conversao DESC;

-- 16. Qual é o orçamento médio por canal de divulgação?

SELECT canais_divulgacao, ROUND(AVG(orcamento), 2) AS media_orcamento
FROM projeto18.campanha_mkt
GROUP BY canais_divulgacao
ORDER BY media_orcamento DESC;

-- 17. Quais campanhas começaram antes de 2024 e ainda estão ativas (sem data de fim)?

SELECT nome_campanha, data_inicio
FROM projeto18.campanha_mkt
WHERE data_inicio < '2024-01-01' AND data_fim IS NULL;




