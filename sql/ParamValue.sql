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
-- Структура таблицы `ParamValue`
--

CREATE TABLE `ParamValue` (
  `ID` int(11) NOT NULL,
  `AnswValue` varchar(100) NOT NULL,
  `ParamValue` varchar(100) NOT NULL,
  `ParamName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ParamValue`
--

INSERT INTO `ParamValue` (`ID`, `AnswValue`, `ParamValue`, `ParamName`) VALUES
(1, 'Дорогой', 'LG', 'manufacturer'),
(2, 'Бюджетный', 'Xiaomi', 'manufacturer'),
(3, 'Дешёвый', 'BBK', 'manufacturer'),
(4, 'Низкая детализация', 'HD', 'resolution'),
(5, 'Средняя детализация', 'FULLHD', 'resolution'),
(6, 'Высокая детализация', '4K', 'resolution'),
(7, 'Замедленная', '50', 'frequency'),
(8, 'Плавная', '60', 'frequency'),
(9, 'Высокая плавность', '120', 'frequency'),
(10, 'Около 110 градусов', 'DLED', 'illumination'),
(11, 'Более 140 градусов', 'OLED', 'illumination'),
(12, 'Около 90 градусов', 'ELED', 'illumination');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ParamValue`
--
ALTER TABLE `ParamValue`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ParamValue`
--
ALTER TABLE `ParamValue`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
