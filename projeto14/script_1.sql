CREATE SCHEMA projeto14 AUTHORIZATION jhenifer;

-- Criação da tabela 

CREATE TABLE IF NOT EXISTS projeto14.vendasrc (
    ano INT NULL,
    pais VARCHAR(50) NULL,
    produto VARCHAR(50) NULL,
    faturamento INT NULL
);

-- Inserção de registros

INSERT INTO projeto14.vendasrc (ano, pais, produto, faturamento) VALUES
(2021, 'Brasil', 'Geladeira', 1130),
(2021, 'Brasil', 'TV', 980),
(2021, 'Argentina', 'Geladeira', 2180),
(2021, 'Argentina', 'TV', 2240),
(2021, 'Portugal', 'Smartphone', 2310),
(2021, 'Portugal', 'TV', 1900),
(2021, 'Inglaterra', 'Notebook', 1800),
(2024, 'Brasil', 'Geladeira', 1400),
(2024, 'Brasil', 'TV', 1345),
(2024, 'Argentina', 'Geladeira', 2180),
(2024, 'Argentina', 'TV', 1390),
(2024, 'Portugal', 'Smartphone', 2480),
(2024, 'Portugal', 'TV', 1980),
(2024, 'Inglaterra', 'Notebook', 2300);