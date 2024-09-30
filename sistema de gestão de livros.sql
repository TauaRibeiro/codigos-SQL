CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE `autor` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `nacionalidade` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `biografia` varchar(1000) NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`autor` (`id_autor`,`nome`, `nacionalidade`, `data_nascimento`, `biografia`)
VALUES 
('1', 'Machado de Assis', 'Brasileiro', '1839-06-21', 'Um dos maiores escritores da literatura brasileira.'),
('2', 'Clarice Lispector', 'Brasileira', '1920-12-10', 'Escritora modernista famosa por suas obras introspectivas.'),
('3', 'Jorge Amado', 'Brasileiro', '1912-08-10', 'Famoso por suas obras que retratam o nordeste brasileiro.'),
('4', 'Paulo Coelho', 'Brasileiro', '1947-08-24', 'Autor de O Alquimista, uma das obras brasileiras mais vendidas no mundo.'),
('5', 'José Saramago', 'Português', '1922-11-16', 'Ganhador do Nobel de Literatura, conhecido por obras como Ensaio Sobre a Cegueira.'),
('6', 'Gabriel García Márquez', 'Colombiano', '1927-03-06', 'Autor de Cem Anos de Solidão e ganhador do Nobel de Literatura.'),
('7', 'Jane Austen', 'Britânica', '1775-12-16', 'Autora de Orgulho e Preconceito, conhecida por retratar a sociedade britânica do século XIX.'),
('8', 'Leo Tolstoy', 'Russo', '1828-09-09', 'Escritor de Guerra e Paz e Anna Karenina, ícone da literatura russa.'),
('9', 'Haruki Murakami', 'Japonês', '1949-01-12', 'Escritor contemporâneo conhecido por suas histórias surrealistas.'),
('10', 'J.K. Rowling', 'Britânica', '1965-07-31', 'Autora da famosa série Harry Potter.');

SELECT * FROM `biblioteca`.`autor`;
SELECT * FROM `biblioteca`.`autor` WHERE(`nacionalidade` = 'Brasileiro');

UPDATE `biblioteca`.`autor` SET `data_nascimento` = '1839-06-21' WHERE(`id_autor` = '1');
UPDATE `biblioteca`.`autor` SET `data_nascimento` = '1839-06-21';

DELETE FROM `biblioteca`.`autor`;
DELETE FROM `biblioteca`.`autor` WHERE `id_autor` = '10';
COMMIT;

CREATE TABLE `autor_livro` (
  `id_livro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `fk_autor_idx` (`id_autor`),
  FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`),
  FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`categoria` (`id_categoria`, `nome`, `descricao`)
VALUES 
('1', 'Ficção', 'Obras que tratam de eventos e personagens imaginários.'),
('2', 'Não-Ficção', 'Livros baseados em fatos reais.'),
('3', 'Romance', 'Obras literárias focadas em histórias de amor e relacionamentos.'),
('4', 'Fantasia', 'Histórias com elementos mágicos ou sobrenaturais.'),
('5', 'Biografia', 'Relatos sobre a vida de pessoas notáveis.'),
('6', 'História', 'Obras que tratam de eventos históricos.'),
('7', 'Ciência', 'Livros focados em temas científicos e acadêmicos.'),
('8', 'Suspense', 'Obras que geram tensão e mistério.'),
('9', 'Poesia', 'Coletâneas de poemas e versos literários.'),
('10', 'Autoajuda', 'Livros que têm como objetivo o desenvolvimento pessoal e emocional.');

SELECT * FROM `biblioteca`.`categoria`;
SELECT * FROM `biblioteca`.`categoria` WHERE (`id_categoria` = 5);

UPDATE `biblioteca`.`categoria` SET `nome` = 'Teste';
UPDATE `biblioteca`.`categoria` SET `nome` = 'Teste' WHERE (`id_categoria` = '1');

DELETE FROM `biblioteca`.`categoria`;
DELETE FROM `biblioteca`.`categoria` WHERE (`id_categoria` = 10);

COMMIT;

CREATE TABLE `devolucao` (
  `id_devolucao` int NOT NULL AUTO_INCREMENT,
  `data_devolucao` date NOT NULL,
  `valor_multa` double NOT NULL,
  PRIMARY KEY (`id_devolucao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`devolucao` (`data_devolucao`, `valor_multa`)
VALUES 
('2022-09-01', 5.00),
('2022-09-15', 2.50),
('2022-10-01', 0.00),
('2022-10-15', 1.75),
('2022-11-01', 3.50),
('2022-11-15', 0.00),
('2022-12-01', 4.25),
('2022-12-15', 1.00),
('2023-01-01', 0.00),
('2023-01-15', 6.00);

SELECT * FROM `biblioteca`.`devolucao`;
SELECT * FROM `biblioteca`.`devolucao` WHERE `valor_multa` > 5;

UPDATE `biblioteca`.`devolucao` SET `valor_multa` = '10' WHERE (`valor_multa` = 0);
UPDATE `biblioteca`.`devolucao` SET `valor_multa` = '10';

DELETE FROM `biblioteca`.`devolucao`;
DELETE FROM `biblioteca`.`devolucao` WHERE `valor_multa` = 0;

COMMIT;

CREATE TABLE `emprestimo` (
  `id_emprestimo` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_livro` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `id_devolucao` int NOT NULL,
  PRIMARY KEY (`id_emprestimo`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_ususario_idx` (`id_livro`),
  KEY `fk_devolucao_livro` (`id_devolucao`),
  FOREIGN KEY (`id_devolucao`) REFERENCES `devolucao` (`id_devolucao`),
  FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`emprestimo` (`id_emprestimo`, `id_usuario`, `id_livro`, `status`, `id_devolucao`)
VALUES 
(1 ,1, 1, 'Devolvido', 1),
(2,2, 2, 'Devolvido', 2),
(3, 3, 3, 'Em andamento', 3),
(4, 4, 4, 'Devolvido', 4),
(5, 5, 5, 'Em atraso', 5),
(6, 6, 6, 'Em andamento', 6),
(7, 7, 7, 'Devolvido', 7),
(8, 8, 8, 'Em atraso', 8),
(9, 9, 9, 'Em andamento', 9),
(10, 10, 10, 'Devolvido', 10);

SELECT * FROM `biblioteca`.`emprestimo`;
SELECT * FROM `biblioteca`.`emprestimo` WHERE(`status` = 'Em atraso');

UPDATE `biblioteca`.`emprestimo` SET `status` = 'Devolvido';
UPDATE `biblioteca`.`emprestimo` SET `status` = 'Devolvido' WHERE(`status` = 'Em andamento');

DELETE FROM `biblioteca`.`emprestimo`;
DELETE FROM `biblioteca`.`emprestimo` WHERE(`status` = 'Devolvido');

COMMIT;

CREATE TABLE `livro` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `id_categoria` int NOT NULL,
  `editora` varchar(150) NOT NULL,
  `ano_publicacao` date NOT NULL,
  `numero_edicao` int NOT NULL,
  `quantidade_total` int NOT NULL,
  `quantidade_disponivel` int NOT NULL,
  PRIMARY KEY (`id_livro`),
  KEY `fk_categoria_livro_idx` (`id_categoria`),
  FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`livro` (`id_livro`, `titulo`, `id_categoria`, `editora`, `ano_publicacao`, `numero_edicao`, `quantidade_total`, `quantidade_disponivel`)
VALUES 
(1, 'Dom Casmurro', 1, 'Editora A', '1899-01-01', 1, 50, 30),
(2, 'A Hora da Estrela', 1, 'Editora B', '1977-01-01', 1, 30, 20),
(3, 'Capitães da Areia', 1, 'Editora C', '1937-01-01', 2, 40, 25),
(4, 'O Alquimista', 4, 'Editora D', '1988-01-01', 1, 60, 40),
(5, 'Ensaio Sobre a Cegueira', 1, 'Editora E', '1995-01-01', 1, 45, 35),
(6, 'Cem Anos de Solidão', 4, 'Editora F', '1967-01-01', 1, 50, 40),
(7, 'Orgulho e Preconceito', 3, 'Editora G', '1813-01-01', 2, 35, 25),
(8, 'Guerra e Paz', 5, 'Editora H', '1869-01-01', 3, 55, 45),
(9, 'Kafka à Beira-mar', 4, 'Editora I', '2002-01-01', 1, 40, 30),
(10, 'Harry Potter e a Pedra Filosofal', 4, 'Editora J', '1997-01-01', 1, 100, 80);

SELECT * FROM `biblioteca`.`livro`;
SELECT * FROM `biblioteca`.`livro` WHERE(`id_livro` = '1');

UPDATE `biblioteca`.`livro` SET `quantidade_disponivel` = 20;
UPDATE `biblioteca`.`livro` SET `quantidade_disponivel` = 20 WHERE(`quantidade_disponivel` > 30);

DELETE FROM `biblioteca`.`livro`;
DELETE FROM `biblioteca`.`livro` WHERE(`quantidade_disponivel` = 80);

COMMIT;

CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_livro` int NOT NULL,
  `data_reserva` date NOT NULL,
  `posicao_fila` int NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_reserva_idx` (`id_livro`),
  FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`reserva` (`id_reserva`, `id_usuario`, `id_livro`, `data_reserva`, `posicao_fila`)
VALUES 
(1, 1, 1, '2023-09-01', 1),
(2, 2, 2, '2023-09-02', 2),
(3, 3, 3, '2023-09-03', 1),
(4, 4, 4, '2023-09-04', 2),
(5, 5, 5, '2023-09-05', 1),
(6, 6, 6, '2023-09-06', 2),
(7, 7, 7, '2023-09-07', 1),
(8, 8, 8, '2023-09-08', 2),
(9, 9, 9, '2023-09-09', 1),
(10, 10, 10, '2023-09-10', 2);

SELECT * FROM `biblioteca`.`reserva`;
SELECT * FROM `biblioteca`.`reserva` WHERE(`id_livro` = '1');

UPDATE `biblioteca`.`reserva` SET `posicao_fila` = 1;
UPDATE `biblioteca`.`reserva` SET `posicao_fila` = 1 WHERE(`posicao_fila` = 2);

DELETE FROM `biblioteca`.`reserva`;
DELETE FROM `biblioteca`.`reserva` WHERE(`posicao_fila` = 1);

COMMIT;

CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `data_cadastro` date NOT NULL,
  `endereco` varchar(150) NOT NULL,
  PRIMARY KEY (`id_usuario`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biblioteca`.`usuario` (`id_usuario`, `nome`, `tipo`, `email`, `telefone`, `data_cadastro`, `endereco`)
VALUES 
(1, 'João Silva', 'Leitor', 'joao.silva@example.com', '11987654321', '2020-02-10', 'Rua A, 123'),
(2, 'Maria Souza', 'Leitor', 'maria.souza@example.com', '11987654322', '2019-07-15', 'Rua B, 456'),
(3, 'Carlos Pereira', 'Leitor', 'carlos.pereira@example.com', '11987654323', '2021-03-22', 'Rua C, 789'),
(4, 'Ana Oliveira', 'Leitor', 'ana.oliveira@example.com', '11987654324', '2021-01-05', 'Rua D, 101'),
(5, 'Pedro Lima', 'Leitor', 'pedro.lima@example.com', '11987654325', '2020-08-19', 'Rua E, 202'),
(6, 'Fernanda Costa', 'Bibliotecário', 'fernanda.costa@example.com', '11987654326', '2018-11-11', 'Rua F, 303'),
(7, 'Lucas Alves', 'Leitor', 'lucas.alves@example.com', '11987654327', '2020-12-08', 'Rua G, 404'),
(8, 'Juliana Lima', 'Leitor', 'juliana.lima@example.com', '11987654328', '2021-05-30', 'Rua H, 505'),
(9, 'Roberto Nunes', 'Bibliotecário', 'roberto.nunes@example.com', '11987654329', '2018-03-17', 'Rua I, 606'),
(10, 'Beatriz Melo', 'Leitor', 'beatriz.melo@example.com', '11987654330', '2019-10-25', 'Rua J, 707');

SELECT * FROM `biblioteca`.`usuario`;
SELECT * FROM `biblioteca`.`usuario` WHERE(`id_usuario` = 1);

UPDATE `biblioteca`.`usuario` SET `tipo` = 'bibliotecário';
UPDATE `biblioteca`.`usuario` SET `tipo` = 'bibliotecário' WHERE(`ìd_usuario` = 1);

DELETE FROM `biblioteca`.`usuario`;
DELETE FROM `biblioteca`.`usuario` WHERE(`ìd_usuario` = 1);

COMMIT;
