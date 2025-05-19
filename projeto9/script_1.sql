CREATE SCHEMA projeto9 AUTHORIZATION jhenifer;

-- Criação das tabelas

CREATE TABLE projeto9.clientes_fin (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_cadastro DATE
);

CREATE TABLE projeto9.contas_fin (
    conta_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES projeto9.clientes_fin (cliente_id),
    tipo_conta VARCHAR(50),
    saldo NUMERIC(12,2)
);

CREATE TABLE projeto9.transacoes_fin (
    transacao_id SERIAL PRIMARY KEY,
    conta_id INT REFERENCES projeto9.contas_fin (conta_id),
    data_transacao DATE,
    tipo_transacao VARCHAR(20),
    valor NUMERIC(10,2)
);

-- Inserção de dados

INSERT INTO projeto9.clientes_fin (nome, email, data_cadastro) VALUES
('João Silva', 'joao.silva@email.com', '2023-02-10'),
('Maria Oliveira', 'maria.oliveira@email.com', '2023-04-22'),
('Carlos Souza', 'carlos.souza@email.com', '2023-06-15'),
('Ana Costa', 'ana.costa@email.com', '2023-07-01'),
('Paulo Mendes', 'paulo.mendes@email.com', '2023-09-18');

INSERT INTO projeto9.contas_fin (cliente_id, tipo_conta, saldo) VALUES
(1, 'Corrente', 2500.75),
(2, 'Poupança', 10400.00),
(3, 'Corrente', 350.50),
(4, 'Investimento', 50000.00),
(5, 'Poupança', 1500.00);

INSERT INTO projeto9.transacoes_fin (conta_id, data_transacao, tipo_transacao, valor) VALUES
(1, '2024-01-10', 'Depósito', 1000.00),
(1, '2024-02-15', 'Saque', 200.00),
(2, '2024-03-05', 'Depósito', 4000.00),
(3, '2024-04-12', 'Saque', 100.00),
(4, '2024-04-15', 'Depósito', 10000.00),
(5, '2024-05-01', 'Saque', 500.00),
(5, '2024-05-10', 'Depósito', 300.00);