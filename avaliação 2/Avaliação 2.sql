CREATE DATABASE bd_avaliacao2;

USE bd_avaliacao2;

-- creates

CREATE TABLE `clientes`(
	`id_cliente` INT NOT NULL,
    `nome_cliente` VARCHAR(100) NOT NULL,
    `email_cliente` VARCHAR(50) NOT NULL,
    `endereco_cliente` VARCHAR(300) NOT NULL,
    PRIMARY KEY(`id_cliente`)
);

CREATE TABLE `produtos`(
	`id_produto` INT NOT NULL,
    `nome_produto` VARCHAR(100) NOT NULL,
    `preco_produto` DOUBLE NOT NULL,
    `estoque_produto` INT NOT NULL,
    PRIMARY KEY(`id_produto`)
);

CREATE TABLE `pedidos`(
	`id_pedido` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    `data_pedido` DATE NOT NULL,
    `valor_total` DOUBLE NOT NULL,
    PRIMARY KEY(`id_pedido`),
    CONSTRAINT `fk_clientes_pedidos` FOREIGN KEY(`id_cliente`) REFERENCES `bd_avaliacao2`.`clientes` (`id_cliente`)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
);

CREATE TABLE `itens_pedidos`(
	`id_item` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    `id_pedido` INT NOT NULL,
    `id_produto` INT NOT NULL,
    `quantidade` INT NOT NULL,
    PRIMARY KEY(`id_item`),
    CONSTRAINT `fk_clientes_itens-pedidos` FOREIGN KEY(`id_cliente`) REFERENCES `bd_avaliacao2`.`clientes`(`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    CONSTRAINT `fk_pedidos_itens-pedidos` FOREIGN KEY(`id_pedido`) REFERENCES `bd_avaliacao2`.`pedidos`(`id_pedido`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    CONSTRAINT `fk_produto_itens-pedidos` FOREIGN KEY(`id_produto`) REFERENCES `bd_avaliacao2`.`produtos`(`id_produto`)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
);

CREATE TABLE `trasportadoras`(
	`id_transportadora` INT NOT NULL,
    `nome_transportadora` VARCHAR(100) NOT NULL,
    `telefone_trasnportadora` VARCHAR(20) NOT NULL,
    PRIMARY KEY(`id_transportadora`)
);

CREATE TABLE `entregas`(
	`id_entrega` INT NOT NULL,
    `id_transportadora` INT NOT NULL,
    `data_entrega` DATE NOT NULL,
    `status_entrega` VARCHAR(50) NOT NULL,
    PRIMARY KEY(`id_entrega`),
    CONSTRAINT `fk_entregas_transportadoras` FOREIGN KEY(`id_transportadora`) REFERENCES `bd_avaliacao2`.`trasportadoras`(`id_transportadora`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

-- SELECTS
SELECT 
`clientes`.`nome_cliente` as "nome", `clientes`.`email_cliente` as "email", `clientes`.`endereco_cliente` as "endereco",
`produtos`.`nome_produto` as "produto", `produtos`.`preco_produto` as "preco unitário",
`itens_pedidos`.`quantidade` as "quantidade pedida", 
`pedidos`.`valor_total` as "total", `pedidos`.`data_pedido` as "data do pedido",
`entregas`.`data_entrega` as "data da entrega", `entregas`.`status_entrega` as "status da entrega"
FROM `bd_avaliacao2`.`clientes`, `bd_avaliacao2`.`produtos`, `bd_avaliacao2`.`itens_pedidos`, `bd_avaliacao2`.`pedidos`, `bd_avaliacao2`.`entregas`
WHERE(
`itens_pedidos`.`id_cliente` = `clientes`.`id_cliente` AND
`itens_pedidos`.`id_pedido` = `pedidos`.`id_pedido` AND
`itens_pedidos`.`id_produto` = `produtos`.`id_produto` AND
`itens_pedidos`.`id_pedido` = `entregas`.`id_pedido`
);

SELECT * FROM `bd_avaliacao2`.`vw_dados_pedidos`;

SELECT CONCAT(`id_cliente`, "-", `nome_cliente`) FROM `bd_avaliacao2`.`clientes`;
SELECT LENGTH(`nome_cliente`) FROM `bd_avaliacao2`.`clientes`;
SELECT UPPER(`nome_cliente`) FROM `bd_avaliacao2`.`clientes`;
SELECT LOWER(`nome_cliente`) FROM `bd_avaliacao2`.`clientes`;
SELECT SUBSTRING(`nome_cliente`, 1, 3) FROM `bd_avaliacao2`.`clientes`;
SELECT TRIM("         OI             ");
 
SELECT ABS(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT ROUND(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT CEIL(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT FLOOR(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT MOD(`preco_produto`, 2) FROM `bd_avaliacao2`.`produtos`;
SELECT RAND();

SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT DATE_FORMAT(NOW(), "%d/%m/%y");
SELECT DATEDIFF(NOW(), '2024-05-03');
SELECT TIMESTAMPDIFF(MONTH, NOW(), '2024-05-03');

SELECT COUNT(*) FROM `bd_avaliacao2`.`clientes`;
SELECT SUM(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT AVG(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT MAX(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;
SELECT MIN(`preco_produto`) FROM `bd_avaliacao2`.`produtos`;

SELECT IF(MOD(`preco_produto`, 2) = 0, "DIVISÍVEL", "NÃO DIVISÍVEL") FROM `bd_avaliacao2`.`produtos`;

SELECT 
CASE
WHEN `preco_produto` > 102 THEN "A"
WHEN MOD(`preco_produto`, 2) = 0 THEN "B"
ELSE "C"
END FROM `bd_avaliacao2`.`produtos`;

SELECT COALESCE(`endereco_cliente`, "Sem endereco") FROM `bd_avaliacao2`.`clientes`;



-- VIEWS
CREATE VIEW `vw_dados_pedidos` AS(
	SELECT 
	`clientes`.`nome_cliente` as "nome", `clientes`.`email_cliente` as "email", `clientes`.`endereco_cliente` as "endereco",
	`produtos`.`nome_produto` as "produto", `produtos`.`preco_produto` as "preco unitário",
	`itens_pedidos`.`quantidade` as "quantidade pedida", 
	`pedidos`.`valor_total` as "total", `pedidos`.`data_pedido` as "data do pedido",
	`entregas`.`data_entrega` as "data da entrega", `entregas`.`status_entrega` as "status da entrega"
	FROM `bd_avaliacao2`.`clientes`, `bd_avaliacao2`.`produtos`, `bd_avaliacao2`.`itens_pedidos`, `bd_avaliacao2`.`pedidos`, `bd_avaliacao2`.`entregas`
	WHERE(
	`itens_pedidos`.`id_cliente` = `clientes`.`id_cliente` AND
	`itens_pedidos`.`id_pedido` = `pedidos`.`id_pedido` AND
	`itens_pedidos`.`id_produto` = `produtos`.`id_produto` AND
	`itens_pedidos`.`id_pedido` = `entregas`.`id_pedido`
	)
);


-- alters

ALTER TABLE `bd_avaliacao2`.`entregas`
	ADD COLUMN `id_pedido` INT NOT NULL,
    ADD CONSTRAINT `fk_entregas_pedidos` FOREIGN KEY(`id_pedido`) REFERENCES `bd_avaliacao2`.`pedidos`(`id_pedido`)

    ON DELETE RESTRICT
    ON UPDATE RESTRICT;


-- DELETE
DELETE FROM `bd_avaliacao2`.`clientes`;
DELETE FROM `bd_avaliacao2`.`produtos`;
DELETE FROM `bd_avaliacao2`.`pedidos`;
DELETE FROM `bd_avaliacao2`.`itens_pedidos`;
DELETE FROM `bd_avaliacao2`.`trasportadoras`;
DELETE FROM `bd_avaliacao2`.`entregas`;