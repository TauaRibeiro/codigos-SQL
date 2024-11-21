CREATE DATABASE db;
USE db;

CREATE TABLE `curso` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(70) NOT NULL,
  PRIMARY KEY (`id_curso`)) ;

CREATE TABLE `notas` (
  `id_professor` int NOT NULL,
  `id_disciplina` int NOT NULL,
  `id_turma` int NOT NULL,
  `nr_matricula` int NOT NULL,
  `data_nota` date NOT NULL,
  `id_avaliacao` int NOT NULL,
  `nota_avaliacao_1` double DEFAULT NULL,
  `nota_avaliacao_2` double DEFAULT NULL,
  `nota_avaliacao_3` double DEFAULT NULL,
  PRIMARY KEY (`id_professor`,`id_disciplina`,`id_turma`,`nr_matricula`,`data_nota`,`id_avaliacao`),
  KEY `fk_disciplina_nota_idx` (`id_disciplina`),
  KEY `fk_turma_nota_idx` (`id_turma`),
  KEY `fk_aluno_nota_idx` (`nr_matricula`),
  CONSTRAINT `fk_aluno_nota` FOREIGN KEY (`nr_matricula`) REFERENCES `alunos` (`nr_matricula`),
  CONSTRAINT `fk_disciplina_nota` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id_disciplina`),
  CONSTRAINT `fk_professor_nota` FOREIGN KEY (`id_professor`) REFERENCES `professor` (`id_professor`),
  CONSTRAINT `fk_turma_nota` FOREIGN KEY (`id_turma`) REFERENCES `turma` (`id_turma`)
);


CREATE TABLE `alunos` (
`nr_matricula` int NOT NULL AUTO_INCREMENT,
`nome_aluno` varchar(70) NOT NULL,
`CPF` int NOT NULL,
`endereco_aluno` varchar(70) NOT NULL,
`foto_aluno` blob,
PRIMARY KEY (`nr_matricula`)
);

CREATE TABLE `disciplina` (
`id_disciplina` int NOT NULL AUTO_INCREMENT,
`nome_disciplina` varchar(50) NOT NULL,
`carga_horaria` int NOT NULL,
`descricao_disciplina` varchar(100) NOT NULL,
`campo` varchar(45) GENERATED ALWAYS AS ((`carga_horaria` * 2)) VIRTUAL,
PRIMARY KEY (`id_disciplina`)
);


CREATE TABLE `turma` (
`id_turma` int NOT NULL AUTO_INCREMENT,
`id_curso` int NOT NULL,
`data_turma` date NOT NULL,
`turno` varchar(70) NOT NULL,
`nr_matricula` int NOT NULL,
PRIMARY KEY (`id_turma`),
KEY `fk_curso_turma` (`id_curso`), 
CONSTRAINT `fk_curso_turma` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`)
);


CREATE TABLE `professor` (
`id_professor` int NOT NULL AUTO_INCREMENT,
`nome_professor` varchar(150) NOT NULL,
`cpf_professor` varchar(11) NOT NULL,
`email_professor` varchar(150) NOT NULL, 
`cel_professor` varchar(20) NOT NULL, 
PRIMARY KEY (`id_professor`), 
UNIQUE KEY `cpf_professor_UNIQUE` (`cpf_professor`)
);
-- alters
ALTER TABLE `db`.`alunos`
	CHANGE COLUMN `CPF` `CPF` BIGINT NOT NULL;
    
-- select
SELECT calcular_carga_horaria_total(1);
SELECT calcular_media_notas(2, 2);
SELECT contar_alunos_turma(1);
SELECT nome_professor_disciplina(3);

-- 	Funções
-- Calculo da media
DELIMITER //
CREATE FUNCTION calcular_media_notas(
    aluno_matricula INT, 
    disciplina_id INT
) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE media DOUBLE;
    SELECT AVG((nota_avaliacao_1 + nota_avaliacao_2 + nota_avaliacao_3) / 3)
    INTO media
    FROM notas
    WHERE nr_matricula = aluno_matricula
      AND id_disciplina = disciplina_id;
    RETURN media;
END //
DELIMITER ;

-- Calculo da carga horaria
DELIMITER //
CREATE FUNCTION calcular_carga_horaria_total(disciplina_ids INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE carga_total INT;

    SELECT SUM(carga_horaria)
    INTO carga_total
    FROM disciplina
    WHERE FIND_IN_SET(id_disciplina, disciplina_ids);

    RETURN IFNULL(carga_total, 0);
END //
DELIMITER ;

-- calculo do número de alunos
DELIMITER //
CREATE FUNCTION contar_alunos_turma(
    turma_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE quantidade INT;

    SELECT COUNT(DISTINCT nr_matricula)
    INTO quantidade
    FROM notas
    WHERE id_turma = turma_id;

    RETURN quantidade;
END //
DELIMITER ;

-- 	professor responsável por uma disciplina
DELIMITER //
CREATE FUNCTION nome_professor_disciplina(
    disciplina_id INT
) RETURNS VARCHAR(150)
DETERMINISTIC
BEGIN
    DECLARE nome_professor VARCHAR(150);

    SELECT p.nome_professor
    INTO nome_professor
    FROM professor p
    JOIN notas n ON p.id_professor = n.id_professor
    WHERE n.id_disciplina = disciplina_id
    LIMIT 1;

    RETURN nome_professor;
END //
DELIMITER ;
-- select
SELECT calcular_carga_horaria_total(1);
SELECT calcular_media_notas();

-- inserts
-- Inserindo dados na tabela `curso`
INSERT INTO `curso` (`id_curso`, `nome_curso`) VALUES
(1, 'Ciência da Computação'),
(2, 'Engenharia de Software'),
(3, 'Análise de Sistemas');

INSERT INTO `alunos` (`nr_matricula`, `nome_aluno`, `CPF`, `endereco_aluno`, `foto_aluno`) VALUES
(1, 'João Silva', 00345678900, 'Rua das Flores, 123', NULL),
(2, 'Maria Oliveira', 98765432100, 'Avenida Central, 456', NULL),
(3, 'Carlos Santos', 56789012345, 'Travessa da Paz, 789', NULL);

INSERT INTO `disciplina` (`id_disciplina`, `nome_disciplina`, `carga_horaria`, `descricao_disciplina`) VALUES
(1, 'Algoritmos e Estruturas de Dados', 60, 'Introdução a algoritmos e estruturas de dados'),
(2, 'Banco de Dados', 80, 'Conceitos de modelagem e gerenciamento de banco de dados'),
(3, 'Engenharia de Software', 50, 'Princípios de engenharia de software');

INSERT INTO `professor` (`id_professor`, `nome_professor`, `cpf_professor`, `email_professor`, `cel_professor`) VALUES
(1, 'Ana Pereira', '12345678900', 'ana.pereira@universidade.edu', '55991234567'),
(2, 'Luiz Costa', '98765432100', 'luiz.costa@universidade.edu', '55998765432'),
(3, 'Cláudia Souza', '11122233344', 'claudia.souza@universidade.edu', '55997654321');

INSERT INTO `turma` (`id_turma`, `id_curso`, `data_turma`, `turno`, `nr_matricula`) VALUES
(1, 1, '2024-01-15', 'Matutino', 1),
(2, 2, '2024-01-15', 'Noturno', 2),
(3, 3, '2024-01-15', 'Vespertino', 3);

INSERT INTO `notas` 
(`id_professor`, `id_disciplina`, `id_turma`, `nr_matricula`, `data_nota`, `id_avaliacao`, `nota_avaliacao_1`, `nota_avaliacao_2`, `nota_avaliacao_3`) 
VALUES
(1, 1, 1, 1, '2024-02-15', 1, 8.5, 9.0, 8.7),
(2, 2, 2, 2, '2024-02-15', 1, 7.5, 8.0, 7.8),
(3, 3, 3, 3, '2024-02-15', 1, 9.0, 8.5, 9.2);

-- Delete
DELETE FROM `db`.`alunos`;
DELETE FROM `db`.`turma`;
DELETE FROM `db`.`professor`;
DELETE FROM `db`.`notas`;
DELETE FROM `db`.`disciplina`;
DELETE FROM `db`.`curso`;
