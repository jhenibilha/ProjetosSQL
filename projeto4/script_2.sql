SELECT * FROM projeto4.estudantes_escola;

SELECT * FROM projeto4.informacoes_pessoais;

SELECT * FROM projeto4.escolas;

-- 1. Qual é a média das notas do Exame 1 de todos os estudantes?

SELECT ROUND(AVG(nota_exame1), 2) AS media_nota_exame1
FROM projeto4.estudantes_escola;

-- 2. Qual escola tem o maior número de estudantes?

SELECT e.nome AS escola, COUNT(*) AS numero_estudantes
FROM projeto4.estudantes_escola ee
JOIN projeto4.escolas e ON ee.id = e.id
GROUP BY e.nome
LIMIT 1;

-- 3. Qual é a distribuição de gênero entre os estudantes?

SELECT genero, COUNT(*) AS distribuicao_genero
FROM projeto4.informacoes_pessoais
GROUP BY genero;

-- 4. Quais são as 3 escolas mais antigas?

SELECT nome AS escola, ano_fundacao
FROM projeto4.escolas
GROUP BY nome, ano_fundacao
ORDER BY ano_fundacao DESC;

-- 5. Qual é a média das notas do Exame 2 para cada tipo de sistema operacional?

SELECT ROUND(AVG(nota_exame2), 2) AS media_exame_2, tipo_sistema_operacional
FROM projeto4.estudantes_escola
GROUP BY tipo_sistema_operacional
ORDER BY media_exame_2 DESC;

-- 6. Quais são os estudantes que nasceram em 2000?

SELECT ee.id AS estudante_id, ip.data_nascimento, ee.nome AS nome_estudante
FROM projeto4.informacoes_pessoais ip
INNER JOIN projeto4.estudantes_escola ee ON ip.estudante_id = ee.id
WHERE ip.data_nascimento BETWEEN '2000-01-01' AND '2001-01-01';

-- 7. Qual é a escola mais recente (com ano de fundação mais recente)?

SELECT nome AS escola, ano_fundacao
FROM projeto4.escolas
GROUP BY nome, ano_fundacao
LIMIT 1;

-- 8. Qual é o estudante com a maior média geral (média entre as duas notas dos exames)?

SELECT nome, sobrenome, ROUND((nota_exame1 + nota_exame2) / 2, 2) AS media_geral
FROM projeto4.estudantes_escola
ORDER BY media_geral DESC
LIMIT 1;

-- 9. Qual é a escola com o maior número de estudantes do gênero 'Masculino'?

SELECT e.nome AS nome_escola, COUNT(*) AS numero_estudantes_masculinos
FROM projeto4.estudantes_escola ee
INNER JOIN projeto4.informacoes_pessoais i ON ee.id = i.estudante_id
INNER JOIN projeto4.escolas e ON ee.id = e.id
WHERE i.genero = 'Masculino'
GROUP BY e.nome
ORDER BY numero_estudantes_masculinos DESC
LIMIT 1;

-- 10. Quais estudantes têm email com domínio "email.com"?

SELECT estudante_id, email
FROM projeto4.informacoes_pessoais
WHERE email LIKE '%@email.com';
