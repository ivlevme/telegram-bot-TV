-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Дек 07 2020 г., 07:12
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
-- Структура таблицы `Answ`
--

CREATE TABLE `Answ` (
  `Parameter` varchar(100) NOT NULL,
  `Value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `Answ_364529796`
--

CREATE TABLE `Answ_364529796` (
  `Parameter` varchar(100) NOT NULL,
  `Value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Answ_364529796`
--

INSERT INTO `Answ_364529796` (`Parameter`, `Value`) VALUES
('manufacturer', 'LG'),
('diagonal', '65'),
('smarttv', 'Да'),
('bluetooth', 'Да'),
('network', 'Да'),
('resolution', '4K'),
('hdr', 'Да'),
('hdmi', '2.1'),
('frequency', '120'),
('illumination', 'OLED'),
('developYear', '2020');

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
  `DevelopYear` varchar(100) DEFAULT NULL,
  `hdmi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Items`
--

INSERT INTO `Items` (`ID`, `Manufacturer`, `Diagonal`, `Smarttv`, `Bluetooth`, `Network`, `Resolution`, `Hdr`, `Frequency`, `Illumination`, `DevelopYear`, `hdmi`) VALUES
(1, 'LG', '65', 'Да', 'Да', 'Да', '4K', 'Да', '120', 'OLED', '2020', '2.1'),
(2, 'BBK', '22', 'Нет', 'Нет', 'Нет', 'HD', 'Нет', '50', 'ELED', '2017', '1.4'),
(3, 'Xiaomi', '55', 'Да', 'Да', 'Да', 'FULLHD', 'Нет', '60', 'DLED', '2019', '2.0'),
(4, 'Xiaomi', '55', 'Да', 'Да', 'Да', 'FULLHD', 'Да', '60', 'DLED', '2020', '2.0'),
(5, 'BBK', '22', 'Нет', 'Нет', 'Нет', 'HD', 'Да', '50', 'ELED', '2018', '1.4');

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
(1, 'Производитель телевизора?', 2, 'LG', 'Xiaomi', 'BBK', 'Не знаю', 0, 'manufacturer', 1),
(2, 'Сегмент телевизора?', 2, 'Дорогой', 'Бюджетный', 'Дешёвый', NULL, 0, 'segment', 2),
(3, 'НАПИШИТЕ диагональ экрана: 22, 55, 65', 1, NULL, NULL, NULL, NULL, 0, 'diagonal', 3),
(4, 'Необходима поддержка Smart TV?', 2, 'Да', 'Нет', 'Не знаю', NULL, 0, 'smarttv', 4),
(5, 'Необходима ли поддержка доступа в интернет?', 2, 'Да', 'Нет', '', NULL, 0, 'network', 8),
(6, 'Нужна ли поддержка bluetooth?', 2, 'Да', 'Нет', 'Не знаю', NULL, 0, 'bluetooth', 6),
(7, 'поддержка беспроводного подключения наушников, трансляция с различных устройств на экран?', 2, 'Да', 'Нет', NULL, NULL, 0, 'bluetooth', 7),
(8, 'Разрешение экрана?', 2, 'HD', 'FULLHD', '4K', 'Не знаю', 0, 'resolution', 9),
(9, 'Степень четкости изображения?\r\n', 2, 'Низкая детализация', 'Средняя детализация', 'Высокая детализация', NULL, 0, 'detailing', 10),
(10, 'Поддержка hdr?', 2, 'Да', 'Нет', 'Не знаю', NULL, 0, 'hdr', 11),
(11, 'лучшая контрастность и цветопередача в современных фильмах?', 2, 'Да', 'Нет', NULL, NULL, 0, 'hdr', 12),
(12, 'Частота обновления экрана?', 2, '50', '60', '120', 'Не знаю', 0, 'frequency', 13),
(13, 'Плавность картинки?', 2, 'Замедленная', 'Плавная', 'Высокая плавность', NULL, 0, 'smoothness', 14),
(14, 'Тип подсветки?', 2, 'OLED', 'DLED', 'ELED', 'Не знаю', 0, 'illumination', 15),
(15, 'Углы обзора?', 2, 'Более 140 градусов', 'Около 110 градусов', 'Около 90 градусов', NULL, 0, 'angle', 16),
(16, 'НАПИШИТЕ Дата производства? от 2017 до 2020', 1, NULL, NULL, NULL, NULL, 0, 'developYear', 17),
(17, 'Возможность открытия приложений на телевизоре?', 2, 'Да', 'Нет', NULL, NULL, 0, 'smarttv', 5);

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

-- --------------------------------------------------------

--
-- Структура таблицы `Quest_364529796`
--

CREATE TABLE `Quest_364529796` (
  `ID` int(11) NOT NULL DEFAULT '0' COMMENT '	\r\nИдентификатор вопроса',
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
-- Дамп данных таблицы `Quest_364529796`
--

INSERT INTO `Quest_364529796` (`ID`, `Question`, `AnsType`, `Answer1`, `Answer2`, `Answer3`, `Answer4`, `Asked`, `Parameter`, `OrderQwest`) VALUES
(1, 'Производитель телевизора?', 2, 'LG', 'Xiaomi', 'BBK', 'Не знаю', 1, 'manufacturer', 1),
(2, 'Сегмент телевизора?', 2, 'Дорогой', 'Бюджетный', 'Дешёвый', NULL, 0, 'segment', 2),
(3, 'НАПИШИТЕ диагональ экрана: 22, 55, 65', 1, NULL, NULL, NULL, NULL, 1, 'diagonal', 3),
(4, 'Необходима поддержка Smart TV?', 2, 'Да', 'Нет', 'Не знаю', NULL, 1, 'smarttv', 4),
(5, 'Необходима ли поддержка доступа в интернет?', 2, 'Да', 'Нет', '', NULL, 0, 'network', 8),
(6, 'Нужна ли поддержка bluetooth?', 2, 'Да', 'Нет', 'Не знаю', NULL, 0, 'bluetooth', 6),
(7, 'поддержка беспроводного подключения наушников, трансляция с различных устройств на экран?', 2, 'Да', 'Нет', NULL, NULL, 0, 'bluetooth', 7),
(8, 'Разрешение экрана?', 2, 'HD', 'FULLHD', '4K', 'Не знаю', 1, 'resolution', 9),
(9, 'Степень четкости изображения?\r\n', 2, 'Низкая детализация', 'Средняя детализация', 'Высокая детализация', NULL, 0, 'detailing', 10),
(10, 'Поддержка hdr?', 2, 'Да', 'Нет', 'Не знаю', NULL, 1, 'hdr', 11),
(11, 'лучшая контрастность и цветопередача в современных фильмах?', 2, 'Да', 'Нет', NULL, NULL, 0, 'hdr', 12),
(12, 'Частота обновления экрана?', 2, '50', '60', '120', 'Не знаю', 1, 'frequency', 13),
(13, 'Плавность картинки?', 2, 'Замедленная', 'Плавная', 'Высокая плавность', NULL, 0, 'smoothness', 14),
(14, 'Тип подсветки?', 2, 'OLED', 'DLED', 'ELED', 'Не знаю', 1, 'illumination', 15),
(15, 'Углы обзора?', 2, 'Более 140 градусов', 'Около 110 градусов', 'Около 90 градусов', NULL, 0, 'angle', 16),
(16, 'НАПИШИТЕ Дата производства? от 2017 до 2020', 1, NULL, NULL, NULL, NULL, 0, 'developYear', 17),
(17, 'Возможность открытия приложений на телевизоре?', 2, 'Да', 'Нет', NULL, NULL, 0, 'smarttv', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `RulesComplex`
--

CREATE TABLE `RulesComplex` (
  `ID` int(100) NOT NULL COMMENT 'Идентификатор правила',
  `IF1_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта посылки.',
  `IF1_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта посылки.',
  `Operation` int(1) DEFAULT NULL COMMENT '	\r\nЛогическая операция ( 0 – нет операции, 1 – AND, 2 – OR, 3 – NOT …)',
  `IF2_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта посылки.',
  `IF2_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта посылки.',
  `Then_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта следствия.',
  `Then_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта следствия.',
  `ChangeValue` int(100) DEFAULT NULL COMMENT 'Прирост/уменьшение вероятности (уверенности, достоверности) гипотезы (факта).',
  `Used` tinyint(1) DEFAULT NULL COMMENT '	\r\nИспользовано/не использовано правило'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `RulesComplex`
--

INSERT INTO `RulesComplex` (`ID`, `IF1_Atr`, `IF1_Value`, `Operation`, `IF2_Atr`, `IF2_Value`, `Then_Atr`, `Then_Value`, `ChangeValue`, `Used`) VALUES
(1, 'hdr', 'Да', 1, 'resolution', '4K', 'hdmi', '2.1', NULL, 0),
(2, 'hdr', 'Да', 1, 'resolution', 'FULLHD', 'hdmi', '2.0', NULL, 0),
(3, 'hdr', 'Да', 1, 'resolution', 'HD', 'hdmi', '1.4', NULL, 0),
(4, 'illumination', 'OLED', 1, 'frequency', '120', 'developYear', '2020', NULL, 0),
(5, 'smarttv', 'Да', 1, 'manufacturer', 'LG', 'bluetooth', 'Да', NULL, 0),
(6, 'smarttv', 'Да', 1, 'manufacturer', 'LG', 'network', 'Да', NULL, 0),
(7, 'resolution', 'FULLHD', 1, 'manufacturer', 'BBK', 'frequency', '60', NULL, 0),
(8, 'resolution', '4K', 1, 'manufacturer', 'Xiaomi', 'hdr', 'Да', NULL, 0),
(9, 'resolution', 'HD', 1, 'manufacturer', 'Xiaomi', 'hdr', 'Нет', NULL, 0),
(10, 'resolution', 'HD', 1, 'manufacturer', 'BBK', 'frequency', '50', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `RulesComplex_364529796`
--

CREATE TABLE `RulesComplex_364529796` (
  `ID` int(100) NOT NULL DEFAULT '0' COMMENT 'Идентификатор правила',
  `IF1_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта посылки.',
  `IF1_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта посылки.',
  `Operation` int(1) DEFAULT NULL COMMENT '	\r\nЛогическая операция ( 0 – нет операции, 1 – AND, 2 – OR, 3 – NOT …)',
  `IF2_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта посылки.',
  `IF2_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта посылки.',
  `Then_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта следствия.',
  `Then_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта следствия.',
  `ChangeValue` int(100) DEFAULT NULL COMMENT 'Прирост/уменьшение вероятности (уверенности, достоверности) гипотезы (факта).',
  `Used` tinyint(1) DEFAULT NULL COMMENT '	\r\nИспользовано/не использовано правило'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `RulesComplex_364529796`
--

INSERT INTO `RulesComplex_364529796` (`ID`, `IF1_Atr`, `IF1_Value`, `Operation`, `IF2_Atr`, `IF2_Value`, `Then_Atr`, `Then_Value`, `ChangeValue`, `Used`) VALUES
(1, 'hdr', 'Да', 1, 'resolution', '4K', 'hdmi', '2.1', NULL, 1),
(2, 'hdr', 'Да', 1, 'resolution', 'FULLHD', 'hdmi', '2.0', NULL, 0),
(3, 'hdr', 'Да', 1, 'resolution', 'HD', 'hdmi', '1.4', NULL, 0),
(4, 'illumination', 'OLED', 1, 'frequency', '120', 'developYear', '2020', NULL, 1),
(5, 'smarttv', 'Да', 1, 'manufacturer', 'LG', 'bluetooth', 'Да', NULL, 1),
(6, 'smarttv', 'Да', 1, 'manufacturer', 'LG', 'network', 'Да', NULL, 1),
(7, 'resolution', 'FULLHD', 1, 'manufacturer', 'BBK', 'frequency', '60', NULL, 0),
(8, 'resolution', '4K', 1, 'manufacturer', 'Xiaomi', 'hdr', 'Да', NULL, 0),
(9, 'resolution', 'HD', 1, 'manufacturer', 'Xiaomi', 'hdr', 'Нет', NULL, 0),
(10, 'resolution', 'HD', 1, 'manufacturer', 'BBK', 'frequency', '50', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `RulesSimple`
--

CREATE TABLE `RulesSimple` (
  `ID` int(100) NOT NULL COMMENT 'Идентификатор правила',
  `IF_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта посылки.',
  `IF_Value` varchar(100) DEFAULT NULL COMMENT 'Значение атрибута (свойства) объекта посылки.',
  `Then_Atr` varchar(100) DEFAULT NULL COMMENT 'Атрибут (свойство) объекта следствия.',
  `Then_Value` varchar(100) DEFAULT NULL COMMENT '	\r\nЗначение атрибута (свойства) объекта следствия.',
  `Used` tinyint(1) DEFAULT NULL COMMENT 'Использовано/не использовано правило'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `RulesSimple`
--

INSERT INTO `RulesSimple` (`ID`, `IF_Atr`, `IF_Value`, `Then_Atr`, `Then_Value`, `Used`) VALUES
(1, 'segment', 'Дорогой', 'manufacturer', 'LG', NULL),
(2, 'segment', 'Бюджетный', 'manufacturer', 'Xiaomi', NULL),
(3, 'segment', 'Дешёвый', 'manufacturer', 'BBK', NULL),
(4, 'detailing', 'Низкая детализация', 'resolution', 'HD', NULL),
(5, 'detailing', 'Средняя детализация', 'resolution', 'FULLHD', NULL),
(6, 'detailing', 'Высокая детализация', 'resolution', '4K', NULL),
(7, 'smoothness', 'Замедленная', 'frequency', '50', NULL),
(8, 'smoothness', 'Плавная', 'frequency', '60', NULL),
(9, 'smoothness', 'Высокая плавность', 'frequency', '120', NULL),
(10, 'angle', 'Около 90 градусов', 'illumination', 'ELED', NULL),
(11, 'angle', 'Около 110 градусов', 'illumination', 'DLED', NULL),
(12, 'angle', 'Более 140 градусов', 'illumination', 'OLED', NULL),
(13, 'manufacturer', 'Не знаю', NULL, NULL, NULL),
(14, 'smarttv', 'Не знаю', NULL, NULL, NULL),
(15, 'bluetooth', 'Не знаю', NULL, NULL, NULL),
(16, 'resolution', 'Не знаю', NULL, NULL, NULL),
(17, 'hdr', 'Не знаю', NULL, NULL, NULL),
(18, 'frequency', 'Не знаю', NULL, NULL, NULL),
(19, 'illumination', 'Не знаю', NULL, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `Quest`
--
ALTER TABLE `Quest`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `QuestRules`
--
ALTER TABLE `QuestRules`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `RulesComplex`
--
ALTER TABLE `RulesComplex`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `RulesSimple`
--
ALTER TABLE `RulesSimple`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Items`
--
ALTER TABLE `Items`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT для таблицы `Quest`
--
ALTER TABLE `Quest`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '	\r\nИдентификатор вопроса', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `QuestRules`
--
ALTER TABLE `QuestRules`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор правила', AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `RulesComplex`
--
ALTER TABLE `RulesComplex`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор правила', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `RulesSimple`
--
ALTER TABLE `RulesSimple`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор правила', AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
