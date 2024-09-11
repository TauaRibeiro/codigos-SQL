create database normalizacao;
use normalizacao;

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nome_categoria` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(255) DEFAULT NULL,
  `endereco_cliente` varchar(255) DEFAULT NULL,
  `telefone_cliente` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `itempedido` (
  `id_cliente` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `valor_unitario_produto` decimal(10,2) DEFAULT NULL,
  `quantidade_produto` int(11) DEFAULT NULL,
  `id_pedidos` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`,`id_produto`,`id_pedidos`),
  KEY `fk_produto_itempedido` (`id_produto`),
  KEY `fk_pedidos_itempedido_idx` (`id_pedidos`),
  CONSTRAINT `fk_cliente_itempedido` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `fk_pedidos_itempedido` FOREIGN KEY (`id_pedidos`) REFERENCES `pedidos` (`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_itempedido` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_pedido` date DEFAULT NULL,
  `valor_total_pedido` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_cliente_pedidos` (`id_cliente`),
  CONSTRAINT `fk_cliente_pedidos` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `preco` (
  `dataPreco` date NOT NULL,
  `id_produto` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `statusPreco` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`dataPreco`),
  KEY `fk_produto_preco` (`id_produto`),
  CONSTRAINT `fk_produto_preco` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `quantidade_estoque` int(11) DEFAULT NULL,
  `nome_produto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `fk_categoria_produto` (`id_categoria`),
  CONSTRAINT `fk_categoria_produto` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

