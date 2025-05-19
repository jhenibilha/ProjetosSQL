CREATE SCHEMA projeto7 AUTHORIZATION jhenifer;

CREATE TABLE projeto7.tratamentos_dentarios (
    id SERIAL PRIMARY KEY,
    paciente_nome VARCHAR(100),
    dentista_nome VARCHAR(100),
    data_tratamento DATE,
    tipo_tratamento VARCHAR(100),
    custo NUMERIC(10, 2),
    pago BOOLEAN,
    observacoes TEXT,
    cancer VARCHAR(3),       
    classe VARCHAR(10),      
    pagamento VARCHAR(10)    
);

INSERT INTO projeto7.tratamentos_dentarios 
(paciente_nome, dentista_nome, data_tratamento, tipo_tratamento, custo, pago, observacoes, cancer, classe, pagamento)
VALUES
('João Silva', 'Dra. Mariana Costa', '2025-03-10', 'Limpeza', 150.00, TRUE, 'Paciente com boa higiene bucal', 'não', 'adulto', 'pago'),
('Maria Souza', 'Dr. Pedro Almeida', '2025-03-15', 'Obturação', 300.00, FALSE, 'Cárie profunda em molar', 'não', 'adulto', 'em aberto'),
('Carlos Lima', 'Dra. Mariana Costa', '2025-03-20', 'Extração', 400.00, TRUE, 'Dente do siso inflamado', 'sim', 'idoso', 'pago'),
('Ana Beatriz', 'Dr. Fábio Mendes', '2025-04-05', 'Canal', 850.00, FALSE, 'Tratamento iniciado - 1ª sessão', 'não', 'adulto', 'em aberto'),
('Luciana Rocha', 'Dra. Mariana Costa', '2025-04-12', 'Clareamento', 600.00, TRUE, 'Resultado satisfatório', 'não', 'adulto', 'pago'),
('Renato Dias', 'Dr. Pedro Almeida', '2025-04-18', 'Prótese', 1200.00, FALSE, 'Aguardando molde final', 'sim', 'idoso', 'em aberto'),
('Fernanda Torres', 'Dr. Fábio Mendes', '2025-04-25', 'Aparelho ortodôntico', 2500.00, TRUE, 'Instalação realizada com sucesso', 'não', 'criança', 'pago'),
('Bruno Martins', 'Dra. Mariana Costa', '2025-05-01', 'Avaliação', 100.00, TRUE, 'Encaminhado para especialista', 'não', 'adulto', 'pago'),
('Paula Gomes', 'Dr. Pedro Almeida', '2025-05-10', 'Implante', 3000.00, FALSE, 'Planejamento cirúrgico realizado', 'sim', 'adulto', 'em aberto'),
('Tiago Ferreira', 'Dr. Fábio Mendes', '2025-05-15', 'Limpeza', 150.00, TRUE, 'Agendado retorno em 6 meses', 'não', 'criança', 'pago');
