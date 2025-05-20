CREATE SCHEMA projeto11 AUTHORIZATION jhenifer;

-- Criação das tabelas

CREATE TABLE projeto11.clientes_roupas (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE projeto11.produtos_roupas (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10, 2)
);

CREATE TABLE projeto11.vendas_roupas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    quantidade INT,
    data_venda DATE,
    FOREIGN KEY (id_cliente) REFERENCES projeto11.clientes_roupas(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES projeto11.produtos_roupas(id_produto)
);

-- Inserção de dados nas tabelas

-- Inserindo dados fictícios
INSERT INTO projeto11.clientes_roupas (nome, email, telefone) VALUES
('Ana Souza', 'ana.souza@email.com', '11987654321'),
('Carlos Pereira', 'carlos.pereira@email.com', '11976543210'),
('Jhenifer Bilhalva', 'jhenifer@gmail.com', '53984288097'),
('Bruno Povoa', 'bruno@gmail.com', '53991190000'),
('Fabio Santos', 'fabio@gmail.com', '53984459696'),
('Mariana Lima', 'mariana.lima@email.com', '11965432100');

-- Inserindo dados fictícios
INSERT INTO projeto11.produtos_roupas (nome_produto, categoria, preco) VALUES
('Camisa Xadrez', 'Camisa', 89.90),
('Camisa Polo', 'Camisa', 59.90),
('Calça Jeans', 'Calça', 159.90),
('Vestido Floral', 'Vestido', 129.90),
('Camisa Xadrez', 'Camisa', 89.90),
('Calça Jeans', 'Calça', 159.90),
('Vestido Azul', 'Vestido', 119.90),
('Calça Social', 'Calça', 99.90),
('Vestido Azul', 'Vestido', 119.90);

-- Inserindo dados fictícios
INSERT INTO projeto11.vendas_roupas (id_cliente, id_produto, quantidade, data_venda) VALUES
(1, 1, 2, '2025-05-01'),
(2, 2, 1, '2025-05-02'),
(3, 3, 3, '2025-05-03'),
(4, 2, 1, '2025-05-01'),
(5, 2, 1, '2025-05-06'),
(6, 2, 1, '2025-05-06'),
(1, 1, 2, '2025-05-10'),
(2, 2, 1, '2025-05-09'),
(3, 3, 3, '2025-05-06'),
(4, 2, 1, '2025-05-07'),
(5, 2, 1, '2025-05-09');