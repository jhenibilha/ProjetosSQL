CREATE SCHEMA projeto19 AUTHORIZATION jhenifer;

-- Criação das tabelas
CREATE TABLE projeto19.clientesstore (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50),
    estado VARCHAR(2),
    data_cadastro DATE
);

CREATE TABLE projeto19.categoriasstore (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE projeto19.produtosstore (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco NUMERIC(10,2),
    categoria_id INTEGER REFERENCES projeto19.categoriasstore(id)
);

CREATE TABLE projeto19.pedidosstore (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES projeto19.clientesstore(id),
    data_pedido DATE,
    status VARCHAR(20)
);

CREATE TABLE projeto19.itens_pedidostore (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES projeto19.pedidosstore(id),
    produto_id INTEGER REFERENCES projeto19.produtosstore(id),
    quantidade INTEGER,
    preco_unitario NUMERIC(10,2)
);

-- Inserção dos dados

-- Categorias
INSERT INTO projeto19.categoriasstore (nome) VALUES ('Eletrônicos'), ('Livros'), ('Vestuário');

-- Clientes
INSERT INTO projeto19.clientesstore (nome, email, cidade, estado, data_cadastro) VALUES
('Ana Silva', 'ana@email.com', 'São Paulo', 'SP', '2023-01-15'),
('Carlos Lima', 'carlos@email.com', 'Rio de Janeiro', 'RJ', '2023-02-10'),
('Fernanda Souza', 'fer@email.com', 'Belo Horizonte', 'MG', '2023-03-05');

-- Produtos
INSERT INTO projeto19.produtosstore (nome, preco, categoria_id) VALUES
('Notebook Dell', 3500.00, 1),
('Camisa Polo', 120.00, 3),
('Livro SQL Avançado', 90.00, 2),
('Fone Bluetooth', 250.00, 1);

-- Pedidos
INSERT INTO projeto19.pedidosstore (cliente_id, data_pedido, status) VALUES
(1, '2023-04-01', 'Finalizado'),
(2, '2023-04-03', 'Cancelado'),
(1, '2023-04-10', 'Finalizado'),
(3, '2023-04-11', 'Finalizado');

-- Itens do Pedido
INSERT INTO projeto19.itens_pedidostore (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 3500.00),  -- Ana comprou 1 Notebook
(1, 3, 2, 90.00),    -- Ana comprou 2 Livros
(2, 4, 1, 250.00),   -- Carlos comprou 1 Fone (pedido cancelado)
(3, 2, 3, 120.00),   -- Ana comprou 3 Camisas
(4, 3, 1, 90.00),    -- Fernanda comprou 1 Livro
(4, 4, 2, 250.00);   -- Fernanda comprou 2 Fones
