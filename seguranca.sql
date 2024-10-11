SELECT * FROM `db_seguranca_publica`.`municipio`;
SELECT * FROM `db_seguranca_publica`.`regiao`;

ALTER TABLE db_seguranca_publica.municipio
CHANGE COLUMN `id` `id` INT NOT NULL,
ADD PRIMARY KEY(`id`),
ADD COLUMN `id_estado` INT DEFAULT NULL,
ADD CONSTRAINT `fk_municipio_estado` FOREIGN KEY(`id_estado`) REFERENCES `db_seguranca_publica`.`estados` (`id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT;

ALTER TABLE `db_seguranca_publica`.`homicidio`
DROP PRIMARY KEY,
ADD PRIMARY KEY(`cod`, `periodo`);

DELETE FROM `db_seguranca_publica`.`estados` WHERE `id` = 0;

CREATE VIEW `vw_municipio_por_estado_por_regiao` as (
SELECT `regiao`.`id_regiao`, `regiao`.`regiao`, `estados`.`id_estado`, `estados`.`estados`, `municipio`.`id_municipio`, `municipio`.`municipio`
FROM `db_seguranca_publica`.`regiao`, `db_seguranca_publica`.`estados`, `db_seguranca_publica`.`municipio`
WHERE
`regiao`.`id_regiao` = `estados`.`cod_regiao` AND `estados`.`id_estado` = `municipio`.`id_estado`
);

SELECT * FROM `vw_municipio_por_estado_por_regiao`;

SELECT CAST(`id` AS CHAR(2)) `id_regiao` FROM `db_seguranca_publica`.`estados`;
SELECT SUBSTRING(CAST(`id` AS CHAR(2)), 1,1) `id_regiao` FROM `db_seguranca_publica`.`estados`;

SELECT CAST(`id` AS CHAR(7)) `id_municipio` FROM `db_seguranca_publica`.`municipio`;
SELECT SUBSTRING(CAST(`id` AS CHAR(7)), 1,2) `id_estado` FROM `db_seguranca_publica`.`municipio`;

UPDATE `db_seguranca_publica`.`municipio`
SET
`id_estado` = SUBSTRING(CAST(`id` AS CHAR(7)), 1,2);

UPDATE `db_seguranca_publica`.`estados`
SET
`cod_regiao` = SUBSTRING(CAST(`id` AS CHAR(2)), 1,1);

COMMIT;
