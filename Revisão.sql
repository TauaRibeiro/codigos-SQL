CREATE DATABASE db_21112024;
USE db_21112024;

/*
	TABELAS
*/
CREATE TABLE `autor`(
	`id_autor` INT AUTO_INCREMENT PRIMARY KEY,
    `nome_autor` VARCHAR(150) NOT NULL
);

CREATE TABLE `genero`(
	`id_genero` INT AUTO_INCREMENT PRIMARY KEY,
    `nome_genero` VARCHAR(150) NOT NULL
);

CREATE TABLE `livro`(
	`id_livro` INT AUTO_INCREMENT PRIMARY KEY,
    `titulo_livro` VARCHAR(150) NOT NULL,
    `id_genero` INT NOT NULL,
    
	CONSTRAINT `fk_genero_livro` FOREIGN KEY(`id_genero`) REFERENCES `genero`(`id_genero`)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE `livro_autor`(
	`id_livro` INT NOT NULL,
    `id_autor` INT NOT NULL,
    
    PRIMARY KEY(`id_livro`, `id_autor`),
    CONSTRAINT `fk_livro_livroAutor` FOREIGN KEY(`id_livro`) REFERENCES `livro`(`id_livro`)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT `fk_autor_livroAutor` FOREIGN KEY(`id_autor`) REFERENCES `autor`(`id_autor`)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE `usuario`(
	`id_usuario` INT AUTO_INCREMENT PRIMARY KEY,
    `nome_usuario` VARCHAR(150) NOT NULL,
    `data_de_adesao` DATE NOT NULL
);

CREATE TABLE `emprestimo`(
	`id_emprestimo` INT AUTO_INCREMENT PRIMARY KEY,
    `id_usuario` INT NOT NULL,
    `id_livro` INT NOT NULL,
    `data_emprestimo` DATE NOT NULL,
    `data_devolucao` DATE DEFAULT NULL,
    
    CONSTRAINT `fk_usuario_emprestimo` FOREIGN KEY(`id_usuario`) REFERENCES `usuario`(`id_usuario`)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT `fk_livro_emprestimo` FOREIGN KEY(`id_livro`) REFERENCES `livro`(`id_livro`)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

/*
	INSERTS
*/

INSERT INTO `autor`(`nome_autor`)
VALUES
("Autor 1"),
("Autor 2"),
("Autor 3"),
("Autor 4");

INSERT INTO `genero`(`nome_genero`)
VALUES
("Genero 1"),
("Genero 2"),
("Genero 3"),
("Genero 4");

INSERT INTO `usuario`(`nome_usuario`, `data_de_adesao`)
VALUES
("Usuario 1", "2024-03-23"),
("Usuario 2", "2024-03-21"),
("Usuario 3", "2024-05-10"),
("Usuario 4", "2024-06-06");

INSERT INTO `livro`(`titulo_livro`, `id_genero`)
VALUES
("Livro 1", 1),
("Livro 2", 2),
("Livro 3", 3),
("Livro 4", 4);

INSERT INTO `livro_autor`(`id_livro`, `id_autor`)
VALUES
(1,1),
(2,2),
(2,3),
(3,4),
(4,1),
(4,2),
(4,3);

INSERT INTO `emprestimo`(`id_usuario`, `id_livro`, `data_emprestimo`)
VALUES
(1, 1, "2024-10-30"),
(1, 2, "2024-08-10"),
(3, 4, "2024-07-15"),
(3, 2, "2024-07-21");

/*
	VIEWS
*/

CREATE VIEW `vw_numero_emprestimos` AS(
	SELECT 
		`usuario`.`nome_usuario`, COUNT(`emprestimo`.`id_usuario`) AS "Número de empréstimos"
	FROM
		`db_21112024`.`usuario`, `db_21112024`.`emprestimo`
	WHERE
		`usuario`.`id_usuario` = `emprestimo`.`id_usuario`
	GROUP BY(`nome_usuario`)
);

CREATE VIEW `vw_dados_emprestimos` AS(
	SELECT 
		`usuario`.`nome_usuario` AS "USUARIO", `livro`.`titulo_livro` AS "LIVRO", 
		`emprestimo`.`data_emprestimo` AS "DATA EMPRESTIMO", 
		COALESCE(`emprestimo`.`data_devolucao`, "Não devolvido") AS "DATA DEVOLUÇÃO"
	FROM 
		`db_21112024`.`emprestimo`, `db_21112024`.`usuario`, `db_21112024`.`livro`
	WHERE
		`usuario`.`id_usuario` = `emprestimo`.`id_usuario` AND
		`livro`.`id_livro` = `emprestimo`.`id_livro`
);

CREATE VIEW `vw_status_devolucao` AS (
	SELECT 
		`usuario`.`nome_usuario` AS "USUARIO", `livro`.`titulo_livro` AS "LIVRO", IF(`emprestimo`.`data_devolucao` IS NULL, "Não devolvido", "Devovlvido") AS "STATUS"
	FROM
		`db_21112024`.`usuario`
	JOIN
		`db_21112024`.`emprestimo`
	ON 
		`usuario`.`id_usuario` = `emprestimo`.`id_usuario`
	JOIN
		`db_21112024`.`livro`
	ON
		`livro`.`id_livro` = `emprestimo`.`id_livro`
);

/*
	FUNÇÕES
*/
DELIMITER //
CREATE FUNCTION quantidade_emprestimos_pendentes(`id_usuario` INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE `resultado` INT;
    
    SELECT COUNT(*) 
    INTO `resultado`
    FROM `db_21112024`.`usuario`, `db_21112024`.`emprestimo` 
    WHERE(
		`id_usuario` = `emprestimo`.`id_usuario` AND
        `emprestimo`.`data_devolucao` IS NULL AND
        `id_usuario` = `usuario`.`id_usuario`);
	
    RETURN `resultado`;
END//
DELIMITER ;

/*
	SELECTS
*/

SELECT * FROM `emprestimo`;

SELECT * FROM `vw_dados_emprestimos`;
SELECT * FROM `vw_numero_emprestimos`;
SELECT * FROM `vw_status_devolucao`;

SELECT `nome_usuario`, quantidade_emprestimos_pendentes(`id_usuario`) AS "QUANTIDADE PENDENTE" FROM `db_21112024`.`usuario`;
/*
	ALTERS
*/

ALTER TABLE `livro`
	DROP COLUMN `id_autor`,
	DROP CONSTRAINT `fk_autor_livro`;

/*
	UPDATE
*/

UPDATE `emprestimo`
	SET
		`id_usuario` = 2
	WHERE(`id_emprestimo` = 3);
    
    
DROP FUNCTION quantidade_emprestimos_pendentes;
COMMIT;