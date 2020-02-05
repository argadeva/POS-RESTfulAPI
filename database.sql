-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2020 at 02:25 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos-restfulapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Food'),
(2, 'Drink'),
(3, 'Cake');

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `id` int(11) NOT NULL,
  `order_number` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sub_total` int(64) NOT NULL,
  `ppn` int(64) NOT NULL,
  `total` int(64) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `checkout`
--

INSERT INTO `checkout` (`id`, `order_number`, `user_id`, `sub_total`, `ppn`, `total`, `created_at`) VALUES
(1, '010410918', 1, 40000, 4000, 44000, '2020-02-05 17:45:56'),
(2, '010410919', 1, 30000, 3000, 33000, '2020-02-04 20:00:58'),
(3, '010410918', 1, 10000, 1000, 11000, '2020-02-01 20:02:36'),
(4, '010410917', 1, 10000, 1000, 11000, '2019-12-31 20:02:41');

-- --------------------------------------------------------

--
-- Table structure for table `checkout_detail`
--

CREATE TABLE `checkout_detail` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` int(64) NOT NULL,
  `qty` int(64) NOT NULL,
  `total` int(64) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `checkout_detail`
--

INSERT INTO `checkout_detail` (`id`, `order_id`, `product_id`, `price`, `qty`, `total`, `created_at`) VALUES
(2, 2, 2, 15000, 2, 30000, '2020-02-04 19:16:13'),
(3, 1, 2, 15000, 2, 30000, '2020-02-05 19:54:29'),
(4, 1, 1, 10000, 1, 10000, '2020-02-05 19:57:04'),
(5, 4, 1, 10000, 1, 10000, '2020-02-05 20:12:41'),
(6, 3, 1, 10000, 1, 10000, '2020-02-05 20:13:15');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `price` int(128) NOT NULL,
  `stock` int(128) NOT NULL,
  `category_id` int(11) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `image`, `price`, `stock`, `category_id`, `update_at`, `created_at`, `deleted`) VALUES
(1, 'Espresso', 'Espresso Coffe', 'http://localhost:1000/uploads/1580896408606-expresso.jpeg', 10000, 1, 2, '2020-02-05 16:53:28', '2020-02-05 16:53:28', 0),
(2, 'Coffe Latte', 'Coffe Latte', 'http://localhost:1000/uploads/1580896568095-coffe-latte.jpeg', 15000, 1, 2, '2020-02-05 16:56:08', '2020-02-05 16:56:08', 0),
(3, 'Cappucino', 'Cappucino Coffe', 'http://localhost:1000/uploads/1580896613266-cappucino.jpeg', 5000, 0, 2, '2020-02-05 16:56:53', '2020-02-05 16:56:53', 0),
(4, 'Red Velvet Latte', 'Red Velvet Latte', 'http://localhost:1000/uploads/1580896647072-red-velvet-latte.jpeg', 33000, 0, 2, '2020-02-05 16:57:27', '2020-02-05 16:57:27', 0),
(5, 'Choco Rhum', 'Choco Rhum Cake', 'http://localhost:1000/uploads/1580896684863-choco-rum.jpeg', 28000, 0, 3, '2020-02-05 16:58:04', '2020-02-05 16:58:04', 0),
(6, 'Black Forest', 'Black Forest Cake', 'http://localhost:1000/uploads/1580896711020-black-forest.jpeg', 30000, 0, 3, '2020-02-05 16:58:31', '2020-02-05 16:58:31', 0),
(7, 'Chicken Katsu Dabu-dabu', 'Chicken Katsu Dabu-dabu', 'http://localhost:1000/uploads/1580896744381-chiken-katsu-dabu-dabu.jpeg', 60000, 0, 1, '2020-02-05 16:59:04', '2020-02-05 16:59:04', 0),
(8, 'Salmon Truffle Teriyaki', 'Salmon Truffle Teriyaki', 'http://localhost:1000/uploads/1580896772138-salmon-teriyaki.jpeg', 60000, 0, 1, '2020-02-05 16:59:32', '2020-02-05 16:59:32', 0),
(9, 'Wiener Schnitzel', 'Wiener Schnitzel', 'http://localhost:1000/uploads/1580896798656-wiener-schnitzel.jpeg', 69000, 0, 1, '2020-02-05 16:59:58', '2020-02-05 16:59:58', 0);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `type` enum('in','out') NOT NULL,
  `qty` int(64) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `type`, `qty`, `description`) VALUES
(1, 1, 'in', 5, 're stock'),
(2, 2, 'in', 5, 're stock');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `token`) VALUES
(1, 'admin', 'admin@admin.com', '$2a$10$ZkU3ojX41XKegDe05N32out0eZTmnCxJYYukxphdT32eG0NYR5/eK', '1#eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHRzIjp7ImlkIjoxLCJuYW1lIjoiYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsInRva2VuIjoiMSNleUpoYkdjaU9pSklVekkxTmlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKeVpYTjFiSFJ6SWpwN0ltbGtJam94TENKdVlXMWxJam9pWVdSdGFXNGlMQ0psYldGcGJDSTZJbUZrYldsdVFHRmtiV2x1TG1OdmJTSXNJblJ2YTJWdUlqcHVkV3hzZlN3aWFXRjBJam94TlRnd09EazBNelV4TENKbGVIQWlPakUxT0RBNU1EVXhOVEY5LnhmMXRuNmJhdFNBaDJJOGFoT05RLWpFc3N4UjNqUXBXckpBWS1vN3JwTjQifSwiaWF0IjoxNTgwOTA0MjU5LCJleHAiOjE1ODA5MTUwNTl9.6XY3i7jaQHr9RJ72liue-UcY9RUPfgaZLyGrNhyuROk'),
(2, 'admin2', 'admin2@admin.com', '$2a$10$D63x.LVhl57W8YlAtQtcOeyFZVSC/WLPLWekPf4GkafVldZAuwgA6', '2#eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHRzIjp7ImlkIjoyLCJuYW1lIjoiYWRtaW4yIiwiZW1haWwiOiJhZG1pbjJAYWRtaW4uY29tIiwidG9rZW4iOm51bGx9LCJpYXQiOjE1ODA5MDc4NzgsImV4cCI6MTU4MDkxODY3OH0.VwoICECfnL5our3wBMf-UbrN5CBBeb20CF1Yaja8ZvY');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `checkout_detail`
--
ALTER TABLE `checkout_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `checkout_detail`
--
ALTER TABLE `checkout_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
