-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2025 at 11:39 AM
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
-- Database: `perfume`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `inventory_id` int(30) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(30) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `client_id`, `inventory_id`, `price`, `quantity`, `date_created`) VALUES
(14, 1, 21, 4600, 1, '2025-01-08 18:26:49');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(30) NOT NULL,
  `category` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `description`, `status`, `date_created`) VALUES
(11, 'MEN', '', 1, '2025-01-08 17:59:18'),
(13, 'UNISEX', '', 1, '2025-01-08 17:59:45'),
(14, 'WOMEN', '&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', 1, '2025-01-08 18:05:55');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(30) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `default_delivery_address` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `firstname`, `lastname`, `gender`, `contact`, `email`, `password`, `default_delivery_address`, `date_created`) VALUES
(1, 'John', 'Smith', 'Male', '09123456789', 'jsmith@sample.com', '1254737c076cf867dc53d60a0364f38e', 'Sample Address', '2021-06-21 16:00:23'),
(2, 'Ligaya', 'Ganda', 'Female', '09666423955', 'ligaya@gmail.com', '202cb962ac59075b964b07152d234b70', 'Cainta', '2025-01-06 08:21:55'),
(3, 'john', 'lenchico', 'Male', '0932133213', 'lenchico@gmail.com', '202cb962ac59075b964b07152d234b70', '828 Gerardo St Sampaloc', '2025-01-09 16:30:05');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `size` varchar(250) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `quantity`, `unit`, `price`, `size`, `date_created`, `date_updated`) VALUES
(21, 19, 10, 'ML', 4600, '200ML', '2025-01-08 18:24:03', '2025-01-08 18:26:34'),
(22, 20, 9, 'ML', 9200, '100ML', '2025-01-08 18:43:14', NULL),
(23, 21, 15, 'ML', 4350, '100ML', '2025-01-08 18:48:19', NULL),
(24, 22, 23, 'ML', 2999, '100ML', '2025-01-08 18:55:30', NULL),
(25, 23, 18, 'ML', 2950, '100ML', '2025-01-08 18:59:56', NULL),
(26, 24, 27, 'ML', 670, '96ML', '2025-01-08 19:05:55', NULL),
(27, 25, 11, 'ML', 3300, '90ML', '2025-01-08 19:28:39', NULL),
(28, 27, 8, 'ML', 2600, '125ML', '2025-01-08 20:07:05', NULL),
(29, 27, 9, 'ML', 3300, '200ML', '2025-01-08 20:07:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `delivery_address` text NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `amount` double NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `delivery_address`, `payment_method`, `amount`, `status`, `paid`, `date_created`, `date_updated`) VALUES
(10, 3, '828 Gerardo St Sampaloc', 'Cash on Delivery', 4600, 1, 1, '2025-01-09 16:30:43', '2025-01-14 18:12:37');

-- --------------------------------------------------------

--
-- Table structure for table `order_list`
--

CREATE TABLE `order_list` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `size` varchar(20) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `quantity` int(30) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `status` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(30) NOT NULL,
  `category_id` int(30) NOT NULL,
  `sub_category_id` int(30) NOT NULL,
  `product_name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `sub_category_id`, `product_name`, `description`, `status`, `date_created`) VALUES
(19, 11, 0, 'COACH FOR MEN EDT', '&lt;p&gt;&lt;span style=&quot;font-size: 18px;&quot;&gt;﻿Coach for Men by Coach is a Woody Aromatic fragrance for men. Coach for Men was launched in 2017. Coach for Men was created by Anne Flipo and Bruno Jovanovic. Top notes are Pear, Kumquat, Bergamot, Lavender and Grapefruit; middle notes are Cardamom, Geranium and Coriander; base notes are Ambergris, Suede, Amberwood and Haitian Vetiver.&lt;/span&gt;&lt;span style=&quot;font-size: 14px;&quot;&gt;﻿&lt;/span&gt;&lt;/p&gt;', 1, '2025-01-08 18:10:40'),
(20, 11, 0, 'SAUVAGE DIOR', '&lt;p&gt;Sauvage Eau de Parfum by Dior is a Amber Fougere fragrance for men. Sauvage Eau de Parfum was launched in 2018. The nose behind this fragrance is Francois Demachy. Top note is Bergamot; middle notes are Sichuan Pepper, Lavender, Star Anise and Nutmeg; base notes are Ambroxan and Vanilla.&lt;/p&gt;', 1, '2025-01-08 18:42:28'),
(21, 11, 0, 'VERSACE DYLAN BLUE MEN', '&lt;p&gt;Versace Pour Homme Dylan Blue by Versace is a Aromatic Fougere fragrance for men. Versace Pour Homme Dylan Blue was launched in 2016. The nose behind this fragrance is Alberto Morillas. Top notes are Calabrian bergamot, Water Notes, Grapefruit and Fig Leaf; middle notes are Ambroxan, Black Pepper, Patchouli, Violet Leaf and Papyrus; base notes are Incense, Musk, Tonka Bean and Saffron.&lt;/p&gt;', 1, '2025-01-08 18:47:45'),
(22, 13, 0, 'ECLAT MEN AND WOMAN FROM USA', '&lt;p&gt;Eclat d&#039;Arpege Pour Homme by Lanvin is a Citrus Aromatic fragrance for men. Eclat d&#039;Arpege Pour Homme was launched in 2015. The nose behind this fragrance is Sonia Constant. Top notes are Mandarin Orange, Lime and Bergamot; middle notes are Violet Leaf, Rosemary and Jasmine; base notes are Musk, Cedar and Sandalwood.&lt;/p&gt;', 1, '2025-01-08 18:54:56'),
(23, 14, 0, 'CLINIQUE HAPPY FOR WOMAN ALL TIME FAV ORIGINAL', '&lt;p&gt;Clinique Happy by Clinique is a Floral Fruity fragrance for women. Clinique Happy was launched in 1998. Clinique Happy was created by Jean Claude Delville and Rodrigo Flores-Roux. Top notes are Orange, Blood Grapefruit, Indian Mandarin, Bergamot, Apple and Plum; middle notes are Lily-of-the-Valley, Freesia, Orchid and Rose; base notes are Mimosa, Lily, Magnolia, Musk and Amber. Clinique Happy Heart 2003 by Clinique is a Chypre Floral fragrance for women. Clinique Happy Heart 2003 was launched in 2003. Clinique Happy Heart 2003 was created by Christophe Laudamiel and Olivier Polge. Top notes are Cucumber, Mandarin Orange and Cassia; middle notes are Water Hyacinth and Carrot; base notes are White Woods and Sandalwood.&lt;/p&gt;', 1, '2025-01-08 18:59:12'),
(24, 14, 0, 'JOVAN BLACK MUSK ', '&lt;p&gt;ALL FROM US ALL TIME FAVORITE DURING 80-90&#039;S&lt;/p&gt;', 1, '2025-01-08 19:05:19'),
(25, 14, 0, 'Coach Floral', '&lt;p&gt;Coach the Fragrance by Coach is a Floral fragrance for women. Coach the Fragrance was launched in 2016. Coach the Fragrance was created by Juliette Karagueuzoglou and Anne Flipo. Top notes are Raspberry Leaf, Pear and Pink Pepper; middle notes are Turkish Rose, Gardenia and Cyclamen; base notes are Suede, Musk, Cashmeran and Sandalwood.&lt;/p&gt;', 1, '2025-01-08 19:11:58'),
(27, 13, 0, 'DavidOff COOL WATER ', '&lt;p&gt;The scent unfolds with aromatic notes of mint and lavender, blended with the sensuality of amber. A unique composition, crafted with more than 18 natural ingredients, that delivers an immediate freshness. Cool Water, your ultimate blend of freshness, sexiness and power&lt;/p&gt;', 1, '2025-01-08 20:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `total_amount` double NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` int(30) NOT NULL,
  `size` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `email`, `password`) VALUES
(1, 'jkl', 'gon@gmail.com', '$2y$10$KGJWyIc0y1J79cEqt9lBgu3XO9ocuPAWTIlhTy9JX3JqinK4NWtp6'),
(2, 'man', 'man@gmail.com', '$2y$10$zE2PmBMmJjKpi4ZCfz90K.0qkrT55o9j2j3xBqBvzrkFuj4cqylim'),
(3, 'asd', 'asd@gmail.com', '$2y$10$23XydSWmujpuJtrbuqTYe.o4yFdo5S8z2hIQ1BPwMsTRhUQjCMeDu');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(30) NOT NULL,
  `parent_id` int(30) NOT NULL,
  `sub_category` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `parent_id`, `sub_category`, `description`, `status`, `date_created`) VALUES
(13, 15, 'COACH', '', 1, '2025-01-08 19:08:09'),
(14, 15, 'SAUVAGE DIOR', '', 1, '2025-01-08 19:08:28'),
(15, 15, 'VERSACE DYLAN BLUE MEN', '', 1, '2025-01-08 19:08:44');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(11) NOT NULL,
  `meta_field` varchar(255) NOT NULL,
  `meta_value` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`, `created_at`) VALUES
(1, 'site_name', 'My Perfume Store', '2025-01-08 11:20:21'),
(2, 'logo', 'uploads/1736335560_Screenshot 2025-01-08 192634.png', '2025-01-08 11:20:21'),
(3, 'cover', 'uploads/1736335560_Screenshot 2025-01-08 192149.png', '2025-01-08 11:20:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1624240500_avatar.png', NULL, 1, '2021-01-20 14:02:37', '2021-06-21 09:55:07'),
(4, 'John', 'Smith', 'jsmith', '1254737c076cf867dc53d60a0364f38e', NULL, NULL, 0, '2021-06-19 08:36:09', '2021-06-19 10:53:12'),
(5, 'Claire', 'Blake', 'cblake', '4744ddea876b11dcb1d169fadf494418', NULL, NULL, 0, '2021-06-19 10:01:51', '2021-06-19 12:03:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_list`
--
ALTER TABLE `order_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
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
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_list`
--
ALTER TABLE `order_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
