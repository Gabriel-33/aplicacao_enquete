-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 29-Ago-2022 às 22:46
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
  `quantidade_votos` int(11) DEFAULT '0',
  PRIMARY KEY (`id_enquete`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `enquete`
--

INSERT INTO `enquete` (`id_enquete`, `titulo_enquete`, `data_inicial`, `data_final`, `horario_inicial`, `horario_final`, `quantidade_votos`) VALUES
(265, 'teste', '2022-08-02', '2022-08-25', '12:12:00', '21:39:00', 4),
(266, 'eleições 2020', '2022-08-16', '2022-08-30', '12:00:00', '23:00:00', 5),
(267, 'p1', '2022-08-04', '2022-08-03', '19:42:00', '19:42:00', 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=709 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `perguntas_enquete`
--

INSERT INTO `perguntas_enquete` (`id_pergunta_enquete`, `fk_enquete`, `pergunta`, `tipo_pergunta`) VALUES
(692, 265, 'p1', 2),
(693, 265, 'p4', 2),
(694, 265, 'p4', 3),
(695, 266, 'p3', 2),
(696, 266, 'p4', 3),
(707, 267, 'p1', 1),
(708, 267, 'p2', 2);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `perguntas_visao`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `perguntas_visao`;
CREATE TABLE IF NOT EXISTS `perguntas_visao` (
`id_enquete` int(11)
,`id_pergunta_enquete` int(11)
,`titulo_enquete` varchar(60)
,`data_inicial` date
,`data_final` date
,`horario_inicial` time
,`horario_final` time
,`pergunta` varchar(60)
,`tipo_pergunta` int(1)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `respostas`
--

DROP TABLE IF EXISTS `respostas`;
CREATE TABLE IF NOT EXISTS `respostas` (
  `id_resposta` int(11) NOT NULL AUTO_INCREMENT,
  `resposta` varchar(45) NOT NULL,
  `fk_enquete` int(11) DEFAULT NULL,
  `fk_pergunta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_resposta`),
  KEY `fk_enquete` (`fk_enquete`),
  KEY `fk_pergunta` (`fk_pergunta`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `respostas`
--

INSERT INTO `respostas` (`id_resposta`, `resposta`, `fk_enquete`, `fk_pergunta`) VALUES
(118, 'Sim', 265, 692),
(119, 'Sim', 265, 693),
(120, '1', 265, 694),
(121, 'Sim', 265, 692),
(122, 'Sim', 265, 693),
(123, '1', 265, 694),
(124, 'Sim', 265, 692),
(125, 'Sim', 265, 693),
(126, '1', 265, 694),
(127, 'Sim', 265, 692),
(128, 'Sim', 265, 693),
(129, '1', 265, 694),
(130, 'Sim', 265, 692),
(131, 'Sim', 265, 693),
(132, '1', 265, 694),
(133, 'Sim', 265, 692),
(134, 'Sim', 265, 693),
(135, '1', 265, 694),
(136, 'Sim', 265, 692),
(137, 'Sim', 265, 693),
(138, '1', 265, 694),
(139, 'Sim', 265, 692),
(140, 'Sim', 265, 693),
(141, '1', 265, 694),
(142, 'Sim', 265, 692),
(143, 'Sim', 265, 693),
(144, '1', 265, 694),
(145, 'Sim', 265, 692),
(146, 'Sim', 265, 693),
(147, '1', 265, 694),
(148, 'Não', 265, 692),
(149, 'Não', 265, 693),
(150, '1', 265, 694),
(151, 'Sim', 265, 692),
(152, 'Sim', 265, 693),
(153, '1', 265, 694),
(154, 'Sim', 265, 692),
(155, 'Sim', 265, 693),
(156, '1', 265, 694),
(157, 'Sim', 265, 692),
(158, 'Sim', 265, 693),
(159, '1', 265, 694),
(160, 'Sim', 266, 695),
(161, '1', 266, 696),
(162, 'Sim', 265, 692),
(163, 'Sim', 265, 693),
(164, '1', 265, 694),
(165, 'Sim', 265, 692),
(166, 'Sim', 265, 693),
(167, '1', 265, 694),
(168, 'Sim', 265, 692),
(169, 'Sim', 265, 693),
(170, '1', 265, 694),
(171, 'Sim', 265, 692),
(172, 'Sim', 265, 693),
(173, '1', 265, 694),
(174, 'Sim', 265, 692),
(175, 'Sim', 265, 693),
(176, '1', 265, 694),
(177, 'Sim', 265, 692),
(178, 'Sim', 265, 693),
(179, '1', 265, 694),
(180, 'Sim', 266, 695),
(181, '1', 266, 696),
(182, 'Sim', 265, 692),
(183, 'Sim', 265, 693),
(184, '1', 265, 694),
(185, 'Sim', 266, 695),
(186, '1', 266, 696),
(187, 'Sim', 265, 692),
(188, 'Sim', 265, 693),
(189, '1', 265, 694),
(190, 'Sim', 265, 692),
(191, 'Sim', 265, 693),
(192, '1', 265, 694),
(193, 'Sim', 266, 695),
(194, '1', 266, 696),
(195, 'Sim', 266, 695),
(196, '1', 266, 696),
(197, 'Não', 266, 695),
(198, '1', 266, 696),
(199, 'Sim', 265, 692),
(200, 'Sim', 265, 693),
(201, '2', 265, 694),
(206, '1', 267, 707),
(207, 'Sim', 267, 708);

-- --------------------------------------------------------

--
-- Estrutura para vista `perguntas_visao`
--
DROP TABLE IF EXISTS `perguntas_visao`;

DROP VIEW IF EXISTS `perguntas_visao`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perguntas_visao`  AS  select `enquete`.`id_enquete` AS `id_enquete`,`perguntas_enquete`.`id_pergunta_enquete` AS `id_pergunta_enquete`,`enquete`.`titulo_enquete` AS `titulo_enquete`,`enquete`.`data_inicial` AS `data_inicial`,`enquete`.`data_final` AS `data_final`,`enquete`.`horario_inicial` AS `horario_inicial`,`enquete`.`horario_final` AS `horario_final`,`perguntas_enquete`.`pergunta` AS `pergunta`,`perguntas_enquete`.`tipo_pergunta` AS `tipo_pergunta` from (`enquete` join `perguntas_enquete`) where (`perguntas_enquete`.`fk_enquete` = `enquete`.`id_enquete`) order by `enquete`.`id_enquete`,`perguntas_enquete`.`id_pergunta_enquete` ;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `perguntas_enquete`
--
ALTER TABLE `perguntas_enquete`
  ADD CONSTRAINT `perguntas_enquete_ibfk_1` FOREIGN KEY (`fk_enquete`) REFERENCES `enquete` (`id_enquete`);

--
-- Limitadores para a tabela `respostas`
--
ALTER TABLE `respostas`
  ADD CONSTRAINT `respostas_ibfk_1` FOREIGN KEY (`fk_enquete`) REFERENCES `enquete` (`id_enquete`),
  ADD CONSTRAINT `respostas_ibfk_2` FOREIGN KEY (`fk_pergunta`) REFERENCES `perguntas_enquete` (`id_pergunta_enquete`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
