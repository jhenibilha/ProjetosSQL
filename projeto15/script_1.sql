CREATE SCHEMA projeto15 AUTHORIZATION jhenifer;

-- Criação das tabelas

CREATE TABLE projeto15.clientes_saas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    empresa VARCHAR(100),
    data_cadastro DATE NOT NULL
);

CREATE TABLE projeto15.assinaturas_saas (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES projeto15.clientes_saas(id),
    plano VARCHAR(50) NOT NULL,
    valor_mensal DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE
);

-- Inserção dos dados

-- Inserindo clientes

INSERT INTO projeto15.clientes_saas (nome, email, empresa, data_cadastro) VALUES
('João Silva', 'joao.silva@example.com', 'TechVision', '2023-02-15'),
('Maria Oliveira', 'maria.oliveira@example.com', 'InnovaCorp', '2023-06-01'),
('Carlos Santos', 'carlos.santos@example.com', 'DevHouse', '2024-01-10'),
('Ana Costa', 'ana.costa@example.com', 'MarketUp', '2024-03-20'),
('Fernanda Lima', 'fernanda.lima@example.com', 'CloudSys', '2024-05-05');

-- Inserindo assinaturas

INSERT INTO projeto15.assinaturas_saas (cliente_id, plano, valor_mensal, status, data_inicio, data_fim) VALUES
(1, 'Pro', 199.90, 'ativa', '2023-02-15', NULL),
(2, 'Basic', 79.90, 'cancelada', '2023-06-01', '2024-04-01'),
(3, 'Premium', 299.90, 'ativa', '2024-01-10', NULL),
(4, 'Pro', 199.90, 'ativa', '2024-03-20', NULL),
(5, 'Basic', 79.90, 'ativa', '2024-05-05', NULL);
