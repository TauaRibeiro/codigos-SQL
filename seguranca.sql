CREATE DATABASE db_seguranca_publica;

USE db_seguranca_publica;

CREATE TABLE `homicidios` (
  `cod` int(11) NOT NULL,
  `nome` text NOT NULL,
  `período` year(4) NOT NULL,
  `valor` double NOT NULL,
  PRIMARY KEY (`período`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `municipio` (
  `id` int(11) NOT NULL,
  `municipio` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `regioes` (
  `id` int(11) NOT NULL,
  `regiao` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `unidade_federativa` (
  `id` int(11) NOT NULL,
  `estado` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT * FROM `db_seguranca_publica`.`unidade_federativa`;