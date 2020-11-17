-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Ноя 17 2020 г., 17:49
-- Версия сервера: 5.7.26-0ubuntu0.16.04.1
-- Версия PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `std_1313`
--

-- --------------------------------------------------------

--
-- Структура таблицы `QuestRules`
--

CREATE TABLE `QuestRules` (
  `ID` int(11) NOT NULL COMMENT 'Идентификатор правила',
  `IF_Par` varchar(100) NOT NULL COMMENT 'Параметр (свойство) объекта.',
  `IF_Value` varchar(100) NOT NULL COMMENT 'Значение параметра объекта',
  `NextQuest` int(11) NOT NULL COMMENT 'Номер (ID) следующего вопроса. Значение =0, если нужно только исключить вопрос.',
  `NoAsk` int(11) DEFAULT NULL COMMENT '	\r\nНомер (ID) вопроса, который не надо задавать. Значение =0, если не нужно исключать вопрос.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `QuestRules`
--

INSERT INTO `QuestRules` (`ID`, `IF_Par`, `IF_Value`, `NextQuest`, `NoAsk`) VALUES
(1, 'manufacturer', 'LG', 3, 2),
(6, 'bluetooth', 'Да', 8, 7),
(8, 'smarttv', 'Да', 6, 5),
(9, 'resolution', '4K', 11, 10),
(10, 'hdr', 'Да', 13, 12),
(11, 'frequency', '50', 15, 14),
(12, 'illumination', 'DLED', 17, 16),
(13, 'manufacturer', 'Xiaomi', 3, 2),
(14, 'manufacturer', 'BBK', 3, 2),
(15, 'smarttv', 'Нет', 6, 5),
(16, 'bluetooth', 'Нет', 8, 7),
(17, 'frequency', '60', 15, 14),
(18, 'frequency', '120', 15, 14),
(19, 'hdr', 'Нет', 13, 12),
(20, 'illumination', 'OLED', 17, 16),
(21, 'illumination', 'ELED', 17, 16),
(22, 'resolution', 'HD', 11, 10),
(23, 'resolution', 'FULLHD', 11, 10);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `QuestRules`
--
ALTER TABLE `QuestRules`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `QuestRules`
--
ALTER TABLE `QuestRules`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор правила', AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
