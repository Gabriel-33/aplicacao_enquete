-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 10-Ago-2022 às 21:55
-- Versão do servidor: 5.7.31
-- versão do PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `signo`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `enquete`
--

DROP TABLE IF EXISTS `enquete`;
CREATE TABLE IF NOT EXISTS `enquete` (
  `id_enquete` int(11) NOT NULL AUTO_INCREMENT,
  `titulo_enquete` varchar(60) DEFAULT NULL,
  `data_inicial` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `horario_inicial` time DEFAULT NULL,
  `horario_final` time DEFAULT NULL,
  PRIMARY KEY (`id_enquete`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `enquete`
--

INSERT INTO `enquete` (`id_enquete`, `titulo_enquete`, `data_inicial`, `data_final`, `horario_inicial`, `horario_final`) VALUES
(157, 'eleições 2022', '2022-08-03', '2022-08-05', '19:42:00', '19:42:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `perguntas_enquete`
--

DROP TABLE IF EXISTS `perguntas_enquete`;
CREATE TABLE IF NOT EXISTS `perguntas_enquete` (
  `id_pergunta_enquete` int(11) NOT NULL AUTO_INCREMENT,
  `fk_enquete` int(11) DEFAULT NULL,
  `pergunta` varchar(60) DEFAULT NULL,
  `tipo_pergunta` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_pergunta_enquete`),
  KEY `fk_enquete` (`fk_enquete`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `perguntas_enquete`
--

INSERT INTO `perguntas_enquete` (`id_pergunta_enquete`, `fk_enquete`, `pergunta`, `tipo_pergunta`) VALUES
(156, 157, 'seu nome', 1),
(157, 157, 'Bolsonaro', 2),
(158, 157, 'Lula', 2),
(159, 157, 'Ciro', 2),
(160, 157, 'Sua idade', 3);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `perguntas_enquete`
--
ALTER TABLE `perguntas_enquete`
  ADD CONSTRAINT `perguntas_enquete_ibfk_1` FOREIGN KEY (`fk_enquete`) REFERENCES `enquete` (`id_enquete`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
