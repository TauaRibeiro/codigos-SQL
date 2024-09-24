CREATE DATABASE ordens_de_servicos;

USE ordens_de_servicos;

CREATE TABLE `cliente` (
  `cod_cliente` int(11) NOT NULL,
  `cnpj_cliente` varchar(14) NOT NULL,
  `nome_cliente` varchar(50) NOT NULL,
  `endereço_cliente` varchar(150) NOT NULL,
  `telefone_cliente` varchar(9) NOT NULL,
  PRIMARY KEY (`cod_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `especialidade` (
  `cod_especialidade_mao_obra` int(11) NOT NULL,
  `desc_especialidade_mao_obra` varchar(300) NOT NULL,
  `vlr_hora_mao_obra` double NOT NULL,
  PRIMARY KEY (`cod_especialidade_mao_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `item` (
  `cod_item_material` int(11) NOT NULL,
  `descricao_item_material` varchar(300) NOT NULL,
  `quant_item_material` int(11) NOT NULL,
  `vlr_unitario_item_material` double NOT NULL,
  `vlr_total_item_material` double NOT NULL,
  PRIMARY KEY (`cod_item_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `item-servico` (
  `codigo_item_servico` int(11) NOT NULL,
  `descricao_item_servico` varchar(300) NOT NULL,
  `numero_ordem_servico` int(11) NOT NULL,
  `cod_item_material` int(11) NOT NULL,
  `valor_total_item_ordem_servico` double NOT NULL,
  PRIMARY KEY (`codigo_item_servico`),
  KEY `fk_item_servico` (`cod_item_material`),
  KEY `fk_ordem_servico_item_servico` (`numero_ordem_servico`),
  CONSTRAINT `fk_item_servico` FOREIGN KEY (`cod_item_material`) REFERENCES `item` (`cod_item_material`),
  CONSTRAINT `fk_ordem_servico_item_servico` FOREIGN KEY (`numero_ordem_servico`) REFERENCES `ordem_de_servico` (`numero_ordem_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `mao-item` (
  `matricula_mao_obra` int(11) NOT NULL,
  `cod_item_material` int(11) NOT NULL,
  `vlr_total_mao_obra_item` double NOT NULL,
  KEY `fk_mao_mao_item` (`matricula_mao_obra`),
  KEY `fk_item_mao_item` (`cod_item_material`),
  CONSTRAINT `fk_item_mao_item` FOREIGN KEY (`cod_item_material`) REFERENCES `item` (`cod_item_material`),
  CONSTRAINT `fk_mao_mao_item` FOREIGN KEY (`matricula_mao_obra`) REFERENCES `mao_de_obra` (`matricula_mao_obra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `mao_de_obra` (
  `matricula_mao_obra` int(11) NOT NULL,
  `nome_mao_obra` varchar(50) NOT NULL,
  `qtd_horas_mao_obra` double NOT NULL,
  `cod_especialidade_mao_obra` int(11) NOT NULL,
  PRIMARY KEY (`matricula_mao_obra`),
  KEY `fk_especialidade_mao` (`cod_especialidade_mao_obra`),
  CONSTRAINT `fk_especialidade_mao` FOREIGN KEY (`cod_especialidade_mao_obra`) REFERENCES `especialidade` (`cod_especialidade_mao_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ordem_de_servico` (
  `numero_ordem_servico` int(11) NOT NULL,
  `cod_cliente` int(11) NOT NULL,
  `descricao_ordem_servico` varchar(300) NOT NULL,
  `data_abertura_ordem_servico` date NOT NULL,
  `data_termino_ordem_servico` date DEFAULT NULL,
  PRIMARY KEY (`numero_ordem_servico`),
  KEY `fk_cliente_ordem_servico` (`cod_cliente`),
  CONSTRAINT `fk_cliente_ordem_servico` FOREIGN KEY (`cod_cliente`) REFERENCES `cliente` (`cod_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
