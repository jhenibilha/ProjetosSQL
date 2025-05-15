-- Cria o schema no banco de dados
CREATE SCHEMA projeto5 AUTHORIZATION jhenifer;

-- Cria a tabela
CREATE TABLE projeto5.vendas_loja (
    ID_Venda SERIAL PRIMARY KEY,
    Data_Venda DATE NOT NULL,
    Nome_Produto VARCHAR(255) NOT NULL,
    Categoria_Produto VARCHAR(255) NOT NULL,
    Unidades_Vendidas INT NOT NULL,
    Valor_Unitario_Venda DECIMAL(10, 2) NOT NULL
);

-- Criação da tabela 'clientes'
CREATE TABLE projeto5.clientes (
    ID_Cliente SERIAL PRIMARY KEY,
    Nome_Cliente VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Endereco VARCHAR(255),
    Data_Cadastro DATE NOT NULL
);

-- Carrega os dados
INSERT INTO projeto5.vendas_loja (Data_Venda, Nome_Produto, Categoria_Produto, Unidades_Vendidas, Valor_Unitario_Venda) VALUES
('2023-08-01', 'Produto A', 'Categoria 1', 5, 10.50),
('2023-08-01', 'Produto B', 'Categoria 1', 3, 15.00),
('2023-09-01', 'Produto C', 'Categoria 2', 4, 12.75),
('2023-09-02', 'Produto D', 'Categoria 3', 2, 20.00),
('2023-09-02', 'Produto E', 'Categoria 3', 6, 18.50),
('2023-09-10', 'Produto A', 'Categoria 1', 7, 10.50),
('2023-10-01', 'Produto B', 'Categoria 1', 2, 15.00),
('2023-10-03', 'Produto C', 'Categoria 2', 5, 12.75),
('2023-10-04', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-01', 'Produto C', 'Categoria 3', 3, 21.00),
('2023-11-07', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-11', 'Produto A', 'Categoria 2', 1, 17.50),
('2023-11-12', 'Produto B', 'Categoria 1', 5, 19.50),
('2023-11-14', 'Produto A', 'Categoria 2', 5, 12.50),
('2023-11-16', 'Produto E', 'Categoria 3', 7, 14.50);

-- Inserindo dados fictícios na tabela 'clientes'
INSERT INTO projeto5.clientes (Nome_Cliente, Email, Telefone, Endereco, Data_Cadastro) VALUES
('Ana Souza', 'ana.souza@email.com', '(11) 91234-5678', 'Rua das Flores, 123', '2022-01-15'),
('Carlos Pereira', 'carlos.pereira@email.com', '(21) 93456-7890', 'Avenida Central, 456', '2022-02-20'),
('Fernanda Silva', 'fernanda.silva@email.com', '(31) 95678-4321', 'Rua do Sol, 789', '2022-03-10'),
('João Santos', 'joao.santos@email.com', '(41) 97321-6543', 'Avenida Brasil, 321', '2022-04-05'),
('Luana Almeida', 'luana.almeida@email.com', '(51) 94876-1234', 'Rua da Paz, 135', '2022-05-25'),
('Paulo Oliveira', 'paulo.oliveira@email.com', '(61) 98345-6789', 'Rua das Acácias, 456', '2022-06-18'),
('Roberta Lima', 'roberta.lima@email.com', '(71) 91234-7654', 'Rua do Mar, 678', '2022-07-02'),
('Tiago Costa', 'tiago.costa@email.com', '(85) 98765-4321', 'Avenida dos Ipês, 234', '2022-08-09'),
('Verônica Rocha', 'veronica.rocha@email.com', '(61) 97234-5678', 'Rua das Flores, 89', '2022-09-12'),
('Vinícius Almeida', 'vinicius.almeida@email.com', '(71) 98765-4321', 'Rua das Orquídeas, 101', '2022-10-20');


-- Adicionando a coluna 'ID_Cliente' na tabela 'vendas_loja' para associar as vendas aos clientes
ALTER TABLE projeto5.vendas_loja
ADD COLUMN ID_Cliente INT;

-- Atualizando a coluna 'ID_Cliente' com dados fictícios de clientes
UPDATE projeto5.vendas_loja
SET ID_Cliente = 1 WHERE ID_Venda IN (1, 2, 6, 11, 12, 13);
UPDATE projeto5.vendas_loja
SET ID_Cliente = 2 WHERE ID_Venda IN (3, 4, 5);
UPDATE projeto5.vendas_loja
SET ID_Cliente = 3 WHERE ID_Venda IN (7, 8);
UPDATE projeto5.vendas_loja
SET ID_Cliente = 4 WHERE ID_Venda IN (9, 10);
UPDATE projeto5.vendas_loja
SET ID_Cliente = 5 WHERE ID_Venda IN (14, 15);
UPDATE projeto5.vendas_loja
SET ID_Cliente = 6 WHERE ID_Venda IN (16);

