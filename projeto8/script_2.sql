SELECT * FROM projeto8.tratamentos_medicos
LIMIT 15;

-- 1. Quantos pacientes há por plano de saúde?

SELECT plano_saude, COUNT(*) AS numero_pacientes
FROM projeto8.tratamentos_medicos
GROUP BY plano_saude
ORDER BY numero_pacientes DESC;

-- USANDO ONE HOT ENCODING

-- 2. Crie uma tabela onde cada plano de saúde vire uma coluna com contagem de pacientes para cada plano.

SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN plano_saude = 'Unimed' THEN 1 ELSE 0 END) AS unimed,
    SUM(CASE WHEN plano_saude = 'Bradesco Saúde' THEN 1 ELSE 0 END) AS bradesco,
    SUM(CASE WHEN plano_saude = 'Amil' THEN 1 ELSE 0 END) AS amil,
    SUM(CASE WHEN plano_saude = 'SulAmérica' THEN 1 ELSE 0 END) AS sulamerica,
    SUM(CASE WHEN plano_saude = 'Particular' THEN 1 ELSE 0 END) AS particular
FROM projeto8.tratamentos_medicos;

-- 3. Qual a quantidade de tratamentos aplicados por gênero e plano de saúde?

SELECT
    genero,
    COUNT(*) AS total,
    SUM(CASE WHEN plano_saude = 'Unimed' THEN 1 ELSE 0 END) AS unimed,
    SUM(CASE WHEN plano_saude = 'Bradesco Saúde' THEN 1 ELSE 0 END) AS bradesco,
    SUM(CASE WHEN plano_saude = 'Amil' THEN 1 ELSE 0 END) AS amil,
    SUM(CASE WHEN plano_saude = 'SulAmérica' THEN 1 ELSE 0 END) AS sulamerica,
    SUM(CASE WHEN plano_saude = 'Particular' THEN 1 ELSE 0 END) AS particular
FROM projeto8.tratamentos_medicos
GROUP BY genero;

-- 4. Quantos pacientes com cada condição receberam cada tipo de tratamento?
-- Transforme os tratamentos em colunas.

SELECT
    condicao,
    SUM(CASE WHEN tratamento = 'Insulina' THEN 1 ELSE 0 END) AS insulina,
    SUM(CASE WHEN tratamento = 'Beta-bloqueador' THEN 1 ELSE 0 END) AS beta_bloqueador,
    SUM(CASE WHEN tratamento = 'Inalador' THEN 1 ELSE 0 END) AS inalador,
    SUM(CASE WHEN tratamento = 'Psicoterapia' THEN 1 ELSE 0 END) AS psicoterapia,
    SUM(CASE WHEN tratamento = 'Antiviral' THEN 1 ELSE 0 END) AS antiviral,
    SUM(CASE WHEN tratamento = 'Dieta' THEN 1 ELSE 0 END) AS dieta
FROM projeto8.tratamentos_medicos
GROUP BY condicao
ORDER BY condicao;

-- 5. Quantos atendimentos cada hospital realizou para cada plano de saúde?

SELECT
    hospital,
    SUM(CASE WHEN plano_saude = 'Unimed' THEN 1 ELSE 0 END) AS unimed,
    SUM(CASE WHEN plano_saude = 'Bradesco Saúde' THEN 1 ELSE 0 END) AS bradesco,
    SUM(CASE WHEN plano_saude = 'Amil' THEN 1 ELSE 0 END) AS amil,
    SUM(CASE WHEN plano_saude = 'SulAmérica' THEN 1 ELSE 0 END) AS sulamerica,
    SUM(CASE WHEN plano_saude = 'Particular' THEN 1 ELSE 0 END) AS particular
FROM projeto8.tratamentos_medicos
GROUP BY hospital
ORDER BY hospital;

-- 6. Transforme os valores categóricos genero, plano_saude e hospital em colunas binárias para uso em Machine Learning.

SELECT
    paciente_nome,
    idade,
    -- Genero
    CASE WHEN genero = 'Masculino' THEN 1 ELSE 0 END AS genero_masc,
    CASE WHEN genero = 'Feminino' THEN 1 ELSE 0 END AS genero_fem,
    CASE WHEN genero = 'Outro' THEN 1 ELSE 0 END AS genero_outro,
    -- Planos
    CASE WHEN plano_saude = 'Unimed' THEN 1 ELSE 0 END AS plano_unimed,
    CASE WHEN plano_saude = 'Bradesco Saúde' THEN 1 ELSE 0 END AS plano_bradesco,
    CASE WHEN plano_saude = 'Amil' THEN 1 ELSE 0 END AS plano_amil,
    CASE WHEN plano_saude = 'SulAmérica' THEN 1 ELSE 0 END AS plano_sulamerica,
    CASE WHEN plano_saude = 'Particular' THEN 1 ELSE 0 END AS plano_particular,
    -- Hospitais
    CASE WHEN hospital = 'Hospital Central' THEN 1 ELSE 0 END AS hospital_central,
    CASE WHEN hospital = 'Clínica São João' THEN 1 ELSE 0 END AS hospital_sao_joao,
    CASE WHEN hospital = 'Santa Casa' THEN 1 ELSE 0 END AS hospital_santa_casa,
    CASE WHEN hospital = 'Hospital Vida' THEN 1 ELSE 0 END AS hospital_vida
FROM projeto8.tratamentos_medicos;

-- 7. Entre pacientes do sexo feminino, quantos casos houve por condição?

SELECT
    condicao,
    COUNT(*) AS total_feminino
FROM projeto8.tratamentos_medicos
WHERE genero = 'Feminino'
GROUP BY condicao
ORDER BY total_feminino DESC;

-- 8. Quantos pacientes estão em cada combinação de plano de saúde e tratamento, com planos como colunas?

SELECT
    tratamento,
    SUM(CASE WHEN plano_saude = 'Unimed' THEN 1 ELSE 0 END) AS unimed,
    SUM(CASE WHEN plano_saude = 'Bradesco Saúde' THEN 1 ELSE 0 END) AS bradesco,
    SUM(CASE WHEN plano_saude = 'Amil' THEN 1 ELSE 0 END) AS amil,
    SUM(CASE WHEN plano_saude = 'SulAmérica' THEN 1 ELSE 0 END) AS sulamerica,
    SUM(CASE WHEN plano_saude = 'Particular' THEN 1 ELSE 0 END) AS particular
FROM projeto8.tratamentos_medicos
GROUP BY tratamento
ORDER BY tratamento;


