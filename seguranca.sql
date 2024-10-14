CREATE DATABASE db_seguranca_publica;

USE db_seguranca_publica;

CREATE TABLE `estados` (
  `id_estado` int NOT NULL,
  `estados` text,
  `cod_regiao` int DEFAULT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `fk_estado_regiao` (`cod_regiao`),
  CONSTRAINT `fk_estado_regiao` FOREIGN KEY (`cod_regiao`) REFERENCES `regiao` (`id_regiao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `homicidio` (
  `cod` int NOT NULL,
  `periodo` year NOT NULL,
  `valor` bigint DEFAULT NULL,
  PRIMARY KEY (`periodo`,`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `municipio` (
  `id_municipio` int NOT NULL,
  `municipio` text,
  `id_estado` int default NULL,
  PRIMARY KEY (`id_municipio`),
  KEY `fk_municipio_estado` (`id_estado`),
  CONSTRAINT `fk_municipio_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `regiao` (
  `id_regiao` int NOT NULL,
  `nome` text,
  PRIMARY KEY (`id_regiao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- ALTERAÇÕES NAS TABELAS

ALTER TABLE `db_seguranca_publica`.`municipio`
CHANGE COLUMN `id_estado` `id_estado` INT DEFAULT NULL;

ALTER TABLE `db_seguranca_publica`.`estados`
CHANGE COLUMN `id` `id_estado` INT NOT NULL;

ALTER TABLE `db_seguranca_publica`.`regiao`
CHANGE COLUMN `id` `id_regiao` INT NOT NULL;

-- SELECTS
SELECT * FROM `db_seguranca_publica`.`homicidio`;
SELECT * FROM `db_seguranca_publica`.`estados`;
SELECT * FROM `db_seguranca_publica`.`municipio`;
SELECT * FROM `db_seguranca_publica`.`regiao`;

SELECT CAST(SUBSTRING(`id_estado`, 1,1) AS CHAR(1)) FROM `db_seguranca_publica`.`estados`;
SELECT CAST(SUBSTRING(`id_municipio`, 1,2) AS CHAR(2)) FROM `db_seguranca_publica`.`municipio`;
SELECT * FROM `db_seguranca_publica`.`vw_dados_homicidios`;


SELECT `id_regiao`, `nome`, `periodo`, `valor` AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`
WHERE `valor` = (SELECT Max(`valor`) AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`);
SELECT `id_estado`, `estados`, `periodo`, `valor` AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`
WHERE `valor` = (SELECT Max(`valor`) AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`);
SELECT `id_municipio`, `municipio`, `periodo`, `valor` AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`
WHERE `valor` = (SELECT Max(`valor`) AS `maior_valor` FROM `db_seguranca_publica`.`vw_dados_homicidios`);



CREATE VIEW `vw_dados_homicidios` AS
SELECT `regiao`.`id_regiao`, `regiao`.`nome`, 
`estados`.`id_estado`, `estados`.`estados`, 
`municipio`.`id_municipio`, `municipio`.`municipio`,
`homicidio`.`periodo`, `homicidio`.`valor`
FROM `db_seguranca_publica`.`regiao`,
`db_seguranca_publica`.`estados`,
`db_seguranca_publica`.`municipio`,
`db_seguranca_publica`.`homicidio`
WHERE(
`regiao`.`id_regiao` = `estados`.`cod_regiao` AND
`estados`.`id_estado` = `municipio`.`id_estado` AND
`municipio`.`id_municipio` = `homicidio`.`cod`
);

UPDATE `db_seguranca_publica`.`estados`
SET `cod_regiao` = CAST(SUBSTRING(`id_estado`, 1,1) AS CHAR(1));
UPDATE `db_seguranca_publica`.`municipio` 
SET `id_estado` = CAST(SUBSTRING(`id_municipio`, 1,2) AS CHAR(2));


COMMIT;
