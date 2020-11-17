-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Ноя 17 2020 г., 17:48
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
-- Структура таблицы `Quest`
--

CREATE TABLE `Quest` (
  `ID` int(11) NOT NULL COMMENT '	\r\nИдентификатор вопроса',
  `Question` varchar(100) DEFAULT NULL COMMENT 'Вопрос',
  `AnsType` int(11) DEFAULT NULL COMMENT 'Тип данных для ответа\r\n(0 – Boolean, 1 – Integer, 2 – String)',
  `Answer1` varchar(100) DEFAULT NULL COMMENT 'Вариант ответа 1',
  `Answer2` varchar(100) DEFAULT NULL COMMENT 'Вариант ответа 2',
  `Answer3` varchar(100) DEFAULT NULL COMMENT 'Вариант ответа 3',
  `Answer4` varchar(100) DEFAULT NULL COMMENT 'Вариант ответа 4',
  `Asked` tinyint(1) DEFAULT NULL COMMENT 'Задан/не задан вопрос',
  `Parameter` varchar(100) DEFAULT NULL COMMENT '	\r\nПараметр (свойство) объекта, значение которого определяется ответом.',
  `OrderQwest` int(11) NOT NULL COMMENT 'Порядок (очередность) задавания вопроса\r\n\r\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Quest`
--

INSERT INTO `Quest` (`ID`, `Question`, `AnsType`, `Answer1`, `Answer2`, `Answer3`, `Answer4`, `Asked`, `Parameter`, `OrderQwest`) VALUES
(1, 'Производитель телевизора?', 2, 'LG', 'Xiaomi', 'BBK', 'help', 0, 'manufacturer', 1),
(2, 'Сегмент телевизора?', 2, 'Дорогой', 'Бюджетный', 'Дешёвый', NULL, 0, 'manufacturer', 2),
(3, 'НАПИШИТЕ диагональ экрана в диапазоне от 22 до 75.', 1, NULL, NULL, NULL, NULL, 0, 'diagonal', 3),
(4, 'Необходима поддержка Smart TV?', 2, 'Да', 'Нет', 'help', NULL, 0, 'smarttv', 4),
(5, 'Необходима ли поддержка допступа в интернет?', 2, 'Да', 'Нет', '', NULL, 0, 'network', 8),
(6, 'Нужна ли поддержка bluetooth?', 2, 'Да', 'Нет', 'help', NULL, 0, 'bluetooth', 6),
(7, 'поддержка беспроводного подключения наушников, трансляция с различных устройств на экран?', 2, 'Да', 'Нет', NULL, NULL, 0, 'bluetooth', 7),
(8, 'Разрешение экрана?', 2, 'HD', 'FULLHD', '4K', 'help', 0, 'resolution', 9),
(9, 'Степень четкости изображения?\r\n', 2, 'Низкая детализация', 'Средняя детализация', 'Высокая детализация', NULL, 0, 'resolution', 10),
(10, 'Поддержка hdr?', 2, 'Да', 'Нет', 'help', NULL, 0, 'hdr', 11),
(11, 'лучшая контрастность и цветопередача в современных фильмах?', 2, 'Да', 'Нет', NULL, NULL, 0, 'hdr', 12),
(12, 'Частота обновления экрана?', 2, '50', '60', '120', 'help', 0, 'frequency', 13),
(13, 'Плавность картинки?', 2, 'Замедленная', 'Плавная', 'Высокая плавность', NULL, 0, 'frequency', 14),
(14, 'Тип подсветки?', 2, 'OLED', 'DLED', 'ELED', 'help', 0, 'illumination', 15),
(15, 'Углы обзора?', 2, 'Более 140 градусов', 'Около 110 градусов', 'Около 90 градусов', NULL, 0, 'illumination', 16),
(16, 'НАПИШТЕ Дата производства? от 2017 до 2020', 1, NULL, NULL, NULL, NULL, 0, 'developYear', 17),
(17, 'Возможность открытия приложений на телевизоре?', 2, 'Да', 'Нет', NULL, NULL, 0, 'smarttv', 5);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Quest`
--
ALTER TABLE `Quest`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Quest`
--
ALTER TABLE `Quest`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '	\r\nИдентификатор вопроса', AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
