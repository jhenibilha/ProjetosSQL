-- Tabela de Clientes
CREATE TABLE projeto1.clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_cadastro DATE
);

-- Tabela de Contas
CREATE TABLE projeto1.contas (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    tipo VARCHAR(20),  -- Ex: 'Corrente', 'Poupança'
    saldo DECIMAL(10, 2)
);

-- Tabela de Transações
CREATE TABLE projeto1.transacoes (
    id SERIAL PRIMARY KEY,
    conta_id INT REFERENCES contas(id),
    tipo VARCHAR(20),  -- Ex: 'Débito', 'Crédito'
    valor DECIMAL(10, 2),
    data_transacao TIMESTAMP,
    descricao TEXT
);

-- Inserindo Clientes
INSERT INTO projeto1.clientes (nome, email, data_cadastro) VALUES
('João Silva', 'joao.silva@email.com', '2023-01-15'),
('Maria Oliveira', 'maria.oliveira@email.com', '2022-11-10'),
('Carlos Souza', 'carlos.souza@email.com', '2023-04-22'),
('Ana Costa', 'ana.costa@email.com', '2021-06-03'),
('Paulo Mendes', 'paulo.mendes@email.com', '2023-02-17');

-- Inserindo Contas Bancárias
INSERT INTO projeto1.contas (cliente_id, tipo, saldo) VALUES
(1, 'Corrente', 1500.75),
(2, 'Poupança', 7500.50),
(3, 'Corrente', 320.10),
(4, 'Corrente', 1800.30),
(5, 'Poupança', 12500.00);

-- Inserindo Transações (Débitos e Créditos)
INSERT INTO projeto1.transacoes (conta_id, tipo, valor, data_transacao, descricao) VALUES
(1, 'Crédito', 1000.00, '2023-05-10 14:32:00', 'Depósito via transferência'),
(1, 'Débito', 200.00, '2023-05-12 10:10:00', 'Pagamento de boleto'),
(2, 'Débito', 500.00, '2023-05-11 15:45:00', 'Pagamento de cartão de crédito'),
(2, 'Crédito', 2000.00, '2023-05-13 09:00:00', 'Depósito em caixa eletrônico'),
(3, 'Crédito', 150.00, '2023-05-09 17:20:00', 'Transferência recebida'),
(4, 'Débito', 50.00, '2023-05-14 11:30:00', 'Pagamento de transferência bancária'),
(4, 'Crédito', 500.00, '2023-05-15 13:10:00', 'Depósito em conta corrente'),
(5, 'Débito', 300.00, '2023-05-11 16:00:00', 'Retirada em caixa eletrônico'),
(5, 'Crédito', 1200.00, '2023-05-13 08:30:00', 'Depósito de salário');

