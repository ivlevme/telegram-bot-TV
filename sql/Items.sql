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
-- Структура таблицы `Items`
--

CREATE TABLE `Items` (
  `ID` int(11) NOT NULL,
  `Manufacturer` varchar(100) DEFAULT NULL,
  `Diagonal` varchar(100) DEFAULT NULL,
  `Smarttv` varchar(100) DEFAULT NULL,
  `Bluetooth` varchar(100) DEFAULT NULL,
  `Network` varchar(100) DEFAULT NULL,
  `Resolution` varchar(100) DEFAULT NULL,
  `Hdr` varchar(100) DEFAULT NULL,
  `Frequency` varchar(100) DEFAULT NULL,
  `Illumination` varchar(100) DEFAULT NULL,
  `DevelopYear` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Items`
--

INSERT INTO `Items` (`ID`, `Manufacturer`, `Diagonal`, `Smarttv`, `Bluetooth`, `Network`, `Resolution`, `Hdr`, `Frequency`, `Illumination`, `DevelopYear`) VALUES
(1, 'LG', '65', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(2, 'BBK', '22', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017'),
(3, 'Xiaomi', '55', 'Да', 'Да', 'Да', 'FULLHD', 'Нет', '60', 'DLED', '2020'),
(4, 'BBK', '23', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017'),
(5, 'BBK', '24', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017'),
(6, 'BBK', '25', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017'),
(7, 'BBK', '26', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017'),
(8, 'Xiaomi', '25', 'Да', 'Да', 'Да', 'FULLHD', 'Да', '60', 'OLED', '2018'),
(9, 'LG', '55', 'Да', 'Да', 'Да', 'FULLHD', 'Да', '60', 'OLED', '2018'),
(10, 'LG', '55', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2019'),
(11, 'LG', '45', 'Да', 'Да', 'Да', 'FULLHD', 'Да', '60', 'OLED', '2019'),
(12, 'LG', '45', 'Да', 'Да', 'Да', 'FULLHD', 'Да', '60', 'OLED', '2020'),
(13, 'LG', '75', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(14, 'LG', '74', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(15, 'LG', '73', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(16, 'LG', '72', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(17, 'LG', '71', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(18, 'LG', '70', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(19, 'LG', '69', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(20, 'LG', '68', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(21, 'LG', '67', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(22, 'LG', '66', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(23, 'LG', '64', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(24, 'LG', '63', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(25, 'LG', '62', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(26, 'LG', '61', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(27, 'LG', '60', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(28, 'Xiaomi', '68', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(29, 'Xiaomi', '65', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(30, 'Xiaomi', '64', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(31, 'Xiaomi', '63', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(32, 'Xiaomi', '62', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(33, 'Xiaomi', '61', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(34, 'Xiaomi', '60', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(35, 'Xiaomi', '50', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(36, 'Xiaomi', '55', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020'),
(37, 'Xiaomi', '45', 'Да', 'Да', 'Да', '4K', 'Да', '60', 'DLED', '2020'),
(38, 'Xiaomi', '40', '', 'Да', 'Да', '4K', 'Да', '60', 'DLED', '2019'),
(39, 'Xiomi', '35', 'Да', 'Да', 'Да', '4K', 'Да', '60', 'DLED', '2019'),
(40, 'Xiomi', '30', 'Да', 'Да', 'Да', '4K', 'Да', '60', 'DLED', '2019'),
(41, 'Xiomi', '25', 'Да', 'Да', 'Да', '4K', 'Да', '60', 'DLED', '2019');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Items`
--
ALTER TABLE `Items`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
