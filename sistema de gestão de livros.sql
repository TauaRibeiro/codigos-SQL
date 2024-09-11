CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE `autor` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `nacionalidade` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `biografia` varchar(1000) NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `autor_livro` (
  `id_livro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `fk_autor_idx` (`id_autor`),
  CONSTRAINT `fk_autor` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_livro` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `devolucao` (
  `id_devolucao` int NOT NULL AUTO_INCREMENT,
  `data_devolucao` date NOT NULL,
  `valor_multa` double NOT NULL,
  `id_emprestimo` int NOT NULL,
  PRIMARY KEY (`id_devolucao`),
  KEY `fk_emprestimo_devolucao_idx` (`id_emprestimo`),
  CONSTRAINT `fk_emprestimo_devolucao` FOREIGN KEY (`id_emprestimo`) REFERENCES `emprestimo` (`id_emprestimo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `emprestimo` (
  `id_emprestimo` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_livro` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `data_emprestimo` date NOT NULL,
  `data_devolucao` date NOT NULL,
  PRIMARY KEY (`id_emprestimo`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_ususario_idx` (`id_livro`),
  CONSTRAINT `fk_livro_ususario` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuario_livro` FOREIGN KEY (`id_usuario`) REFERENCES `ususario` (`id_ususario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `livro` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `id_autor` int NOT NULL,
  `id_categoria` int NOT NULL,
  `editora` varchar(150) NOT NULL,
  `ano_publicacao` date NOT NULL,
  `numero_edicao` int NOT NULL,
  `quantidade_total` int NOT NULL,
  `quantidade_disponivel` int NOT NULL,
  PRIMARY KEY (`id_livro`),
  KEY `fk_autor_livro_idx` (`id_autor`),
  KEY `fk_categoria_livro_idx` (`id_categoria`),
  CONSTRAINT `fk_autor_livro` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_categoria_livro` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_livro` int NOT NULL,
  `data_reserva` date NOT NULL,
  `posicao_fila` int NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_usuario_livro_idx` (`id_usuario`),
  KEY `fk_livro_reserva_idx` (`id_livro`),
  CONSTRAINT `fk_livro_reserva` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuario_reserva` FOREIGN KEY (`id_usuario`) REFERENCES `ususario` (`id_ususario`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ususario` (
  `id_ususario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `data_cadastro` date NOT NULL,
  `endereço` varchar(150) NOT NULL,
  PRIMARY KEY (`id_ususario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
