-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2026 at 03:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tradee_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auctions`
--

CREATE TABLE `auctions` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(512) NOT NULL,
  `price` int(11) NOT NULL,
  `image_small` varchar(256) NOT NULL,
  `image_regular` varchar(256) NOT NULL,
  `item_condition` varchar(128) NOT NULL,
  `location` varchar(128) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `leader_id` int(11) DEFAULT NULL,
  `auction_time` int(11) NOT NULL,
  `published_at` datetime NOT NULL,
  `published` tinyint(1) NOT NULL,
  `category_id` varchar(128) DEFAULT NULL,
  `views` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auctions`
--

INSERT INTO `auctions` (`id`, `name`, `description`, `price`, `image_small`, `image_regular`, `item_condition`, `location`, `owner_id`, `leader_id`, `auction_time`, `published_at`, `published`, `category_id`, `views`) VALUES
(101, 'Gul och svart robotleksak', 'This is an example auction item.', 80, 'https://images.unsplash.com/photo-1593085512500-5d55148d6f0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1593085512500-5d55148d6f0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 558174, '2026-03-04 08:46:45', 1, '1', 10),
(102, 'Svart och röd motorcykelhjälm', 'This is an example auction item.', 234, 'https://images.unsplash.com/photo-1608889345749-630640d94426?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889345749-630640d94426?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, 1, 463761, '2026-03-04 08:46:46', 1, '1', 200),
(103, 'Röd och svart hjälm på svart och vit textil', 'This is an example auction item.', 210, 'https://images.unsplash.com/photo-1608889453743-bf8eabeb12fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1608889453743-bf8eabeb12fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 480222, '2026-03-04 08:46:47', 1, '1', 30),
(104, 'Kvinna i svart jacka som står på grå betongväg nära brunt tegelbyggnad under dagtid', 'This is an example auction item.', 30, 'https://images.unsplash.com/photo-1610098692961-e916be8f2901?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1610098692961-e916be8f2901?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 216530, '2026-03-04 08:46:47', 1, '1', 170),
(105, 'En blå leksaksbil som sitter ovanpå ett träbord', 'This is an example auction item.', 490, 'https://images.unsplash.com/photo-1631623299163-ba93c3cf3c1b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1631623299163-ba93c3cf3c1b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 108719, '2026-03-04 08:46:48', 1, '1', 100),
(106, 'En hög med röda och vita lego som ligger ovanpå varandra', 'This is an example auction item.', 360, 'https://images.unsplash.com/photo-1634578681002-3b744a3f7f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1634578681002-3b744a3f7f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 86430, '2026-03-04 08:46:49', 0, '1', 90),
(107, 'En leksaksfigur som sitter ovanpå en burk färg', 'This is an example auction item.', 900, 'https://images.unsplash.com/photo-1680940429127-a4b0944e8584?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1680940429127-a4b0944e8584?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 456022, '2026-03-04 08:46:49', 1, '1', 180),
(108, 'En svart bakgrund med rosa linjer och snöflingor', 'This is an example auction item.', 990, 'https://images.unsplash.com/photo-1689699544590-d23cb29dc3a7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689699544590-d23cb29dc3a7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 387119, '2026-03-04 08:46:50', 1, '1', 150),
(109, 'En närbild av ett rosa objekt på en svart bakgrund', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1689699544848-bbd44b6ff85c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689699544848-bbd44b6ff85c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 109779, '2026-03-04 08:46:51', 1, '1', 150),
(110, 'En hund som står på golvet med ett uppstoppat djur', 'This is an example auction item.', 500, 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1699150762670-c450be47426f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 322265, '2026-03-04 08:46:51', 1, '1', 110),
(111, 'En träskyltdocka som står framför en vägg', 'This is an example auction item.', 880, 'https://images.unsplash.com/photo-1705180502044-36ebb305974a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1705180502044-36ebb305974a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 197049, '2026-03-04 08:46:52', 1, '1', 200),
(112, 'En gummianka med solglasögon på huvudet som sitter bredvid en vattenpöl', 'This is an example auction item.', 600, 'https://images.unsplash.com/photo-1713830551089-cb57c85c5c40?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1713830551089-cb57c85c5c40?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 503331, '2026-03-04 08:46:52', 1, '1', 70),
(113, 'Ett par småfåglar som sitter ovanpå skrammel', 'This is an example auction item.', 390, 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1720535190566-89d1e2aa0e39?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 430167, '2026-03-04 08:46:53', 1, '1', 80),
(114, 'En seriefigur med rosa hår och en rosa outfit', 'This is an example auction item.', 430, 'https://images.unsplash.com/photo-1728729729215-00ae703063ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1728729729215-00ae703063ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 226133, '2026-03-04 08:46:54', 1, '1', 50),
(115, 'Lego star wars-figurer förbereder sig för strid.', 'This is an example auction item.', 240, 'https://images.unsplash.com/photo-1745483547576-3bb3ce24a24e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1745483547576-3bb3ce24a24e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 424924, '2026-03-04 08:46:54', 1, '1', 50),
(116, 'En snurrande fidget-leksak med en orange mitt.', 'This is an example auction item.', 520, 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1760507776802-358a3868cbb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 267377, '2026-03-04 08:46:55', 1, '1', 150),
(117, 'En plyschgrön julgran med färgglada ornament.', 'This is an example auction item.', 670, 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1764255281678-db10e34ff791?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 438431, '2026-03-04 08:46:55', 1, '1', 0),
(118, 'Liten butik med skyltfönster och öppen dörr.', 'This is an example auction item.', 150, 'https://images.unsplash.com/photo-1764351903979-4e3c59f03479?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1764351903979-4e3c59f03479?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 319087, '2026-03-04 08:46:56', 1, '1', 10),
(119, 'En tomte med röd hatt och luddigt skägg.', 'This is an example auction item.', 200, 'https://images.unsplash.com/photo-1766525457533-d165eb992a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1766525457533-d165eb992a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 96577, '2026-03-04 08:46:56', 1, '1', 80),
(120, 'Silhuett av en person som går in i en cirkulär tunnel', 'This is an example auction item.', 370, 'https://images.unsplash.com/photo-1769527818981-ed8961067a14?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1769527818981-ed8961067a14?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI4MDN8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 291835, '2026-03-04 08:46:57', 1, '1', 70),
(121, 'Svart och blå skivspelare på brunt träbord', 'This is an example auction item.', 460, 'https://images.unsplash.com/photo-1485726696757-76885c99f0f5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1485726696757-76885c99f0f5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 251695, '2026-03-04 08:48:31', 1, '2', 110),
(122, 'Böcker i brun bokhylla', 'This is an example auction item.', 10, 'https://images.unsplash.com/photo-1516888693095-f0e05366ddc6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1516888693095-f0e05366ddc6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 264006, '2026-03-04 08:48:31', 1, '2', 0),
(123, 'Beige fordon', 'This is an example auction item.', 550, 'https://images.unsplash.com/photo-1566935126136-2dc1c088e066?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1566935126136-2dc1c088e066?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 489783, '2026-03-04 08:48:33', 1, '2', 190),
(124, 'Brun tegelvägg under blå himmel under dagtid', 'This is an example auction item.', 860, 'https://images.unsplash.com/photo-1620831902801-9c518ca7d1ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1620831902801-9c518ca7d1ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 337577, '2026-03-04 08:48:33', 1, '2', 130),
(125, 'Svart och silver kamera på vit yta', 'This is an example auction item.', 530, 'https://images.unsplash.com/photo-1630951747824-c17e965fb4de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1630951747824-c17e965fb4de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 92708, '2026-03-04 08:48:34', 0, '2', 190),
(126, 'Ett svartvitt foto av en byggnad med en klocka', 'This is an example auction item.', 980, 'https://images.unsplash.com/photo-1641243519676-0bc3304be9ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1641243519676-0bc3304be9ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 200519, '2026-03-04 08:48:34', 1, '2', 170),
(127, 'En pool med paraplyer och ett vattenfall', 'This is an example auction item.', 440, 'https://images.unsplash.com/photo-1661207718083-5b13407cbe41?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1661207718083-5b13407cbe41?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 313311, '2026-03-04 08:48:35', 1, '2', 80),
(128, 'En byggnad med en skylt på', 'This is an example auction item.', 380, 'https://images.unsplash.com/photo-1662531916809-673923573549?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1662531916809-673923573549?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 523701, '2026-03-04 08:48:36', 1, '2', 30),
(129, 'En ljuskrona som hänger från ett tak i ett mörkt rum', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1674744540420-e94848013fa7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1674744540420-e94848013fa7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 147422, '2026-03-04 08:48:36', 1, '2', 10),
(130, 'En kvinna som håller ett barn på stranden', 'This is an example auction item.', 20, 'https://images.unsplash.com/photo-1693812205574-e441ed7f9c98?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1693812205574-e441ed7f9c98?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 518360, '2026-03-04 08:48:37', 1, '2', 20),
(131, 'En byrå i trä som sitter framför en butik', 'This is an example auction item.', 810, 'https://images.unsplash.com/photo-1698953704644-6fb636c6389d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1698953704644-6fb636c6389d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 382525, '2026-03-04 08:48:37', 1, '2', 90),
(132, 'En man och kvinna som håller ett litet barn', 'This is an example auction item.', 950, 'https://images.unsplash.com/photo-1730130596440-e9925840f028?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730130596440-e9925840f028?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 424022, '2026-03-04 08:48:38', 1, '2', 160),
(133, 'En närbild av en metalldörr med ett handtag', 'This is an example auction item.', 2147483647, 'https://images.unsplash.com/photo-1730634889417-56a2e7d50a75?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730634889417-56a2e7d50a75?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, 1, 181393, '2026-03-04 08:48:38', 0, '2', 130),
(134, 'En staty av en person i en kyrka', 'This is an example auction item.', 960, 'https://images.unsplash.com/photo-1733502985243-b721ea1b84c4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1733502985243-b721ea1b84c4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 306029, '2026-03-04 08:48:38', 1, '2', 70),
(135, 'Trasig utsmyckad skål med gyllene bas och blommig design', 'This is an example auction item.', 500, 'https://images.unsplash.com/photo-1755167348728-02cc5c45b355?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755167348728-02cc5c45b355?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 417578, '2026-03-04 08:48:38', 1, '2', 100),
(136, 'Hörn av en byggnad mot en klar himmel', 'This is an example auction item.', 640, 'https://images.unsplash.com/photo-1755900094171-4c446d65f8ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755900094171-4c446d65f8ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 480324, '2026-03-04 08:48:38', 1, '2', 170),
(137, 'En rad veteranbilar kör längs en trädkantad väg.', 'This is an example auction item.', 740, 'https://images.unsplash.com/photo-1757191462391-d43358c9ab3e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1757191462391-d43358c9ab3e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 386302, '2026-03-04 08:48:38', 1, '2', 20),
(138, 'Två väckarklockor med glödande ansikten på ett bord.', 'This is an example auction item.', 450, 'https://images.unsplash.com/photo-1759088731172-592a4ad90fe0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759088731172-592a4ad90fe0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 234467, '2026-03-04 08:48:38', 1, '2', 170),
(139, 'Utsmyckat historiskt monument med skulpterade figurer och djur.', 'This is an example auction item.', 890, 'https://images.unsplash.com/photo-1759937268759-2a9122b3b202?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759937268759-2a9122b3b202?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 305785, '2026-03-04 08:48:38', 1, '2', 100),
(140, 'Vintage glastallrik med abstrakta starburst-mönster', 'This is an example auction item.', 690, 'https://images.unsplash.com/photo-1765205134334-ddc94cc928f9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1765205134334-ddc94cc928f9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzI5MDh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 103712, '2026-03-04 08:48:38', 1, '2', 130),
(141, 'Tre olika färger chevrolet pickup lastbilar parkering nära byggnaden', 'This is an example auction item.', 550, 'https://images.unsplash.com/photo-1561122850-9f97268703ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1561122850-9f97268703ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 354629, '2026-03-04 08:48:38', 1, '3', 180),
(142, 'Vit bil parkerad på parkeringsplats under dagtid', 'This is an example auction item.', 690, 'https://images.unsplash.com/photo-1609141842470-c02b20381435?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1609141842470-c02b20381435?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 327236, '2026-03-04 08:48:38', 1, '3', 190),
(143, 'Röd ferrari-bil parkerad på trottoaren under dagtid', 'This is an example auction item.', 110, 'https://images.unsplash.com/photo-1619042822294-43580ae4620c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1619042822294-43580ae4620c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 253648, '2026-03-04 08:48:38', 1, '3', 140),
(144, 'Grön och vit volkswagen t-2 parkerad bredvid vit betongbyggnad under dagtid', 'This is an example auction item.', 960, 'https://images.unsplash.com/photo-1623587672045-0619ca96029f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1623587672045-0619ca96029f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 255593, '2026-03-04 08:48:38', 1, '3', 160),
(145, 'Röd och vit veteranbil på väg under dagtid', 'This is an example auction item.', 380, 'https://images.unsplash.com/photo-1625842129921-2be232dadd47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1625842129921-2be232dadd47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 378349, '2026-03-04 08:48:38', 1, '3', 60),
(146, 'Röd ferrari coupe parkerad bredvid svart bil', 'This is an example auction item.', 830, 'https://images.unsplash.com/photo-1626037032344-fb740102bbfa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1626037032344-fb740102bbfa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 337232, '2026-03-04 08:48:38', 1, '3', 0),
(147, 'Ett par svarta bilar som kör längs en gata', 'This is an example auction item.', 490, 'https://images.unsplash.com/photo-1632350456732-6e0b9ee534bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1632350456732-6e0b9ee534bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 347996, '2026-03-04 08:48:38', 1, '3', 20),
(148, 'En liten vit bil parkerad på en parkeringsplats', 'This is an example auction item.', 250, 'https://images.unsplash.com/photo-1642489093729-6ffdbe356fdb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1642489093729-6ffdbe356fdb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 281634, '2026-03-04 08:48:38', 1, '3', 170),
(149, 'En raket på himlen', 'This is an example auction item.', 410, 'https://images.unsplash.com/photo-1662814558315-5ff94bb3e03c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1662814558315-5ff94bb3e03c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 487869, '2026-03-04 08:48:38', 1, '3', 100),
(150, 'En flagga på ett torn', 'This is an example auction item.', 870, 'https://images.unsplash.com/photo-1663616132732-d6d08b717322?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1663616132732-d6d08b717322?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 315231, '2026-03-04 08:48:38', 1, '3', 140),
(151, 'Ett parkeringsgarage fyllt med massor av bilar', 'This is an example auction item.', 310, 'https://images.unsplash.com/photo-1681566820375-ed1eaa101a78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1681566820375-ed1eaa101a78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 218474, '2026-03-04 08:48:38', 1, '3', 90),
(152, 'En dubbeldäckarbuss parkerad vid en busshållplats', 'This is an example auction item.', 740, 'https://images.unsplash.com/photo-1689686083518-57012453e1fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1689686083518-57012453e1fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 215903, '2026-03-04 08:48:38', 1, '3', 50),
(153, 'En röd och gul helikopter som flyger genom en blå himmel', 'This is an example auction item.', 400, 'https://images.unsplash.com/photo-1692176961746-e3b5aeb9669a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1692176961746-e3b5aeb9669a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 464221, '2026-03-04 08:48:38', 1, '3', 190),
(154, 'Ett svartvitt foto av en lastbil och en buss', 'This is an example auction item.', 410, 'https://images.unsplash.com/photo-1695119391036-36e21406db61?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1695119391036-36e21406db61?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 182385, '2026-03-04 08:48:38', 1, '3', 0),
(155, 'En vit buss som kör längs en gata bredvid höga byggnader', 'This is an example auction item.', 180, 'https://images.unsplash.com/photo-1695395848370-4dfad20d96bf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1695395848370-4dfad20d96bf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 427283, '2026-03-04 08:48:38', 1, '3', 50),
(156, 'Två bilar parkerade i ett parkeringsgarage bredvid varandra', 'This is an example auction item.', 910, 'https://images.unsplash.com/photo-1709595303000-8eac8137440f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1709595303000-8eac8137440f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 184069, '2026-03-04 08:48:38', 0, '3', 90),
(157, 'Ett par bilar parkerade bredvid varandra', 'This is an example auction item.', 490, 'https://images.unsplash.com/photo-1730904910637-0f30b15b5008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1730904910637-0f30b15b5008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 331074, '2026-03-04 08:48:38', 1, '3', 20),
(158, 'Röd sportbil parkerad på trottoar', 'This is an example auction item.', 680, 'https://images.unsplash.com/photo-1755508138283-ce620211d733?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1755508138283-ce620211d733?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 233954, '2026-03-04 08:48:38', 1, '3', 90),
(159, 'Porsche-emblemet med en häst- och stuttgart-text', 'This is an example auction item.', 580, 'https://images.unsplash.com/photo-1759784082315-cf16eaf54bd8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1759784082315-cf16eaf54bd8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 551882, '2026-03-04 08:48:38', 1, '3', 0),
(160, 'Man som täcker ansiktet med handen i ökenlandskapet', 'This is an example auction item.', 550, 'https://images.unsplash.com/photo-1761131239571-b1fd759b5d89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=400', 'https://images.unsplash.com/photo-1761131239571-b1fd759b5d89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w4NjI0MTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE3Njk2NzMwMzh8&ixlib=rb-4.1.0&q=80&w=1080', '', '', 1, NULL, 121880, '2026-03-04 08:48:38', 1, '3', 20);

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `auction_id`, `user_id`, `price`) VALUES
(0, 123, 1, 5400),
(0, 102, 1, 152),
(0, 123, 1, 2500),
(0, 102, 1, 234),
(0, 133, 1, 2147483647);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'toys'),
(2, 'antiques'),
(3, 'vehicles');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `lastName` varchar(128) NOT NULL,
  `firstName` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `accountCreated` date DEFAULT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `lastName`, `firstName`, `city`, `email`, `accountCreated`, `password`) VALUES
(1, 'Bergström', 'Anton', 'Stockholm', 'admin@tradee.com', NULL, '$2b$12$4Y8eGKAWE6vSAPvckbOnGud8dal2D0.a.szGtqZJnFW.BwKuidHtC'),
(11, 'Albert', 'Eskil', 'Stockholm', 'Eskildmail@mail.com', NULL, '$2b$12$DjWk/I9HqU9dWtL7mLGMQeO1/1oFd7qCQor13i5uUT6We8cW7zUyq'),
(17, 'Doe', 'Man', 'Florida', 'email@email.email', '2026-03-05', '$2b$12$aeu0fwyc7dm1OlGHkjpkTe3c6/EkwIIvOrPXoDFE.oyYX6.G50cQC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
