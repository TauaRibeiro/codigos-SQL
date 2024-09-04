create database pedidos;

use pedidos;

CREATE TABLE `cliente` (
  `nome_cliente` varchar(255) NOT NULL,
  `endereco_cliente` varchar(255) DEFAULT NULL,
  `telefone_cliente` varchar(20) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nome_categoria` varchar(255) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `detalhe_pedido` (
  `id_pedido` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  PRIMARY KEY (`id_pedido`,`data_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `pedido` (
  `id_produto` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  `quantidade_produto` int(11) NOT NULL,
  `valor_total_pedido` decimal(10,2) NOT NULL,
  `id_cliente` varchar(45) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_produto`,`id_cliente`,`data_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL AUTO_INCREMENT,
  `nome_produto` varchar(255) NOT NULL,
  `categoria_produto` varchar(255) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_produto`,`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `preco_produto` (
  `id_produto` int(11) NOT NULL,
  `data_atual` date NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_produto`,`data_atual`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
