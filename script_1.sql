-- CRIAÇÃO DAS TABELAS

-- Criar tabela de clientes
CREATE TABLE projeto2.clientes_loja_piscina (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(255)
);

-- Criar tabela de produtos
CREATE TABLE projeto2.produtos_loja_piscina (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10, 2),
    estoque INT
);

-- Criar tabela de vendas
CREATE TABLE projeto2.vendas_loja_piscina (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes_loja_piscina(id),
    produto_id INT REFERENCES produtos_loja_piscina(id),
    data_venda DATE,
    quantidade INT,
    total DECIMAL(10, 2)
);

-- INSERÇÃO DOS REGISTROS

INSERT INTO projeto2.clientes_loja_piscina (nome, email, telefone, endereco)
VALUES 
('João Silva', 'joao.silva@email.com', '11987654321', 'Rua das Flores, 123, São Paulo - SP'),
('Maria Oliveira', 'maria.oliveira@email.com', '11912345678', 'Avenida Paulista, 456, São Paulo - SP'),
('Carlos Souza', 'carlos.souza@email.com', '11933445566', 'Rua Rio Branco, 789, São Paulo - SP');

INSERT INTO projeto2.produtos_loja_piscina (nome, descricao, preco, estoque)
VALUES 
('Piscina de Chão 3x2', 'Piscina de 3 metros por 2 metros, ideal para espaços pequenos.', 1500.00, 10),
('Piscina de Chão 4x3', 'Piscina de 4 metros por 3 metros, ideal para famílias grandes.', 2500.00, 5),
('Piscina de Chão 6x3', 'Piscina de 6 metros por 3 metros, para quem quer mais espaço e conforto.', 4000.00, 2),
('Piscina Infantil 2x1', 'Piscina pequena para crianças, 2 metros por 1 metro.', 500.00, 20);

INSERT INTO projeto2.vendas_loja_piscina (cliente_id, produto_id, data_venda, quantidade, total)
VALUES 
(1, 1, '2023-05-01', 1, 1500.00),
(2, 2, '2023-05-02', 1, 2500.00),
(3, 3, '2023-05-03', 1, 4000.00),
(1, 4, '2023-05-04', 2, 1000.00),
(2, 1, '2023-05-05', 1, 1500.00);

SELECT * FROM projeto2.vendas_loja_piscina;


