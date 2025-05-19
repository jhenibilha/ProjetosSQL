SELECT * FROM projeto6.pacientes_menopausa;

-- 1. Qual é a distribuição dos pacientes por classe (sem-recorrência-eventos vs. com-recorrencia-eventos)?

SELECT classe, COUNT(*) AS contagem_classe
FROM projeto6.pacientes_menopausa
GROUP BY classe;

-- 2. Quantos pacientes estão na faixa etária de 40-49 anos?

SELECT idade AS faixa_etaria, COUNT(*) AS total_pacientes
FROM projeto6.pacientes_menopausa
WHERE idade = '40-49'
GROUP BY idade;

-- 3. Qual é a média de grau de malignidade (deg_malig) para pacientes que estão em pré-menopausa?

SELECT menopausa, ROUND(AVG(deg_malig), 2) AS media_deg_malig
FROM projeto6.pacientes_menopausa
WHERE menopausa = 'pré-menopausa' 
GROUP BY menopausa;

-- 4. Qual é o número de pacientes que estão com tumores de tamanho "15-19"?

SELECT tamanho_tumor, COUNT(*) AS total_pacientes
FROM projeto6.pacientes_menopausa
WHERE tamanho_tumor = '15-19'
GROUP BY tamanho_tumor;

-- 5. Qual é o número de pacientes que têm linfonodos invadidos (inv_nodes = '2-4') e não têm capsulação (node_caps = 'não')?

SELECT inv_nodes, node_caps, COUNT(*) AS total_pacientes
FROM projeto6.pacientes_menopausa
WHERE inv_nodes = '2-4' AND node_caps = 'não'
GROUP BY inv_nodes, node_caps;

-- 6. Qual é a proporção de pacientes com tumores localizados no seio esquerdo versus direito?

SELECT seio, COUNT(*) AS total_pacientes
FROM projeto6.pacientes_menopausa
GROUP BY seio;

-- 7. Qual é a total de recorrência de eventos para pacientes que têm tumores no quadrante "esquerdo_inferior"?

SELECT classe, COUNT(*) AS numero_pacientes
FROM projeto6.pacientes_menopausa
WHERE quadrante = 'esquerdo_inferior'
GROUP BY classe;

-- 8. Qual a faixa etária dos pacientes que mais estão irradiando?

SELECT idade AS faixa_etaria, irradiando
FROM projeto6.pacientes_menopausa
WHERE irradiando = 'sim'
GROUP BY idade, irradiando;

-- 9. Quantos pacientes têm grau de malignidade maior que 2?

SELECT COUNT(*) AS numero_pacientes_grau_maior_que_2
FROM projeto6.pacientes_menopausa
WHERE deg_malig > 2;

-- 10. Qual a proporção de pacientes com tumores de tamanho "30-34" e que têm linfonodos invadidos (inv_nodes = '2-4')?

SELECT COUNT(*) total_pacientes
FROM projeto6.pacientes_menopausa
WHERE tamanho_tumor = '30-34' AND inv_nodes = '2-4';

-- 11. Qual a distribuição dos pacientes que têm "menopausa acima_de_40" e não estão irradiando?

SELECT classe, COUNT(*) AS numero_pacientes
FROM projeto6.pacientes_menopausa
WHERE menopausa = 'acima_de_40' AND irradiando = 'não'
GROUP BY classe;

-- 12. Qual é a taxa de recorrência de eventos para pacientes na faixa etária de 50-59 anos?

SELECT classe, COUNT(*) AS numero_pacientes
FROM projeto6.pacientes_menopausa
WHERE idade = '50-59'
GROUP BY classe;

-- 13. Qual é a distribuição de tumores com tamanho "20-24" em relação à quantidade de linfonodos invadidos?

SELECT inv_nodes, COUNT(*) AS numero_pacientes
FROM projeto6.pacientes_menopausa
WHERE tamanho_tumor = '20-24'
GROUP BY inv_nodes;

-- 14. Quantos pacientes na faixa etária de 60-69 anos têm grau de malignidade igual a 3?

SELECT COUNT(*) AS numero_pacientes_60_69_grau_3
FROM projeto6.pacientes_menopausa
WHERE idade = '60-69' AND deg_malig = 3;

-- 15. Qual é a distribuição dos pacientes por idade (faixas de 10 anos)?

SELECT CASE
           WHEN idade = '30-39' THEN '30-39'
           WHEN idade = '40-49' THEN '40-49'
           WHEN idade = '50-59' THEN '50-59'
           WHEN idade = '60-69' THEN '60-69'
           ELSE 'Outro'
       END AS faixa_etaria,
       COUNT(*) AS numero_pacientes
FROM projeto6.pacientes_menopausa
GROUP BY faixa_etaria;


SELECT * FROM projeto6.pacientes_menopausa;