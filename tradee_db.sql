-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1
-- Tid vid skapande: 25 jan 2026 kl 00:24
-- Serverversion: 10.4.32-MariaDB
-- PHP-version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `tradee_db`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `auctions`
--

CREATE TABLE `auctions` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(512) NOT NULL,
  `price` int(11) NOT NULL,
  `image_small` varchar(256) NOT NULL,
  `image_regular` varchar(256) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `leader_id` int(11) DEFAULT NULL,
  `auction_time` int(11) NOT NULL,
  `published_at` varchar(32) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `category_id` varchar(128) DEFAULT NULL,
  `views` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `auctions`
--

INSERT INTO `auctions` (`id`, `name`, `description`, `price`, `image_small`, `image_regular`, `owner_id`, `leader_id`, `auction_time`, `published_at`, `published`, `category_id`, `views`) VALUES
(61, 'Spindelmannen och spindelmannen', 'This is an example auction item.', 892, 'https://images.unsplash.com/photo-1608889476561-6242cfdbf622?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889476561-6242cfdbf622?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 571931, '2026-01-25T00:23:40.417867', 1, '1', 29),
(62, 'Vit och röd robot på brun jord', 'This is an example auction item.', 436, 'https://images.unsplash.com/photo-1608889825146-c9276dc26bdc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889825146-c9276dc26bdc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 245925, '2026-01-25T00:23:41.001593', 1, '1', 188),
(63, 'Brun trärobotleksak på vit yta', 'This is an example auction item.', 494, 'https://images.unsplash.com/photo-1610855128164-77be0c77c7ac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1610855128164-77be0c77c7ac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 464460, '2026-01-25T00:23:41.477209', 1, '1', 49),
(64, 'Vit och svart kattillustration', 'This is an example auction item.', 496, 'https://images.unsplash.com/photo-1611001440551-e2e835b003e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1611001440551-e2e835b003e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 265253, '2026-01-25T00:23:42.145845', 1, '1', 78),
(65, 'Vit och röd robotleksak', 'This is an example auction item.', 251, 'https://images.unsplash.com/photo-1620390108932-930ac0adc512?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1620390108932-930ac0adc512?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 398162, '2026-01-25T00:23:42.814169', 1, '1', 61),
(66, 'En blå leksaksbil som sitter på toppen av en gata', 'This is an example auction item.', 853, 'https://images.unsplash.com/photo-1623111396948-5706bc25703e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1623111396948-5706bc25703e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 298100, '2026-01-25T00:23:43.456882', 1, '1', 91),
(67, 'En hund som hoppar i luften', 'This is an example auction item.', 402, 'https://images.unsplash.com/photo-1655894756391-1569df5ab388?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1655894756391-1569df5ab388?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 593412, '2026-01-25T00:23:44.543101', 1, '1', 56),
(68, 'En vas med apelsinblommor', 'This is an example auction item.', 252, 'https://images.unsplash.com/photo-1662304102244-8c9e91814da1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1662304102244-8c9e91814da1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 222842, '2026-01-25T00:23:45.157841', 1, '1', 67),
(69, 'En hund som står på golvet med ett uppstoppat djur', 'This is an example auction item.', 615, 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 554116, '2026-01-25T00:23:45.953136', 1, '1', 84),
(70, 'Ett svartvitt foto av en bebis insvept i en filt', 'This is an example auction item.', 801, 'https://images.unsplash.com/photo-1703220181579-90e904bfeecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1703220181579-90e904bfeecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 180392, '2026-01-25T00:23:46.691829', 1, '1', 157),
(71, 'Ett bord toppat med massor av leksaksfigurer', 'This is an example auction item.', 941, 'https://images.unsplash.com/photo-1708020777427-518e5c6c739d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1708020777427-518e5c6c739d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 181093, '2026-01-25T00:23:47.297942', 1, '1', 108),
(72, 'En liten leksak som sitter ovanpå ett träbord', 'This is an example auction item.', 484, 'https://images.unsplash.com/photo-1712231169838-cf99bf1323d1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1712231169838-cf99bf1323d1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 120981, '2026-01-25T00:23:47.869219', 1, '1', 81),
(73, 'Ett par småfåglar som sitter ovanpå skrammel', 'This is an example auction item.', 436, 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 230901, '2026-01-25T00:23:48.469016', 1, '1', 111),
(74, 'En stor gul nallebjörn som sitter ovanpå ett bord', 'This is an example auction item.', 206, 'https://images.unsplash.com/photo-1729487151695-07fb5d8a4982?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1729487151695-07fb5d8a4982?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 322938, '2026-01-25T00:23:49.077117', 1, '1', 77),
(75, 'En person som håller ett skyltfodral med fyra bilar i', 'This is an example auction item.', 923, 'https://images.unsplash.com/photo-1732947655987-add693211191?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1732947655987-add693211191?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 364252, '2026-01-25T00:23:49.646136', 1, '1', 112),
(76, 'En kvinna som sitter framför ett datorbord och håller en surfplatta', 'This is an example auction item.', 678, 'https://images.unsplash.com/photo-1732947655964-eb2a7dc9f76b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1732947655964-eb2a7dc9f76b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 599773, '2026-01-25T00:23:50.289810', 1, '1', 112),
(77, 'Barn som leker vid en liten kanal i en europeisk stad.', 'This is an example auction item.', 289, 'https://images.unsplash.com/photo-1759244984519-d1d3b4b4da80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759244984519-d1d3b4b4da80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 460154, '2026-01-25T00:23:50.959401', 1, '1', 117),
(78, 'En snurrande fidget-leksak med en orange mitt.', 'This is an example auction item.', 50, 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 494033, '2026-01-25T00:23:51.514810', 1, '1', 10),
(79, 'En plyschgrön julgran med färgglada ornament.', 'This is an example auction item.', 516, 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 506728, '2026-01-25T00:23:52.075363', 1, '1', 67),
(80, 'En stiliserad kaninfigur upplyst i en cirkulär ram', 'This is an example auction item.', 146, 'https://images.unsplash.com/photo-1765176938538-b182e1d2a77d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1765176938538-b182e1d2a77d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjkyOTcwMTl8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 449295, '2026-01-25T00:23:52.709980', 1, '1', 132);

-- --------------------------------------------------------

--
-- Tabellstruktur `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'toys');

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `lastName` varchar(128) NOT NULL,
  `firstName` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`ID`, `lastName`, `firstName`, `city`, `email`, `password`) VALUES
(1, 'Bergström', 'Anton', 'Stockholm', 'admin@tradee.com', '$2b$12$d3mk1tf01IztwDh6nU3SM.DPQx0HygabgPr82KNd1Ql0pDsJO.r1y');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `auctions`
--
ALTER TABLE `auctions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT för tabell `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
