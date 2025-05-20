-- 1. Quais estudantes estão cursando disciplinas no semestre "2025-1" ou "2025-2"?

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semestre = '2025-1'

UNION

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semestre = '2025-2';

-- 2. Quais estudantes estão cursando alguma disciplina no semestre "2025-1" ou "2025-2", 
-- incluindo os estudantes que aparecem mais de uma vez nas disciplinas?

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semestre = '2025-1'

UNION ALL

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semes

-- 3. Quais estudantes estão cursando disciplinas de "Engenharia de Computação" e "Medicina"?

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE e.curso = 'Engenharia de Computação'

UNION

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE e.curso = 'Medicina';

-- 4. Quais estudantes cursaram disciplinas no semestre "2025-1" ou "2025-2", mas estão no curso "Engenharia de Computação"?

-- Usando UNION 
SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semestre = '2025-1' AND e.curso = 'Engenharia de Computação'

UNION ALL

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE d.semestre = '2025-2' AND e.curso = 'Engenharia de Computação';

-- Não usando UNION
SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
WHERE e.curso = 'Engenharia de Computação' AND (d.semestre = '2025-1' OR d.semestre = '2025-2');

-- 5. Quais estudantes estão cursando disciplinas em qualquer semestre, sem duplicação, com mais de uma disciplina?

SELECT e.nome
FROM projeto12.estudantes_univ e
INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
GROUP BY e.nome
HAVING COUNT(d.id_disciplina) > 1;

-- 6. Quais são os estudantes que cursaram mais de uma disciplina no semestre "2025-1"?

WITH Disciplinas_2025_1 AS (
    SELECT e.nome, COUNT(d.id_disciplina) AS qtd_disciplinas
    FROM projeto12.estudantes_univ e
    INNER JOIN projeto12.disciplinas_univ d ON e.id_estudante = d.id_estudante
    WHERE d.semestre = '2025-1'
    GROUP BY e.nome
)
SELECT nome
FROM Disciplinas_2025_1
WHERE qtd_disciplinas > 1;

-- Verificar os dados

SELECT * FROM projeto12.estudantes_univ;

SELECT * FROM projeto12.disciplinas_univ;