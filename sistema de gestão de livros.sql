CREATE database BD_19102024;
use BD_19102024;
-- CREATES

CREATE TABLE `autor` (
  `idautor` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `nacionalidade` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `biografia` varchar(255) NOT NULL,
  PRIMARY KEY (`idautor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `emprestimo` (
  `idemprestimo` int NOT NULL,
  `idusuario` int NOT NULL,
  `idlivro` int NOT NULL,
  `data_emprestimo` date NOT NULL,
  `data_devolucao` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `multa_atraso` double NOT NULL,
  PRIMARY KEY (`idemprestimo`),
  KEY `fk_livro_emprestimo` (`idlivro`),
  KEY `fk_usuario_emprestimo` (`idusuario`),
  CONSTRAINT `fk_livro_emprestimo` FOREIGN KEY (`idlivro`) REFERENCES `livro` (`idlivro`),
  CONSTRAINT `fk_usuario_emprestimo` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `livro` (
  `idlivro` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `idcategoria` int NOT NULL,
  `editora` varchar(255) NOT NULL,
  `ano_de_publicacao` date NOT NULL,
  `numero_edicao` int NOT NULL,
  `qntd_exemplares` int NOT NULL,
  `qntd_disponivel` int NOT NULL,
  PRIMARY KEY (`idlivro`),
  KEY `fk_categoria_livro` (`idcategoria`),
  CONSTRAINT `fk_categoria_livro` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `livro_autor` (
  `id_livro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `fk_livro_autor(autor)` (`id_autor`),
  CONSTRAINT `fk_livro_autor(autor)` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`idautor`),
  CONSTRAINT `fk_livro_autor(livro)` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`idlivro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_livro` int NOT NULL,
  `data_reserva` date NOT NULL,
  `posicao_fila` int NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_usuario_reserva` (`id_usuario`),
  KEY `fk_livro_reserva` (`id_livro`),
  CONSTRAINT `fk_livro_reserva` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`idlivro`),
  CONSTRAINT `fk_usuario_reserva` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `nome_usuario` varchar(45) NOT NULL,
  `tipo_usuario` varchar(45) NOT NULL,
  `email_usuario` varchar(45) NOT NULL,
  `telefone_usuario` int NOT NULL,
  `data_cadastro` date NOT NULL,
  `endereco_usuario` varchar(255) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- VIEWS
CREATE VIEW `vw_usuarios_em_atrasos` AS (
	SELECT 
	`livro`.`titulo`,
	`emprestimo`.`idusuario`, `emprestimo`.`data_emprestimo`, `emprestimo`.`data_devolucao`,`emprestimo`.`status`,
	`usuario`.`nome_usuario`, `usuario`.`email_usuario`, `usuario`.`telefone_usuario`, (`emprestimo`.`data_devolucao` - `emprestimo`.`data_emprestimo`) AS "dias_emprestimo"
	FROM 
	`bd_19102024`.`livro`, `bd_19102024`.`usuario`, `bd_19102024`.`emprestimo`
	WHERE(
	`emprestimo`.`idusuario` = `usuario`.`idusuario` AND
	`emprestimo`.`idlivro` = `livro`.`idlivro` AND
	(CAST(sysdate() AS DATE) - `emprestimo`.`data_emprestimo`) > 5 AND 
	sysdate() > `emprestimo`.`data_devolucao` AND
	`emprestimo`.`status` = "emprestado"
	)
);

CREATE VIEW `vw_quantidade_livros_emprestados` AS(
	SELECT 
	`livro`.`titulo`, `categoria`.`nome` AS "categoria", COUNT(*) AS "quantidade_emprestimos"
	FROM 
	`bd_19102024`.`emprestimo`, `bd_19102024`.`livro`, `bd_19102024`.`categoria`
	WHERE(
	`emprestimo`.`idlivro` = `livro`.`idlivro` AND
	`livro`.`idcategoria` = `categoria`.`idcategoria`
	)
	GROUP BY 
	`livro`.`titulo`, `categoria`.`nome`
	ORDER BY COUNT(*) DESC
);

-- SELECTS
SELECT * FROM `bd_19102024`.`autor`;
SELECT * FROM `bd_19102024`.`categoria`;
SELECT * FROM `bd_19102024`.`emprestimo`;
SELECT * FROM `bd_19102024`.`livro`;
SELECT * FROM `bd_19102024`.`reserva`;
SELECT * FROM `bd_19102024`.`usuario`;
SELECT * FROM `bd_19102024`.`livro_autor`;

SELECT `titulo`, `nome_usuario`, `email_usuario`, `telefone_usuario`, `dias_emprestimo` FROM `bd_19102024`.`vw_usuarios_em_atrasos`;
SELECT * FROM `bd_19102024`.`vw_quantidade_livros_emprestados`;


-- ALTER TABLES
DROP TABLE `bd_19102024`.`produtos`;
DROP TABLE `bd_19102024`.`itensvenda`;
DROP TABLE `bd_19102024`.`devolucao`;
DROP VIEW `bd_19102024`.`vw_usuarios_em_atrasos`;


ALTER TABLE `bd_19102024`.`livro`
	DROP CONSTRAINT `fk_autor_livro`,
    DROP COLUMN `idautor`;
    
ALTER TABLE `bd_19102024`.`autor`
	CHANGE COLUMN `data_nascimento` `data_nascimento` DATE NOT NULL;

ALTER TABLE `bd_19102024`.`emprestimo`
	ADD COLUMN `multa_atraso` DOUBLE NOT NULL;
    
-- UPDATES

-- INSERTS

INSERT INTO `bd_19102024`.`categoria`(
	`idcategoria`,
    `nome`,
    `descricao`
)VALUES
	(1, "PROGRAMAÇÃO", "DESCRIÇÃO"),
    (2, "QUALQUER COISA", "SEI LÁ");
    
INSERT INTO `bd_19102024`.`livro`(
	`idlivro`,
    `titulo`,
    `editora`, 
    `ano_de_publicacao`,
    `numero_edicao`,
    `qntd_exemplares`,
    `qntd_disponivel`,
    `idcategoria`
)
VALUES
(1, "ENGENHARIA DE SOFTWARE", "SENAI", "1900-10-02", 24, 20, 10, 1),
(2, "PROGRAMAÇÃO PYTHON", "EDITORA", "2000-10-02", 2, 30, 29, 1),
(3, "COMO FAZER UMA CHURRASQUEIRA A CONTROLE REMOTO", "ALEATORIO", "1980-10-02", 24, 20, 10, 2);


INSERT INTO `bd_19102024`.`autor`(
	`idautor`,
    `nome`,
    `nacionalidade`,
    `data_nascimento`,
    `biografia`
)VALUES
(1, "Jorge", "Brasileiro", "1895-06-05", "BIOGRAFIA"),
(2, "Marcone", "Brasileiro", "2000-10-08", "QUALQUER SEMELHANÇA É MERA COINCIDÊNCIA"),
(3, "Faustão", "Budapeste", "1800-05-08", "VOCÊ DESTRUIU O MEU OVO");

INSERT INTO `bd_19102024`.`livro_autor`(
	`id_livro`,
    `id_autor`
)VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);

-- pelo amor de deus usa um tipo de nomeclatura para os campos
INSERT INTO `bd_19102024`.`usuario`(
	`idusuario`,
    `nome_usuario`,
    `tipo_usuario`,
    `email_usuario`,
    `telefone_usuario`,
    `data_cadastro`,
    `endereco_usuario`
)VALUES
(1, "Tauã", "DEV", "email@gmail.com", 12556746, "2024-10-19", "BRASIL"),
(2, "Didi", "Leitor", "pao@gmail.com", 40028922, "1875-05-12", "Mansão");

INSERT INTO `bd_19102024`.`emprestimo`(
	`idemprestimo`,
    `idusuario`,
    `idlivro`,
    `data_emprestimo`,
    `data_devolucao`,
    `multa_atraso`,
    `status`
)VALUES
(2, 2, 3, "2024-10-10", "2024-10-20", 540, "emprestado"),
(3, 1, 1, "2024-10-18", "2024-10-23", 540, "emprestado");

INSERT INTO `bd_19102024`.`reserva`(
`id_reserva`,
`id_usuario`,
`id_livro`,
`data_reserva`,
`posicao_fila`
)VALUES
(1, 1, 2, "2024-10-22", 1);

-- DELETES
DELETE FROM `bd_19102024`.`categoria`;
DELETE FROM `bd_19102024`.`autor`;
DELETE FROM `bd_19102024`.`usuario`;
DELETE FROM `bd_19102024`.`emprestimo`;
DELETE FROM `bd_19102024`.`livro`;


COMMIT;

