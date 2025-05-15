-- Cria o schema no banco de dados
CREATE SCHEMA projeto4 AUTHORIZATION jhenifer;

-- Criando a tabela 'estudantes_escola'
CREATE TABLE projeto4.estudantes_escola (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    nota_exame1 DECIMAL(5, 2),
    nota_exame2 DECIMAL(5, 2),
    tipo_sistema_operacional VARCHAR(20)
);

-- Criando a tabela 'escolas'
CREATE TABLE projeto4.escolas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(20),  
    endereco VARCHAR(255),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    pais VARCHAR(50),
    ano_fundacao INT
);

-- Criando a tabela 'informacoes_pessoais'
CREATE TABLE projeto4.informacoes_pessoais (
    id SERIAL PRIMARY KEY,
    estudante_id INT REFERENCES projeto4.estudantes_escola(id),  -- Relaciona com a tabela de estudantes
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    genero VARCHAR(10)  
);


-- Inserindo 30 registros fictícios na tabela 'estudantes_escola'
INSERT INTO projeto4.estudantes_escola (nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional) VALUES
('Xavier', 'Murphy', 86.0, 89.0, 'Linux'),
('Yara', 'Bailey', 80.5, 81.0, 'Windows'),
('Alice', 'Smith', 80.5, 85.0, 'Windows'),
('Quincy', 'Roberts', 86.5, 90.0, 'Mac'),
('Bob', 'Johnson', 75.0, 88.0, 'Linux'),
('Carol', 'Williams', 90.0, 90.5, 'Mac'),
('Grace', 'Miller', 95.5, 93.0, 'Windows'),
('Nina', 'Carter', 80.5, 81.0, 'Windows'),
('Ursula', 'Kim', 80.0, 82.5, 'Linux'),
('Eve', 'Jones', 90.0, 88.0, 'Mac'),
('Frank', 'Garcia', 79.0, 82.0, 'Linux'),
('Helen', 'Davis', 90.0, 89.5, 'Mac'),
('Grace', 'Rodriguez', 89.0, 88.0, 'Windows'),
('Jack', 'Martinez', 90.0, 80.0, 'Linux'),
('Karen', 'Hernandez', 93.5, 91.0, 'Windows'),
('Leo', 'Lewis', 82.0, 85.5, 'Mac'),
('Mallory', 'Nelson', 91.0, 89.0, 'Linux'),
('Oscar', 'Mitchell', 88.0, 87.5, 'Linux'),
('Paul', 'Perez', 94.0, 92.0, 'Windows'),
('Rita', 'Gomez', 77.0, 80.0, 'Linux'),
('Steve', 'Freeman', 89.5, 88.5, 'Windows'),
('Troy', 'Reed', 90.0, 92.0, 'Mac'),
('Victor', 'Morgan', 90.0, 85.0, 'Windows'),
('Oscar', 'Bell', 85.5, 87.0, 'Mac'),
('Zane', 'Rivera', 89.0, 90.5, 'Mac'),
('Aria', 'Wright', 75.0, 76.5, 'Linux'),
('Bruce', 'Cooper', 90.0, 84.0, 'Windows'),
('Karen', 'Peterson', 90.0, 92.5, 'Mac'),
('Dave', 'Brown', 88.5, 89.0, 'Windows'),
('Derek', 'Wood', 86.0, 87.5, 'Linux');

-- Inserindo dados na tabela 'escolas'
INSERT INTO projeto4.escolas (nome, tipo, endereco, cidade, estado, pais, ano_fundacao) VALUES
('Escola São João', 'Privada', 'Rua das Flores, 123', 'São Paulo', 'SP', 'Brasil', 1985),
('Escola Rio Claro', 'Pública', 'Avenida Brasil, 456', 'Rio de Janeiro', 'RJ', 'Brasil', 1950),
('Colégio Alpha', 'Privada', 'Rua das Acácias, 789', 'Belo Horizonte', 'MG', 'Brasil', 1992);

-- Inserindo dados na tabela 'informacoes_pessoais'
INSERT INTO projeto4.informacoes_pessoais (estudante_id, data_nascimento, endereco, telefone, email, genero) VALUES
(1, '1999-03-15', 'Rua das Palmeiras, 12', '(11) 98765-4321', 'xavier.murphy@email.com', 'Masculino'),
(2, '2000-07-22', 'Avenida Central, 34', '(21) 91234-5678', 'yara.bailey@email.com', 'Feminino'),
(3, '1998-11-05', 'Rua do Sol, 56', '(31) 93456-7890', 'alice.smith@email.com', 'Feminino'),
(4, '1997-01-10', 'Avenida Pôr do Sol, 78', '(51) 93456-1234', 'quincy.roberts@email.com', 'Masculino'),
(5, '2001-05-23', 'Rua das Andorinhas, 101', '(41) 98123-4567', 'bob.johnson@email.com', 'Masculino'),
(6, '1998-09-30', 'Avenida dos Pioneiros, 99', '(61) 99123-4567', 'carol.williams@email.com', 'Feminino'),
(7, '1997-04-25', 'Rua das Magnólias, 12', '(11) 97531-2468', 'grace.miller@email.com', 'Feminino'),
(8, '2000-12-12', 'Rua do Bosque, 21', '(21) 93947-8990', 'nina.carter@email.com', 'Feminino'),
(9, '1999-07-19', 'Avenida Central, 98', '(31) 99345-1234', 'ursula.kim@email.com', 'Feminino'),
(10, '1998-08-22', 'Rua do Mar, 23', '(41) 94567-5432', 'eve.jones@email.com', 'Feminino'),
(11, '2001-02-17', 'Avenida Liberdade, 432', '(51) 96123-8765', 'frank.garcia@email.com', 'Masculino'),
(12, '1997-11-10', 'Rua dos Limoeiros, 88', '(21) 91456-4321', 'helen.davis@email.com', 'Feminino'),
(13, '2000-09-14', 'Rua Nova, 56', '(31) 96789-1234', 'grace.rodriguez@email.com', 'Feminino'),
(14, '1999-04-30', 'Avenida das Palmeiras, 120', '(41) 91234-7890', 'jack.martinez@email.com', 'Masculino'),
(15, '1998-03-21', 'Rua das Acácias, 12', '(11) 98765-4321', 'karen.hernandez@email.com', 'Feminino'),
(16, '2000-06-09', 'Rua das Orquídeas, 99', '(61) 98123-4567', 'leo.lewis@email.com', 'Masculino'),
(17, '2001-01-11', 'Rua do Sol, 10', '(21) 99654-3210', 'mallory.nelson@email.com', 'Feminino'),
(18, '1999-12-03', 'Avenida Brasil, 300', '(41) 96789-6543', 'oscar.mitchell@email.com', 'Masculino'),
(19, '2000-02-20', 'Rua dos Ipês, 45', '(51) 99876-5432', 'paul.perez@email.com', 'Masculino'),
(20, '1998-10-05', 'Rua do Rio, 88', '(31) 99345-9876', 'rita.gomez@email.com', 'Feminino'),
(21, '2001-07-17', 'Avenida Morumbi, 56', '(61) 96789-7654', 'steve.freeman@email.com', 'Masculino'),
(22, '1997-11-25', 'Rua São João, 44', '(41) 96345-1234', 'troy.reed@email.com', 'Masculino'),
(23, '2000-10-11', 'Rua do Parque, 120', '(21) 93756-4321', 'victor.morgan@email.com', 'Masculino'),
(24, '1998-12-02', 'Rua das Rosas, 200', '(31) 99823-4657', 'oscar.bell@email.com', 'Masculino'),
(25, '2001-04-22', 'Avenida das Águas, 150', '(51) 91543-9876', 'zane.rivera@email.com', 'Masculino'),
(26, '1997-08-17', 'Rua do Caminho, 75', '(11) 97234-8765', 'aria.wright@email.com', 'Feminino'),
(27, '2000-03-18', 'Avenida Paulista, 76', '(21) 96543-2109', 'bruce.cooper@email.com', 'Masculino'),
(28, '1999-02-10', 'Rua do Verde, 45', '(41) 96789-6541', 'karen.pet@email.com', 'Feminino');
