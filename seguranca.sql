CREATE DATABASE db_seguranca_publica;

USE db_seguranca_publica;

CREATE TABLE `homicidio` (
  `cod` int(11) DEFAULT NULL,
  `nome` text DEFAULT NULL,
  `periodo` datetime DEFAULT NULL,
  `valor` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `municipio` (
  `id` int(11) DEFAULT NULL,
  `municipio` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `estados` (
  `id` int(11) NOT NULL,
  `estados` text DEFAULT NULL,
  `cod_regiao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estado_regiao` (`cod_regiao`),
  CONSTRAINT `fk_estado_regiao` FOREIGN KEY (`cod_regiao`) REFERENCES `regiao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `regiao` (
  `id` int(11) NOT NULL,
  `nome` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



SELECT * FROM `db_seguranca_publica`.`homicidio`;
SELECT * FROM `db_seguranca_publica`.`estados`;
SELECT * FROM `db_seguranca_publica`.`municipio`;
SELECT * FROM `db_seguranca_publica`.`regiao`;

SELECT * FROM `db_seguranca_publica`.`homicidio` WHERE `periodo` >= 1900;
SELECT * FROM `db_seguranca_publica`.`estados` WHERE `id_estado` = 11;
SELECT * FROM `db_seguranca_publica`.`municipio` WHERE `id_municipio` % 2 = 0;
SELECT * FROM `db_seguranca_publica`.`regiao` WHERE `id_regiao` = 1;

DELETE FROM `db_seguranca_publica`.`estados`
WHERE `id_estado` = 11;
DELETE FROM `db_seguranca_publica`.`homicidio`
WHERE `periodo` >= 1900;
DELETE FROM `db_seguranca_publica`.`municipio`
WHERE `id_municipio` % 2 = 0;
DELETE FROM `db_seguranca_publica`.`regiao`
WHERE `id_regiao` = 1;

DELETE FROM `db_seguranca_publica`.`estados`;
DELETE FROM `db_seguranca_publica`.`homicidio`;
DELETE FROM `db_seguranca_publica`.`municipio`;
DELETE FROM `db_seguranca_publica`.`regiao`;
