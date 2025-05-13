-- Criação da tabela
CREATE TABLE filiais (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    data_abertura DATE,
    faturamento_mensal NUMERIC(10,2),
    numero_funcionarios INT
);

-- Inserção de dados na tabela
INSERT INTO filiais (nome, cidade, estado, data_abertura, faturamento_mensal, numero_funcionarios) VALUES
('Papel e Cia - Centro', 'São Paulo', 'SP', '2018-03-12', 75500.00, 12),
('Papel e Cia - Norte', 'Campinas', 'SP', '2019-07-25', 48200.00, 8),
('Papel e Cia - Sul', 'Curitiba', 'PR', '2020-02-10', 53400.00, 9),
('Papel e Cia - Shopping', 'Porto Alegre', 'RS', '2017-11-05', 86000.00, 15),
('Papel e Cia - Centro', 'Belo Horizonte', 'MG', '2021-04-01', 60000.00, 10),
('Papel e Cia - Industrial', 'Contagem', 'MG', '2019-09-19', 41000.00, 7),
('Papel e Cia - Estudantil', 'Recife', 'PE', '2022-01-15', 37000.00, 6),
('Papel e Cia - Litoral', 'Salvador', 'BA', '2018-06-30', 54500.00, 9),
('Papel e Cia - Shopping', 'Fortaleza', 'CE', '2020-12-22', 68000.00, 11),
('Papel e Cia - Centro', 'Rio de Janeiro', 'RJ', '2016-08-17', 90000.00, 14);
