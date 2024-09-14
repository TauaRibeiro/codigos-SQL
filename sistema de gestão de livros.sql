CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE `autor` (
  `id_autor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `nacionalidade` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `biografia` varchar(1000) NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `autor_livro` (
  `id_livro` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `fk_autor_idx` (`id_autor`),
  CONSTRAINT `fk_autor` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`),
  CONSTRAINT `fk_livro` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `devolucao` (
  `id_devolucao` int(11) NOT NULL AUTO_INCREMENT,
  `data_devolucao` date NOT NULL,
  `valor_multa` double NOT NULL,
  PRIMARY KEY (`id_devolucao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `emprestimo` (
  `id_emprestimo` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_livro` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `id_devolucao` int(11) NOT NULL,
  PRIMARY KEY (`id_emprestimo`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_ususario_idx` (`id_livro`),
  KEY `fk_devolucao_livro` (`id_devolucao`),
  CONSTRAINT `fk_devolucao_livro` FOREIGN KEY (`id_devolucao`) REFERENCES `devolucao` (`id_devolucao`),
  CONSTRAINT `fk_livro_ususario` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`),
  CONSTRAINT `fk_usuario_livro` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `livro` (
  `id_livro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `id_autor` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `editora` varchar(150) NOT NULL,
  `ano_publicacao` date NOT NULL,
  `numero_edicao` int(11) NOT NULL,
  `quantidade_total` int(11) NOT NULL,
  `quantidade_disponivel` int(11) NOT NULL,
  PRIMARY KEY (`id_livro`),
  KEY `fk_autor_livro_idx` (`id_autor`),
  KEY `fk_categoria_livro_idx` (`id_categoria`),
  CONSTRAINT `fk_autor_livro` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`),
  CONSTRAINT `fk_categoria_livro` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reserva` (
  `id_reserva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_livro` int(11) NOT NULL,
  `data_reserva` date NOT NULL,
  `posicao_fila` int(11) NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_reserva_idx` (`id_livro`),
  CONSTRAINT `fk_livro_reserva` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`),
  CONSTRAINT `fk_usuario_reserva` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `data_cadastro` date NOT NULL,
  `endereco` varchar(150) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

