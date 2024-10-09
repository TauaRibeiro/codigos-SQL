CREATE DATABASE db_seguranca_publica;

USE db_seguranca_publica;


CREATE TABLE `estados`(
`id_estado` VARCHAR(2) NOT NULL,
`id_regiao` INT,
`nome_estado` VARCHAR(50) NOT NULL,
PRIMARY KEY (`id_estado`)
);


CREATE TABLE `municipio`(
`id_municipio` INT NOT NULL,
`id_estado` VARCHAR(2),
`nome_municipio` VARCHAR(100) NOT NULL,
PRIMARY KEY (`id_municipio`)
); 


CREATE TABLE `regiao`(
`id_regiao` INT NOT NULL,
`nome_regiao` VARCHAR(50) NOT NULL,
PRIMARY KEY (`id_regiao`)
);


CREATE TABLE `homicidio`(
`cod` INT NOT NULL,
`periodo` YEAR NOT NULL,
`valor` INT NOT NULL,
`id_municipio` INT NOT NULL,
PRIMARY KEY (`cod`, `periodo`)
);
  
DROP TABLE `db_seguranca_publica`.`homicidio`, `db_seguranca_publica`.`municipio`, `db_seguranca_publica`.`estados`, `db_seguranca_publica`.`regiao`;
