CREATE DATABASE db_seguranca_publica;

USE db_seguranca_publica;

CREATE TABLE `estados`(
`id_estado` INT NOT NULL,
`nome_estado` VARCHAR(50) NOT NULL,
PRIMARY KEY (`id_estado`),
CONSTRAINT `fk_estado_regiao` FOREIGN KEY (`id_regiao`) REFERENCES `db_seguranca_publica`.`regiao` (`id_regiao`) 
ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE `municipio`(
`id_municipio` INT NOT NULL,
`id_estado` INT NOT NULL,
`nome_municipio` VARCHAR(100) NOT NULL,
PRIMARY KEY (`id_municipio`),
CONSTRAINT `fk_municipio_estado` FOREIGN KEY (`id_estado`) REFERENCES `db_seguranca_publica`.`estados` (`id_estado`)
ON DELETE RESTRICT
ON UPDATE RESTRICT
); 

CREATE TABLE `regiao`(
`id_regiao` INT NOT NULL,
`nome_regiao` VARCHAR(50) NOT NULL,
PRIMARY KEY (`id_regiao`)
);

CREATE TABLE `homicidio`(
`cod` INT NOT NULL,
`nome` VARCHAR(200) NOT NULL,
`periodo` YEAR NOT NULL,
`valor` INT NOT NULL,
`id_municipio` INT NOT NULL,
PRIMARY KEY (`cod`, `periodo`),
CONSTRAINT `fk_homicidio_municipio` FOREIGN KEY (`id_municipio`) REFERENCES `db_seguranca_publica`.`municipio` (`id_municipio`)
ON DELETE RESTRICT
ON UPDATE RESTRICT
);

SELECT * FROM `db_seguranca_publica`.`estados`;

ALTER TABLE `db_seguranca_publica`.`estados`
ADD COLUMN `id_regiao` INT NOT NULL AFTER `nome_estado`, 
ADD CONSTRAINT `fk_estado_regiao`
  FOREIGN KEY (`id_regiao`)
  REFERENCES `db_seguranca_publica`.`regiao` (`id_regiao`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;