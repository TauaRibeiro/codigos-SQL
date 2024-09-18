CREATE DATABASE gestao_projetos;

USE gestao_projetos;

CREATE TABLE `cliente` (
  `numero_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(150) NOT NULL,
  PRIMARY KEY (`numero_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `funcionario` (
  `matricula_funcionario` int(11) NOT NULL,
  `nome_funcionario` varchar(150) NOT NULL,
  PRIMARY KEY (`matricula_funcionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `funcionario_tarefa` (
  `matricula_funcionario` int(11) NOT NULL,
  `id_tarefa` int(11) NOT NULL,
  PRIMARY KEY (`matricula_funcionario`,`id_tarefa`),
  KEY `fk_tarefa_funcionario_tarefa` (`id_tarefa`),
  CONSTRAINT `fk_funcionario_funcionario_tarefa` FOREIGN KEY (`matricula_funcionario`) REFERENCES `funcionario` (`matricula_funcionario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tarefa_funcionario_tarefa` FOREIGN KEY (`id_tarefa`) REFERENCES `tarefa` (`id_tarefa`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `projeto` (
  `numero_projeto` int(11) NOT NULL AUTO_INCREMENT,
  `descricao_projeto` varchar(500) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  PRIMARY KEY (`numero_projeto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `projeto_cliente` (
  `numero_projeto` int(11) NOT NULL,
  `numero_cliente` int(11) NOT NULL,
  PRIMARY KEY (`numero_projeto`,`numero_cliente`),
  KEY `fk_cliente_projeto_cliente` (`numero_cliente`),
  CONSTRAINT `fk_cliente_projeto_cliente` FOREIGN KEY (`numero_cliente`) REFERENCES `cliente` (`numero_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_projeto_projeto_cliente` FOREIGN KEY (`numero_projeto`) REFERENCES `projeto` (`numero_projeto`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tarefa` (
  `id_tarefa` int(11) NOT NULL AUTO_INCREMENT,
  `numero_tarefa` int(11) NOT NULL,
  `numero_projeto` int(11) NOT NULL,
  `descricao_tarefa` varchar(500) NOT NULL,
  `data_inicio_tarefa` date NOT NULL,
  `data_fim_tarefa` date NOT NULL,
  `percentual_execucao_tarefa` double NOT NULL,
  PRIMARY KEY (`id_tarefa`),
  KEY `fk_projeto_tarefa` (`numero_projeto`),
  CONSTRAINT `fk_projeto_tarefa` FOREIGN KEY (`numero_projeto`) REFERENCES `projeto` (`numero_projeto`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
