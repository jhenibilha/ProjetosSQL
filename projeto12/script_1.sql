CREATE SCHEMA projeto12 AUTHORIZATION jhenifer;

-- Criação das tabelas

CREATE TABLE projeto12.estudantes_univ (
    id_estudante SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    curso VARCHAR(100)
);

CREATE TABLE projeto12.disciplinas_univ (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    id_estudante INT,
    semestre VARCHAR(20),
    FOREIGN KEY (id_estudante) REFERENCES projeto12.estudantes_univ (id_estudante)
);

-- Inserindo dados fictícios

INSERT INTO projeto12.estudantes_univ (nome, idade, curso) VALUES
('João Silva', 20, 'Engenharia de Computação'),
('Maria Oliveira', 22, 'Medicina'),
('Pedro Costa', 21, 'Arquitetura'),
('Ana Souza', 23, 'Biologia'),
('Lucas Martins', 19, 'Engenharia de Computação');

-- Inserindo dados fictícios

INSERT INTO projeto12.disciplinas_univ (nome_disciplina, id_estudante, semestre) VALUES
('Matemática', 1, '2025-1'),
('Física', 1, '2025-1'),
('Anatomia', 2, '2025-1'),
('Desenho Técnico', 3, '2025-1'),
('Bioquímica', 4, '2025-2'),
('Algoritmos', 5, '2025-1'),
('Cálculo', 1, '2025-2');
