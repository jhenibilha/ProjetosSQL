CREATE SCHEMA projeto10 AUTHORIZATION jhenifer;

-- Criação das tabelas

CREATE TABLE projeto10.campanhas_mkt (
    campanha_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(20)
);


CREATE TABLE projeto10.clientes_mkt (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    campanha_id INT REFERENCES projeto10.campanhas_mkt(campanha_id)
);


CREATE TABLE projeto10.vendas_mkt (
    venda_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES projeto10.clientes_mkt (cliente_id),
    data_venda DATE,
    valor NUMERIC(10,2)
);

-- Inserção dos dados 

INSERT INTO projeto10.campanhas_mkt (nome, data_inicio, data_fim, status) VALUES
('Promoção de Verão', '2024-02-01', '2024-02-28', 'Concluída'),
('Campanha de Natal', '2024-12-01', '2024-12-31', 'Ativa'),
('Desconto do Mês', '2024-05-01', '2024-05-31', 'Concluída'),
('Lançamento de Produto', '2024-07-01', '2024-07-15', 'Ativa'),
('Promoção de Verão', '2024-02-10', '2024-02-28', 'Concluída'),
('Campanha de Natal', '2024-12-09', '2024-12-31', 'Ativa'),
('Desconto do Mês', '2024-05-01', '2024-05-31', 'Concluída'),
('Lançamento de Produto', '2024-08-01', '2024-08-15', 'Ativa'),
('Super Ofertas', '2024-08-01', '2024-08-31', 'Pausada');


INSERT INTO projeto10.clientes_mkt (nome, email, campanha_id) VALUES
('Lucas Oliveira', 'lucas.oliveira@email.com', 1),
('Mariana Costa', 'mariana.costa@email.com', 2),
('Carlos Souza', 'carlos.souza@email.com', 3),
('Ana Lima', 'ana.lima@email.com', 1),
('Jhenifer Bilhalva', 'jheniferbilhalva@gmail.com', 4),
('Paulo Santos', 'paulo.santos@email.com', NULL);


INSERT INTO projeto10.vendas_mkt (cliente_id, data_venda, valor) VALUES
(1, '2024-06-10', 150.75),
(2, '2024-12-05', 300.50),
(3, '2024-05-10', 120.00),
(4, '2024-06-20', 200.00),
(5, '2024-08-05', 0.00);

