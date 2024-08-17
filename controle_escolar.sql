USE controle_escolar;

CREATE TABLE `aluno` (
  `matricula` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `tipo_logradouro` varchar(10) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  PRIMARY KEY (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `controle_escolar`.`aluno`
(`matricula`,
`nome`,
`data_nascimento`,
`tipo_logradouro`,
`endereco`)
VALUES
(<{matricula: }>,
<{nome: }>,
<{data_nascimento: }>,
<{tipo_logradouro: }>,
<{endereco: }>);

