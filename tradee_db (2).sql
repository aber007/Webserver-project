-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1
-- Tid vid skapande: 17 apr 2026 kl 07:45
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
  `published_at` datetime NOT NULL,
  `published` tinyint(1) NOT NULL,
  `category_id` varchar(128) DEFAULT NULL,
  `views` int(11) NOT NULL,
  `location` varchar(64) DEFAULT NULL,
  `auction_condition` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `auctions`
--

INSERT INTO `auctions` (`id`, `name`, `description`, `price`, `image_small`, `image_regular`, `owner_id`, `leader_id`, `auction_time`, `published_at`, `published`, `category_id`, `views`, `location`, `auction_condition`) VALUES
(101, 'Gul och svart robotleksak', 'This is an example auction item.', 80, 'https://images.unsplash.com/photo-1593085512500-5d55148d6f0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1593085512500-5d55148d6f0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 558174, '2026-04-16 08:48:38', 1, '1', 10, NULL, NULL),
(102, 'Svart och röd motorcykelhjälm', 'This is an example auction item.', 150, 'https://images.unsplash.com/photo-1608889345749-630640d94426?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889345749-630640d94426?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 463761, '2026-04-16 08:48:38', 1, '1', 200, NULL, NULL),
(103, 'Röd och svart hjälm på svart och vit textil', 'This is an example auction item.', 210, 'https://images.unsplash.com/photo-1608889453743-bf8eabeb12fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889453743-bf8eabeb12fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 480222, '2026-04-16 08:48:38', 1, '1', 30, NULL, NULL),
(104, 'Kvinna i svart jacka som står på grå betongväg nära brunt tegelbyggnad under dagtid', 'This is an example auction item.', 30, 'https://images.unsplash.com/photo-1610098692961-e916be8f2901?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1610098692961-e916be8f2901?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 216530, '2026-04-16 08:48:38', 1, '1', 170, NULL, NULL),
(105, 'En blå leksaksbil som sitter ovanpå ett träbord', 'This is an example auction item.', 490, 'https://images.unsplash.com/photo-1631623299163-ba93c3cf3c1b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1631623299163-ba93c3cf3c1b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 108719, '2026-04-16 08:48:38', 1, '1', 100, NULL, NULL),
(106, 'En hög med röda och vita lego som ligger ovanpå varandra', 'This is an example auction item.', 360, 'https://images.unsplash.com/photo-1634578681002-3b744a3f7f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1634578681002-3b744a3f7f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 86430, '2026-04-16 08:48:38', 1, '1', 90, NULL, NULL),
(107, 'En leksaksfigur som sitter ovanpå en burk färg', 'This is an example auction item.', 900, 'https://images.unsplash.com/photo-1680940429127-a4b0944e8584?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1680940429127-a4b0944e8584?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 456022, '2026-04-16 08:48:38', 1, '1', 180, NULL, NULL),
(108, 'En svart bakgrund med rosa linjer och snöflingor', 'This is an example auction item.', 990, 'https://images.unsplash.com/photo-1689699544590-d23cb29dc3a7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689699544590-d23cb29dc3a7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 387119, '2026-04-16 08:48:38', 1, '1', 150, NULL, NULL),
(109, 'En närbild av ett rosa objekt på en svart bakgrund', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1689699544848-bbd44b6ff85c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689699544848-bbd44b6ff85c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 109779, '2026-04-16 08:48:38', 1, '1', 150, NULL, NULL),
(110, 'En hund som står på golvet med ett uppstoppat djur', 'This is an example auction item.', 500, 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 322265, '2026-04-16 08:48:38', 1, '1', 110, NULL, NULL),
(111, 'En träskyltdocka som står framför en vägg', 'This is an example auction item.', 880, 'https://images.unsplash.com/photo-1705180502044-36ebb305974a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1705180502044-36ebb305974a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 197049, '2026-04-16 08:48:38', 1, '1', 200, NULL, NULL),
(112, 'En gummianka med solglasögon på huvudet som sitter bredvid en vattenpöl', 'This is an example auction item.', 600, 'https://images.unsplash.com/photo-1713830551089-cb57c85c5c40?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1713830551089-cb57c85c5c40?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 503331, '2026-04-16 08:48:38', 1, '1', 70, NULL, NULL),
(113, 'Ett par småfåglar som sitter ovanpå skrammel', 'This is an example auction item.', 390, 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 430167, '2026-04-16 08:48:38', 1, '1', 80, NULL, NULL),
(114, 'En seriefigur med rosa hår och en rosa outfit', 'This is an example auction item.', 430, 'https://images.unsplash.com/photo-1728729729215-00ae703063ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1728729729215-00ae703063ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 226133, '2026-04-16 08:48:38', 1, '1', 50, NULL, NULL),
(115, 'Lego star wars-figurer förbereder sig för strid.', 'This is an example auction item.', 240, 'https://images.unsplash.com/photo-1745483547576-3bb3ce24a24e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1745483547576-3bb3ce24a24e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 424924, '2026-04-16 08:48:38', 1, '1', 50, NULL, NULL),
(116, 'En snurrande fidget-leksak med en orange mitt.', 'This is an example auction item.', 520, 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 267377, '2026-04-16 08:48:38', 1, '1', 150, NULL, NULL),
(117, 'En plyschgrön julgran med färgglada ornament.', 'This is an example auction item.', 670, 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 438431, '2026-04-16 08:48:38', 1, '1', 0, NULL, NULL),
(118, 'Liten butik med skyltfönster och öppen dörr.', 'This is an example auction item.', 150, 'https://images.unsplash.com/photo-1764351903979-4e3c59f03479?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1764351903979-4e3c59f03479?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 319087, '2026-04-16 08:48:38', 1, '1', 10, NULL, NULL),
(119, 'En tomte med röd hatt och luddigt skägg.', 'This is an example auction item.', 200, 'https://images.unsplash.com/photo-1766525457533-d165eb992a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1766525457533-d165eb992a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 96577, '2026-04-16 08:48:38', 1, '1', 80, NULL, NULL),
(120, 'Silhuett av en person som går in i en cirkulär tunnel', 'This is an example auction item.', 370, 'https://images.unsplash.com/photo-1769527818981-ed8961067a14?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1769527818981-ed8961067a14?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 291835, '2026-04-16 08:48:38', 1, '1', 70, NULL, NULL),
(121, 'Svart och blå skivspelare på brunt träbord', 'This is an example auction item.', 460, 'https://images.unsplash.com/photo-1485726696757-76885c99f0f5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1485726696757-76885c99f0f5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 251695, '2026-04-16 08:48:38', 1, '2', 110, NULL, NULL),
(122, 'Böcker i brun bokhylla', 'This is an example auction item.', 10, 'https://images.unsplash.com/photo-1516888693095-f0e05366ddc6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1516888693095-f0e05366ddc6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 264006, '2026-04-16 08:48:38', 1, '2', 0, NULL, NULL),
(123, 'Beige fordon', 'This is an example auction item.', 648, 'https://images.unsplash.com/photo-1566935126136-2dc1c088e066?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1566935126136-2dc1c088e066?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, 1, 489783, '2026-04-16 08:48:38', 1, '2', 190, NULL, NULL),
(124, 'Brun tegelvägg under blå himmel under dagtid', 'This is an example auction item.', 860, 'https://images.unsplash.com/photo-1620831902801-9c518ca7d1ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1620831902801-9c518ca7d1ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 337577, '2026-04-16 08:48:38', 1, '2', 130, NULL, NULL),
(125, 'Svart och silver kamera på vit yta', 'This is an example auction item.', 530, 'https://images.unsplash.com/photo-1630951747824-c17e965fb4de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1630951747824-c17e965fb4de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 92708, '2026-04-16 08:48:38', 1, '2', 190, NULL, NULL),
(126, 'Ett svartvitt foto av en byggnad med en klocka', 'This is an example auction item.', 980, 'https://images.unsplash.com/photo-1641243519676-0bc3304be9ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1641243519676-0bc3304be9ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 200519, '2026-04-16 08:48:38', 1, '2', 170, NULL, NULL),
(127, 'En pool med paraplyer och ett vattenfall', 'This is an example auction item.', 440, 'https://images.unsplash.com/photo-1661207718083-5b13407cbe41?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1661207718083-5b13407cbe41?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 313311, '2026-04-16 08:48:38', 1, '2', 80, NULL, NULL),
(128, 'En byggnad med en skylt på', 'This is an example auction item.', 380, 'https://images.unsplash.com/photo-1662531916809-673923573549?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1662531916809-673923573549?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 523701, '2026-04-16 08:48:38', 1, '2', 30, NULL, NULL),
(129, 'En ljuskrona som hänger från ett tak i ett mörkt rum', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1674744540420-e94848013fa7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1674744540420-e94848013fa7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 147422, '2026-04-16 08:48:38', 1, '2', 10, NULL, NULL),
(130, 'En kvinna som håller ett barn på stranden', 'This is an example auction item.', 20, 'https://images.unsplash.com/photo-1693812205574-e441ed7f9c98?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1693812205574-e441ed7f9c98?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 518360, '2026-04-16 08:48:38', 1, '2', 20, NULL, NULL),
(131, 'En byrå i trä som sitter framför en butik', 'This is an example auction item.', 810, 'https://images.unsplash.com/photo-1698953704644-6fb636c6389d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1698953704644-6fb636c6389d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 382525, '2026-04-16 08:48:38', 1, '2', 90, NULL, NULL),
(132, 'En man och kvinna som håller ett litet barn', 'This is an example auction item.', 950, 'https://images.unsplash.com/photo-1730130596440-e9925840f028?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730130596440-e9925840f028?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 424022, '2026-04-16 08:48:38', 1, '2', 160, NULL, NULL),
(133, 'En närbild av en metalldörr med ett handtag', 'This is an example auction item.', 122, 'https://images.unsplash.com/photo-1730634889417-56a2e7d50a75?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730634889417-56a2e7d50a75?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, 1, 181393, '2026-04-16 08:48:38', 1, '2', 130, NULL, NULL),
(134, 'En staty av en person i en kyrka', 'This is an example auction item.', 960, 'https://images.unsplash.com/photo-1733502985243-b721ea1b84c4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1733502985243-b721ea1b84c4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 306029, '2026-04-16 08:48:38', 1, '2', 70, NULL, NULL),
(135, 'Trasig utsmyckad skål med gyllene bas och blommig design', 'This is an example auction item.', 500, 'https://images.unsplash.com/photo-1755167348728-02cc5c45b355?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755167348728-02cc5c45b355?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 417578, '2026-04-16 08:48:38', 1, '2', 100, NULL, NULL),
(136, 'Hörn av en byggnad mot en klar himmel', 'This is an example auction item.', 640, 'https://images.unsplash.com/photo-1755900094171-4c446d65f8ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755900094171-4c446d65f8ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 480324, '2026-04-16 08:48:38', 1, '2', 170, NULL, NULL),
(137, 'En rad veteranbilar kör längs en trädkantad väg.', 'This is an example auction item.', 740, 'https://images.unsplash.com/photo-1757191462391-d43358c9ab3e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1757191462391-d43358c9ab3e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 386302, '2026-04-16 08:48:38', 1, '2', 20, NULL, NULL),
(138, 'Två väckarklockor med glödande ansikten på ett bord.', 'This is an example auction item.', 450, 'https://images.unsplash.com/photo-1759088731172-592a4ad90fe0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759088731172-592a4ad90fe0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 234467, '2026-04-16 08:48:38', 1, '2', 170, NULL, NULL),
(139, 'Utsmyckat historiskt monument med skulpterade figurer och djur.', 'This is an example auction item.', 890, 'https://images.unsplash.com/photo-1759937268759-2a9122b3b202?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759937268759-2a9122b3b202?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 305785, '2026-04-16 08:48:38', 1, '2', 100, NULL, NULL),
(140, 'Vintage glastallrik med abstrakta starburst-mönster', 'This is an example auction item.', 690, 'https://images.unsplash.com/photo-1765205134334-ddc94cc928f9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1765205134334-ddc94cc928f9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 103712, '2026-04-16 08:48:38', 1, '2', 130, NULL, NULL),
(141, 'Tre olika färger chevrolet pickup lastbilar parkering nära byggnaden', 'This is an example auction item.', 550, 'https://images.unsplash.com/photo-1561122850-9f97268703ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1561122850-9f97268703ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 354629, '2026-04-16 08:48:38', 1, '3', 180, NULL, NULL),
(142, 'Vit bil parkerad på parkeringsplats under dagtid', 'This is an example auction item.', 690, 'https://images.unsplash.com/photo-1609141842470-c02b20381435?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1609141842470-c02b20381435?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 327236, '2026-04-16 08:48:38', 1, '3', 190, NULL, NULL),
(143, 'Röd ferrari-bil parkerad på trottoaren under dagtid', 'This is an example auction item.', 110, 'https://images.unsplash.com/photo-1619042822294-43580ae4620c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1619042822294-43580ae4620c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 253648, '2026-04-16 08:48:38', 1, '3', 140, NULL, NULL),
(144, 'Grön och vit volkswagen t-2 parkerad bredvid vit betongbyggnad under dagtid', 'This is an example auction item.', 960, 'https://images.unsplash.com/photo-1623587672045-0619ca96029f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1623587672045-0619ca96029f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 255593, '2026-04-16 08:48:38', 1, '3', 160, NULL, NULL),
(145, 'Röd och vit veteranbil på väg under dagtid', 'This is an example auction item.', 380, 'https://images.unsplash.com/photo-1625842129921-2be232dadd47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1625842129921-2be232dadd47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 378349, '2026-04-16 08:48:38', 1, '3', 60, NULL, NULL),
(146, 'Röd ferrari coupe parkerad bredvid svart bil', 'This is an example auction item.', 830, 'https://images.unsplash.com/photo-1626037032344-fb740102bbfa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1626037032344-fb740102bbfa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 337232, '2026-04-16 08:48:38', 1, '3', 0, NULL, NULL),
(147, 'Ett par svarta bilar som kör längs en gata', 'This is an example auction item.', 490, 'https://images.unsplash.com/photo-1632350456732-6e0b9ee534bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1632350456732-6e0b9ee534bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 347996, '2026-04-16 08:48:38', 1, '3', 20, NULL, NULL),
(148, 'En liten vit bil parkerad på en parkeringsplats', 'This is an example auction item.', 250, 'https://images.unsplash.com/photo-1642489093729-6ffdbe356fdb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1642489093729-6ffdbe356fdb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 281634, '2026-04-16 08:48:38', 1, '3', 170, NULL, NULL),
(149, 'En raket på himlen', 'This is an example auction item.', 410, 'https://images.unsplash.com/photo-1662814558315-5ff94bb3e03c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1662814558315-5ff94bb3e03c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 487869, '2026-04-16 08:48:38', 1, '3', 100, NULL, NULL),
(150, 'En flagga på ett torn', 'This is an example auction item.', 870, 'https://images.unsplash.com/photo-1663616132732-d6d08b717322?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1663616132732-d6d08b717322?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 315231, '2026-04-16 08:48:38', 1, '3', 140, NULL, NULL),
(151, 'Ett parkeringsgarage fyllt med massor av bilar', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1681566820375-ed1eaa101a78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1681566820375-ed1eaa101a78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 218474, '2026-04-16 08:48:38', 1, '3', 90, NULL, NULL),
(152, 'En dubbeldäckarbuss parkerad vid en busshållplats', 'This is an example auction item.', 740, 'https://images.unsplash.com/photo-1689686083518-57012453e1fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689686083518-57012453e1fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 215903, '2026-04-16 08:48:38', 1, '3', 50, NULL, NULL),
(153, 'En röd och gul helikopter som flyger genom en blå himmel', 'This is an example auction item.', 400, 'https://images.unsplash.com/photo-1692176961746-e3b5aeb9669a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1692176961746-e3b5aeb9669a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 464221, '2026-04-16 08:48:38', 1, '3', 190, NULL, NULL),
(154, 'Ett svartvitt foto av en lastbil och en buss', 'This is an example auction item.', 410, 'https://images.unsplash.com/photo-1695119391036-36e21406db61?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1695119391036-36e21406db61?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 182385, '2026-04-16 08:48:38', 1, '3', 0, NULL, NULL),
(155, 'En vit buss som kör längs en gata bredvid höga byggnader', 'This is an example auction item.', 180, 'https://images.unsplash.com/photo-1695395848370-4dfad20d96bf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1695395848370-4dfad20d96bf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 427283, '2026-04-16 08:48:38', 1, '3', 50, NULL, NULL),
(156, 'Två bilar parkerade i ett parkeringsgarage bredvid varandra', 'This is an example auction item.', 910, 'https://images.unsplash.com/photo-1709595303000-8eac8137440f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1709595303000-8eac8137440f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 184069, '2026-04-16 08:48:38', 1, '3', 90, NULL, NULL),
(157, 'Ett par bilar parkerade bredvid varandra', 'This is an example auction item.', 512, 'https://images.unsplash.com/photo-1730904910637-0f30b15b5008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730904910637-0f30b15b5008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, 1, 331074, '2026-04-16 08:48:38', 1, '3', 20, NULL, NULL),
(158, 'Röd sportbil parkerad på trottoar', 'This is an example auction item.', 680, 'https://images.unsplash.com/photo-1755508138283-ce620211d733?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755508138283-ce620211d733?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 233954, '2026-04-16 08:48:38', 1, '3', 90, NULL, NULL),
(159, 'Porsche-emblemet med en häst- och stuttgart-text', 'This is an example auction item.', 580, 'https://images.unsplash.com/photo-1759784082315-cf16eaf54bd8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759784082315-cf16eaf54bd8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 551882, '2026-04-16 08:48:38', 1, '3', 0, NULL, NULL),
(160, 'Man som täcker ansiktet med handen i ökenlandskapet', 'This is an example auction item.', 550, 'https://images.unsplash.com/photo-1761131239571-b1fd759b5d89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1761131239571-b1fd759b5d89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', 1, NULL, 121880, '2026-04-16 08:48:38', 1, '3', 20, NULL, NULL),
(164, 'Fert', 'sad', 213, '/static/uploaded_images/me-selling-fert-v0-cxgd0xmqjcgg1.webp', '/static/uploaded_images/me-selling-fert-v0-cxgd0xmqjcgg1.webp', 1, NULL, 72, '2026-04-16 08:48:38', 1, '1', 0, 'Stockholm', 'new'),
(165, 'Fert', 'Its fert', 213, '/static/uploaded_images/me-selling-fert-v0-cxgd0xmqjcgg1.webp', '/static/uploaded_images/me-selling-fert-v0-cxgd0xmqjcgg1.webp', 1, NULL, 168, '2026-04-16 08:48:38', 1, '3', 0, 'Stockholm', 'like-new'),
(166, 'Vintage Table', 'Solid wood chair in great condition', 211, '/static/uploaded_images/20251201_110749.jpg', '/static/uploaded_images/20251201_110749.jpg', 1, NULL, 86400, '2026-04-16 08:48:38', 1, '2', 0, 'Stockholm', 'used'),
(167, 'Bob', 'very good man, handsome', 1221, '/static/uploaded_images/fly7.gif', '/static/uploaded_images/fly7.gif', 3, NULL, 240, '2026-04-16 08:48:38', 1, '1', 4, 'Florida', 'like-new'),
(168, 'Bob', 'very good man, handsome', 1221, '/static/uploaded_images/icon.png', '/static/uploaded_images/icon.png', 3, NULL, 240, '2026-04-16 08:48:38', 1, '1', 0, 'Florida', 'like-new'),
(170, 'Vintage Chair', 'Solid wood chair in great condition', 50, '/static/uploaded_images/20251201_110749.jpg', '/static/uploaded_images/20251201_110749.jpg', 1, NULL, 86400, '2026-04-16 08:48:38', 1, 'furniture', 0, 'Stockholm', 'used'),
(171, 'Vintage Chair', 'Solid wood chair in great condition', 50, '/static/uploaded_images/20251201_110749.jpg', '/static/uploaded_images/20251201_110749.jpg', 1, NULL, 86400, '2026-04-16 08:48:38', 1, '1', 0, 'Stockholm', 'used'),
(172, 'Vintage Chair', 'Solid wood chair in great condition', 50, '/static/uploaded_images/20251201_110749.jpg', '/static/uploaded_images/20251201_110749.jpg', 1, NULL, 86400, '2026-04-16 08:48:38', 1, '1', 0, 'Stockholm', 'used');

-- --------------------------------------------------------

--
-- Tabellstruktur `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `bids`
--

INSERT INTO `bids` (`id`, `auction_id`, `user_id`, `price`) VALUES
(1, 157, 1, 491),
(2, 157, 1, 512),
(3, 123, 1, 648),
(4, 133, 1, 120),
(5, 133, 1, 122);

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
(1, 'toys'),
(2, 'antiques'),
(3, 'vehicles');

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `account_created` date DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `last_name`, `first_name`, `city`, `account_created`, `email`, `password`) VALUES
(1, 'Bergström', 'Anton', 'Stockholm', NULL, 'admin@tradee.com', '$2b$12$d3mk1tf01IztwDh6nU3SM.DPQx0HygabgPr82KNd1Ql0pDsJO.r1y'),
(3, 'Man', 'Florida Man', 'Florida', '2026-03-13', 'test@example.com', '$2b$12$aygJ5xjazN5SRvCXgXxfzepz3kf7JR.yC.oOrxzap5unUgCSiPp1O'),
(4, 'Doe', 'Jane', 'Stockholm', '2026-03-13', 'jane@example.com', '$2b$12$g1CwGm3z52K878PWWp4tOOOU2kX8xqHcBelBB0YWHghLVWH63muu2'),
(6, 'Doe', 'Jane', 'Stockholm', '2026-03-14', 'jasdne@example.com', '$2b$12$PVjA5Z3i85sdHLW2OfyrO.xmda3QmemCHYMYpgsZbpKmzOFpFc8a.'),
(7, 'Doeber', 'Jane', 'Stockholm', '2026-03-14', 'jadssdne@example.com', '$2b$12$OwRpWc6Xwfqkou6MoIIvKeFCbclVUmfwbDt11FK7OL.HiyXXS4vVi');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `bids`
--
ALTER TABLE `bids`
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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `auctions`
--
ALTER TABLE `auctions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT för tabell `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT för tabell `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
