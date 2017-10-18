-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 18, 2017 at 08:22 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gx3`
--

-- --------------------------------------------------------

--
-- Table structure for table `accessories`
--

CREATE TABLE `accessories` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` int(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accessories`
--

INSERT INTO `accessories` (`id`, `name`, `price`, `created_at`, `updated_at`, `active`) VALUES
('10099', '6Kg Regulator', 1200, '2017-06-01 12:46:32', '2017-06-18 08:42:36', 1),
('10100', 'Acc', 12, '2017-07-29 19:00:32', '2017-07-29 19:00:32', 1),
('10101', '50Kg Regulator', 2850, '2017-06-01 12:55:54', '2017-06-01 12:55:54', 1),
('10102', '6Kg Cylinder', 3500, '2017-06-01 13:00:23', '2017-06-18 07:26:44', 1),
('10103', '13Kg Cylinder', 4500, '2017-06-01 13:00:43', '2017-06-01 13:00:43', 1),
('10104', '50Kg Cylinder', 10000, '2017-06-01 13:01:00', '2017-06-01 13:01:00', 1),
('10105', 'Hose Pipe /Meter', 350, '2017-06-01 13:01:28', '2017-06-01 13:01:28', 1),
('10106', 'Burner', 700, '2017-06-01 13:01:35', '2017-06-01 13:01:35', 1),
('10107', 'Grill', 500, '2017-06-01 13:01:45', '2017-06-01 13:01:45', 1),
('10108', '13Kg Regulator L/P', 1500, '2017-06-10 10:27:06', '2017-06-10 10:27:06', 1),
('10109', 'Oirere Acc', 129, '2017-07-30 12:02:43', '2017-07-30 12:02:43', 1),
('10110', 'EDOIO', 22, '2017-07-30 12:16:54', '2017-07-30 12:16:54', 1),
('10111', 'Pip', 145, '2017-07-30 14:01:04', '2017-07-30 14:01:04', 1),
('10112', 'Pip', 12, '2017-07-30 14:09:12', '2017-07-30 14:09:12', 1),
('10113', 'Edd', 2344, '2017-07-30 19:22:59', '2017-07-30 19:22:59', 1);

--
-- Triggers `accessories`
--
DELIMITER $$
CREATE TRIGGER `stock_account_acc` AFTER INSERT ON `accessories` FOR EACH ROW BEGIN
           CALL create_stock_account(NEW.id, 1, NEW.created_at, NEW.updated_at);
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `balance` double NOT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `balance` double NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `category`, `code`, `name`, `balance`, `active`, `created_at`, `updated_at`) VALUES
(1, 'EQUITY', 1, 'Cash Account', 50695, 1, '2016-06-22 08:04:26', '2017-10-12 07:13:38'),
(2, 'LIABILITY', 2, 'Mpesa Account', 35521, 1, '2016-06-22 08:04:51', '2017-09-05 13:22:13'),
(3, 'EQUITY', 3, 'Bank Account', 105000, 1, '2016-06-22 08:05:23', '2017-02-17 16:26:32'),
(4, 'INCOME', 100, 'Vincent Omwaka', 1200, 0, '2017-08-28 06:09:19', '2017-08-28 06:09:19'),
(5, 'ASSET', 1001, 'Fuel', 14650, 0, '2017-09-16 21:39:16', '2017-09-16 21:39:16'),
(6, 'ASSET', 1002, 'Fuel', 1200, 0, '2017-09-16 21:53:22', '2017-09-16 21:53:22'),
(7, 'ASSET', 1003, 'Accumulated Depreciation', 146000, 1, '2017-09-16 22:10:44', '2017-10-10 05:32:31'),
(8, 'EXPENSE', 3010, 'Petty Cash', 9998200, 1, '2017-09-29 10:25:14', '2017-09-29 10:25:26'),
(9, 'EXPENSE', 3050, 'General Expenses', 6000, 1, '2017-09-29 17:45:45', '2017-09-29 17:45:45');

-- --------------------------------------------------------

--
-- Table structure for table `account_transactions`
--

CREATE TABLE `account_transactions` (
  `id` int(10) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(255) NOT NULL,
  `account_debited` int(10) NOT NULL,
  `account_credited` int(10) NOT NULL,
  `bank_transaction_id` int(10) NOT NULL,
  `bank_statement_id` int(10) NOT NULL,
  `transaction_amount` float(8,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account_transactions`
--

INSERT INTO `account_transactions` (`id`, `transaction_date`, `description`, `account_debited`, `account_credited`, `bank_transaction_id`, `bank_statement_id`, `transaction_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, '2017-09-16', 'None', 1, 1, 0, 0, 18000.00, '', '2017-09-16 23:02:14', '2017-09-16 23:02:14'),
(2, '2017-09-29', 'Payed an outstanding Expense Claim', 2, 1, 0, 0, 450.00, '', '2017-09-29 10:11:31', '2017-09-29 10:11:31'),
(3, '2017-09-29', 'Bought office Bread', 5, 8, 0, 0, 150.00, '', '2017-09-29 10:32:27', '2017-09-29 10:32:27'),
(4, '2017-09-29', 'Bought office Bread', 5, 8, 0, 0, 150.00, '', '2017-09-29 10:35:37', '2017-09-29 10:35:37'),
(5, '2017-09-29', 'Bought office Bread', 5, 8, 0, 0, 150.00, '', '2017-09-29 10:39:16', '2017-09-29 10:39:16'),
(6, '2017-09-29', 'Bought office Bread', 5, 8, 0, 0, 150.00, '', '2017-09-29 10:39:31', '2017-09-29 10:39:31'),
(7, '2017-09-29', 'Bla', 5, 8, 0, 0, 450.00, '', '2017-09-29 10:42:12', '2017-09-29 10:42:12'),
(8, '2017-09-29', 'njsnd', 5, 8, 0, 0, 300.00, '', '2017-09-29 10:44:55', '2017-09-29 10:44:55'),
(9, '2017-09-29', 'Transferred cash from Fuel account to Petty Cash Account', 5, 5, 0, 0, 1000.00, '', '2017-09-29 10:46:24', '2017-09-29 10:46:24'),
(10, '2017-09-29', 'Transferred Money to Petty Cash Account from Ken Wango', 5, 2, 0, 0, 1000.00, '', '2017-09-29 10:47:28', '2017-09-29 10:47:28'),
(13, '2017-10-10', 'Bla', 5, 8, 0, 0, 150.00, '', '2017-10-10 15:21:21', '2017-10-10 15:21:21');

-- --------------------------------------------------------

--
-- Table structure for table `allowances`
--

CREATE TABLE `allowances` (
  `id` int(10) UNSIGNED NOT NULL,
  `allowance_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(10) NOT NULL,
  `asset_name` varchar(255) NOT NULL,
  `asset_number` varchar(255) NOT NULL,
  `purchase_date` date NOT NULL,
  `purchase_price` double(15,2) NOT NULL,
  `book_value` double(15,2) NOT NULL,
  `warranty_expiry` date NOT NULL,
  `serial_number` varchar(255) NOT NULL,
  `depreciation_start_date` date NOT NULL,
  `last_depreciated` date NOT NULL,
  `depreciation_method` varchar(255) NOT NULL,
  `averaging_method` varchar(255) NOT NULL,
  `salvage_value` double(15,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `rate` double(3,2) NOT NULL,
  `years` smallint(6) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`id`, `asset_name`, `asset_number`, `purchase_date`, `purchase_price`, `book_value`, `warranty_expiry`, `serial_number`, `depreciation_start_date`, `last_depreciated`, `depreciation_method`, `averaging_method`, `salvage_value`, `method`, `rate`, `years`, `status`, `created_at`, `updated_at`) VALUES
(1, 'sample asset2', 'AST_0001', '2017-09-16', 12000.00, 12000.00, '2018-09-16', 'JK45192OB86', '2017-09-16', '0000-00-00', 'SL', 'HALFYR', 2000.00, 'rate', 9.99, 0, '', '2017-09-16 22:04:33', '2017-09-16 22:04:33'),
(2, 'sample asset2', 'AST_0001', '2017-09-16', 12000.00, 12000.00, '2018-09-16', 'JK45192OB86', '2017-09-16', '0000-00-00', 'SL', 'HALFYR', 2000.00, 'rate', 9.99, 0, '', '2017-09-16 22:10:44', '2017-09-16 22:10:44'),
(3, 'sample asset2', 'AST_0001', '2017-09-16', 12000.00, 12000.00, '2018-09-16', 'JK45192OB86', '2017-09-16', '0000-00-00', 'SL', 'HALFYR', 2000.00, 'rate', 9.99, 0, '', '2017-09-16 22:11:10', '2017-09-16 22:11:10'),
(4, 'sample asset4', 'AST_0004', '2017-09-16', 12000.00, 12000.00, '2018-09-16', 'JK45192OB86', '2017-09-16', '0000-00-00', 'SL', 'HALFYR', 2000.00, 'rate', 9.99, 0, '', '2017-09-16 22:11:41', '2017-09-16 22:11:41'),
(5, 'Laptop', 'AST_0005', '2017-09-29', 70000.00, 70000.00, '2018-09-29', '12345678', '2017-09-29', '0000-00-00', 'SL', 'FULLMO', 1000.00, 'rate', 9.99, 0, '', '2017-09-29 10:16:21', '2017-09-29 10:16:21'),
(6, 'Laptop', 'AST_0006', '2017-10-10', 40000.00, 40000.00, '2018-10-10', '12345678', '2017-10-10', '0000-00-00', 'SL', 'FULLMO', 1.00, 'rate', 3.20, 0, '', '2017-10-10 05:32:31', '2017-10-10 05:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `assigndrivers`
--

CREATE TABLE `assigndrivers` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `time_out` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `driver` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact` int(10) UNSIGNED NOT NULL,
  `reg_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `oil_level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `water_level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fuel_level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tire_pressure` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `general_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `assigndrivers`
--

INSERT INTO `assigndrivers` (`id`, `date`, `time_out`, `driver`, `contact`, `reg_no`, `model`, `oil_level`, `water_level`, `fuel_level`, `tire_pressure`, `general_comments`, `created_at`, `updated_at`) VALUES
(1, '2016-11-21', '10:00AM', '3', 721446205, '1', 'XTRAIL', 'FULL', 'FULL', 'EMPTY', 'FLAT', 'THE DRIVER DOES NOT CARE', '2016-11-21 08:44:07', '2016-11-21 08:44:07');

-- --------------------------------------------------------

--
-- Table structure for table `assigned_roles`
--

CREATE TABLE `assigned_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `assigned_roles`
--

INSERT INTO `assigned_roles` (`id`, `user_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `audits`
--

CREATE TABLE `audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float(10,0) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `audits`
--

INSERT INTO `audits` (`id`, `date`, `user`, `action`, `entity`, `amount`, `description`, `created_at`, `updated_at`) VALUES
(1, '2017-10-11', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-11 08:43:30', '2017-10-11 08:43:30'),
(2, '2017-10-11', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-11 08:45:05', '2017-10-11 08:45:05'),
(3, '2017-10-11', 'superadmin', 'viewed journal entries', 'Journals', NULL, 'viewed journal entries in the system', '2017-10-11 08:48:48', '2017-10-11 08:48:48'),
(4, '2017-10-11', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-11 09:41:30', '2017-10-11 09:41:30'),
(5, '2017-10-11', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-11 09:59:20', '2017-10-11 09:59:20'),
(6, '2017-10-11', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-11 11:12:28', '2017-10-11 11:12:28'),
(7, '2017-10-11', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-11 13:14:56', '2017-10-11 13:14:56'),
(8, '2017-10-11', 'superadmin', 'viewed users', 'System', NULL, 'viewed system users', '2017-10-11 13:17:20', '2017-10-11 13:17:20'),
(9, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:25:22', '2017-10-11 13:25:22'),
(10, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:25:26', '2017-10-11 13:25:26'),
(11, '2017-10-11', 'superadmin', 'viewed mail configuration', 'Mail Configuration', NULL, 'viewed mail configuration in the system', '2017-10-11 13:25:33', '2017-10-11 13:25:33'),
(12, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:25:36', '2017-10-11 13:25:36'),
(13, '2017-10-11', 'superadmin', 'viewed mail configuration', 'Mail Configuration', NULL, 'viewed mail configuration in the system', '2017-10-11 13:25:41', '2017-10-11 13:25:41'),
(14, '2017-10-11', 'superadmin', 'viewed mail configuration', 'Mail Configuration', NULL, 'viewed mail configuration in the system', '2017-10-11 13:26:23', '2017-10-11 13:26:23'),
(15, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:26:25', '2017-10-11 13:26:25'),
(16, '2017-10-11', 'superadmin', 'viewed user roles', 'Roles', NULL, 'viewed user roles in the system', '2017-10-11 13:31:36', '2017-10-11 13:31:36'),
(17, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:31:38', '2017-10-11 13:31:38'),
(18, '2017-10-11', 'superadmin', 'viewed user roles', 'Roles', NULL, 'viewed user roles in the system', '2017-10-11 13:31:44', '2017-10-11 13:31:44'),
(19, '2017-10-11', 'superadmin', 'viewed a user role', 'Roles', NULL, 'viewed user role Admin in the system', '2017-10-11 13:31:48', '2017-10-11 13:31:48'),
(20, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:31:50', '2017-10-11 13:31:50'),
(21, '2017-10-11', 'superadmin', 'change system language', 'Language', NULL, 'changed system language to kiswahili', '2017-10-11 13:35:40', '2017-10-11 13:35:40'),
(22, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:35:53', '2017-10-11 13:35:53'),
(23, '2017-10-11', 'superadmin', 'change system language', 'Language', NULL, 'changed system language to english', '2017-10-11 13:36:01', '2017-10-11 13:36:01'),
(24, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 13:36:01', '2017-10-11 13:36:01'),
(25, '2017-10-11', 'superadmin', 'viewed stocks', 'Stocks', NULL, 'viewed stocks in the system', '2017-10-11 13:39:29', '2017-10-11 13:39:29'),
(26, '2017-10-11', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-11 13:45:10', '2017-10-11 13:45:10'),
(27, '2017-10-11', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-11 14:18:21', '2017-10-11 14:18:21'),
(28, '2017-10-11', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/10/0105 assigned to driverBett Obadiah in the system', '2017-10-11 14:30:09', '2017-10-11 14:30:09'),
(29, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 14:32:38', '2017-10-11 14:32:38'),
(30, '2017-10-11', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-11 14:45:45', '2017-10-11 14:45:45'),
(31, '2017-10-11', 'superadmin', 'viewed purchase orders', 'Purchase Order', NULL, 'viewed purchase orders in the system', '2017-10-11 14:52:02', '2017-10-11 14:52:02'),
(32, '2017-10-11', 'superadmin', 'viewed a purchase order', 'Purchase Order', NULL, 'viewed a purchase order, order number 2017/10/10/0106 in the system', '2017-10-11 14:52:05', '2017-10-11 14:52:05'),
(33, '2017-10-11', 'superadmin', 'viewed purchase orders', 'Purchase Order', NULL, 'viewed purchase orders in the system', '2017-10-11 14:59:18', '2017-10-11 14:59:18'),
(34, '2017-10-11', 'superadmin', 'viewed quotation', 'Quotation', NULL, 'viewed quotation for customer Wuduria order number 2017/09/26/0080 in the system', '2017-10-11 15:34:20', '2017-10-11 15:34:20'),
(35, '2017-10-11', 'superadmin', 'created payment', 'Payments', NULL, 'created payment for client Wuduria, order number 2017/09/26/0080, amount 2000 in the system', '2017-10-11 15:48:10', '2017-10-11 15:48:10'),
(36, '2017-10-11', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-11 15:48:10', '2017-10-11 15:48:10'),
(37, '2017-10-11', 'superadmin', 'viewed user roles', 'Roles', NULL, 'viewed user roles in the system', '2017-10-11 15:48:17', '2017-10-11 15:48:17'),
(38, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 15:48:20', '2017-10-11 15:48:20'),
(39, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 15:52:33', '2017-10-11 15:52:33'),
(40, '2017-10-11', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-11 15:54:16', '2017-10-11 15:54:16'),
(41, '2017-10-11', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-11 16:00:34', '2017-10-11 16:00:34'),
(42, '2017-10-11', 'superadmin', 'viewed daily payments', 'Payments', NULL, 'viewed daily payments in the system', '2017-10-11 16:00:40', '2017-10-11 16:00:40'),
(43, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 16:00:49', '2017-10-11 16:00:49'),
(44, '2017-10-11', 'superadmin', 'viewed daily payments report', 'Payments', NULL, 'viewed daily payments report in the system', '2017-10-11 16:01:14', '2017-10-11 16:01:14'),
(45, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 16:01:20', '2017-10-11 16:01:20'),
(46, '2017-10-11', 'superadmin', 'viewed daily payments report', 'Payments', NULL, 'viewed daily payments report in the system', '2017-10-11 16:21:10', '2017-10-11 16:21:10'),
(47, '2017-10-11', 'superadmin', 'viewed bank balances report', 'Account', NULL, 'viewed bank balances report in the system', '2017-10-11 16:21:18', '2017-10-11 16:21:18'),
(48, '2017-10-11', 'superadmin', 'viewed daily payments report', 'Payments', NULL, 'viewed daily payments report in the system', '2017-10-11 16:25:39', '2017-10-11 16:25:39'),
(49, '2017-10-11', 'superadmin', 'viewed bank balances report', 'Account', NULL, 'viewed bank balances report in the system', '2017-10-11 16:26:02', '2017-10-11 16:26:02'),
(50, '2017-10-11', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-11 16:26:09', '2017-10-11 16:26:09'),
(51, '2017-10-11', 'superadmin', 'viewed bank balances report', 'Account', NULL, 'viewed bank balances report in the system', '2017-10-11 16:26:20', '2017-10-11 16:26:20'),
(52, '2017-10-11', 'superadmin', 'viewed account balances report', 'Account', NULL, 'viewed account balances report in the system', '2017-10-11 16:28:18', '2017-10-11 16:28:18'),
(53, '2017-10-11', 'superadmin', 'viewed account balances report', 'Account', NULL, 'viewed account balances report in the system', '2017-10-11 16:29:52', '2017-10-11 16:29:52'),
(54, '2017-10-11', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-11 16:31:42', '2017-10-11 16:31:42'),
(55, '2017-10-11', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-11 17:06:05', '2017-10-11 17:06:05'),
(56, '2017-10-12', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-12 06:18:40', '2017-10-12 06:18:40'),
(57, '2017-10-12', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-12 06:21:58', '2017-10-12 06:21:58'),
(58, '2017-10-12', 'superadmin', 'created sales order', 'Sales Order', NULL, 'created a sales order with order number 2017/10/12/0108 for client Wuduria in the system', '2017-10-12 06:22:14', '2017-10-12 06:22:14'),
(59, '2017-10-12', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-12 06:22:15', '2017-10-12 06:22:15'),
(60, '2017-10-12', 'superadmin', 'viewed audit trails', 'Audit Trails', NULL, 'viewed audit trails in the system', '2017-10-12 06:22:27', '2017-10-12 06:22:27'),
(61, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:13:11', '2017-10-12 07:13:11'),
(62, '2017-10-12', 'superadmin', 'created payment', 'Payments', NULL, 'created payment for client Wuduria, order number 2017/09/26/0080, amount 2000 in the system', '2017-10-12 07:13:38', '2017-10-12 07:13:38'),
(63, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:13:38', '2017-10-12 07:13:38'),
(64, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:15:23', '2017-10-12 07:15:23'),
(65, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:15:48', '2017-10-12 07:15:48'),
(66, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:16:16', '2017-10-12 07:16:16'),
(67, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:17:20', '2017-10-12 07:17:20'),
(68, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:17:41', '2017-10-12 07:17:41'),
(69, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:18:39', '2017-10-12 07:18:39'),
(70, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:57:46', '2017-10-12 07:57:46'),
(71, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:58:39', '2017-10-12 07:58:39'),
(72, '2017-10-12', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-12 07:58:47', '2017-10-12 07:58:47'),
(73, '2017-10-16', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-16 09:55:01', '2017-10-16 09:55:01'),
(74, '2017-10-16', 'superadmin', 'viewed clients` discount prices', 'Prices', NULL, 'viewed clients` discount prices in the system', '2017-10-16 11:14:09', '2017-10-16 11:14:09'),
(75, '2017-10-16', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-16 11:14:31', '2017-10-16 11:14:31'),
(76, '2017-10-16', 'superadmin', 'viewed clients` discount prices', 'Prices', NULL, 'viewed clients` discount prices in the system', '2017-10-16 11:14:50', '2017-10-16 11:14:50'),
(77, '2017-10-16', 'superadmin', 'created a client discount price', 'Prices', NULL, 'created a client discount price for client Wuduria item  13kgs gas refill amount 500 in the system', '2017-10-16 11:15:00', '2017-10-16 11:15:00'),
(78, '2017-10-16', 'superadmin', 'viewed clients` discount prices', 'Prices', NULL, 'viewed clients` discount prices in the system', '2017-10-16 11:15:01', '2017-10-16 11:15:01'),
(79, '2017-10-16', 'superadmin', 'viewed payments', 'Payments', NULL, 'viewed payments in the system', '2017-10-16 11:15:08', '2017-10-16 11:15:08'),
(80, '2017-10-16', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-16 13:02:24', '2017-10-16 13:02:24'),
(81, '2017-10-16', 'superadmin', 'viewed a sales order', 'Sales Order', NULL, 'viewed a sale order for customer Wuduria order number 2017/10/12/0108 in the system', '2017-10-16 13:02:33', '2017-10-16 13:02:33'),
(82, '2017-10-16', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-16 13:03:48', '2017-10-16 13:03:48'),
(83, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:15:49', '2017-10-17 07:15:49'),
(84, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:16:49', '2017-10-17 07:16:49'),
(85, '2017-10-17', 'superadmin', 'updated a client', 'Clients', NULL, 'updated client Wuduria in the system', '2017-10-17 07:17:38', '2017-10-17 07:17:38'),
(86, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:17:38', '2017-10-17 07:17:38'),
(87, '2017-10-17', 'superadmin', 'updated a client', 'Clients', NULL, 'updated client Wuduria in the system', '2017-10-17 07:20:36', '2017-10-17 07:20:36'),
(88, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:20:36', '2017-10-17 07:20:36'),
(89, '2017-10-17', 'superadmin', 'created a client', 'Clients', NULL, 'created client ken in the system', '2017-10-17 07:22:15', '2017-10-17 07:22:15'),
(90, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:22:15', '2017-10-17 07:22:15'),
(91, '2017-10-17', 'superadmin', 'updated a client', 'Clients', NULL, 'updated client ken in the system', '2017-10-17 07:22:28', '2017-10-17 07:22:28'),
(92, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:22:30', '2017-10-17 07:22:30'),
(93, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:27:40', '2017-10-17 07:27:40'),
(94, '2017-10-17', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-17 07:29:51', '2017-10-17 07:29:51'),
(95, '2017-10-17', 'superadmin', 'viewed a sales order', 'Sales Order', NULL, 'viewed a sale order for customer Wuduria order number 2017/10/12/0108 in the system', '2017-10-17 07:29:57', '2017-10-17 07:29:57'),
(96, '2017-10-17', 'superadmin', 'viewed quotation', 'Quotation', NULL, 'viewed quotation for customer Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:30:08', '2017-10-17 07:30:08'),
(97, '2017-10-17', 'superadmin', 'viewed invoice', 'Invoice', NULL, 'viewed invoice for client Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:30:15', '2017-10-17 07:30:15'),
(98, '2017-10-17', 'superadmin', 'viewed invoice', 'Invoice', NULL, 'viewed invoice for client Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:31:34', '2017-10-17 07:31:34'),
(99, '2017-10-17', 'superadmin', 'viewed invoice', 'Invoice', NULL, 'viewed invoice for client Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:32:27', '2017-10-17 07:32:27'),
(100, '2017-10-17', 'superadmin', 'viewed invoice', 'Invoice', NULL, 'viewed invoice for client Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:35:03', '2017-10-17 07:35:03'),
(101, '2017-10-17', 'superadmin', 'viewed invoice', 'Invoice', NULL, 'viewed invoice for client Wuduria order number 2017/09/26/0080 in the system', '2017-10-17 07:37:55', '2017-10-17 07:37:55'),
(102, '2017-10-17', 'superadmin', 'viewed purchase orders', 'Purchase Order', NULL, 'viewed purchase orders in the system', '2017-10-17 07:38:49', '2017-10-17 07:38:49'),
(103, '2017-10-17', 'superadmin', 'viewed sales targets', 'Sales Target', NULL, 'viewed sales targets in the system', '2017-10-17 07:38:50', '2017-10-17 07:38:50'),
(104, '2017-10-17', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-17 07:38:52', '2017-10-17 07:38:52'),
(105, '2017-10-17', 'superadmin', 'viewed a sales order', 'Sales Order', NULL, 'viewed a sale order for customer Wuduria order number 2017/10/12/0108 in the system', '2017-10-17 07:38:56', '2017-10-17 07:38:56'),
(106, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 07:39:00', '2017-10-17 07:39:00'),
(107, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:42:54', '2017-10-17 07:42:54'),
(108, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:43:54', '2017-10-17 07:43:54'),
(109, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:44:03', '2017-10-17 07:44:03'),
(110, '2017-10-17', 'superadmin', 'viewed a client details', 'Clients', NULL, 'viewed client details for client Wuduria in the system', '2017-10-17 07:44:07', '2017-10-17 07:44:07'),
(111, '2017-10-17', 'superadmin', 'viewed a client details', 'Clients', NULL, 'viewed client details for client Wuduria in the system', '2017-10-17 07:44:50', '2017-10-17 07:44:50'),
(112, '2017-10-17', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-17 07:44:59', '2017-10-17 07:44:59'),
(113, '2017-10-17', 'superadmin', 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 07:45:03', '2017-10-17 07:45:03'),
(114, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 07:48:36', '2017-10-17 07:48:36'),
(115, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 07:49:45', '2017-10-17 07:49:45'),
(116, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 07:53:09', '2017-10-17 07:53:09'),
(117, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 07:57:45', '2017-10-17 07:57:45'),
(118, '2017-10-17', 'superadmin', 'viewed sales orders', 'Sales Orders', NULL, 'viewed sales orders in the system', '2017-10-17 08:01:00', '2017-10-17 08:01:00'),
(119, '2017-10-17', 'superadmin', 'viewed a sales order', 'Sales Order', NULL, 'viewed a sale order for customer Wuduria order number 2017/10/12/0108 in the system', '2017-10-17 08:01:04', '2017-10-17 08:01:04'),
(120, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 08:01:07', '2017-10-17 08:01:07'),
(121, '2017-10-17', 'superadmin', 'viewed delivery note', 'Delivery Note', NULL, 'viewed delivery note for order 2017/10/12/0108 assigned to driver Bett Obadiah in the system', '2017-10-17 08:05:37', '2017-10-17 08:05:37'),
(122, '2017-10-17', 'superadmin', 'viewed accounts', 'Accounts', NULL, 'viewed chart of accounts in the system', '2017-10-17 08:11:24', '2017-10-17 08:11:24'),
(123, '2017-10-17', 'superadmin', 'viewed expenses', 'Expenses', NULL, 'viewed expenses in the system', '2017-10-17 08:11:30', '2017-10-17 08:11:30'),
(124, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 09:34:05', '2017-10-17 09:34:05'),
(125, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 09:44:59', '2017-10-17 09:44:59'),
(126, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:03:33', '2017-10-17 10:03:33'),
(127, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:06:04', '2017-10-17 10:06:04'),
(128, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:06:06', '2017-10-17 10:06:06'),
(129, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:07:34', '2017-10-17 10:07:34'),
(130, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:08:21', '2017-10-17 10:08:21'),
(131, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:08:47', '2017-10-17 10:08:47'),
(132, '2017-10-17', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-17 10:09:20', '2017-10-17 10:09:20'),
(133, '2017-10-18', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-18 03:12:09', '2017-10-18 03:12:09'),
(134, '2017-10-18', NULL, 'viewed clients', 'Clients', NULL, 'viewed clients in the system', '2017-10-18 03:18:40', '2017-10-18 03:18:40');

-- --------------------------------------------------------

--
-- Table structure for table `authentications`
--

CREATE TABLE `authentications` (
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(75) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authentications`
--

INSERT INTO `authentications` (`username`, `password`, `created_at`, `updated_at`) VALUES
('gasexpress', 'e10adc3949ba59abbe56e057f20f883e', '2017-07-26 23:45:17', '2017-07-26 23:45:17'),
('eddie', '$2y$10$13dw78mS6gE/NobD8luLCeKYOwcYmiB2sBh3cI9b36k2ctxVV9sjq', '2017-07-27 09:00:15', '2017-07-27 09:00:15');

-- --------------------------------------------------------

--
-- Table structure for table `autoprocesses`
--

CREATE TABLE `autoprocesses` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banking`
--

CREATE TABLE `banking` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_from` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_to` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` int(10) UNSIGNED NOT NULL,
  `bank_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `bank_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Equity Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Krep Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'CO-Operative Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'Family Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'Barclays Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 'Kenya Commercial Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'Chase Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 'Bank of Africa', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 'COnsolidated Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 'CFC Stanbic Holdings Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 'Diamond Trust Bank', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(10) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `bank_name`, `account_name`, `account_number`, `created_at`, `updated_at`) VALUES
(1, 'EQUITY BANK', 'COOPERATE', '0011197895456002', '2017-09-16 21:46:41', '2017-09-16 21:46:41');

-- --------------------------------------------------------

--
-- Table structure for table `bank_branches`
--

CREATE TABLE `bank_branches` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `bank_branch_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_statements`
--

CREATE TABLE `bank_statements` (
  `id` int(10) NOT NULL,
  `bank_account_id` int(10) NOT NULL,
  `bal_bd` float(8,2) NOT NULL,
  `adj_bal_bd` float(8,2) NOT NULL,
  `stmt_month` varchar(255) NOT NULL,
  `is_reconciled` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Head Office', '2016-06-22 07:30:26', '2016-06-22 07:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `bulk_gas`
--

CREATE TABLE `bulk_gas` (
  `price` float NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bulk_gas`
--

INSERT INTO `bulk_gas` (`price`, `created_at`, `updated_at`, `id`) VALUES
(125, '2017-06-01 13:01:54', '2017-07-31 04:42:38', 10099);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calculation_method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `percentage_of` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float(10,0) NOT NULL,
  `fee` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `disabled` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charge_loanproduct`
--

CREATE TABLE `charge_loanproduct` (
  `id` int(10) UNSIGNED NOT NULL,
  `charge_id` int(10) UNSIGNED NOT NULL,
  `loanproduct_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charge_savingproduct`
--

CREATE TABLE `charge_savingproduct` (
  `id` int(10) UNSIGNED NOT NULL,
  `charge_id` int(10) UNSIGNED NOT NULL,
  `savingproduct_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `claim_receipts`
--

CREATE TABLE `claim_receipts` (
  `id` int(10) NOT NULL,
  `claim_id` int(10) NOT NULL,
  `receipt_from` varchar(255) NOT NULL,
  `transaction_date` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `claim_receipts`
--

INSERT INTO `claim_receipts` (`id`, `claim_id`, `receipt_from`, `transaction_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Vincent', '2017-09-16', 'Awaiting Payment', '2017-09-29 14:48:40', '2017-09-29 17:48:40'),
(2, 1, 'Vincent', '2017-09-16', 'Awaiting Payment', '2017-09-29 14:48:40', '2017-09-29 17:48:40'),
(3, 2, 'Ken wango', '2017-09-29', 'Payed', '2017-09-29 10:11:31', '2017-09-29 10:11:31'),
(4, 3, 'ken', '2017-10-10', 'Payed', '2017-10-10 06:34:23', '2017-10-10 06:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `claim_receipt_items`
--

CREATE TABLE `claim_receipt_items` (
  `id` int(10) NOT NULL,
  `claimReceiptID` int(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(10) NOT NULL,
  `unit_price` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `claim_receipt_items`
--

INSERT INTO `claim_receipt_items` (`id`, `claimReceiptID`, `description`, `quantity`, `unit_price`, `created_at`, `updated_at`) VALUES
(1, 2, 'None', 10, 12000, '2017-09-16 22:27:31', '2017-09-16 22:27:31'),
(2, 3, 'Water', 1, 450, '2017-09-29 10:00:41', '2017-09-29 10:00:41'),
(3, 4, 'water', 1, 450, '2017-10-10 06:25:39', '2017-10-10 06:25:39');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_person` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_person_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_person_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `percentage_discount` double NOT NULL DEFAULT '0',
  `balance` double NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `code`, `name`, `date`, `email`, `phone`, `address`, `contact_person`, `contact_person_phone`, `contact_person_email`, `type`, `percentage_discount`, `balance`, `created_at`, `updated_at`, `category`, `category1`, `credit`) VALUES
(1, '59689684', 'Wuduria', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 07:55:53', '2017-10-17 07:20:34', '', '', NULL),
(2, NULL, 'Jenniffer Kioko', '2016-06-22', '', '0720299250', 'ngong view apertment;kilimani rd;hse C2', '', '', '', 'Customer', 0, 0, '2016-06-22 07:57:04', '2016-06-22 07:57:04', '', '', NULL),
(3, NULL, 'Korean resturant', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 07:57:34', '2016-06-22 07:57:34', '', '', NULL),
(4, NULL, 'Railways club', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 07:57:54', '2016-06-22 07:57:54', '', '', NULL),
(5, NULL, 'Lulu Abdulahi', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 07:58:22', '2016-06-22 07:58:22', '', '', NULL),
(6, NULL, 'Glevak Investment Ltd', '2016-06-22', '', '', '', '', '', '', 'Supplier', 0, 0, '2016-06-22 07:58:54', '2016-06-22 07:58:54', '', '', NULL),
(7, NULL, 'Ann Emily ', '2016-06-22', '', '0721615182', 'Roshani building; Jabavu road;black gate grey wall', '', '', '', 'Customer', 0, 0, '2016-06-22 07:59:48', '2016-06-22 08:00:29', '', '', NULL),
(8, NULL, 'Grace House yaya', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 12:34:09', '2016-06-22 12:34:09', '', '', NULL),
(9, NULL, 'C/O Timon', '2016-06-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-22 13:51:19', '2016-06-22 13:51:19', '', '', NULL),
(10, NULL, 'Hass', '2016-06-23', '', '', '', '', '', '', 'Supplier', 0, 0, '2016-06-23 05:25:37', '2016-06-23 05:25:37', '', '', NULL),
(11, NULL, 'Mary Colary', '2016-06-23', '', '0738148908', 'Lavington; muthangari rd;Chelby Drive', '', '', '', 'Customer', 0, 0, '2016-06-23 05:30:33', '2016-06-23 05:30:33', '', '', NULL),
(12, NULL, 'Roselyne/ Paul mugambi', '2016-06-23', '', '0721403474/ 0722990540', 'ndemi road; MNG Apt; Hse no. A5', '', '', '', 'Customer', 0, 0, '2016-06-23 05:32:27', '2016-06-23 05:32:27', '', '', NULL),
(13, NULL, 'Anhur/Arif', '2016-06-23', '', '0710312334', 'Brook house', '', '', '', 'Customer', 0, 0, '2016-06-23 05:35:27', '2016-06-23 05:35:27', '', '', NULL),
(14, NULL, 'Nustrat/Blueridge Equipments ltd', '2016-06-23', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-23 05:36:05', '2016-06-23 05:36:05', '', '', NULL),
(15, NULL, 'Carol Mwende', '2016-06-23', '', '', 'Wanye road', '', '', '', 'Customer', 0, 0, '2016-06-23 09:16:45', '2016-06-23 09:16:45', '', '', NULL),
(16, NULL, 'Sam Gakunga', '2016-06-23', '', '', 'Kayawi court; kayawi road; hse.A5', '', '', '', 'Customer', 0, 0, '2016-06-23 09:17:34', '2016-06-23 09:17:34', '', '', NULL),
(17, NULL, 'Zodiac club', '2016-06-23', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-23 09:20:07', '2016-06-23 09:20:07', '', '', NULL),
(18, NULL, 'Hotel Riverview', '2016-06-23', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-23 09:21:49', '2016-06-23 09:21:49', '', '', NULL),
(19, NULL, 'Blixen Tamarind Karen', '2016-06-23', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-23 12:44:15', '2016-06-23 12:44:15', '', '', NULL),
(20, NULL, 'Ann/ david mugofwa', '2016-06-24', '', '0722200938/ 0722972065', 'clyde gardens hse no. B6', '', '', '', 'Customer', 0, 0, '2016-06-24 13:27:36', '2016-06-24 13:27:36', '', '', NULL),
(21, NULL, 'Lillian Wacuka karuri', '2016-06-24', '', '0722737631', 'clermont apt hse no. C3,MBAAZI RD', '', '', '', 'Customer', 0, 0, '2016-06-24 13:29:38', '2016-06-24 13:29:38', '', '', NULL),
(22, NULL, 'MOSES NJUGUNA', '2016-06-24', '', '0731876118', 'SIPARA GARDENS HSE NO. B3,OPP RIARA GARDENS RIARA RD', '', '', '', 'Customer', 0, 0, '2016-06-24 13:31:21', '2016-06-24 13:31:21', '', '', NULL),
(23, NULL, 'DONOVAN BANE', '2016-06-24', '', '0720762470', 'SECOND GREEN GATE OFF RIARA RD OLE DUMME RD', '', '', '', 'Customer', 0, 0, '2016-06-24 13:32:44', '2016-06-24 13:32:44', '', '', NULL),
(24, NULL, 'AMBO GARDENS', '2016-06-24', '', '', 'AMBO GARDENS', '', '', '', 'Customer', 0, 0, '2016-06-24 13:33:13', '2016-06-24 13:33:13', '', '', NULL),
(25, NULL, 'prisca maina/ robert njogu', '2016-06-24', '', '0721951525', 'kalu apt ,east church road off raphta rd, left off the third bump westy', '', '', '', 'Customer', 0, 0, '2016-06-24 13:35:33', '2016-06-24 13:35:33', '', '', NULL),
(26, NULL, 'steve gitonga', '2016-06-24', '', '0725203885', 'george padmore hse no. 1, bhind baraton university ,before yaya center', '', '', '', 'Customer', 0, 0, '2016-06-24 13:37:20', '2016-06-24 13:37:20', '', '', NULL),
(27, NULL, 'Emily muhuthia', '2016-06-24', '', '0722830955', 'millenium gardens hse no. B8 mbaazi road kilimani', '', '', '', 'Customer', 0, 0, '2016-06-24 13:38:22', '2016-08-06 11:48:16', '', '', NULL),
(28, NULL, 'Dinners ', '2016-06-24', '', '', 'diners', '', '', '', 'Customer', 0, 0, '2016-06-24 13:50:51', '2016-10-27 06:54:10', 'Institutional', '', NULL),
(29, NULL, 'Magdaline mwende/ robert habwe', '2016-06-25', '', '0722383378 / 0733718774', 'beyabeya flats block B1 door no. 6 opp Tmall near mbagathi roundabout', '', '', '', 'Customer', 0, 0, '2016-06-25 12:27:25', '2016-06-25 12:27:25', '', '', NULL),
(30, NULL, 'Gracehouse annex', '2016-06-25', '', 'ANNEX', '', '', '', '', 'Customer', 0, 0, '2016-06-25 12:29:06', '2016-06-25 12:29:06', '', '', NULL),
(31, NULL, 'Wallmat group', '2016-06-25', '', '0738769999', 'galana road', '', '', '', 'Customer', 0, 0, '2016-06-25 12:35:27', '2016-06-25 12:35:27', '', '', NULL),
(32, NULL, 'Tribeka lounge', '2016-06-25', '', '', 'nairobi town', '', '', '', 'Customer', 0, 0, '2016-06-25 12:36:46', '2016-06-25 12:36:46', '', '', NULL),
(33, NULL, 'halima ali', '2016-06-26', '', '0722365554', 'jamhuri Ph1 hse no. K26D', '', '', '', 'Customer', 0, 0, '2016-06-26 13:28:06', '2016-06-26 13:28:06', '', '', NULL),
(34, NULL, 'Lillian moraa', '2016-06-26', '', '0721325565', 'Apple honey apt hse no.D3,roysambu lumumba drive small gate', '', '', '', 'Customer', 0, 0, '2016-06-26 13:29:29', '2016-06-26 13:29:29', '', '', NULL),
(35, NULL, 'catherine muhandia', '2016-06-26', '', '0724158692', 'opp joseph kangethe primary sch next to red kiosk', '', '', '', 'Customer', 0, 0, '2016-06-26 13:30:56', '2016-06-26 13:30:56', '', '', NULL),
(36, NULL, 'Janet', '2016-06-26', '', '0736938002', 'saru gardens hse no. B11 off kilimani rd', '', '', '', 'Customer', 0, 0, '2016-06-26 13:32:15', '2016-06-26 13:32:15', '', '', NULL),
(37, NULL, 'J\'S DEEEP BLUE', '2016-06-26', '', '', 'KAREN', '', '', '', 'Customer', 0, 0, '2016-06-26 13:37:28', '2016-06-26 13:37:28', '', '', NULL),
(38, NULL, 'shebano', '2016-06-28', '', '', 'Lavington; clyde ; hse C1', '', '', '', 'Customer', 0, 0, '2016-06-28 07:51:14', '2016-06-28 07:51:14', '', '', NULL),
(39, NULL, 'Explorer', '2016-06-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-28 07:51:58', '2016-06-28 07:51:58', '', '', NULL),
(40, NULL, '0', '2016-06-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-28 13:25:01', '2016-07-16 09:13:32', '', '', NULL),
(41, NULL, 'Carol Kotonya', '2016-06-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-28 13:25:17', '2016-06-28 13:25:17', '', '', NULL),
(42, NULL, 'Eunice Muhia', '2016-06-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-28 13:25:35', '2016-06-28 13:25:35', '', '', NULL),
(43, NULL, 'Bodyzone', '2016-06-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-06-28 13:38:28', '2016-06-28 13:38:28', '', '', NULL),
(44, NULL, 'New Shizzlers', '2016-06-29', '', '', 'new shizzlers', '', '', '', 'Customer', 0, 0, '2016-06-29 12:32:47', '2016-06-29 12:32:47', '', '', NULL),
(45, NULL, 'Irene Musavwa', '2016-06-29', '', '0721306989', 'Juliet court hse no. A5, gikuyu close ,Racecourse', '', '', '', 'Customer', 0, 0, '2016-06-29 12:35:18', '2016-06-29 12:35:18', '', '', NULL),
(46, NULL, 'Mercy muli', '2016-06-30', '', '0719325649', 'black gate hse no. 30B, ON chambers rd opp bia bora ngara', '', '', '', 'Customer', 0, 0, '2016-06-30 11:58:39', '2016-06-30 11:58:39', '', '', NULL),
(47, NULL, 'Jennifer Karanja', '2016-06-30', '', '0722996867', 'riara woods hse no. B5 ole dumme rd', '', '', '', 'Customer', 0, 0, '2016-06-30 11:59:46', '2016-06-30 11:59:46', '', '', NULL),
(48, NULL, 'club sevens', '2016-06-30', '', '0721770377', 'moi avenue', '', '', '', 'Customer', 0, 0, '2016-06-30 12:16:02', '2016-06-30 12:16:02', '', '', NULL),
(49, NULL, 'Red ruby', '2016-06-30', '', '', 'westlands', '', '', '', 'Customer', 0, 0, '2016-06-30 12:33:24', '2016-06-30 12:33:24', '', '', NULL),
(50, NULL, 'Alex Hedge', '2016-07-01', '', '0706269736', 'Ndemi court;kilimani rd;hse15', '', '', '', 'Customer', 0, 0, '2016-07-01 10:09:05', '2016-07-01 10:09:05', '', '', NULL),
(51, NULL, 'Spice House', '2016-07-01', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-01 10:09:59', '2016-07-01 10:09:59', '', '', NULL),
(52, NULL, 'Maureen Mavindu', '2016-07-01', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-01 10:10:25', '2016-07-01 10:10:25', '', '', NULL),
(53, NULL, 'Dinners Gardens', '2016-07-01', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-01 10:10:58', '2016-07-01 10:10:58', '', '', NULL),
(54, NULL, 'Gateman Njuguna', '2016-07-02', '', '', 'westlands;maruti court;mvuli road', '', '', '', 'Customer', 0, 0, '2016-07-02 11:53:44', '2016-07-02 11:53:44', '', '', NULL),
(55, NULL, 'Bettyr Ngara', '2016-07-02', '', '0722207632', 'Ngara behind kenyatta university; Tarasons properties after fig tree', '', '', '', 'Customer', 0, 0, '2016-07-02 11:55:53', '2016-07-02 11:55:53', '', '', NULL),
(56, NULL, 'Dinners Grill', '2016-07-02', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-02 12:42:42', '2016-07-02 12:42:42', '', '', NULL),
(57, NULL, 'Dinners KLB', '2016-07-02', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-02 12:42:55', '2016-07-02 12:42:55', '', '', NULL),
(58, NULL, 'Clarence/cloud nine', '2016-07-02', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-02 12:44:19', '2016-07-02 12:44:19', '', '', NULL),
(59, NULL, 'Brian Morang\'a', '2016-07-03', '', '0725459953', 'elgeyo marakwet rd;elgeyo gaderns', '', '', '', 'Customer', 0, 0, '2016-07-03 08:19:04', '2016-07-03 08:19:04', '', '', NULL),
(60, NULL, 'Jerotich Murugi', '2016-07-03', '', '0722866802', '5th ngon avenue;kamiti court;hse D10', '', '', '', 'Customer', 0, 0, '2016-07-03 12:25:27', '2016-07-03 12:25:27', '', '', NULL),
(61, NULL, 'David Israel', '2016-07-04', '', '0729575794', 'plot 67 pink gate joseph kangethe', '', '', '', 'Customer', 0, 0, '2016-07-04 12:44:56', '2016-07-04 12:44:56', '', '', NULL),
(62, NULL, 'grace chumba/ edith chumba', '2016-07-04', '', '0725250809/ 0736556047', 'salama park hse no. B10 RIARA RD', '', '', '', 'Customer', 0, 0, '2016-07-04 12:47:12', '2016-07-04 12:47:12', '', '', NULL),
(63, NULL, 'CHEKA GROUP', '2016-07-04', '', '', 'OFF JAMES GICHURU ROAD', '', '', '', 'Customer', 0, 0, '2016-07-04 12:48:13', '2016-07-04 12:48:13', '', '', NULL),
(64, NULL, 'Juliet Kayoshabire', '2016-07-04', '', '0705299750', 'lugonyie close hse no. 34 blue gate,mimosa rd ngumo', '', '', '', 'Customer', 0, 0, '2016-07-04 12:50:25', '2016-07-04 12:50:25', '', '', NULL),
(65, NULL, 'Jupiter restaurant', '2016-07-04', '', '0715542934', 'parklands', '', '', '', 'Customer', 0, 0, '2016-07-04 12:51:52', '2016-07-04 12:51:52', '', '', NULL),
(66, NULL, 'kenneth kamuyu', '2016-07-04', '', '0722919852', 'karen,ngong road miotoni rd on the left 4th gate', '', '', '', 'Customer', 0, 0, '2016-07-04 12:55:03', '2016-07-04 12:55:03', '', '', NULL),
(67, NULL, 'Mercy Musembi', '2016-07-05', '', '0720362397', 'mvuli park hse no. 1,mvuli road,westlands', '', '', '', 'Customer', 0, 50, '2016-07-05 12:29:15', '2016-11-09 15:08:09', 'Domestic', '', NULL),
(68, NULL, 'gladys langat', '2016-07-05', '', '0722713200', 'viraj vill hse no.C32', '', '', '', 'Customer', 0, 0, '2016-07-05 12:31:54', '2016-07-05 12:31:54', '', '', NULL),
(69, NULL, 'vicky karuga', '2016-07-05', '', '0722304690/ 0733334690', 'braeside gardens hse no. M1 green gate past ISF muthangari road', '', '', '', 'Customer', 0, 0, '2016-07-05 12:33:43', '2016-07-05 12:33:43', '', '', NULL),
(70, NULL, 'joachim steuerwald', '2016-07-05', '', '0791718100', 'lobelia court hse no. E5 ,george padmore road', '', '', '', 'Customer', 0, 0, '2016-07-05 12:47:28', '2016-07-05 12:47:28', '', '', NULL),
(71, NULL, 'peter soulja', '2016-07-06', '', '', 'riverside hse no. 65 next to chile embassy', '', '', '', 'Customer', 0, 0, '2016-07-06 10:28:54', '2016-07-06 10:28:54', '', '', NULL),
(72, NULL, 'lydia jasmin', '2016-07-06', '', '0724643639', 'jasmine court, maalima juma road', '', '', '', 'Customer', 0, 0, '2016-07-06 10:30:05', '2016-07-06 10:30:05', '', '', NULL),
(73, NULL, 'oscar waruingi', '2016-07-06', '', '0722949849', 'greenpark flats hse no. D2 jamhuri', '', '', '', 'Customer', 0, 0, '2016-07-06 10:32:45', '2016-07-06 10:32:45', '', '', NULL),
(74, NULL, 'Zarula', '2016-07-06', '', '', 'Glenbrook apt hse no. D5,chaka rd hurlingham', '', '', '', 'Customer', 0, 0, '2016-07-06 13:42:53', '2016-07-06 13:42:53', '', '', NULL),
(75, NULL, 'Zipporah Rimu', '2016-07-07', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-07 13:21:08', '2016-07-07 13:21:08', '', '', NULL),
(76, NULL, '2', '2016-07-07', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-07 13:21:25', '2016-08-06 12:19:04', '', '', NULL),
(77, NULL, 'Josh Mwangemi', '2016-07-07', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-07 13:21:45', '2016-07-07 13:21:45', '', '', NULL),
(78, NULL, 'Sara Allan Oisebe', '2016-07-07', '', '0723828482', 'oasis park;hse A4', '', '', '', 'Customer', 0, 0, '2016-07-07 13:54:56', '2016-07-07 13:54:56', '', '', NULL),
(79, NULL, 'Roselyne Kimathi / Maureen ', '2016-07-08', '', '0722530199 /0722336911', 'Ndemi road;easthill apt;hse no.40', '', '', '', 'Customer', 0, 0, '2016-07-08 09:08:34', '2016-07-31 13:26:37', '', '', NULL),
(80, NULL, 'Ricos Taproom', '2016-07-08', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-08 09:08:54', '2016-07-08 09:08:54', '', '', NULL),
(81, NULL, 'Patrick Osir', '2016-07-08', '', '0721842423', '', '', '', '', 'Customer', 0, 0, '2016-07-08 09:10:21', '2016-07-08 09:10:21', '', '', NULL),
(82, NULL, 'Hassan Hashi', '2016-07-08', '', '0722516705', 'raphta road; Aun properties;terraces close; Hse B4', '', '', '', 'Customer', 0, 0, '2016-07-08 09:12:10', '2016-07-08 09:12:10', '', '', NULL),
(83, NULL, 'Kimberly Kamau', '2016-07-08', '', 'ndemi rd;easthill apt; hse 48', '', '', '', '', 'Customer', 0, 0, '2016-07-08 11:12:56', '2016-07-08 11:12:56', '', '', NULL),
(84, NULL, 'SIP & LIP', '2016-07-08', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-08 13:51:52', '2016-07-08 13:51:52', '', '', NULL),
(85, NULL, 'veronica Mburu', '2016-07-08', '', '', 'oof church road ;pyramid springs', '', '', '', 'Customer', 0, 0, '2016-07-08 13:54:08', '2016-07-08 13:54:08', '', '', NULL),
(86, NULL, 'susan waithera', '2016-07-08', '', '', 'satte house road ; milimani hotel;opol court', '', '', '', 'Customer', 0, 0, '2016-07-08 13:54:41', '2016-07-08 13:54:41', '', '', NULL),
(87, NULL, 'Alice', '2016-07-09', '', '0722812272', 'saru gardens; hse A11; kilimani road', '', '', '', 'Customer', 0, 0, '2016-07-09 11:17:05', '2016-07-09 11:17:05', '', '', NULL),
(88, NULL, 'margaret jerotich', '2016-07-09', '', '0722223247', 'mulberry apt; kingara rd; A6', '', '', '', 'Customer', 0, 0, '2016-07-09 11:18:42', '2016-07-09 11:18:42', '', '', NULL),
(89, NULL, 'Millicent Odhiambo', '2016-07-10', '', '0726317258', 'garden terrace apt; hse E3;kabarnet rd after moi girls', '', '', '', 'Customer', 0, 0, '2016-07-10 12:57:50', '2016-07-10 12:57:50', '', '', NULL),
(90, NULL, 'Joy Adhiambo', '2016-07-10', '', '0722407559', 'KMA hse no.A8; Bamboo lane; riara', '', '', '', 'Customer', 0, 0, '2016-07-10 12:59:10', '2016-07-10 12:59:10', '', '', NULL),
(91, NULL, 'Shirely Odero', '2016-07-10', '', '0724168609', 'shelter pride; enter rough road before safari park; hse B404', '', '', '', 'Customer', 0, 0, '2016-07-10 13:00:33', '2016-07-10 13:00:33', '', '', NULL),
(92, NULL, 'CHECKERS BAR & RESTAURANT', '2016-07-11', '', '', 'Opp kilimani police station', '', '', '', 'Customer', 0, 0, '2016-07-11 08:07:02', '2016-07-11 08:07:02', '', '', NULL),
(93, NULL, 'JOAN NJUGUNA', '2016-07-11', '', '0722231990', 'Last brown gate,school grove,school lane,westlands', '', '', '', 'Customer', 0, 0, '2016-07-11 08:09:47', '2016-07-11 08:09:47', '', '', NULL),
(94, NULL, 'alfred', '2016-07-11', '', '', 'joseph kangethe', '', '', '', 'Customer', 0, 0, '2016-07-11 13:06:57', '2016-07-11 13:06:57', '', '', NULL),
(95, NULL, 'MARK PHILLIP / Vincent Ochieng', '2016-07-12', '', '0734761010  / 0720247678', 'nandi road 95 hse no. 7 karen', '', '', '', 'Customer', 0, 0, '2016-07-12 10:47:31', '2016-12-24 15:06:01', 'Domestic', '', NULL),
(96, NULL, 'Q-Lounge', '2016-07-12', '', '0723285177', 'denis pritt rd,maalim juma rd next to citizen', '', '', '', 'Customer', 0, 0, '2016-07-12 13:22:15', '2016-07-12 13:22:15', '', '', NULL),
(97, NULL, 'Angela Nomisigio / Steve Lubia', '2016-07-13', '', '0717852466 / 0721519897', 'vasudev heights hse no. A3,siaya rd off oloitoktok road', '', '', '', 'Customer', 0, 0, '2016-07-13 12:34:57', '2016-07-13 12:34:57', '', '', NULL),
(98, NULL, 'juma', '2016-07-14', '', '', 'nairobi west 4th gate', '', '', '', 'Customer', 0, 0, '2016-07-14 13:45:54', '2016-07-14 13:45:54', '', '', NULL),
(99, NULL, 'northshore agencies', '2016-07-14', '', '', 'akila house no.147 mbagathi road', '', '', '', 'Customer', 0, 0, '2016-07-14 13:47:08', '2016-07-14 13:47:08', '', '', NULL),
(100, NULL, 'Abda Ahmed', '2016-07-14', '', '', 'brentwood apt , mararo rd', '', '', '', 'Customer', 0, 0, '2016-07-14 13:51:14', '2016-07-14 13:51:14', '', '', NULL),
(101, NULL, 'Damaris Alfayo', '2016-07-14', '', '0724042296', 'jawabu school green gate', '', '', '', 'Customer', 0, 0, '2016-07-14 13:55:36', '2016-07-14 13:55:36', '', '', NULL),
(102, NULL, 'Roast by Canivore/Tamarind', '2016-07-15', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-15 13:20:25', '2016-07-15 13:21:26', '', '', NULL),
(103, NULL, 'Samah hassan', '2016-07-15', '', '0722737333', 'terranova court, chaka rd', '', '', '', 'Customer', 0, 0, '2016-07-15 13:20:40', '2016-09-28 11:38:17', '', '', NULL),
(104, NULL, 'Blixen Tamarind', '2016-07-15', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-15 13:21:07', '2016-07-15 13:21:07', '', '', NULL),
(105, NULL, 'Samuel Gitungo', '2016-07-15', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-15 13:21:58', '2016-07-15 13:21:58', '', '', NULL),
(106, NULL, 'Osnet Gardens', '2016-07-16', '', '', 'muthangari road ;off gitanga road', '', '', '', 'Customer', 0, 0, '2016-07-16 08:59:04', '2016-07-16 08:59:04', '', '', NULL),
(107, NULL, 'Maureen Elite court', '2016-07-16', '', '0733441690', 'Elite court; ole dume road;hse no.2', '', '', '', 'Customer', 0, 0, '2016-07-16 09:02:27', '2016-07-16 09:02:27', '', '', NULL),
(108, NULL, 'Antony ngugi', '2016-07-16', '', '', 'lavington;chalbi court;hse 14', '', '', '', 'Customer', 0, 0, '2016-07-16 13:47:15', '2016-07-16 13:47:15', '', '', NULL),
(109, NULL, 'Jostinah Mutinda', '2016-07-16', '', '', 'kawangware;shama flats;D10', '', '', '', 'Customer', 0, 0, '2016-07-16 13:47:53', '2016-07-16 13:47:53', '', '', NULL),
(110, NULL, 'Mary Sitonik', '2016-07-17', '', '', 'elgeyo marakwet rd;walter apt; hse A7', '', '', '', 'Customer', 0, 0, '2016-07-17 13:06:44', '2016-07-17 13:06:44', '', '', NULL),
(111, NULL, 'Clara masinde', '2016-07-20', '', '0722714743', 'jambo terraces hse no. 12, kabasiran road lavington', '', '', '', 'Customer', 0, 0, '2016-07-20 10:37:44', '2016-07-20 10:37:44', '', '', NULL),
(112, NULL, 'Simon Kamuyu', '2016-07-20', '', '0722723170', 'miotoni road 4th white gate on the left.karen', '', '', '', 'Customer', 0, 0, '2016-07-20 10:39:50', '2016-07-20 10:39:50', '', '', NULL),
(113, NULL, 'Susan/ Robert Bresson', '2016-07-20', '', '0727241326/ 0722520238', 'united estates hse no. 19,ole dume rd before riara rd', '', '', '', 'Customer', 0, 0, '2016-07-20 10:42:32', '2016-07-20 10:42:32', '', '', NULL),
(114, NULL, 'Kalekye Mumo', '2016-07-20', '', '0722719678', '3rd gate hse no.1,green gate next to coca cola shop , likoni lane ,denis pritt rd', '', '', '', 'Customer', 0, 0, '2016-07-20 10:44:29', '2016-07-20 10:44:29', '', '', NULL),
(115, NULL, 'Hibiscus bed and breakfast', '2016-07-21', '', '0728886854', 'hibiscus hotel', '', '', '', 'Customer', 0, 0, '2016-07-21 11:29:05', '2016-07-21 11:29:05', '', '', NULL),
(116, NULL, 'elizabeth njau', '2016-07-21', '', '0722791953', 'GREEN GATE hse no. 400 ,jamhuri  nxt to togo flats friends shop on the right', '', '', '', 'Customer', 0, 0, '2016-07-21 11:31:51', '2016-07-21 11:31:51', '', '', NULL),
(117, NULL, 'Albert maingi', '2016-07-21', '', '0722521128', 'hardrock apts hse no. 3, 1st gate on the right of likoni lane off denis pritt rd', '', '', '', 'Customer', 0, 0, '2016-07-21 11:35:00', '2016-07-21 11:35:00', '', '', NULL),
(118, NULL, 'Brian Mangoli', '2016-07-21', '', '0722576242', 'lions liar hse no. C3 kileleshwa, oloitoktok', '', '', '', 'Customer', 0, 0, '2016-07-21 11:36:53', '2016-07-21 11:36:53', '', '', NULL),
(119, NULL, 'Fred muhhuku/ cynthia', '2016-07-21', '', '0727208716', 'sohil park hse no.A12 raphta rd,westlands nxt to dragon apt', '', '', '', 'Customer', 0, 0, '2016-07-21 11:38:00', '2016-11-09 07:43:01', 'Domestic', '', NULL),
(120, NULL, 'Retro cafe', '2016-07-21', '', '', 'westlands', '', '', '', 'Customer', 0, 0, '2016-07-21 12:15:20', '2016-07-21 12:15:20', '', '', NULL),
(121, NULL, 'makutano grill', '2016-07-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-22 05:18:43', '2016-07-22 05:18:43', '', '', NULL),
(122, NULL, 'Liz', '2016-07-22', '', '0721362193', 'Raphta road;school lane', '', '', '', 'Customer', 0, 0, '2016-07-22 06:58:57', '2016-07-22 06:58:57', '', '', NULL),
(123, NULL, 'Corinne Isige', '2016-07-22', '', '0704539942', 'mimosa; path between kilonzo advocates and faulu', '', 'mimosa', '', 'Customer', 0, 0, '2016-07-22 11:17:54', '2016-07-22 11:17:54', '', '', NULL),
(124, NULL, 'Poonam', '2016-07-22', '', '0791477944', 'raphta road; sohil apertment; 4B', '', 'raphta road', '', 'Customer', 0, 0, '2016-07-22 11:19:29', '2016-07-22 11:19:29', '', '', NULL),
(125, NULL, 'Moraa Omwenga', '2016-07-23', '', '0722274763', 'karuna close 15 Hse no.2', '', '', '', 'Customer', 0, 0, '2016-07-23 12:22:39', '2016-07-23 12:22:39', '', '', NULL),
(126, NULL, 'David Mwangi', '2016-07-23', '', '0733660050', 'imara daima gardens; msa road near riara school', '', '', '', 'Customer', 0, 0, '2016-07-23 12:24:32', '2016-07-23 12:24:32', '', '', NULL),
(127, NULL, 'Gardens flats gateman', '2016-07-24', '', '', 'gardens flats;opp impala club;makindi road;oppswedish school;hse 8', '', '', '', 'Customer', 0, 0, '2016-07-24 10:39:34', '2016-07-24 10:39:34', '', '', NULL),
(128, NULL, 'priscilla angwenyi', '2016-07-25', '', '0721247698', 'kikam estate,kileleshwa', '', '', '', 'Customer', 0, 0, '2016-07-25 12:35:08', '2016-07-25 12:53:56', '', '', NULL),
(129, NULL, 'Husna Dahag', '2016-07-25', '', '', 'hervines apt hse no. F10,raphta rd,westlands', '', '', '', 'Customer', 0, 0, '2016-07-25 12:36:04', '2016-11-11 16:00:27', 'Domestic', '', NULL),
(130, NULL, 'edmond kadogo', '2016-07-25', '', '0718787393', 'kikam estate,kileleshwa', '', '', '', 'Customer', 0, 0, '2016-07-25 12:41:46', '2016-07-25 12:53:12', '', '', NULL),
(131, NULL, 'Edwin Rukwaro/ Ian rukwaro', '2016-07-26', '', '0701111590 /0726174912', 'junction apt hse no. A9.riara road next to linxnet tech', '', '', '', 'Customer', 0, 0, '2016-07-26 11:22:08', '2016-07-26 11:22:08', '', '', NULL),
(132, NULL, 'timon odhiambo', '2016-07-26', '', '0717199009', 'kibera', '', '', '', 'Customer', 0, 0, '2016-07-26 11:23:07', '2016-07-26 11:23:07', '', '', NULL),
(133, NULL, 'WACUKA KIMANI', '2016-07-26', '', '0722643078', 'Bishop okulu gardens hse no.1,kasuku rd off lenana rd', '', '', '', 'Customer', 0, 0, '2016-07-26 13:34:00', '2016-07-26 13:34:00', '', '', NULL),
(134, NULL, 'Charles Kimathi', '2016-07-27', '', '0712219229', '', '', 'kabarsiran avenue; near kianda school; maruti plaza;hse 6D', '', 'Customer', 0, 0, '2016-07-27 10:52:39', '2016-07-27 10:52:39', '', '', NULL),
(135, NULL, 'AAR-Insurance', '2016-07-28', '', '', '', '', '', '', 'Customer', 0, 0, '2016-07-28 09:54:22', '2016-07-28 09:54:22', '', '', NULL),
(136, NULL, 'DORCAS BIBA', '2016-07-29', '', '071538761', 'RONGAI', '', '', '', 'Customer', 0, 0, '2016-07-29 14:04:42', '2016-07-29 14:04:42', '', '', NULL),
(137, NULL, 'Lucy mwai', '2016-07-29', '', '0722254027', 'bijami place hse no. B7.suguta rd kileleshwa', '', '', '', 'Customer', 0, 0, '2016-07-29 14:06:22', '2016-07-29 14:06:22', '', '', NULL),
(138, NULL, 'PARK PLACE', '2016-07-29', '', '', 'magadi road', '', '', '', 'Customer', 0, 0, '2016-07-29 14:07:13', '2016-07-29 14:07:13', '', '', NULL),
(139, NULL, 'VERONICA KENYA', '2016-07-30', '', '0791801549', 'TETU HOUSING HSE NO. D4,  milimani road before statehouse rd', '', '', '', 'Customer', 0, 0, '2016-07-30 10:54:35', '2016-07-30 12:27:39', '', '', NULL),
(140, NULL, 'sophie c/o timon', '2016-07-31', '', '', 'kibera,karanja kwa jude', '', '', '', 'Customer', 0, 0, '2016-07-31 12:40:54', '2016-07-31 12:40:54', '', '', NULL),
(141, NULL, 'Kiplimo gateman', '2016-08-02', '', '', 'kirichwa gardens', '', '', '', 'Customer', 0, 0, '2016-08-02 08:23:29', '2016-08-02 08:23:29', '', '', NULL),
(142, NULL, 'Jennifer Ashihundu', '2016-08-02', '', '0721640345', '', '', '', '', 'Customer', 0, 0, '2016-08-02 11:37:37', '2016-08-02 11:37:37', '', '', NULL),
(143, NULL, 'Ann Emily', '2016-08-02', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-02 13:42:26', '2016-08-02 13:42:26', '', '', NULL),
(144, NULL, 'Gerry Gitau', '2016-08-02', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-02 13:43:09', '2016-08-02 13:43:09', '', '', NULL),
(145, NULL, 'Susan Wamalwa', '2016-08-04', '', '0728814581', 'kileleshwa;lima place;kandara rd;hse B6', '', '', '', 'Customer', 0, 0, '2016-08-04 09:11:07', '2016-08-04 09:13:35', '', '', NULL),
(146, NULL, 'Mary Gicheru', '2016-08-04', '', '0763157931', 'Masanduku Lane;Mbathi road;valley acade;thompson 1 apertment;hse E16', '', '', '', 'Customer', 0, 0, '2016-08-04 09:12:51', '2016-09-07 09:06:40', '', '', NULL),
(147, NULL, 'Fabrizio Italy', '2016-08-05', '', '0717803444', 'raphta road; sohil apertment; 4D', '', '', '', 'Customer', 0, 0, '2016-08-05 12:51:22', '2016-08-05 12:51:22', '', '', NULL),
(148, NULL, 'Esther  Musaisi Nyanchama', '2016-08-06', '', '0722433084', '', '', 'delamere;block j32', '', 'Customer', 0, 0, '2016-08-06 11:44:07', '2016-08-06 11:44:07', '', '', NULL),
(149, NULL, 'KIVI', '2016-08-06', '', '', 'Milimani road', '', '', '', 'Customer', 0, 0, '2016-08-06 11:47:49', '2016-08-06 11:47:49', '', '', NULL),
(150, NULL, 'irene kombo', '2016-08-08', '', '0725813801', 'garden road black gate 13 apt no. 15,riverside drive', '', '', '', 'Customer', 0, 0, '2016-08-08 13:47:29', '2016-08-08 13:47:29', '', '', NULL),
(151, NULL, 'joseph andola', '2016-08-08', '', '0734172027', 'miotoni road road hse no. 257 , opp bell air', '', '', '', 'Customer', 0, 0, '2016-08-08 13:48:26', '2016-08-08 13:48:26', '', '', NULL),
(152, NULL, 'sheen makena marete', '2016-08-08', '', '0721743221', '2 black gates down the road,at marula lane next to marula mercantile', '', '', '', 'Customer', 0, 0, '2016-08-08 13:52:03', '2016-08-08 13:52:03', '', '', NULL),
(153, NULL, 'makele', '2016-08-08', '', '0792651020', 'muringa grove hse no. B 808,tall yellow and red building at muringa rd', '', '', '', 'Customer', 0, 0, '2016-08-08 13:53:57', '2016-08-08 13:53:57', '', '', NULL),
(154, NULL, 'halima bakari', '2016-08-08', '', '0703188877', 'mac apt hse no. A1,kingara rd', '', '', '', 'Customer', 0, 0, '2016-08-08 14:03:35', '2016-08-08 14:03:35', '', '', NULL),
(155, NULL, 'Raecheal kimani', '2016-08-08', '', '', 'consolata primary', '', '', '', 'Customer', 0, 0, '2016-08-08 14:29:23', '2016-08-08 14:29:23', '', '', NULL),
(156, NULL, 'Dorcas Odera', '2016-08-10', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-10 10:46:56', '2016-08-10 10:46:56', '', '', NULL),
(157, NULL, ' c/o wycliff', '2016-08-10', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-10 10:47:16', '2017-02-11 15:47:47', 'Domestic', '', NULL),
(158, NULL, 'Christine Gachucha', '2016-08-10', '', '0722870200', 'lavington;othaya road;mawala gardens', '', '', '', 'Customer', 0, 0, '2016-08-10 12:41:00', '2016-08-10 12:41:00', '', '', NULL),
(159, NULL, 'Steve Baraza', '2016-08-11', '', '', 'Kingara heights', '', '', '', 'Customer', 0, 0, '2016-08-11 09:10:14', '2016-08-11 09:10:14', '', '', NULL),
(160, NULL, 'eva nyakerario', '2016-08-12', '', '0715478804 / 0763478804', 'alpha towers hse no. A19, kawangware 46 after equity bank', '', '', '', 'Customer', 0, 0, '2016-08-12 11:49:31', '2016-09-02 12:06:33', '', '', NULL),
(161, NULL, 'KEN c/o elizabeth njau', '2016-08-12', '', '0724244852', 'S/Q hse no. 400 jamhuri estate', '', '', '', 'Customer', 0, 0, '2016-08-12 11:51:27', '2016-08-12 11:51:27', '', '', NULL),
(162, NULL, 'JOHN MWENDWA', '2016-08-13', '', '0722775312', 'Thompson apt hse no. B3 , mbaazi avenue', '', '', '', 'Customer', 0, 0, '2016-08-13 12:18:42', '2016-08-13 12:18:42', '', '', NULL),
(163, NULL, 'NICK', '2016-08-13', '', '0716979464', 'Riverlyne apt hse no. 6, laikipia road,kileleshwa', '', '', '', 'Customer', 0, 0, '2016-08-13 12:20:26', '2016-08-13 12:20:26', '', '', NULL),
(164, NULL, 'ZIPPORAH ONGWENYI', '2016-08-13', '', '0735831791', 'Sunnyhill apt hse no. F10', '', '', '', 'Customer', 0, 0, '2016-08-13 12:29:44', '2016-08-13 12:29:44', '', '', NULL),
(165, NULL, 'meshack odhiambo', '2016-08-14', '', '0727218176', 'joseph kangethe hse no. 67 pink gate', '', '', '', 'Customer', 0, 0, '2016-08-14 14:31:04', '2016-08-14 14:31:04', '', '', NULL),
(166, NULL, 'Irene tiva estate', '2016-08-15', '', '0734293494', '5yh nong avenue;tiva estate;hseA15', '', '', '', 'Customer', 0, 0, '2016-08-15 09:44:04', '2016-08-15 09:45:07', '', '', NULL),
(167, NULL, 'Julius kinyua', '2016-08-15', '', '', 'Jamhuri', '', '', '', 'Customer', 0, 0, '2016-08-15 12:20:21', '2016-08-15 12:20:21', '', '', NULL),
(168, NULL, 'elizabeth njau (Hibiscus)', '2016-08-15', '', '', 'jamhuri', '', '', '', 'Customer', 0, 0, '2016-08-15 12:27:30', '2016-08-15 12:27:30', '', '', NULL),
(169, NULL, 'Mrs Otieno', '2016-08-16', '', '', 'Jamhuri two', '', '', '', 'Customer', 0, 0, '2016-08-16 05:34:51', '2016-08-16 05:34:51', '', '', NULL),
(170, NULL, 'Donner Den', '2016-08-16', '', '', 'Adams', '', '', '', 'Customer', 0, 0, '2016-08-16 13:28:15', '2016-08-16 13:28:15', '', '', NULL),
(171, NULL, 'Isaac Opondo Allan', '2016-08-16', '', '0722879158', 'kayahwe villas hse no. 5', '', '', '', 'Customer', 0, 0, '2016-08-16 13:29:22', '2016-09-08 13:29:15', '', '', NULL),
(172, NULL, 'Seraph', '2016-08-16', '', '', 'Dennis pritt rd', '', '', '', 'Customer', 0, 0, '2016-08-16 13:36:21', '2016-08-16 13:36:21', '', '', NULL),
(173, NULL, 'Rosa Sora', '2016-08-17', '', '0700617761', 'Mbaazi Ave; Millenium Gardens;D3', '', '', '', 'Customer', 0, 0, '2016-08-17 09:06:33', '2016-08-17 09:06:33', '', '', NULL),
(174, NULL, 'Jackie Mburu', '2016-08-18', '', '0717666151', 'kieni court;kileleshwa; creek rd;hse 33', '', '', '', 'Customer', 0, 0, '2016-08-18 10:09:12', '2016-08-18 10:09:12', '', '', NULL),
(175, NULL, 'James obuya', '2016-08-19', '', '0722619098', 'blue bells gardens hse no. N21 opp great wallapt along bejing rd off msa rd just before the weigh bridge at allpark industries ', '', '', '', 'Customer', 0, 0, '2016-08-19 13:44:23', '2016-08-19 13:44:23', '', '', NULL),
(176, NULL, 'pauline mogwanja', '2016-08-19', '', '0716286622', 'riara woods hse no. C8, ole dume road', '', '', '', 'Customer', 0, 0, '2016-08-19 14:26:36', '2016-08-19 14:26:36', '', '', NULL),
(177, NULL, 'DORINE MWITHI', '2016-08-20', '', '', 'kirichwa creek;kieni court;hse.39', '', '', '', 'Customer', 0, 0, '2016-08-20 14:40:35', '2016-10-25 14:21:12', 'Domestic', '', NULL),
(178, NULL, 'alex sio', '2016-08-20', '', '0722519968', 'golf course ph 2 hse no.587', '', '', '', 'Customer', 0, 0, '2016-08-20 14:41:34', '2016-08-20 14:41:34', '', '', NULL),
(179, NULL, 'mary mulili', '2016-08-20', '', '', 'aften apt jamhuri', '', '', '', 'Customer', 0, 0, '2016-08-20 14:43:28', '2016-08-20 14:43:28', '', '', NULL),
(180, NULL, 'ann wambui', '2016-08-20', '', '0721624000', 'jamhuri', '', '', '', 'Customer', 0, 0, '2016-08-20 14:44:22', '2016-08-20 14:44:22', '', '', NULL),
(181, NULL, 'martin kimani', '2016-08-20', '', '0723419415', 'magiwa estate', '', '', '', 'Customer', 0, 0, '2016-08-20 14:45:48', '2016-08-20 14:45:48', '', '', NULL),
(182, NULL, 'Linet mama lucy', '2016-08-22', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-22 13:30:04', '2016-08-22 13:30:04', '', '', NULL),
(183, NULL, 'Carol Kuria', '2016-08-23', '', '', 'kirichwa road', '', '', '', 'Customer', 0, 0, '2016-08-23 10:28:05', '2016-08-23 10:28:05', '', '', NULL),
(184, NULL, 'Flamingo Hill Camp', '2016-08-23', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-23 11:34:23', '2016-08-23 11:34:23', '', '', NULL),
(185, NULL, 'Maureen Riviera gardens', '2016-08-24', '', '', '', '', '', '', 'Customer', 0, 0, '2016-08-24 11:40:16', '2016-08-24 11:40:16', '', '', NULL),
(186, NULL, 'Ken Ochieng', '2016-08-25', '', '0721310992/0722846283', 'jamhuri;harmony court;2nd flr hse no. 24', '', '', '', 'Customer', 0, 0, '2016-08-25 05:56:16', '2016-08-25 06:06:39', '', '', NULL),
(187, NULL, 'Catherine Nduta', '2016-08-25', '', '0705367312', 'Kileleshwa near kenya high sch; mandera rd; 2nd gate', '', '', '', 'Customer', 0, 0, '2016-08-25 05:58:31', '2016-08-25 05:58:31', '', '', NULL),
(188, NULL, 'Azeem Omar', '2016-08-29', '', '0702831084', 'jambo investment;hse NA22; nxt to prestige', '', '', '', 'Customer', 0, 0, '2016-08-29 10:19:33', '2016-08-29 10:19:33', '', '', NULL),
(189, NULL, 'George Adams', '2016-08-30', '', '', 'Adams', '', '', '', 'Customer', 0, 0, '2016-08-30 12:50:13', '2016-08-30 12:50:13', '', '', NULL),
(190, NULL, 'Clarice', '2016-08-30', '', '0722456425', 'Denis pritt rd;likoni ridge apt;hse D4', '', '', '', 'Customer', 0, 0, '2016-08-30 12:52:49', '2016-08-30 12:52:49', '', '', NULL),
(191, NULL, 'Jerry Namadila', '2016-09-01', '', '0708380606', 'denis prit road;kitale lane;lamuria apt;hse no.A4', '', '', '', 'Customer', 0, 0, '2016-09-01 12:09:17', '2016-09-01 12:09:17', '', '', NULL),
(192, NULL, 'Betty Kidenda', '2016-09-01', '', '0724730326/0720737881', 'ndemi road;braton court;hse 2C', '', '', '', 'Customer', 0, 0, '2016-09-01 13:38:44', '2016-09-01 13:38:44', '', '', NULL),
(193, NULL, 'ann mueke/ maxwell malulu', '2016-09-02', '', '0737491737', 'KAN apt hse no. A7,kandara road,Kieleshwa', '', '', '', 'Customer', 0, 0, '2016-09-02 11:46:52', '2016-09-02 12:05:45', '', '', NULL),
(194, NULL, 'mary makena', '2016-09-02', '', '0724777073', 'jambo estate hse no. C3 , hurlingham next to nairobi womens hosiptal', '', '', '', 'Customer', 0, 0, '2016-09-02 11:48:54', '2016-09-02 11:48:54', '', '', NULL),
(195, NULL, 'Rita Chebomui', '2016-09-03', '', '0728355669', 'muringa place hse no. B2, muringa rd', '', '', '', 'Customer', 0, 0, '2016-09-03 12:38:41', '2016-09-03 12:38:41', '', '', NULL),
(196, NULL, 'Azizah Abubakar', '2016-09-05', '', '', 'sohil regency;raphta rd;2B', '', '', '', 'Customer', 0, 0, '2016-09-05 11:50:43', '2016-09-05 11:50:43', '', '', NULL),
(197, NULL, 'Dr David Silverstein', '2016-09-06', '', '0734666687', 'argwings kodhek road;dental clinic care', '', '', '', 'Customer', 0, 0, '2016-09-06 12:52:09', '2016-09-06 12:52:09', '', '', NULL),
(198, NULL, 'oscar c/o/ wycliffe', '2016-09-07', '', '', 'argwings kodhek road', '', '', '', 'Customer', 0, 0, '2016-09-07 09:07:20', '2016-09-07 09:07:20', '', '', NULL),
(199, NULL, 'MERIADA GARDENS', '2016-09-07', '', '0725877117', 'muthangari gardens ;off gitanga road next to osnet', '', '', '', 'Customer', 0, 0, '2016-09-07 12:36:14', '2016-09-29 07:38:51', '', '', NULL),
(200, NULL, 'jedidah shilaku', '2016-09-08', '', '0712000996', 'westy', '', '', '', 'Customer', 0, 0, '2016-09-08 12:29:49', '2016-09-08 12:29:49', '', '', NULL),
(201, NULL, 'cafe hellena', '2016-09-08', '', '', 'mama ngina street,nairobi at the end of cityhall', '', '', '', 'Customer', 0, 0, '2016-09-08 12:30:50', '2016-09-08 12:30:50', '', '', NULL),
(202, NULL, 'ANKARA RESTAURANT', '2016-09-08', '', '0792148618', 'TOWN', '', '', '', 'Customer', 0, 0, '2016-09-08 13:56:08', '2016-09-08 13:56:08', '', '', NULL),
(203, NULL, 'PANDA CHINEESE RESTAURANT', '2016-09-08', '', '0736163543', 'TOWN', '', '', '', 'Customer', 0, 0, '2016-09-08 13:56:53', '2016-09-08 13:56:53', '', '', NULL),
(204, NULL, 'ORIENT', '2016-09-08', '', '0718034747', 'NAIROBI TOWN', '', '', '', 'Customer', 0, 0, '2016-09-08 13:57:33', '2016-09-08 13:57:33', '', '', NULL),
(205, NULL, 'PRETORIA', '2016-09-08', '', '', 'NAIROBI TOWN', '', '', '', 'Customer', 0, 0, '2016-09-08 13:57:56', '2016-09-08 13:57:56', '', '', NULL),
(206, NULL, 'Ann Muthoni', '2016-09-09', '', '', 'valley creek Apt;kingara close;HseC6', '', '', '', 'Customer', 0, 0, '2016-09-09 14:01:38', '2016-09-09 14:01:38', '', '', NULL),
(207, NULL, 'Mollyne Aketch', '2016-09-10', '', '0723302880', 'Loresho', '', '', '', 'Customer', 0, 0, '2016-09-10 11:18:23', '2016-09-10 11:18:23', '', '', NULL),
(208, NULL, 'Juluis Kinyanjui', '2016-09-10', '', '0722510471', 'Loresho', '', '', '', 'Customer', 0, 0, '2016-09-10 11:21:03', '2016-09-10 11:21:03', '', '', NULL),
(209, NULL, 'Tafadzwa Chivaura', '2016-09-10', '', '0716746266', 'Terranova Court; Hse No. B3', '', '', '', 'Customer', 0, 0, '2016-09-10 12:00:07', '2016-09-10 12:00:07', '', '', NULL),
(210, NULL, 'Joachim Steurwald', '2016-09-12', '', '0717268939', '701 Pyramid park; ole odume close', '', '', '', 'Customer', 0, 0, '2016-09-12 13:05:35', '2016-09-12 13:05:35', '', '', NULL),
(211, NULL, 'CANAM VUSHA', '2016-09-15', '', '0717548453', 'KIANGARA HEIGHTS HSE NO. C6', '', '', '', 'Customer', 0, 0, '2016-09-15 09:53:58', '2016-09-15 09:53:58', '', '', NULL),
(212, NULL, 'JAMILA-MACHINES', '2016-09-15', '', '', 'LENANA TOWERS', '', '', '', 'Customer', 0, 0, '2016-09-15 09:54:27', '2016-09-15 09:54:27', '', '', NULL),
(213, NULL, 'GULF ENERGY', '2016-09-15', '', '', 'GULF ENERGY', '', '', '', 'Supplier', 0, 0, '2016-09-15 09:54:55', '2016-09-15 09:54:55', '', '', NULL),
(214, NULL, 'Garmel Ethopian embassy', '2016-09-15', '', '0773049916', 'kivi milimani hotel apt no. 606', '', '', '', 'Customer', 0, 0, '2016-09-15 12:25:09', '2016-09-15 12:25:09', '', '', NULL),
(215, NULL, 'Montessori schools', '2016-09-17', '', '0722268865', 'Lavington', '', '', '', 'Customer', 0, 0, '2016-09-17 09:56:26', '2016-09-17 09:56:26', '', '', NULL),
(216, NULL, 'JEAN ORCHID', '2016-09-19', '', '0703405268', 'SUNSET HILL HSE NO. 5,GITANGA RD', '', '', '', 'Customer', 0, 0, '2016-09-19 13:57:02', '2016-09-19 13:57:02', '', '', NULL),
(217, NULL, 'NICTA MALOVA', '2016-09-20', '', '0726420670', 'Mzeras court hse no. 12,mazeras road kileleshwa', '', '', '', 'Customer', 0, 0, '2016-09-20 09:01:24', '2016-09-20 09:01:24', '', '', NULL),
(218, NULL, 'LIBRA RESTAURANT-GRACE MUGO', '2016-09-20', '', '0723830866', 'MBAGATHI RD,NEXT TO TMALL', '', '', '', 'Customer', 0, 0, '2016-09-20 09:06:22', '2016-11-18 15:51:06', 'Institutional', '', NULL),
(219, NULL, 'asha abdi', '2016-09-20', '', '0721366021', 'Kan apt hse no. B4', '', '', '', 'Customer', 0, 0, '2016-09-20 12:47:57', '2016-09-20 12:47:57', '', '', NULL),
(220, NULL, 'OTIENO MAKINI', '2016-09-20', '', '0721770013', 'Waterlily  apt, jamhuri two', '', '', '', 'Customer', 0, 0, '2016-09-20 12:49:53', '2016-09-20 12:51:41', '', '', NULL),
(221, NULL, 'RONALD', '2016-09-21', '', '', 'WESTSIDE , MURINGA RD', '', '', '', 'Customer', 0, 0, '2016-09-21 12:25:59', '2016-09-21 12:25:59', '', '', NULL),
(222, NULL, 'MAZERAS COURT', '2016-09-21', '', '', 'MAZERAS COURT HSE NO. A5,MAZERAS RD', '', '', '', 'Customer', 0, 0, '2016-09-21 12:26:52', '2016-09-21 12:26:52', '', '', NULL),
(223, NULL, 'EDEN GARDENS- carolyne namenge / shiko', '2016-09-21', '', '0721853252', 'james gichuru rd,kingara rd', '', '', '', 'Customer', 0, 0, '2016-09-21 12:28:24', '2016-09-21 12:28:24', '', '', NULL),
(224, NULL, 'ali mohammed', '2016-09-21', '', '0722371822', 'riara wood hse no. B2, riara rd off ole dumme rd', '', '', '', 'Customer', 0, 0, '2016-09-21 12:31:29', '2016-09-21 12:31:29', '', '', NULL),
(225, NULL, 'SAYANA GRILL & BAR', '2016-09-21', '', '', 'KAREN', '', '', '', 'Customer', 0, 0, '2016-09-21 12:47:52', '2016-09-21 12:47:52', '', '', NULL),
(226, NULL, 'KILIMANJARO FOOD COURT', '2016-09-22', '', '', 'KILIMANJARO RD', '', '', '', 'Customer', 0, 0, '2016-09-22 12:13:53', '2016-09-22 12:13:53', '', '', NULL),
(227, NULL, 'Tin Roof Cafe', '2016-09-23', '', '', '', '', 'Tin roof cafe; souk next to The Hub', '', 'Customer', 0, 0, '2016-09-23 12:51:59', '2016-09-23 12:51:59', '', '', NULL),
(228, NULL, 'Jedydah Keya', '2016-09-24', '', '', 'Loresho; block H ;hse 3D', '', '', '', 'Customer', 0, 0, '2016-09-24 13:33:18', '2016-09-24 13:33:18', '', '', NULL),
(229, NULL, 'Caroline Njeri', '2016-09-24', '', '0722494645', 'junction apertmernt; Hse A9', '', '', '', 'Customer', 0, 0, '2016-09-24 13:37:23', '2016-09-24 13:37:23', '', '', NULL),
(230, NULL, 'Isabel Wangeci', '2016-09-26', '', '07213128525', 'mararo court hse no. A32,MARARO RD', '', '', '', 'Customer', 0, 0, '2016-09-26 13:20:43', '2016-09-26 13:20:43', '', '', NULL),
(231, NULL, 'beth mwangi', '2016-09-28', '', '', 'tetui housing hse no. D4,statehouse avenue', '', '', '', 'Customer', 0, 0, '2016-09-28 11:35:35', '2016-09-28 11:35:35', '', '', NULL),
(232, NULL, 'Lillian Mada', '2016-09-29', '', '0725680530', 'karuri court Block 44B,GROUND FLR. MADARAKA next to strathmore uni', '', '', '', 'Customer', 0, 0, '2016-09-29 07:25:52', '2016-09-29 07:25:52', '', '', NULL),
(233, NULL, 'Justus', '2016-09-30', '', '0722257789', 'mbagathi road; madaraka; sikawa ', '', '', '', 'Customer', 0, 0, '2016-09-30 06:39:53', '2016-09-30 06:39:53', '', '', NULL),
(234, NULL, 'Salma Khaldi', '2016-10-02', '', '0721101627', 'Adams', '', '', '', 'Customer', 0, 0, '2016-10-02 09:21:07', '2016-10-02 09:21:07', '', '', NULL),
(235, NULL, 'Vanronaldo CHESTER Food COURT', '2016-10-03', '', '', 'GALLERIA MALL,FIRST FLOOR', '', '', '', 'Customer', 0, 0, '2016-10-03 09:20:47', '2016-10-03 09:20:47', '', '', NULL),
(236, NULL, 'emily', '2016-10-03', '', '', 'langata rd', '', '', '', 'Customer', 0, 0, '2016-10-03 12:02:24', '2016-10-03 12:02:24', '', '', NULL),
(237, NULL, 'peter loresho', '2016-10-03', '', '', 'loresho springs hse no. A5A, LORESHO', '', '', '', 'Customer', 0, 0, '2016-10-03 12:38:41', '2016-10-03 12:38:41', '', '', NULL),
(238, NULL, 'Eastern Gardens Chineese', '2016-10-04', '', '0722524141', 'westlands', 'QIU XIN', '', '', 'Customer', 0, 0, '2016-10-04 12:22:17', '2016-10-04 12:22:17', '', '', NULL),
(239, NULL, 'DEBORAH-kivi', '2016-10-04', '', '', 'kivi milimani hse no. 1706', '', '', '', 'Customer', 0, 0, '2016-10-04 12:24:48', '2016-10-04 12:24:48', '', '', NULL),
(240, NULL, 'margaret lidoro', '2016-10-04', '', '', 'lamp court.kayahwe rd', '', '', '', 'Customer', 0, 0, '2016-10-04 12:28:37', '2016-10-04 12:28:37', '', '', NULL),
(241, NULL, 'Musa Kibera', '2016-10-06', '', '0714432349', 'DC Kibera', '', '', '', 'Customer', 0, 0, '2016-10-06 11:34:42', '2016-10-06 11:34:42', '', '', NULL),
(242, NULL, 'Jeans carol', '2016-10-07', '', '0721436759', 'bloomfield hse no. 204, muringa rd', '', '', '', 'Customer', 0, 0, '2016-10-07 12:58:28', '2016-10-07 12:58:28', '', '', NULL),
(243, NULL, 'winnie', '2016-10-07', '', '072580350', 'laikipia rd,opp viraj gardens. there is a masionette with many trees hse no. 17. grilled gate with black color', '', '', '', 'Customer', 0, 0, '2016-10-07 13:00:25', '2016-10-07 13:00:25', '', '', NULL),
(244, NULL, 'yvonne kanyembo', '2016-10-07', '', '0795467429', 'riverside hse no. 65,next to chile embassy', '', '', '', 'Customer', 0, 0, '2016-10-07 13:01:52', '2016-10-07 13:01:52', '', '', NULL),
(245, NULL, 'Cloud hotel / YEGO', '2016-10-07', '', '', 'westlands', '', '', '', 'Customer', 0, 0, '2016-10-07 13:03:38', '2016-10-07 13:03:38', '', '', NULL),
(246, NULL, 'Father Jacob Mattappillil', '2016-10-07', '', '0736691915', 'vincentian prayer hse,amboseli rd lavington', '', '', 'mtplsaji@yahoo.com', 'Customer', 0, 0, '2016-10-07 13:06:18', '2016-10-07 13:07:12', '', '', NULL),
(247, NULL, 'margaret kinyanjui', '2016-10-08', '', '0722659558', 'loresho springs block D4A', '', '', '', 'Customer', 0, 0, '2016-10-08 13:41:59', '2016-10-08 13:41:59', '', '', NULL),
(248, NULL, 'Pauline Muhoho', '2016-10-08', '', '0727395632', 'pritt lane hse no. C5,likoni lane', '', '', '', 'Customer', 0, 0, '2016-10-08 13:44:31', '2016-10-08 13:44:31', '', '', NULL),
(249, NULL, 'kivi milimani APARTMENTS', '2016-10-09', '', '', 'kivi milimani apt', '', '', '', 'Customer', 0, 0, '2016-10-09 12:55:00', '2016-12-09 15:39:23', 'Domestic', '', NULL),
(251, NULL, 'Edna Gitei C/O  Gateman', '2016-10-19', '', '0726540030', '', '', '0726540030', '', 'Customer', 0, 0, '2016-10-19 15:31:03', '2016-10-19 15:31:03', 'Domestic', '', NULL),
(252, NULL, 'loydre loydre', '2016-10-20', '', '0738856238', 'adex court hse no. 14,ndemi rd.', '', 'ssloydre1979@yahoo.com', '', 'Customer', 0, 0, '2016-10-20 15:47:20', '2016-10-20 15:47:20', 'Domestic', '', NULL),
(253, NULL, 'RUTH MBUGUA', '2016-10-21', '', '0722857062', 'Mwewe apt hse no. A1 .KANGUNDO RD.KILELESHWA', '', '0722857062', '', 'Customer', 0, 0, '2016-10-21 16:29:43', '2016-10-21 16:29:43', 'Domestic', '', NULL),
(254, NULL, 'monica agum', '2016-10-22', '', '0717865342', 'riara tone hse no. 8,riara road', '', '0717865342', '', 'Customer', 0, 0, '2016-10-22 14:57:02', '2016-10-22 14:57:02', 'Domestic', '', NULL),
(255, NULL, 'travel cafe', '2016-10-22', '', '', 'kileleshwa', '', 'travel cafe', '', 'Customer', 0, 0, '2016-10-22 14:58:53', '2016-10-22 15:00:10', 'Institutional', '', NULL),
(256, NULL, 'metropolis hotel', '2016-10-22', '', '0716502882', 'mazeras rd', '', '0716502882', '', 'Customer', 0, 0, '2016-10-22 14:59:53', '2016-10-22 14:59:53', 'Institutional', '', NULL),
(257, NULL, 'Alice Kimanzi', '2016-10-24', '', '0715628137', 'Ngong', '', '0715628137', '', 'Customer', 0, 0, '2016-10-24 10:06:56', '2016-10-24 10:06:56', 'Domestic', '', NULL),
(258, NULL, 'Mbithe Kimathi', '2016-10-24', '', '0703843923', 'Jipe close:maruti plaza hse D6', '', '0703843923', '', 'Customer', 0, 0, '2016-10-24 15:49:07', '2016-10-24 15:49:07', 'Domestic', '', NULL),
(259, NULL, 'Newton Kinuthia', '2016-10-25', '', '0724517567', 'statehouse; nxt to knec kenya', '', '0724517567', '', 'Customer', 0, 0, '2016-10-25 14:15:40', '2016-10-25 14:15:40', 'Domestic', '', NULL),
(260, NULL, 'Ann Mburu', '2016-10-25', '', '0721812978/ 0722882190', 'Delamere flats;hse.F34', '', '0721812978', '', 'Customer', 0, 0, '2016-10-25 14:25:42', '2016-10-25 14:25:42', 'Domestic', '', NULL),
(261, NULL, 'jeremy obado', '2016-10-26', '', '0725392143', 'sapphire park hse no. B1,nyeri rd.kileleshwa', '', 'jayobado@hotmail.com', '', 'Customer', 0, 0, '2016-10-26 11:44:15', '2016-10-26 11:44:15', 'Domestic', '', NULL),
(262, NULL, 'Dinners NHC', '2016-10-27', '', '', 'TOWN NAIROBI', '', 'dinners nhc', '', 'Customer', 0, 0, '2016-10-27 06:55:01', '2016-10-27 06:55:01', 'Institutional', '', NULL),
(263, NULL, 'NEREA AMUKONYI', '2016-10-27', '', '0722797007', 'loresho springs hse no. J1B', '', '0722797007', '', 'Customer', 0, 0, '2016-10-27 16:22:17', '2016-10-27 16:22:17', 'Domestic', '', NULL),
(264, NULL, 'Gordon Jamal', '2016-10-28', '', '0721446205', '', '', '0721446205', '', 'Customer', 0, 0, '2016-10-28 14:37:06', '2016-10-28 14:37:06', 'Domestic', '', NULL),
(265, NULL, 'Sarah Ngugi', '2016-10-28', '', '0722842665', 'Westlands                                                                                                                                                                             Jambo regency;hse C1;Waiyaki way opp St Mark Church                      ', '', '0722842665', '', 'Customer', 0, 0, '2016-10-28 15:02:15', '2016-10-28 15:02:15', 'Domestic', '', NULL),
(266, NULL, 'Julie Luseno', '2016-10-28', '', '0722369073', 'hurlighum;argwings khodhek rd; nxt gate after nairobi womens', '', '0722369073', '', 'Customer', 0, 0, '2016-10-28 15:04:27', '2016-10-28 15:04:27', 'Domestic', '', NULL),
(267, NULL, 'wangui mwaniki', '2016-10-29', '', '0722709219', 'Raphta rd; 80; Hse B2', '', '0722709219', '', 'Customer', 0, 0, '2016-10-29 16:00:15', '2016-10-29 16:00:15', 'Domestic', '', NULL),
(268, NULL, 'Monikos limited', '2016-10-31', '', '', 'valley arcade,willson airport.', '', 'monikos ltd', '', 'Customer', 0, 0, '2016-10-31 14:06:23', '2016-10-31 14:06:23', 'Institutional', '', NULL),
(269, NULL, 'andrew waititu ngunya', '2016-11-02', '', '', 'nandi road', '', 'andy', '', 'Customer', 0, 0, '2016-11-02 14:31:51', '2016-11-02 14:31:51', 'Domestic', '', NULL),
(270, NULL, 'edwin simiyu', '2016-11-02', '', '', 'raphta road', '', 'eddy', '', 'Customer', 0, 0, '2016-11-02 14:34:00', '2016-11-02 14:34:00', 'Domestic', '', NULL),
(271, NULL, 'Rehema Sonnie', '2016-11-03', '', '0722109399', 'brookside heights hse no. A7,westy,on brookside drive off lower kabete', '', 'soniekamotho@gmail.com', '', 'Customer', 0, 0, '2016-11-03 14:14:34', '2016-11-03 14:14:34', 'Domestic', '', NULL),
(272, NULL, 'Nancy Muigai', '2016-11-05', '', '0721710506', 'Delamere flats:Block A12', '', '0721710506', '', 'Customer', 0, 0, '2016-11-05 15:59:19', '2016-11-05 15:59:19', 'Domestic', '', NULL),
(273, NULL, 'pekeshe', '2016-11-07', '', '', 'karen', '', 'pekeshe hotel', '', 'Customer', 0, 0, '2016-11-07 15:41:10', '2016-11-07 15:41:10', 'Institutional', '', NULL),
(274, NULL, 'parklands villas', '2016-11-07', '', '0722801632', 'parklands', '', 'hiram kagiri', '', 'Customer', 0, 0, '2016-11-07 16:13:10', '2016-11-07 16:13:10', 'Institutional', '', NULL);
INSERT INTO `clients` (`id`, `code`, `name`, `date`, `email`, `phone`, `address`, `contact_person`, `contact_person_phone`, `contact_person_email`, `type`, `percentage_discount`, `balance`, `created_at`, `updated_at`, `category`, `category1`, `credit`) VALUES
(275, NULL, 'KALWOON CHINEESE RESTAURANT', '2016-11-08', '', '0732566167', 'KOINANGE STREET', '', 'QWNOON', '', 'Customer', 0, 0, '2016-11-08 16:54:13', '2016-11-12 15:44:06', 'Institutional', '', NULL),
(276, NULL, 'Ethiopian Hamame', '2016-11-09', '', '0700166926', 'white gate hse no.8, opp metropolitan, hurlingham', '', 'Ethiopian hamame', '', 'Customer', 0, 0, '2016-11-09 07:41:22', '2016-11-09 07:41:22', 'Domestic', '', NULL),
(277, NULL, 'Josephine ', '2016-11-09', '', '0720700640', 'kahawa wendani07', '', '0700805523', '', 'Customer', 0, 0, '2016-11-09 09:27:59', '2016-11-09 09:27:59', 'Domestic', '', NULL),
(278, NULL, 'Shamim hasman ', '2016-11-09', '', '0727626557', 'Katanja,d.c kibera', '', '0727626557', '', 'Customer', 0, 2000, '2016-11-09 10:16:49', '2016-11-09 15:11:26', 'Domestic', '', NULL),
(279, NULL, 'Selle c/o timon', '2016-11-09', '', '', 'kibera,karanja', '', 'selle c/o timon', '', 'Customer', 0, 0, '2016-11-09 15:07:30', '2016-11-09 15:07:30', 'Domestic', '', NULL),
(280, NULL, 'panda chineese restaurant / tang qin', '2016-11-09', '', '0722271666', 'TOWN NAIROBI', '', '0722271666', '', 'Customer', 0, 0, '2016-11-09 15:42:58', '2016-11-09 15:42:58', 'Domestic', '', NULL),
(281, NULL, 'CLUB FIESTA', '2016-11-10', '', '', 'RUAKA,RUNDA', '', 'One to one', '', 'Customer', 0, 7500, '2016-11-10 13:25:09', '2016-11-10 13:25:09', 'Institutional', '', NULL),
(282, NULL, 'Samuel kamiti', '2016-11-10', '', '0723831014', 'kamiti court---- office 5th ngong road', '', '0723831014', '', 'Customer', 0, 0, '2016-11-10 13:30:09', '2016-11-10 15:29:10', 'Domestic', '', NULL),
(283, NULL, 'Brian Green Park', '2016-11-11', '', '0700931355', '', '', '0700931355', '', 'Customer', 0, 0, '2016-11-11 16:02:26', '2016-11-11 16:02:26', 'Domestic', '', NULL),
(284, NULL, 'GRACE KIMANI', '2016-11-12', '', '0729337802', 'Maryland apt hse no. C2,off waiyaki way past kianda school ,opp engen petrol station', '', '0729337802', '', 'Customer', 0, 0, '2016-11-12 15:43:24', '2016-11-12 15:43:24', 'Domestic', '', NULL),
(285, NULL, 'Blueberry HOTEL', '2016-11-17', '', '0721154011', 'upperhill ,next to java house', '', '0721154011', '', 'Customer', 0, 0, '2016-11-17 13:07:34', '2016-11-17 13:07:34', 'Institutional', '', NULL),
(286, NULL, 'Barack MUSYOKI', '2016-11-17', '', '0710593525', 'kindaruma court hse no. B5, kindaruma road', '', '0710593525', '', 'Customer', 0, 0, '2016-11-17 13:09:57', '2016-11-17 13:09:57', 'Domestic', '', NULL),
(287, NULL, 'NAIROBI SAFARI CLUB', '2016-11-17', '', '', 'nairobi safari club', '', 'nairobi safari club', '', 'Customer', 0, 0, '2016-11-17 15:02:01', '2016-11-17 15:02:01', 'Institutional', '', NULL),
(288, NULL, 'Yasmeen Baloch', '2016-11-18', '', '0722511910', 'lavington;zima springs road; on the right ; gate 80', '', '07225119101', '', 'Customer', 0, 0, '2016-11-18 15:35:27', '2016-11-18 15:35:27', 'Domestic', '', NULL),
(289, NULL, 'Natives', '2016-11-18', '', '', '', '', '0713877659 nancy', '', 'Customer', 0, 0, '2016-11-18 15:40:35', '2016-11-18 15:40:35', 'Institutional', '', NULL),
(290, NULL, 'Doreen', '2016-11-21', '', '0722609129', 'georgia mansion hse no. 4, statehouse rd', '', '0722609129', '', 'Customer', 0, 0, '2016-11-21 16:30:03', '2016-11-21 16:30:03', 'Domestic', '', NULL),
(291, NULL, 'Homeland LOUNGE', '2016-11-22', '', '070034309', 'THIKA ROAD', '', '070034309', '', 'Customer', 0, 0, '2016-11-22 07:18:06', '2016-11-22 07:18:06', 'Institutional', '', NULL),
(292, NULL, 'JACARANDA HOTELS', '2016-11-26', '', '0735286132', 'westlands,grove', '', '0724595706', '', 'Customer', 0, 0, '2016-11-26 15:02:28', '2016-11-26 15:02:28', 'Institutional', '', NULL),
(293, NULL, 'ann siz', '2016-11-27', '', '0796133254', 'great cliff apt,muringa rd', '', '0796133254', '', 'Customer', 0, 0, '2016-11-27 13:54:49', '2016-11-27 13:54:49', 'Domestic', '', NULL),
(294, NULL, 'cafe republik & bar', '2016-12-02', '', '254', 'container city,langiri rd', '', '254', '', 'Customer', 0, 0, '2016-12-02 11:16:25', '2016-12-02 11:16:25', 'Institutional', '', NULL),
(295, NULL, 'joyce gitangu', '2016-12-03', '', '0716342400', 'chalbi court hse no.14,chalbi drive ', '', '0716342400', '', 'Customer', 0, 0, '2016-12-03 16:02:46', '2016-12-03 16:02:46', 'Domestic', '', NULL),
(296, NULL, 'maxland restaurant', '2016-12-03', '', '0723003137', 'westlands & thika rd ', '', '0723003137', '', 'Customer', 0, 0, '2016-12-03 16:05:08', '2016-12-03 16:05:08', 'Institutional', '', NULL),
(297, NULL, 'Shushi', '2016-12-05', '', '', '', '', '1', '', 'Customer', 0, 0, '2016-12-05 16:33:51', '2016-12-05 16:33:51', 'Institutional', '', NULL),
(298, NULL, 'John Ngugi', '2016-12-05', '', '', '', '', '07', '', 'Customer', 0, 0, '2016-12-05 16:35:19', '2016-12-05 16:35:19', 'Domestic', '', NULL),
(299, NULL, 'Wycliff', '2016-12-05', '', '', '', '', '0', '', 'Customer', 0, 0, '2016-12-05 16:35:49', '2016-12-05 16:35:49', 'Domestic', '', NULL),
(300, NULL, 'ORIGINAL HOT POT', '2016-12-10', '', '0704529258', 'LENANA ROAD', '', '0704529258', '', 'Customer', 0, 0, '2016-12-10 16:00:57', '2016-12-10 16:00:57', 'Institutional', '', NULL),
(301, NULL, 'UNIVERSAL CUISINES', '2016-12-12', '', '0722305022', 'chicken world', '', '0722305022', '', 'Customer', 0, 0, '2016-12-12 16:21:51', '2016-12-12 16:21:51', 'Institutional', '', NULL),
(302, NULL, 'Sherehez', '2016-12-14', '', '0722953922', '', '', '0722953922', '', 'Customer', 0, 0, '2016-12-14 05:04:14', '2016-12-14 05:04:14', 'Institutional', '', NULL),
(303, NULL, 'Caroline Mwende Munguti', '2016-12-14', '', '', 'naivasha road;nxt to riara school; Hse A3', '', '0727796267', '', 'Customer', 0, 0, '2016-12-14 16:27:07', '2016-12-14 16:27:07', 'Domestic', '', NULL),
(304, NULL, 'James Muiruri', '2016-12-15', '', '0722320949', '', '', '0722320949', '', 'Customer', 0, 0, '2016-12-15 16:37:25', '2016-12-15 16:37:25', 'Institutional', '', NULL),
(305, NULL, 'Peter SHIMA apts', '2016-12-16', '', '0725623287', 'shima apt hse no. D5,KAYAHWE RD', '', '0725623287', '', 'Customer', 0, 0, '2016-12-16 15:12:11', '2016-12-16 15:12:11', 'Domestic', '', NULL),
(306, NULL, 'carol gitau', '2016-12-16', '', '0726966590', 'funguo estate hse no. 23,mbagathi way', '', '0726966590', '', 'Customer', 0, 0, '2016-12-16 16:21:35', '2016-12-16 16:21:35', 'Domestic', '', NULL),
(307, NULL, 'IMPALA HOTEL', '2016-12-18', '', '0717427353', 'parklands opp parklands police station', '', '0717427353', '', 'Customer', 0, 0, '2016-12-18 16:41:56', '2016-12-18 16:41:56', 'Institutional', '', NULL),
(308, NULL, 'juma', '2016-12-19', '', '0720442290', 'milla estate hse no. 10,tmall next to moi educational center', '', '0720442290', '', 'Customer', 0, 0, '2016-12-19 15:37:08', '2016-12-19 15:37:08', 'Domestic', '', NULL),
(309, NULL, 'Jane Apiyo', '2016-12-22', '', '', 'Adams woodley', '', '0720870817', '', 'Customer', 0, 0, '2016-12-22 16:46:27', '2016-12-22 16:46:27', 'Domestic', '', NULL),
(310, NULL, 'Assia Shidane', '2016-12-22', '', '', 'Ngara', '', '0722207632', '', 'Customer', 0, 0, '2016-12-22 16:48:19', '2016-12-22 16:48:19', 'Domestic', '', NULL),
(311, NULL, 'KAREN FASHER', '2016-12-23', '', '0703452696', 'ndemi court hse no. 15,ndemi rd', '', '0703452696', '', 'Customer', 0, 0, '2016-12-23 16:18:36', '2016-12-23 16:18:36', 'Domestic', '', NULL),
(312, NULL, 'BETTY ONYANGO', '2016-12-26', '', '0713229162', 'golf course2 hse no. ', '', '0713229162', '', 'Customer', 0, 0, '2016-12-26 16:15:56', '2016-12-26 16:15:56', 'Domestic', '', NULL),
(313, NULL, 'vICTOR OKELLO', '2016-12-26', '', '0792501320', 'Adams woodley', '', '0792501320', '', 'Customer', 0, 0, '2016-12-26 16:26:18', '2016-12-26 16:26:18', 'Domestic', '', NULL),
(314, NULL, 'Alvan Njeru Njagi(vaite)', '2016-12-27', '', '', '0724517389', '', '0724517389', '', 'Customer', 0, 0, '2016-12-27 16:19:13', '2016-12-27 16:19:13', 'Domestic', '', NULL),
(315, NULL, 'FRANK ALILA', '2016-12-28', '', '0725711091', 'JAMHURI 1st green gate hse no. 52', '', '0725711091', '', 'Customer', 0, 0, '2016-12-28 16:22:47', '2016-12-28 16:22:47', 'Domestic', '', NULL),
(316, NULL, 'WOK EXPRESS', '2016-12-28', '', '0726803371', 'WOK EXPRESS', '', '0726803371', '', 'Customer', 0, 0, '2016-12-28 16:23:47', '2016-12-28 16:24:21', 'Institutional', '', NULL),
(317, NULL, 'TITUS ONYAPIDI', '2016-12-28', '', '0727703851', 'riara pitt,next to rira primary', '', '0727703851', '', 'Customer', 0, 0, '2016-12-28 16:27:43', '2016-12-28 16:27:43', 'Domestic', '', NULL),
(318, NULL, 'Susan Muchene', '2017-01-25', '', '0722446137', 'waterlilly apt jamhury', '', '0722446137', '', 'Customer', 0, 0, '2017-01-25 16:41:32', '2017-01-25 16:41:32', 'Domestic', '', NULL),
(319, NULL, 'mercy kigali', '2017-01-30', '', '0726364794', 'ferosa court hse no. A5,mbaazi avenue', '', '0726364794', '', 'Customer', 0, 0, '2017-01-30 15:41:53', '2017-01-30 15:41:53', 'Domestic', '', NULL),
(320, NULL, 'lily cheboror', '2017-01-31', '', '0726864289', 'kirichwa road,opp willow court with a flowery wall', '', '0726864289', '', 'Customer', 0, 0, '2017-01-31 16:53:02', '2017-01-31 16:53:02', 'Domestic', '', NULL),
(321, NULL, 'joan oburu', '2017-02-04', '', '0722935581', 'taj gardens hse no. B8.githunguri rd kileleshwa', '', '0722935581', '', 'Customer', 0, 0, '2017-02-04 14:16:21', '2017-02-04 14:16:21', 'Domestic', '', NULL),
(322, NULL, 'ESTHER waititu', '2017-02-04', '', '0739741644', 'the estatee hse no. 2.Nandi road', '', '0739741644', '', 'Customer', 0, 0, '2017-02-04 14:17:25', '2017-02-04 14:17:25', 'Domestic', '', NULL),
(323, NULL, 'JIWEKE TARVERN', '2017-02-05', '', '0728333985 OR 0726812619', 'ngong rd behind china center', '', '0728333985 OR 0726812619', 'jiweketarvern@gmail.com', 'Customer', 0, 0, '2017-02-05 16:39:17', '2017-02-05 16:39:17', 'Institutional', '', NULL),
(324, NULL, 'LIYU GERMACHEWS', '2017-02-05', '', '0713340505', 'Kivi milimani apt hse no. 606', '', '0713340505', '', 'Customer', 0, 0, '2017-02-05 16:57:49', '2017-02-05 16:57:49', 'Institutional', '', NULL),
(325, NULL, 'selanga', '2017-02-10', '', '0728615615', ' gikuyu close. green gate on the left hse no. H7 opp jehova witness before racecourse', '', '0728615615', '', 'Customer', 0, 0, '2017-02-10 16:03:45', '2017-02-10 16:03:45', 'Domestic', '', NULL),
(326, NULL, 'EVAIRENE MWARA', '2017-02-12', '', '0721316324', 'kirichwa grove fist hse on the left hse no. 1.office park. riveside drive', '', '0721316324', '', 'Customer', 0, 0, '2017-02-12 15:31:13', '2017-02-12 15:31:13', 'Domestic', '', NULL),
(327, NULL, 'Kingdom Gardens', '2017-02-13', '', '0788472332', 'Muthaiga', '', '0788472332', '', 'Customer', 0, 0, '2017-02-13 15:41:02', '2017-02-13 15:41:02', 'Institutional', '', NULL),
(328, NULL, 'Philmont Oriko', '2017-02-13', '', '0713247627', '', '', '0713247627', '', 'Customer', 0, 0, '2017-02-13 15:42:11', '2017-02-13 15:42:11', 'Domestic', '', NULL),
(329, NULL, 'Edith Nyakhoa', '2017-02-15', '', '0721318713', 'lower kabete;lake view estate;elementai close;hse20', '', '0721318713', '', 'Customer', 0, 0, '2017-02-15 08:14:35', '2017-02-15 08:14:35', 'Domestic', '', NULL),
(330, NULL, 'james muiruri', '2017-02-19', '', '0721837177', 'rongai', '', '0721837177', '', 'Customer', 0, 0, '2017-02-19 16:45:45', '2017-02-19 16:45:45', 'Domestic', '', NULL),
(331, NULL, 'Peponi Springs', '2017-02-23', '', '', '', '', '0733336644', '', 'Customer', 0, 0, '2017-02-23 16:59:04', '2017-02-23 16:59:04', 'Institutional', '', NULL),
(332, NULL, 'mike rubia/faith wambua', '2017-09-01', '', '0704431143 ', 'eden falls, atheru road , amboseli road', '0704431143 ', '0704431143 ', '', 'Customer', 0, 0, '2017-09-01 14:42:22', '2017-09-01 14:42:22', 'Domestic', '', NULL),
(333, NULL, 'spice lounge', '2017-09-01', '', '0795629707', '', '', '0795629707', '', 'Customer', 0, 0, '2017-09-01 15:10:31', '2017-09-01 15:10:31', 'Institutional', '', NULL),
(334, NULL, 'gem suites riverside', '2017-09-01', '', '0715628130', '', '', '0715628130', '', 'Customer', 0, 0, '2017-09-01 15:24:14', '2017-09-01 15:24:14', 'Institutional', '', NULL),
(335, NULL, 'club 1824', '2017-09-01', '', '0715818260', '', '', '0715818260', '', 'Customer', 0, 0, '2017-09-01 16:31:28', '2017-09-01 16:31:28', 'Institutional', '', NULL),
(336, NULL, 'gazlin energy', '2017-09-02', 'wangoken2@gmail.com', '0720439497', '', '', '0720439497', '', 'Supplier', 0, 0, '2017-09-02 11:04:44', '2017-10-05 08:35:59', 'Institutional', '', NULL),
(337, NULL, 'clearence', '2017-09-02', '', '0711509050', '', '', '0711509050', '', 'Customer', 0, 0, '2017-09-02 15:51:36', '2017-09-02 15:51:36', 'Institutional', '', NULL),
(338, NULL, 'parklands villa', '2017-09-02', '', '0712040692', '', '', '0712040692', '', 'Customer', 0, 0, '2017-09-02 16:27:32', '2017-09-02 16:27:32', 'Institutional', '', NULL),
(339, NULL, 'peponi springs', '2017-09-02', '', '0725336644', '', '', '0725336644', '', 'Customer', 0, 0, '2017-09-02 16:31:54', '2017-09-02 16:31:54', 'Institutional', '', NULL),
(340, NULL, 'wallmatt', '2017-09-02', '', '0705577667', '', '', '0705577667', '', 'Customer', 0, 0, '2017-09-02 16:41:07', '2017-09-02 16:41:07', 'Institutional', '', NULL),
(341, NULL, 'red tarvern', '2017-09-02', '', '0721862441', '', '', '0721862441', '', 'Customer', 0, 0, '2017-09-02 16:53:29', '2017-09-02 16:53:29', 'Institutional', '', NULL),
(342, NULL, 'dinners', '2017-09-02', '', '0721511599', '', '', '0721511599', '', 'Customer', 0, 0, '2017-09-02 16:57:20', '2017-09-02 16:57:20', 'Institutional', '', NULL),
(343, NULL, 'red office', '2017-09-02', '', '', '', '', '0710808757', '', 'Customer', 0, 0, '2017-09-02 17:07:33', '2017-09-02 17:07:33', 'Institutional', '', NULL),
(344, NULL, 'keneles', '2017-09-02', '', '', '', '', '0721893096', '', 'Customer', 0, 0, '2017-09-02 17:24:26', '2017-09-02 17:24:26', 'Institutional', '', NULL),
(345, NULL, 'finix casino', '2017-09-03', '', '0700049217', '', '', '0700049217', '', 'Customer', 0, 0, '2017-09-03 09:11:32', '2017-09-03 09:11:32', 'Institutional', '', NULL),
(346, NULL, 'hoffmann', '2017-09-03', '', '', '', '', '0722762937', '', 'Customer', 0, 0, '2017-09-03 12:32:11', '2017-09-03 12:32:11', 'Domestic', '', NULL),
(347, NULL, 'Fred Gachoka', '2017-09-04', '', '0721479269', '', '', '0721479269', '', 'Customer', 0, 0, '2017-09-03 21:22:09', '2017-09-03 21:22:09', 'Domestic', '', NULL),
(348, NULL, 'mrs njau', '2017-09-04', '', '0725730013', 'Athero road,princess park house no D2', '', '0725730013', '', 'Customer', 0, 0, '2017-09-04 14:44:46', '2017-09-04 14:44:46', 'Domestic', '', NULL),
(349, NULL, 'thermo restraunt', '2017-09-04', '', '0736770736', 'kenya re', '', '0736770736', '', 'Customer', 0, 0, '2017-09-04 15:51:51', '2017-09-04 15:51:51', 'Institutional', '', NULL),
(350, NULL, 'steve gitonga', '2017-09-04', '', '0725203883', 'ngong road  oop morningside woodley court no3', '', '0725203883', '', 'Customer', 0, 0, '2017-09-04 16:53:17', '2017-09-04 16:53:17', 'Domestic', '', NULL),
(351, NULL, 'one to one cateres/ club fiesta', '2017-09-05', '', '0725133011', 'club fiesta,past two rivers mall next to animal feeds', '', '0725133011', '', 'Customer', 0, 0, '2017-09-05 05:02:51', '2017-09-05 05:02:51', 'Institutional', '', NULL),
(352, NULL, 'winum', '2017-09-05', '', '0720806603', '', '', '0720806603', '', 'Customer', 0, 0, '2017-09-05 13:18:36', '2017-09-05 13:18:36', 'Institutional', '', NULL),
(353, NULL, 'david ouko', '2017-09-05', '', '0728692864', 'shell ringroad kileleshwa', '', '0728692864', '', 'Customer', 0, 0, '2017-09-05 13:48:41', '2017-09-05 13:48:41', 'Domestic', '', NULL),
(354, NULL, 'gem siutes statehouse', '2017-09-06', '', '0202635543', 'statehouse', '', '0202635543', '', 'Customer', 0, 0, '2017-09-06 16:08:06', '2017-09-06 16:08:06', 'Institutional', '', NULL),
(355, NULL, 'Mama pharez', '2017-09-07', '', '0701017978', 'neema court hse G5', '', '0701017978', '', 'Customer', 0, 0, '2017-09-07 06:32:07', '2017-09-07 06:32:07', 'Domestic', '', NULL),
(356, NULL, 'faith sila sila', '2017-09-08', '', '', '', '', '0727948710', '', 'Customer', 0, 0, '2017-09-08 05:58:09', '2017-09-08 05:58:09', 'Domestic', '', NULL),
(357, NULL, 'thermo restraunt', '2017-09-08', '', '+254736770736', 'kenya re', '', '0701350615', '', 'Customer', 0, 0, '2017-09-08 08:36:08', '2017-09-08 08:36:08', 'Institutional', '', NULL),
(358, NULL, 'red ruby', '2017-09-08', '', '', '', '', '0723412858', '', 'Customer', 0, 0, '2017-09-08 08:41:43', '2017-09-08 08:41:43', 'Institutional', '', NULL),
(359, NULL, 'rendevours', '2017-09-08', '', '', '', '', '0720941527', '', 'Customer', 0, 0, '2017-09-08 08:45:29', '2017-09-08 08:45:29', 'Institutional', '', NULL),
(360, NULL, 'Chriustian Sabwa', '2017-09-11', '', '0737660195', '', '', '0737660195', '', 'Customer', 0, 0, '2017-09-11 05:39:34', '2017-09-11 05:39:34', 'Domestic', '', NULL),
(361, NULL, 'Samar/Suhail Abbasi', '2017-09-14', '', '0799387999', 'garden place hse no. A5,nxt to impala club', '', '0799387999', '', 'Customer', 0, 0, '2017-09-14 19:03:31', '2017-09-14 19:03:31', '', '', NULL),
(362, NULL, 'Vincent Omwaka', '2017-09-27', 'vomwaka12@gmail.com', '726630811', 'Harambe Ave, NHC', 'vincentqww', '726630877', 'vomwaka1223@gmail.com', 'Supplier', 0, 1200, '2017-09-27 10:01:10', '2017-09-27 10:01:10', 'Institutional', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `company_property`
--

CREATE TABLE `company_property` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `property_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `property_description` text COLLATE utf8_unicode_ci,
  `property_serial_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `property_digital_serial_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `issued_by` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `property_issue_date` date NOT NULL,
  `property_return_date` date NOT NULL,
  `property_amount` double(15,2) NOT NULL DEFAULT '0.00',
  `returned` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `received_by` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `shortname`, `created_at`, `updated_at`) VALUES
(1, 'Kenyan Shillings', 'KES', '2016-06-22 07:30:26', '2016-06-22 07:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` varchar(40) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(45) NOT NULL,
  `birthday` varchar(45) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `phone`, `created_at`, `updated_at`, `email`, `birthday`, `fname`, `lname`) VALUES
('1', '254700460888', '2017-06-01 13:14:41', '2017-07-02 16:15:06', 'eddiebranth@gmail.com', '1996-10-21', 'Eddie', 'Oirere'),
('10', '254715081980', '2017-06-05 07:01:48', '2017-06-05 07:01:48', 'mpanyako@gmail.com', '1989-3-12', 'Moses', 'Panyako'),
('10000001', '254721636546', '2017-06-29 20:43:32', '2017-06-29 20:43:32', 'muthoni.nyoike@yahoo.com', '1981-3-27', 'Muthoni', 'Nyoike'),
('11', '254725145304', '2017-06-05 11:20:50', '2017-06-05 11:20:50', 'wangoken2@gmail.com', '1990-5-13', 'kennedy', 'wango'),
('12', '254729683817', '2017-06-05 11:23:23', '2017-06-05 11:23:23', 'kelvin.makamu@lixnet.net', '1987-9-5', 'Kelvin', 'Makamu'),
('13', '254705299750', '2017-06-06 12:50:49', '2017-06-06 12:50:49', 'kotonyajuliet@gmail.com', '1981-3-17', 'Juliet', 'KOTONYA'),
('14', '254733639791', '2017-06-07 14:36:04', '2017-07-02 16:09:22', 'eddiebranth@gmail.com', '1996-10-21', 'Test', 'Don\'t Deliver'),
('15', '254733636330', '2017-06-08 12:37:13', '2017-06-08 12:37:13', 'dennismuriukikaranja@gmail.com', '2017-5-8', 'Dennis', 'Karanja'),
('16', '254722376756', '2017-06-08 15:48:24', '2017-06-08 15:48:24', 'kinyuajulius@gmail.com', '1976-0-30', 'Julius', 'Kinyua'),
('17', '254722609129', '2017-06-09 14:08:21', '2017-06-09 14:08:21', 'dokiri@gmail.com', '1980-5-1', 'Dee', 'Okiri'),
('18', '254726291777', '2017-06-09 18:42:27', '2017-06-09 18:42:27', 'm.oscar.james@gmail.com', '1978-11-11', 'Oscar', 'm'),
('19', '254707039661', '2017-06-09 22:11:06', '2017-06-09 22:11:06', 'suziemani@gmail.com', '2017-5-21', 'Su Zi', 'Mani'),
('2', '254718442980', '2017-06-02 14:41:02', '2017-06-02 14:41:02', 'gabriel.makokha@gx.co.ke', '1989-11-31', 'Gabriel', 'Makokha'),
('20', '254722257061', '2017-06-10 14:52:41', '2017-06-10 14:52:41', 'cambetsa@gmail.com', '2017-8-14', 'Christine', 'Ambetsa'),
('21', '254722222332', '2017-06-10 16:03:14', '2017-06-10 16:03:14', 'meg.nyamusi@gmail.com', '1983-9-17', 'Meg', 'Nyamusi'),
('22', '254733332027', '2017-06-10 16:22:17', '2017-06-10 16:22:17', 'austinotieno@hotmail.com', '1971-2-20', 'Austin', 'Otieno'),
('23', '254722769130', '2017-06-10 17:38:22', '2017-06-10 17:38:22', 'omakanda@gmail.com', '1983-5-21', 'Okalle', 'Makanda'),
('24', '254718260177', '2017-06-12 09:20:24', '2017-06-12 09:20:24', 'arobert@gmail.com', '2017-5-12', 'Alex', 'Robert'),
('25', '254723744071', '2017-06-12 15:12:08', '2017-06-12 15:12:08', 'hshakombo@gmail.com', '1985-4-12', 'Hanifa', 'Shakombo'),
('26', '254725815056', '2017-06-15 15:35:56', '2017-06-15 15:35:56', 'winnienamuli@gmail.com', '2017-10-6', 'winnie', 'namuli'),
('27', '254722540627', '2017-06-16 19:13:18', '2017-06-16 19:13:18', 'ngetichg@yahoo.com', '2017-1-14', 'Jeff', 'Ngetich'),
('28', '254790456462', '2017-06-16 19:27:45', '2017-06-16 19:27:45', 'emmanuelmbio@gmail.com', '1996-1-2', 'Emmanuel', 'Mbio'),
('29', '254714859267', '2017-06-17 07:31:21', '2017-06-17 07:31:21', 'paulin.o.achieng@gmail.com', '1984-10-1', 'pauline', 'Achieng'),
('3', '254724305011', '2017-06-03 04:40:47', '2017-06-03 04:40:47', 'victor.kotonya@gmail.com', '1976-10-27', 'victor', 'kotonya'),
('30', '254725926409', '2017-06-19 05:51:13', '2017-06-19 05:51:13', 'edgarkib.kibinge@gmail.com', '1986-10-10', 'Edgar', 'Kahindi'),
('31', '254721519897', '2017-06-19 11:19:31', '2017-06-19 11:19:31', 'stevelubz@gmail.com', '1982-8-25', 'Steve', 'Lubia'),
('32', '254763123456', '2017-06-19 13:01:38', '2017-06-19 13:01:38', 'bethkariuki@gmail.com', '1981-0-25', 'Beth', 'Kariuki'),
('4', '254722798098', '2017-06-03 09:45:28', '2017-06-03 09:45:28', 'kasangasylvia@gmail.com', '2017-6-14', 'sylvia', 'kasanga'),
('5', '254714688160', '2017-06-03 12:10:57', '2017-06-03 12:10:57', 'andrew.abwoga@gmail.com', '1990-5-11', 'andrew', 'abwoga'),
('6', '254707712191', '2017-06-03 17:06:23', '2017-06-03 17:06:23', 'bochere80@gmail.com', '1995-2-21', 'Liz', 'Bochere'),
('7', '254710623006', '2017-06-05 06:12:56', '2017-06-05 06:12:56', 'basil.ochola@gx.co.ke', '1988-1-2', 'Basil', 'Ochola'),
('8', '254701153555', '2017-06-05 06:26:01', '2017-06-05 06:26:01', 'miken@gmail.com', '2017-5-5', 'Mike', 'O'),
('9', '254717890470', '2017-06-05 06:51:16', '2017-06-05 06:51:16', 'info@gx.co.ke', '2014-10-27', 'Gas', 'Express');

-- --------------------------------------------------------

--
-- Table structure for table `deductions`
--

CREATE TABLE `deductions` (
  `id` int(10) UNSIGNED NOT NULL,
  `deduction_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `deductions`
--

INSERT INTO `deductions` (`id`, `deduction_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Salary Advance', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Loans', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Savings', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'Breakages and spoilages', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_locations`
--

CREATE TABLE `delivery_locations` (
  `order_id` varchar(45) NOT NULL,
  `location_id` varchar(40) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `delivery_locations`
--

INSERT INTO `delivery_locations` (`order_id`, `location_id`, `created_at`, `updated_at`) VALUES
('0c7e027d-169d-4975-acda-0be98d4104df', '5930134160415', '2017-06-01 13:55:56', '2017-06-01 13:55:56'),
('11001', '59380f549a83b', '2017-06-07 19:39:07', '2017-06-07 19:39:07'),
('11002', '59380f549a83b', '2017-06-07 19:45:53', '2017-06-07 19:45:53'),
('11003', '593178fe10b46', '2017-06-08 10:29:07', '2017-06-08 10:29:07'),
('11004', '593178fe10b46', '2017-06-08 13:16:48', '2017-06-08 13:16:48'),
('11005', '593178fe10b46', '2017-06-08 17:12:28', '2017-06-08 17:12:28'),
('11006', '5934ff64e850f', '2017-06-09 04:54:44', '2017-06-09 04:54:44'),
('11007', '5934ff64e850f', '2017-06-09 06:10:50', '2017-06-09 06:10:50'),
('11008', '593178fe10b46', '2017-06-09 08:31:46', '2017-06-09 08:31:46'),
('11009', '5934ff64e850f', '2017-06-09 08:32:34', '2017-06-09 08:32:34'),
('11010', '5934ff64e850f', '2017-06-09 14:53:15', '2017-06-09 14:53:15'),
('11011', '593aec1374300', '2017-06-09 18:47:00', '2017-06-09 18:47:00'),
('11012', '5934ff64e850f', '2017-06-11 14:40:08', '2017-06-11 14:40:08'),
('11013', '5934f97962233', '2017-06-13 11:50:23', '2017-06-13 11:50:23'),
('11014', '593f5b85806c7', '2017-06-13 16:46:36', '2017-06-13 16:46:36'),
('11015', '593f5b85806c7', '2017-06-13 17:36:39', '2017-06-13 17:36:39'),
('11016', '593f5b85806c7', '2017-06-13 17:54:23', '2017-06-13 17:54:23'),
('11017', '593f5b85806c7', '2017-06-13 17:57:42', '2017-06-13 17:57:42'),
('11018', '593f5b85806c7', '2017-06-13 18:00:31', '2017-06-13 18:00:31'),
('11019', '593f5b85806c7', '2017-06-13 18:02:35', '2017-06-13 18:02:35'),
('11020', '593f5b85806c7', '2017-06-13 18:08:16', '2017-06-13 18:08:16'),
('11021', '593f5b85806c7', '2017-06-13 18:09:54', '2017-06-13 18:09:54'),
('11022', '593f5b85806c7', '2017-06-13 19:23:52', '2017-06-13 19:23:52'),
('11023', '593f5b85806c7', '2017-06-13 20:17:11', '2017-06-13 20:17:11'),
('11024', '593eaf483fa7e', '2017-06-14 18:44:51', '2017-06-14 18:44:51'),
('11025', '5934f97962233', '2017-06-16 05:30:46', '2017-06-16 05:30:46'),
('11026', '5947b343a53f2', '2017-06-19 11:20:26', '2017-06-19 11:20:26'),
('11027', '59353e923e517', '2017-06-28 14:27:57', '2017-06-28 14:27:57'),
('11028', '593f5b85806c7', '2017-06-30 07:57:39', '2017-06-30 07:57:39'),
('11029', '593f5b85806c7', '2017-06-30 08:03:27', '2017-06-30 08:03:27'),
('11030', '5934ff64e850f', '2017-06-30 08:03:30', '2017-06-30 08:03:30'),
('11031', '593f5b85806c7', '2017-06-30 08:07:15', '2017-06-30 08:07:15'),
('11032', '5934ff64e850f', '2017-06-30 08:11:30', '2017-06-30 08:11:30'),
('11033', '593eaf483fa7e', '2017-07-02 05:08:20', '2017-07-02 05:08:20'),
('11034', '5934ff64e850f', '2017-07-07 17:48:54', '2017-07-07 17:48:54'),
('11035', '593971c84455b', '2017-07-09 05:45:12', '2017-07-09 05:45:12'),
('29f0d7bf-93a2-4e01-8473-a1965c916933', '59333602b9383', '2017-06-06 14:53:36', '2017-06-06 14:53:36'),
('52775402-144e-48a8-ab9e-f9d4fead1aed', '5930134160415', '2017-06-01 13:35:31', '2017-06-01 13:35:31'),
('580db8d7-4a1d-49c6-8cad-4d05fc502d73', '59333602b9383', '2017-06-06 15:41:24', '2017-06-06 15:41:24'),
('6876af20-943a-4fe0-9f3b-1649d4808d6f', '59333602b9383', '2017-06-06 15:42:25', '2017-06-06 15:42:25'),
('6b5cdb9f-8bfd-4306-b626-e276ec0c6dd2', '5930134160415', '2017-06-01 14:17:06', '2017-06-01 14:17:06'),
('88659ab1-25d7-420d-8c3a-0f73330fc15d', '5934f97962233', '2017-06-05 08:23:51', '2017-06-05 08:23:51'),
('8aa78708-7de9-4c31-a082-14394d2324b5', '5930134160415', '2017-06-01 13:31:31', '2017-06-01 13:31:31'),
('9b391040-3a79-4f4e-86ef-e08cc2dcb4d5', '59333602b9383', '2017-06-07 08:03:28', '2017-06-07 08:03:28'),
('a940d12a-023e-46a8-8c47-283c4b576de3', '59323dcf05859', '2017-06-03 04:42:45', '2017-06-03 04:42:45'),
('aa14a46b-62d3-4381-8d65-1c0ed01d0499', '5934f66871c03', '2017-06-05 06:15:11', '2017-06-05 06:15:11'),
('c48e7903-71b0-4586-892a-3d2e02a1b38a', '5934f66871c03', '2017-06-05 06:24:35', '2017-06-05 06:24:35'),
('d112fbed-3131-4bcd-9bf6-01a667353a02', '59333602b9383', '2017-06-06 13:48:50', '2017-06-06 13:48:50'),
('d55bb04c-577f-43be-bfd1-7ea61d42ad5f', '59333602b9383', '2017-06-06 11:44:23', '2017-06-06 11:44:23'),
('e0be88e9-5745-4de3-82b3-9dd04e33440f', '5930134160415', '2017-06-01 13:48:34', '2017-06-01 13:48:34'),
('f1787f5d-5aab-454c-816f-1d4c830a7a97', '59333602b9383', '2017-06-06 11:35:14', '2017-06-06 11:35:14'),
('fa528d4d-bf56-40fd-8eb5-6b8142c6d911', '59333602b9383', '2017-06-06 14:54:28', '2017-06-06 14:54:28'),
('ffad9b72-7423-4588-ac0c-80329777044c', '59333602b9383', '2017-06-03 22:19:55', '2017-06-03 22:19:55');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `department_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `department_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Information Technology', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Management', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Marketing', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'Finance', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'Human Resource', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `document_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `document_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int(10) UNSIGNED NOT NULL,
  `surname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_names` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `surname`, `first_name`, `other_names`, `date`, `contact`, `employee_no`, `created_at`, `updated_at`) VALUES
(2, 'Bett', 'Obadiah ', '', '2017-09-01', '', '025', '2017-09-01 11:21:24', '2017-09-01 11:21:24'),
(3, 'Rotich', 'Weldon', '', '2017-09-01', '', '019', '2017-09-01 11:21:54', '2017-09-01 11:21:54'),
(4, 'Ivelia', 'Benedict', '', '2017-09-01', '', '023', '2017-09-01 11:22:21', '2017-09-01 11:22:21');

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `earnings_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `narrative` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `earnings_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(10) UNSIGNED NOT NULL,
  `education_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `education_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Primary School', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Secondary School', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'College - Certificate', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'College - Diploma', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'Degree', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 'Masters Degree', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'PHD', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 'None', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(10) UNSIGNED NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `personal_file_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identity_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `passport_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `basic_pay` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `vol_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `pin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `social_security_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hospital_insurance_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `work_permit_number` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `job_title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `department_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `job_group_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `type_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marital_status` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yob` date DEFAULT NULL,
  `citizenship` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `education_type_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `income_tax_applicable` int(11) NOT NULL DEFAULT '0',
  `income_tax_relief_applicable` int(11) NOT NULL DEFAULT '0',
  `hospital_insurance_applicable` int(11) NOT NULL DEFAULT '0',
  `social_security_applicable` int(11) NOT NULL DEFAULT '0',
  `mode_of_payment` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `bank_branch_id` int(11) NOT NULL DEFAULT '0',
  `bank_account_number` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_eft_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `swift_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_clock_rate_normal` double(15,2) NOT NULL DEFAULT '0.00',
  `day_clock_rate_normal` double(15,2) NOT NULL DEFAULT '0.00',
  `time_clock_rate_weekday` double(15,2) NOT NULL DEFAULT '0.00',
  `day_clock_rate_weekday` double(15,2) NOT NULL DEFAULT '0.00',
  `time_clock_rate_saturday` double(15,2) NOT NULL DEFAULT '0.00',
  `day_clock_rate_saturday` double(15,2) NOT NULL DEFAULT '0.00',
  `time_clock_rate_sunday` double(15,2) NOT NULL DEFAULT '0.00',
  `day_clock_rate_sunday` double(15,2) NOT NULL DEFAULT '0.00',
  `time_clock_rate_holiday` double(15,2) NOT NULL DEFAULT '0.00',
  `day_clock_rate_holiday` double(15,2) NOT NULL DEFAULT '0.00',
  `medical_smoker` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `medical_blood_group` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `medical_disabilities` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `medical_conditions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_office` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_personal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone_office` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone_extension_office` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone_mobile` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_zip` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_joined` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bf_leave_days` int(11) NOT NULL DEFAULT '0',
  `annual_leave_days` int(11) NOT NULL DEFAULT '0',
  `custom_field1` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `in_employment` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_allowances`
--

CREATE TABLE `employee_allowances` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `allowance_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `allowance_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_deductions`
--

CREATE TABLE `employee_deductions` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deduction_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `formular` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `instalments` int(11) DEFAULT '0',
  `deduction_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `deduction_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_relief`
--

CREATE TABLE `employee_relief` (
  `id` int(10) UNSIGNED NOT NULL,
  `relief_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `relief_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_type`
--

CREATE TABLE `employee_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employee_type`
--

INSERT INTO `employee_type` (`id`, `employee_type_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Full Time', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Contract', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Internship', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `erporderitems`
--

CREATE TABLE `erporderitems` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `issued_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_of_issue` date DEFAULT NULL,
  `date_of_return` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_returned` tinyint(1) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `duration` int(11) DEFAULT NULL,
  `erporder_id` int(10) UNSIGNED NOT NULL,
  `price` double DEFAULT NULL,
  `client_discount` double NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `erporderitems`
--

INSERT INTO `erporderitems` (`id`, `item_id`, `quantity`, `issued_by`, `date_of_issue`, `date_of_return`, `status`, `is_returned`, `rate`, `duration`, `erporder_id`, `price`, `client_discount`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, 2700, 0, '2017-09-01 14:52:03', '2017-09-01 14:52:03'),
(2, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 2, 2700, 900, '2017-09-01 14:53:33', '2017-09-01 14:53:33'),
(3, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 2, 1500, 600, '2017-09-01 14:53:33', '2017-09-01 14:53:33'),
(4, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 3, 9000, 4000, '2017-09-01 15:07:12', '2017-09-01 15:07:12'),
(5, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 4, 7000, 0, '2017-09-01 15:12:44', '2017-09-01 15:12:44'),
(6, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 5, 9000, 2000, '2017-09-01 15:33:34', '2017-09-01 15:33:34'),
(7, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 7, 1430, 0, '2017-09-01 15:44:50', '2017-09-01 15:44:50'),
(8, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 8, 2700, 1200, '2017-09-01 17:26:50', '2017-09-01 17:26:50'),
(9, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 9, 5600, 0, '2017-09-02 11:09:33', '2017-09-02 11:09:33'),
(10, 2, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 9, 1430, 0, '2017-09-02 11:09:33', '2017-09-02 11:09:33'),
(11, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 10, 5600, 0, '2017-09-02 15:47:11', '2017-09-02 15:47:11'),
(12, 2, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 10, 1430, 0, '2017-09-02 15:47:11', '2017-09-02 15:47:11'),
(13, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 11, 9000, 3000, '2017-09-02 15:57:47', '2017-09-02 15:57:47'),
(14, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 12, 9000, 2000, '2017-09-02 16:09:22', '2017-09-02 16:09:22'),
(15, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 13, 9000, 1500, '2017-09-02 16:29:41', '2017-09-02 16:29:41'),
(16, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 14, 9000, 1800, '2017-09-02 16:33:29', '2017-09-02 16:33:29'),
(17, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 15, 2700, 900, '2017-09-02 16:45:49', '2017-09-02 16:45:49'),
(18, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 16, 2700, 900, '2017-09-02 16:46:19', '2017-09-02 16:46:19'),
(19, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 17, 2700, 900, '2017-09-02 16:47:59', '2017-09-02 16:47:59'),
(20, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 21, 2700, 400, '2017-09-02 17:05:38', '2017-09-02 17:05:38'),
(21, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 22, 9000, 1500, '2017-09-02 17:16:54', '2017-09-02 17:16:54'),
(22, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 23, 9000, 2000, '2017-09-02 17:27:40', '2017-09-02 17:27:40'),
(23, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 24, 2700, 900, '2017-09-02 17:29:23', '2017-09-02 17:29:23'),
(24, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 26, 9000, 1500, '2017-09-03 09:15:06', '2017-09-03 09:15:06'),
(25, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 27, 9000, 2000, '2017-09-03 09:20:42', '2017-09-03 09:20:42'),
(26, 2, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 27, 2700, 4500, '2017-09-03 09:20:42', '2017-09-03 09:20:42'),
(27, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 28, 2700, 900, '2017-09-03 09:22:14', '2017-09-03 09:22:14'),
(28, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 30, 1500, 0, '2017-09-03 12:45:49', '2017-09-03 12:45:49'),
(29, 12, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 31, 3500, 0, '2017-09-03 13:12:40', '2017-09-03 13:12:40'),
(30, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 33, 1800, 0, '2017-09-04 10:58:37', '2017-09-04 10:58:37'),
(31, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 34, 9000, 1700, '2017-09-04 14:41:27', '2017-09-04 14:41:27'),
(32, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 35, 2700, 0, '2017-09-04 14:46:09', '2017-09-04 14:46:09'),
(33, 1, 10, NULL, NULL, NULL, NULL, 0, 0, NULL, 36, 5600, 0, '2017-09-04 14:50:21', '2017-09-04 14:50:21'),
(34, 2, 15, NULL, NULL, NULL, NULL, 0, 0, NULL, 36, 1430, 0, '2017-09-04 14:50:21', '2017-09-04 14:50:21'),
(35, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 37, 2700, 802, '2017-09-04 15:46:03', '2017-09-04 15:46:03'),
(36, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 38, 2700, 500, '2017-09-04 15:55:43', '2017-09-04 15:55:43'),
(37, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 39, 1500, 0, '2017-09-04 16:54:45', '2017-09-04 16:54:45'),
(38, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 40, 2700, 1200, '2017-09-05 05:00:50', '2017-09-05 05:00:50'),
(39, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 41, 9000, 1200, '2017-09-05 05:03:46', '2017-09-05 05:03:46'),
(40, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 42, 2700, 700, '2017-09-05 13:03:50', '2017-09-05 13:03:50'),
(41, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 43, 2700, 802, '2017-09-05 13:33:09', '2017-09-05 13:33:09'),
(42, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 44, 9000, 2000, '2017-09-05 13:35:22', '2017-09-05 13:35:22'),
(43, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 45, 2700, 0, '2017-09-05 13:36:26', '2017-09-05 13:36:26'),
(44, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 46, 9000, 1700, '2017-09-05 13:38:54', '2017-09-05 13:38:54'),
(45, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 47, 9000, 1700, '2017-09-05 13:42:48', '2017-09-05 13:42:48'),
(46, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 48, 2700, 400, '2017-09-05 13:45:51', '2017-09-05 13:45:51'),
(47, 8, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 49, 4500, 0, '2017-09-05 13:54:26', '2017-09-05 13:54:26'),
(48, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 50, 9000, 1500, '2017-09-06 05:21:52', '2017-09-06 05:21:52'),
(49, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 51, 9000, 1500, '2017-09-06 05:22:25', '2017-09-06 05:22:25'),
(50, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 52, 9000, 4000, '2017-09-06 16:00:52', '2017-09-06 16:00:52'),
(51, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 53, 9000, 2000, '2017-09-06 16:04:27', '2017-09-06 16:04:27'),
(52, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 54, 2700, 600, '2017-09-06 16:11:45', '2017-09-06 16:11:45'),
(53, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 55, 1500, 500, '2017-09-07 06:33:23', '2017-09-07 06:33:23'),
(54, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 56, 2700, 600, '2017-09-07 18:59:40', '2017-09-07 18:59:40'),
(55, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 57, 2700, 0, '2017-09-08 06:00:51', '2017-09-08 06:00:51'),
(56, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 58, 2700, 500, '2017-09-08 08:38:35', '2017-09-08 08:38:35'),
(57, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 59, 9000, 2000, '2017-09-08 08:43:23', '2017-09-08 08:43:23'),
(58, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 60, 9000, 2000, '2017-09-08 08:48:20', '2017-09-08 08:48:20'),
(59, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 61, 9000, 2000, '2017-09-11 05:33:27', '2017-09-11 05:33:27'),
(60, 2, 3, NULL, NULL, NULL, NULL, 0, 0, NULL, 62, 2700, 1800, '2017-09-11 05:34:46', '2017-09-11 05:34:46'),
(61, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 63, 1000, 0, '2017-09-11 09:42:06', '2017-09-11 09:42:06'),
(62, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 64, 9000, 1000, '2017-09-11 09:44:04', '2017-09-11 09:44:04'),
(63, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 65, 1500, 500, '2017-09-11 09:52:13', '2017-09-11 09:52:13'),
(64, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 66, 9000, 0, '2017-09-11 12:18:26', '2017-09-11 12:18:26'),
(65, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 67, 2700, 200, '2017-09-11 15:33:00', '2017-09-11 15:33:00'),
(66, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 68, 9000, 1500, '2017-09-11 15:33:48', '2017-09-11 15:33:48'),
(67, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 68, 900, 0, '2017-09-11 15:33:49', '2017-09-11 15:33:49'),
(68, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 69, 9000, 1500, '2017-09-11 15:34:51', '2017-09-11 15:34:51'),
(69, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 70, 2700, 0, '2017-09-12 04:45:16', '2017-09-12 04:45:16'),
(70, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 71, 2700, 1200, '2017-09-12 04:47:53', '2017-09-12 04:47:53'),
(71, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 72, 2700, 0, '2017-09-12 16:23:29', '2017-09-12 16:23:29'),
(72, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 73, 9000, 2000, '2017-09-12 16:26:52', '2017-09-12 16:26:52'),
(73, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 74, 2200, 0, '2017-09-12 16:29:08', '2017-09-12 16:29:08'),
(74, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 78, 9000, 0, '2017-09-16 23:02:14', '2017-09-16 23:02:14'),
(75, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 79, 9000, 0, '2017-09-17 05:15:38', '2017-09-17 05:15:38'),
(76, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 80, 1430, 0, '2017-09-25 11:51:13', '2017-09-25 11:51:13'),
(77, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 81, 9000, 2000, '2017-09-26 08:06:53', '2017-09-26 08:06:53'),
(78, 1, 4, NULL, NULL, NULL, NULL, 0, 0, NULL, 82, 5600, 0, '2017-09-27 16:43:50', '2017-09-27 16:43:50'),
(79, 1, 10, NULL, NULL, NULL, NULL, 0, 0, NULL, 83, 4750, 0, '2017-09-27 17:44:37', '2017-09-27 17:44:37'),
(80, 2, 10, NULL, NULL, NULL, NULL, 0, 0, NULL, 83, 1235, 0, '2017-09-27 17:44:37', '2017-09-27 17:44:37'),
(81, 3, 6, NULL, NULL, NULL, NULL, 0, 0, NULL, 83, 570, 0, '2017-09-27 17:44:37', '2017-09-27 17:44:37'),
(82, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 84, 2700, 1200, '2017-09-27 18:05:03', '2017-09-27 18:05:03'),
(83, 1, 4, NULL, NULL, NULL, NULL, 0, 0, NULL, 85, 5600, 0, '2017-09-28 10:38:18', '2017-09-28 10:38:18'),
(84, 2, 4, NULL, NULL, NULL, NULL, 0, 0, NULL, 86, 1430, 0, '2017-09-28 10:39:08', '2017-09-28 10:39:08'),
(85, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 87, 9000, 4000, '2017-09-29 11:25:41', '2017-09-29 11:25:41'),
(86, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 88, 5600, 0, '2017-09-29 16:34:08', '2017-09-29 16:34:08'),
(87, 1, 4, NULL, NULL, NULL, NULL, 0, 0, NULL, 89, 9000, 0, '2017-09-29 16:39:08', '2017-09-29 16:39:08'),
(88, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 90, 9000, 0, '2017-09-29 16:45:58', '2017-09-29 16:45:58'),
(89, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 91, 2700, 0, '2017-09-29 16:47:10', '2017-09-29 16:47:10'),
(90, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 92, 5600, 0, '2017-10-04 07:17:10', '2017-10-04 07:17:10'),
(91, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 93, 1200, 0, '2017-10-04 07:23:36', '2017-10-04 07:23:36'),
(92, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 94, 50, 0, '2017-10-05 06:42:57', '2017-10-05 06:42:57'),
(93, 2, 10, NULL, NULL, NULL, NULL, 0, 0, NULL, 95, 1000, 0, '2017-10-05 13:20:09', '2017-10-05 13:20:09'),
(94, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 96, 1000, 0, '2017-10-06 12:49:13', '2017-10-06 12:49:13'),
(95, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 97, 1000, 0, '2017-10-06 13:05:59', '2017-10-06 13:05:59'),
(96, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 97, 1000, 0, '2017-10-06 13:05:59', '2017-10-06 13:05:59'),
(97, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 98, 9000, 4000, '2017-10-07 11:28:17', '2017-10-07 11:28:17'),
(98, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 99, 9000, 4000, '2017-10-07 11:29:05', '2017-10-07 11:29:05'),
(99, 2, 3, NULL, NULL, NULL, NULL, 0, 0, NULL, 99, 2700, 0, '2017-10-07 11:29:05', '2017-10-07 11:29:05'),
(100, 1, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 100, 9000, 4000, '2017-10-07 11:38:19', '2017-10-07 11:38:19'),
(101, 2, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 100, 2700, 0, '2017-10-07 11:38:19', '2017-10-07 11:38:19'),
(102, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 101, 9000, 2000, '2017-10-09 07:14:20', '2017-10-09 07:14:20'),
(103, 1, 10, NULL, NULL, NULL, NULL, 0, 0, NULL, 102, 1500, 0, '2017-10-09 07:45:33', '2017-10-09 07:45:33'),
(104, 2, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 102, 1200, 0, '2017-10-09 07:45:33', '2017-10-09 07:45:33'),
(105, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 103, 2700, 0, '2017-10-09 10:04:41', '2017-10-09 10:04:41'),
(106, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 104, 2700, 0, '2017-10-09 10:08:21', '2017-10-09 10:08:21'),
(107, 3, 3, NULL, NULL, NULL, NULL, 0, 0, NULL, 105, 600, 0, '2017-10-09 14:11:31', '2017-10-09 14:11:31'),
(108, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 105, 100, 0, '2017-10-09 14:11:31', '2017-10-09 14:11:31'),
(109, 2, 7, NULL, NULL, NULL, NULL, 0, 0, NULL, 105, 50, 0, '2017-10-09 14:11:31', '2017-10-09 14:11:31'),
(110, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 106, 9000, 2000, '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(111, 2, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 106, 2700, 0, '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(112, 3, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 106, 1500, 0, '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(113, 1, 5, NULL, NULL, NULL, NULL, 0, 0, NULL, 107, 100, 0, '2017-10-10 14:15:01', '2017-10-10 14:15:01'),
(114, 2, 4, NULL, NULL, NULL, NULL, 0, 0, NULL, 107, 400, 0, '2017-10-10 14:15:01', '2017-10-10 14:15:01'),
(115, 3, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, 107, 672, 0, '2017-10-10 14:15:01', '2017-10-10 14:15:01'),
(116, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 108, 9000, 2000, '2017-10-12 06:19:11', '2017-10-12 06:19:11'),
(117, 2, 3, NULL, NULL, NULL, NULL, 0, 0, NULL, 109, 2700, 0, '2017-10-12 06:22:14', '2017-10-12 06:22:14');

-- --------------------------------------------------------

--
-- Table structure for table `erporders`
--

CREATE TABLE `erporders` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `total_amount` double DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_lease` tinyint(1) NOT NULL DEFAULT '0',
  `payment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inv_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `ordered_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_id` int(11) NOT NULL,
  `prepared_by` int(11) DEFAULT NULL,
  `authorized_by` int(11) DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `is_paid` int(11) DEFAULT NULL,
  `is_cancelled` int(11) DEFAULT NULL,
  `is_approved` int(11) DEFAULT NULL,
  `is_rejected` int(11) DEFAULT NULL,
  `is_pending` int(11) DEFAULT NULL,
  `cancelled_by` int(11) DEFAULT NULL,
  `approve_cancel_by` int(11) DEFAULT NULL,
  `reject_cancel_by` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `erporders`
--

INSERT INTO `erporders` (`id`, `client_id`, `date`, `status`, `comment`, `total_amount`, `discount_amount`, `type`, `is_lease`, `payment_type`, `order_number`, `inv_number`, `due_date`, `ordered_by`, `organization_id`, `prepared_by`, `authorized_by`, `reviewed_by`, `is_paid`, `is_cancelled`, `is_approved`, `is_rejected`, `is_pending`, `cancelled_by`, `approve_cancel_by`, `reject_cancel_by`, `confirmation_code`, `created_at`, `updated_at`) VALUES
(1, 332, '2017-09-01', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/01/0001', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 14:52:03', '2017-09-28 10:33:09'),
(2, 19, '2017-09-01', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/01/0002', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 14:53:33', '2017-09-01 15:07:28'),
(3, 323, '2017-09-01', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/01/0003', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 15:07:12', '2017-09-01 15:07:24'),
(4, 333, '2017-09-01', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/01/0004', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 15:12:44', '2017-09-01 15:14:13'),
(5, 334, '2017-09-01', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/01/0005', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 15:33:34', '2017-09-01 15:33:43'),
(7, 6, '2017-09-01', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/01/0007', NULL, NULL, NULL, 0, 1, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 15:44:50', '2017-09-28 10:02:24'),
(8, 335, '2017-09-01', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/01/0007', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-01 17:26:50', '2017-09-05 05:04:13'),
(9, 336, '2017-09-02', 'delivered', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/02/0008', NULL, NULL, NULL, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 11:09:33', '2017-09-28 14:39:59'),
(10, 336, '2017-09-02', 'delivered', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/02/0009', NULL, NULL, NULL, 0, 3, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 15:47:11', '2017-09-29 08:23:31'),
(11, 337, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0010', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 15:57:47', '2017-09-02 15:57:59'),
(12, 335, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0011', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:09:22', '2017-09-02 16:09:33'),
(13, 338, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0012', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:29:40', '2017-09-02 16:29:48'),
(14, 339, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0013', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:33:29', '2017-09-02 16:33:37'),
(15, 340, '2017-09-02', 'cancelled', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0014', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:45:49', '2017-09-02 16:48:40'),
(16, 340, '2017-09-02', 'cancelled', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0014', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:46:19', '2017-09-02 16:48:21'),
(17, 340, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0016', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:47:59', '2017-09-02 16:55:44'),
(18, 341, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/02/0017', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 16:55:24', '2017-09-02 16:55:36'),
(19, 342, '2017-09-02', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/02/0018', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:02:00', '2017-09-02 17:04:09'),
(20, 342, '2017-09-02', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/02/0018', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:03:26', '2017-09-02 17:03:43'),
(21, 342, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/02/0020', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:05:38', '2017-09-02 17:05:47'),
(22, 343, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/02/0021', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:16:54', '2017-09-02 17:17:10'),
(23, 344, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0022', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:27:40', '2017-09-02 17:29:55'),
(24, 344, '2017-09-02', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/02/0023', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-02 17:29:23', '2017-09-02 17:30:09'),
(25, 335, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/03/0024', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 04:37:35', '2017-09-03 09:22:30'),
(26, 345, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/03/0025', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 09:15:06', '2017-09-03 09:17:52'),
(27, 323, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/03/0026', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 09:20:42', '2017-09-03 09:20:50'),
(28, 340, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/03/0027', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 09:22:14', '2017-09-03 09:24:49'),
(29, 346, '2017-09-03', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/03/0028', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 12:35:01', '2017-09-03 12:35:27'),
(30, 346, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/03/0028', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 12:45:49', '2017-09-03 13:36:16'),
(31, 346, '2017-09-03', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/03/0030', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 13:12:40', '2017-09-03 13:36:28'),
(32, 347, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/04/0031', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-03 21:32:05', '2017-09-05 05:04:58'),
(33, 121, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/04/0032', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 10:58:37', '2017-09-05 05:05:09'),
(34, 268, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/04/0033', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 14:41:27', '2017-09-05 05:05:18'),
(35, 348, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/04/0034', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 14:46:09', '2017-09-05 05:04:47'),
(36, 336, '2017-09-04', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/04/0035', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 14:50:21', '2017-10-05 06:19:15'),
(37, 268, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/04/0036', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 15:46:03', '2017-09-05 05:04:39'),
(38, 349, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/04/0037', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 15:55:43', '2017-09-05 05:04:33'),
(39, 26, '2017-09-04', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/04/0038', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-04 16:54:45', '2017-09-05 05:04:22'),
(40, 335, '2017-09-05', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0039', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 05:00:50', '2017-09-05 05:04:06'),
(41, 351, '2017-09-05', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0040', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 05:03:46', '2017-09-05 05:04:00'),
(42, 121, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/05/0041', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:03:50', '2017-09-05 13:03:50'),
(43, 268, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0042', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:33:09', '2017-09-05 13:33:09'),
(44, 334, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0043', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:35:22', '2017-09-05 13:35:22'),
(45, 16, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/05/0044', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:36:26', '2017-09-05 13:36:26'),
(46, 302, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0045', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:38:54', '2017-09-05 13:38:54'),
(47, 199, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0046', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:42:48', '2017-09-05 13:42:48'),
(48, 99, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/05/0047', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:45:51', '2017-09-05 13:45:51'),
(49, 353, '2017-09-05', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/05/0048', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-05 13:54:26', '2017-09-05 13:54:26'),
(50, 31, '2017-09-06', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/06/0049', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-06 05:21:52', '2017-09-06 05:23:52'),
(51, 345, '2017-09-06', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/06/0050', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-06 05:22:25', '2017-09-06 05:24:02'),
(52, 323, '2017-09-06', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/06/0051', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-06 16:00:52', '2017-09-06 16:00:52'),
(53, 333, '2017-09-06', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/06/0052', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-06 16:04:27', '2017-09-06 16:04:27'),
(54, 354, '2017-09-06', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/06/0053', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-06 16:11:45', '2017-09-06 16:11:45'),
(55, 355, '2017-09-07', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/07/0054', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-07 06:33:23', '2017-09-07 06:33:23'),
(56, 335, '2017-09-07', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/07/0055', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-07 18:59:40', '2017-09-07 18:59:46'),
(57, 356, '2017-09-08', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/08/0056', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-08 06:00:51', '2017-09-08 06:01:02'),
(58, 357, '2017-09-08', 'delivered', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/08/0057', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-08 08:38:34', '2017-09-08 08:43:50'),
(59, 358, '2017-09-08', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/08/0058', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-08 08:43:23', '2017-09-08 08:43:58'),
(60, 359, '2017-09-08', 'delivered', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/08/0059', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-08 08:48:20', '2017-09-08 08:48:58'),
(61, 335, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/11/0060', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 05:33:27', '2017-09-11 05:33:27'),
(62, 335, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/11/0061', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 05:34:46', '2017-09-11 05:34:46'),
(63, 121, '2017-09-11', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/11/0062', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 09:42:06', '2017-09-11 09:52:24'),
(64, 80, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/11/0063', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 09:44:04', '2017-09-11 09:44:04'),
(65, 121, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/11/0064', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 09:52:12', '2017-09-11 09:52:12'),
(66, 1, '2017-09-11', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/11/0065', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 12:18:26', '2017-09-11 15:29:53'),
(67, 246, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/11/0066', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 15:33:00', '2017-09-11 15:33:00'),
(68, 31, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/11/0067', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 15:33:48', '2017-09-11 15:33:48'),
(69, 345, '2017-09-11', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/11/0068', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-11 15:34:51', '2017-09-11 15:34:51'),
(70, 144, '2017-09-12', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/12/0069', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-12 04:45:16', '2017-09-12 04:45:16'),
(71, 335, '2017-09-12', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/12/0070', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-12 04:47:53', '2017-09-12 04:47:53'),
(72, 133, '2017-09-12', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/12/0071', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-12 16:23:29', '2017-09-12 16:23:29'),
(73, 323, '2017-09-12', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/12/0072', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-12 16:26:51', '2017-09-12 16:26:51'),
(74, 334, '2017-09-12', 'new', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/12/0073', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-12 16:29:08', '2017-09-12 16:29:08'),
(75, 14, '2017-09-14', 'new', '', NULL, 0, 'sales', 0, NULL, '2017/09/14/0074', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-14 19:12:10', '2017-09-14 19:12:10'),
(76, 361, '2017-09-14', 'new', '', NULL, 0, 'sales', 0, NULL, '2017/09/14/0075', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-14 19:33:23', '2017-09-14 19:33:23'),
(77, 361, '2017-09-14', 'new', '', NULL, 0, 'sales', 0, NULL, '2017/09/14/0075', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-14 19:33:35', '2017-09-14 19:33:35'),
(78, 1, '2017-09-16', 'new', '', NULL, 0, 'sales', 0, NULL, '2017/09/16/0077', NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-16 23:02:14', '2017-10-05 08:04:35'),
(79, 1, '2017-09-16', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/16/0078', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-17 05:15:38', '2017-09-17 05:15:38'),
(80, 6, '1970-01-01', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/25/0079', NULL, NULL, NULL, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-25 11:51:12', '2017-09-29 08:33:37'),
(81, 1, '2017-09-26', 'new', '', NULL, NULL, 'quotations', 0, NULL, '2017/09/26/0080', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-26 08:06:52', '2017-09-26 08:06:52'),
(82, 6, '2017-09-27', 'cancelled', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/27/0081', NULL, NULL, NULL, 0, 3, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-27 16:43:50', '2017-10-04 11:58:58'),
(83, 336, '2017-09-27', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/27/0082', NULL, NULL, NULL, 0, 5, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-27 17:44:37', '2017-10-05 06:14:22'),
(84, 335, '2017-09-27', 'cancelled', '', NULL, NULL, 'sales', 0, 'credit', '2017/09/27/0083', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, 1, NULL, NULL, '2017-09-27 18:05:03', '2017-10-05 12:55:48'),
(85, 6, '2017-09-28', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/28/0084', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-28 10:38:18', '2017-09-28 10:38:18'),
(86, 6, '2017-09-28', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/28/0085', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-28 10:39:08', '2017-09-28 10:39:08'),
(87, 1, '2017-09-29', 'new', '', NULL, NULL, 'quotations', 0, NULL, '2017/09/29/0086', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-29 11:25:41', '2017-09-29 11:25:41'),
(88, 336, '2017-09-29', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/09/29/0087', NULL, NULL, NULL, 0, 5, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-09-29 16:34:08', '2017-09-29 17:01:41'),
(89, 39, '2017-09-29', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/29/0088', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, 1, NULL, NULL, '2017-09-29 16:39:08', '2017-10-05 12:51:11'),
(90, 7, '2017-09-29', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/29/0089', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, '2017-09-29 16:45:58', '2017-10-05 12:16:31'),
(91, 7, '2017-09-29', 'cancelled', '', NULL, NULL, 'sales', 0, 'cash', '2017/09/29/0090', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, '2017-09-29 16:47:10', '2017-10-05 12:15:25'),
(92, 6, '2017-10-04', 'cancelled', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/04/0091', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-04 07:17:09', '2017-10-04 07:22:46'),
(93, 6, '2017-10-04', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/04/0092', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-04 07:23:36', '2017-10-04 11:04:54'),
(94, 6, '2017-10-05', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/05/0093', NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-05 06:42:57', '2017-10-05 08:05:33'),
(95, 6, '2017-10-05', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/05/0094', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-05 13:20:09', '2017-10-05 13:22:11'),
(96, 6, '2017-10-06', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/06/0095', NULL, NULL, NULL, 0, 3, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-06 12:49:13', '2017-10-06 12:53:31'),
(97, 6, '2017-10-06', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/06/0096', NULL, NULL, NULL, 0, 3, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-06 13:05:59', '2017-10-06 13:06:57'),
(98, 1, '2017-10-07', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/07/0097', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-07 11:28:17', '2017-10-07 11:28:17'),
(99, 1, '2017-10-07', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/07/0098', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-07 11:29:05', '2017-10-07 11:29:05'),
(100, 1, '2017-10-07', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/07/0099', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-07 11:38:19', '2017-10-07 11:38:19'),
(101, 1, '2017-10-09', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/09/0100', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-09 07:14:19', '2017-10-09 07:14:19'),
(102, 6, '2017-10-09', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/09/0101', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-09 07:45:33', '2017-10-09 08:04:39'),
(103, 1, '2017-10-09', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/09/0102', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-09 10:04:41', '2017-10-09 10:04:41'),
(104, 1, '2017-10-09', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/09/0103', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-09 10:08:20', '2017-10-09 10:08:20'),
(105, 6, '2017-10-09', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/09/0104', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-09 14:11:31', '2017-10-09 14:12:18'),
(106, 1, '2017-10-10', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/10/0105', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(107, 6, '2017-10-10', 'new', '', NULL, NULL, 'purchases', 0, NULL, '2017/10/10/0106', NULL, NULL, NULL, 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-11 18:15:01', '2017-10-10 14:15:15'),
(108, 1, '2017-10-12', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/12/0107', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-12 06:19:11', '2017-10-12 06:19:11'),
(109, 1, '2017-10-12', 'new', '', NULL, NULL, 'sales', 0, 'cash', '2017/10/12/0108', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-12 06:22:14', '2017-10-12 06:22:14');

-- --------------------------------------------------------

--
-- Table structure for table `erpquotations`
--

CREATE TABLE `erpquotations` (
  `id` int(10) NOT NULL,
  `quotation` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date DEFAULT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `name`, `amount`, `type`, `date`, `account_id`, `receiver_id`, `confirmation_code`, `confirmed_id`, `created_at`, `updated_at`) VALUES
(1, 'water', '20', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:49:56', '2017-09-01 15:49:56'),
(2, 'fuel motobike tvs', '500', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:50:33', '2017-09-01 15:50:33'),
(3, 'car fuel noah', '1000', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:53:01', '2017-09-01 15:53:01'),
(4, 'offloading spice lounge', '50', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:53:52', '2017-09-01 15:53:52'),
(5, 'tyre repair', '250', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:54:59', '2017-09-01 15:54:59'),
(6, 'offloading gem sutes', '50', 'Expenditure', '2017-09-01', 1, NULL, NULL, NULL, '2017-09-01 15:56:07', '2017-09-01 15:56:07'),
(7, 'Electricity tokens', '1000', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 05:34:04', '2017-09-03 05:34:04'),
(8, 'punture repair for noah', '250', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 05:36:28', '2017-09-03 05:36:28'),
(9, 'off loading red tarvern', '50', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 05:44:21', '2017-09-03 05:44:21'),
(10, 'offloading red office', '50', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 05:45:18', '2017-09-03 05:45:18'),
(11, 'offloading clearence ', '100', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 05:46:53', '2017-09-03 05:46:53'),
(12, 'car fuel noah', '1500', 'Expenditure', '2017-09-02', 2, NULL, NULL, NULL, '2017-09-03 09:27:39', '2017-09-03 09:27:39'),
(13, 'fuel motobike tvs', '500', 'Expenditure', '2017-09-02', 2, NULL, NULL, NULL, '2017-09-03 09:28:25', '2017-09-03 09:28:25'),
(14, 'offloading finix casino', '50', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 09:29:20', '2017-09-03 09:29:20'),
(15, 'fuel motobike boxer', '500', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 16:37:34', '2017-09-03 16:37:34'),
(16, 'envelope', '100', 'Expenditure', '2017-09-03', 1, NULL, NULL, NULL, '2017-09-03 16:38:03', '2017-09-03 16:38:03'),
(17, 'offloading wallmat grpup', '50', 'Expenditure', '2017-09-06', 1, NULL, NULL, NULL, '2017-09-06 05:23:14', '2017-09-06 05:23:14'),
(18, 'vitz fuel', '300', 'Expenditure', '2017-09-06', 1, NULL, NULL, NULL, '2017-09-06 05:23:31', '2017-09-06 05:23:31'),
(19, 'tyre repair', '250', 'Expenditure', '2017-09-08', 1, NULL, NULL, NULL, '2017-09-08 06:03:56', '2017-09-08 06:03:56'),
(20, 'offloading rendervour', '50', 'Expenditure', '2017-09-08', 1, NULL, NULL, NULL, '2017-09-08 08:34:52', '2017-09-08 08:34:52'),
(21, 'offloading ricos taproom', '50', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:40:49', '2017-09-11 15:40:49'),
(22, 'offloading finix casino', '50', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:42:39', '2017-09-11 15:42:39'),
(23, 'offloading wallmat group', '50', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:43:04', '2017-09-11 15:43:04'),
(24, 'A4 envelopes', '180', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:43:33', '2017-09-11 15:43:33'),
(25, 'motorbike fuel', '500', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:43:59', '2017-09-11 15:43:59'),
(26, 'noah fuel', '2000', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:44:15', '2017-09-11 15:44:15'),
(27, 'drinking water', '460', 'Expenditure', '2017-09-11', 1, NULL, NULL, NULL, '2017-09-11 15:44:34', '2017-09-11 15:44:34'),
(28, 'motorbike fuel', '500', 'Expenditure', '2017-09-12', 1, NULL, NULL, NULL, '2017-09-12 16:37:28', '2017-09-12 16:37:28'),
(29, 'water and omo', '30', 'Expenditure', '2017-09-12', 1, NULL, NULL, NULL, '2017-09-12 16:37:44', '2017-09-12 16:37:44'),
(30, 'Bread', '150', 'Expenditure', '2017-10-10', 8, 3, 'b9e317ac2c9fa918a9a9105af158984d', 1, '2017-10-10 06:18:25', '2017-10-10 06:18:25');

-- --------------------------------------------------------

--
-- Table structure for table `expense_claims`
--

CREATE TABLE `expense_claims` (
  `id` int(10) NOT NULL,
  `claimer` varchar(255) NOT NULL,
  `date_submitted` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) DEFAULT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expense_claims`
--

INSERT INTO `expense_claims` (`id`, `claimer`, `date_submitted`, `status`, `receiver_id`, `confirmation_code`, `confirmed_id`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', '2017-09-16', 'Approved', NULL, NULL, NULL, '2017-09-29 14:48:40', '2017-09-29 17:48:40'),
(2, 'superadmin', '2017-09-29', 'Payed', NULL, NULL, NULL, '2017-09-29 10:11:31', '2017-09-29 10:11:31'),
(3, 'alice', '2017-10-10', 'Payed', NULL, NULL, NULL, '2017-10-10 06:34:23', '2017-10-10 06:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `gas`
--

CREATE TABLE `gas` (
  `id` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `active` int(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gas`
--

INSERT INTO `gas` (`id`, `name`, `active`, `created_at`, `updated_at`) VALUES
('1', 'Hashi', 1, '2017-06-01 13:02:34', '2017-06-18 10:11:58'),
('10', 'Ommm', 1, '2017-07-29 16:56:22', '2017-07-29 16:56:22'),
('11', 'NN', 1, '2017-07-30 11:42:30', '2017-07-30 11:42:30'),
('12', 'New Gas', 1, '2017-07-30 11:48:13', '2017-07-30 11:48:13'),
('13', 'NE', 1, '2017-07-30 11:50:17', '2017-07-30 11:50:17'),
('14', 'AGG', 1, '2017-07-30 11:52:07', '2017-07-30 11:52:07'),
('15', 'Oirere', 1, '2017-07-30 12:00:49', '2017-07-30 12:00:49'),
('16', 'ANOTHER', 1, '2017-07-30 12:17:23', '2017-07-30 12:17:23'),
('17', 'Oirere', 1, '2017-07-30 14:00:44', '2017-07-30 14:00:44'),
('18', 'Oml', 1, '2017-07-30 14:42:33', '2017-07-30 14:42:33'),
('19', 'New Gas', 1, '2017-07-31 08:01:41', '2017-07-31 08:01:41'),
('2', 'K-Gas', 1, '2017-06-01 13:02:40', '2017-06-01 13:02:40'),
('3', 'Total', 1, '2017-06-01 13:02:47', '2017-06-01 13:02:47'),
('4', 'Afrigas', 1, '2017-06-01 13:02:51', '2017-06-01 13:02:51'),
('5', 'Hass', 1, '2017-06-03 18:04:45', '2017-06-03 18:04:45'),
('6', 'Supa Gas', 1, '2017-06-10 10:31:42', '2017-06-10 10:31:42'),
('7', 'Eddie', 1, '2017-07-29 16:42:16', '2017-07-29 16:42:16'),
('8', 'Oirere', 1, '2017-07-29 16:48:46', '2017-07-29 16:48:46'),
('9', 'Edd', 1, '2017-07-29 16:49:49', '2017-07-29 16:49:49');

--
-- Triggers `gas`
--
DELIMITER $$
CREATE TRIGGER `stock_account` AFTER INSERT ON `gas` FOR EACH ROW BEGIN
           CALL create_stock_account(NEW.id, 2, NEW.created_at, NEW.updated_at);
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gas_locations`
--

CREATE TABLE `gas_locations` (
  `type` int(1) NOT NULL,
  `address` varchar(80) NOT NULL,
  `lng` float(10,6) NOT NULL,
  `lat` float(10,6) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `id` varchar(45) NOT NULL,
  `active` int(1) DEFAULT '0',
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gas_locations`
--

INSERT INTO `gas_locations` (`type`, `address`, `lng`, `lat`, `created_at`, `updated_at`, `id`, `active`, `description`) VALUES
(1, 'Ole Sangale Rd, Nairobi, Kenya', 36.812534, -1.310082, '2017-06-01 13:14:41', '2017-06-01 13:14:41', '5930134160415', 0, 'Neema Court. Opposite Karuri Court. New building, house number 892.'),
(1, 'Lagiri Road', 36.784443, -1.302786, '2017-06-02 14:41:02', '2017-06-02 14:41:02', '593178fe10b46', 0, 'Container city, langiri road off Suna road-left turn to Adams arcade round about.'),
(1, 'Loginye Road', 36.800014, -1.305135, '2017-06-03 04:40:47', '2017-06-03 04:40:47', '59323dcf05859', 0, 'House 34 loginye Road'),
(1, 'Unnamed Road', 37.053604, -1.445008, '2017-06-03 09:45:28', '2017-06-03 09:45:28', '5932853898d9d', 0, 'kileleshwa Elite view apartment C8'),
(1, 'Limuru Road', 36.823437, -1.267618, '2017-06-03 12:10:57', '2017-06-03 12:10:57', '5932a751ce1da', 0, 'Kaua, kaua, kaua, kaua, kaua,kaua,'),
(1, 'Seasons Road', 36.903770, -1.216623, '2017-06-03 17:06:23', '2017-06-03 17:06:23', '5932ec8f81b54', 0, 'Asha Place flats'),
(1, 'Madaraka Estate, Nairobi, Kenya', 36.815605, -1.309858, '2017-06-03 22:19:46', '2017-06-07 14:22:32', '59333602b9383', 2, 'Opposite Strathmore University. House number 892'),
(1, 'Nairobi, Kenya', 36.821945, -1.292066, '2017-06-05 06:12:56', '2017-06-05 06:12:56', '5934f66871c03', 0, 'shaurimoyo, off jogoo road, baptist church'),
(1, 'Allsops, Nairobi, Kenya', 36.872112, -1.248733, '2017-06-05 06:26:01', '2017-06-05 06:26:01', '5934f97962233', 0, 'luck Summer 435'),
(1, 'Lagiri Road', 36.784096, -1.302895, '2017-06-05 06:51:16', '2017-06-05 06:51:16', '5934ff64e850f', 0, 'container city ,along Langiri road'),
(1, 'Nairobi County, Kenya', 36.845737, -1.291536, '2017-06-05 07:01:48', '2017-06-05 07:01:48', '593501dc3ae46', 0, 'Umoja, moi drive'),
(1, 'Naivasha Road', 36.755882, -1.295870, '2017-06-05 11:20:50', '2017-06-05 11:20:50', '59353e923e517', 0, 'ungwaro, 123, coast'),
(1, 'Naivasha Road', 36.759781, -1.298079, '2017-06-05 11:23:23', '2017-06-05 11:23:23', '59353f2b311d5', 0, 'my home house cab be freedjhbd'),
(1, 'Kanjaro Road', 36.800636, -1.305004, '2017-06-06 12:50:49', '2017-06-06 12:50:49', '5936a52960909', 0, '34, Loginye road'),
(1, 'Seasons Rd, Nairobi, Kenya', 36.903912, -1.215951, '2017-06-07 08:05:46', '2017-06-25 07:54:41', '5937b3da4f4e9', 2, 'Opposite diegz entertainment. Green house flats.'),
(1, 'Seasons Rd, Nairobi, Kenya', 36.903912, -1.215951, '2017-06-07 14:36:04', '2017-06-13 03:25:53', '59380f549a83b', 2, 'Green house. Opposite diegz'),
(1, 'Prof Mourice Alala Road', 36.807999, -1.274676, '2017-06-08 12:37:13', '2017-06-08 12:37:13', '593944f93e81e', 0, 'business premises'),
(1, 'Nairobi, Kenya', 36.772346, -1.303447, '2017-06-08 15:48:24', '2017-06-08 15:48:24', '593971c84455b', 0, 'Jamhuri 2, Neema Court Block No. 2, House No. 7, Nairobi'),
(1, 'State House CRE, Nairobi, Kenya', 36.808552, -1.286140, '2017-06-09 14:08:21', '2017-06-09 14:08:21', '593aabd518616', 0, 'Georgia Mansions'),
(1, 'Somalia', 44.531303, 1.406086, '2017-06-09 18:42:27', '2017-06-09 18:42:27', '593aec1374300', 0, '10 street\nshbsbj'),
(1, 'Mandera Rd, Nairobi, Kenya', 36.794262, -1.275338, '2017-06-09 22:11:06', '2017-06-09 22:11:06', '593b1cfa2a7cd', 0, 'Block 3 31Ahpfhpcchooc'),
(1, 'Unnamed Road', 39.705257, -0.604252, '2017-06-10 14:52:41', '2017-06-10 14:52:41', '593c07b9e97ee', 0, 'magiwa estate hse no 125'),
(1, 'Tharaka-Nithi County', 38.042084, -0.025265, '2017-06-10 16:03:15', '2017-06-10 16:03:15', '593c1842ed3d3', 0, 'Westlands Avenue, Pearl Heaven Apartments'),
(1, 'Kirichwa Gardens Road', 36.779953, -1.290292, '2017-06-10 16:22:17', '2017-06-10 16:22:17', '593c1cb9c02d6', 0, 'Kirichwa Shelters D3'),
(1, 'Ole Dume Rd, Nairobi, Kenya', 36.774807, -1.297220, '2017-06-10 17:38:22', '2017-06-10 17:38:22', '593c2e8e4ffa9', 0, 'La Casa Gardens, B2'),
(1, 'Ring Road Kilimani', 36.787937, -1.294284, '2017-06-12 09:20:24', '2017-06-12 09:20:24', '593e5cd8416cc', 0, 'chania court house number 5'),
(1, 'Rhapta Road', 36.801575, -1.265837, '2017-06-12 15:12:08', '2017-06-12 15:12:08', '593eaf483fa7e', 0, 'Lenana Road, Kilimani'),
(1, 'Ole Sangale Rd, Nairobi, Kenya', 36.812534, -1.310082, '2017-06-13 03:27:01', '2017-06-13 03:27:01', '593f5b85806c7', 0, 'Opposite Karuri Court.'),
(1, 'Kikambala Road', 36.781643, -1.287240, '2017-06-15 15:35:56', '2017-06-15 15:35:56', '5942a95c695b1', 0, 'lions lair,oloitoktok road,house c3'),
(1, 'Lavington Estate, Nairobi, Kenya', 36.779259, -1.274523, '2017-06-16 19:13:18', '2017-06-16 19:13:18', '59442dce7b06f', 0, 'A6 Kingara Road'),
(1, 'Langata Rd, Nairobi, Kenya', 36.799934, -1.320858, '2017-06-16 19:27:45', '2017-06-16 19:27:45', '594431316a6d1', 0, 'Orion Apartment, House #4B 3rd floor. Directly opposite kisima pork place next to Jupiter guest resort.'),
(1, 'Nairobi, Kenya', 36.821945, -1.292066, '2017-06-17 07:31:21', '2017-06-17 07:31:21', '5944dac9802ca', 0, 'hendred road Angelican Height house no.4D'),
(1, 'Kikuyu - Nderi Road', 36.662579, -1.238644, '2017-06-19 05:51:13', '2017-06-19 05:51:13', '594766516c915', 0, 'Kinoo villa point flats'),
(1, 'Siaya Rd, Nairobi, Kenya', 36.784966, -1.281297, '2017-06-19 11:19:31', '2017-06-19 11:19:31', '5947b343a53f2', 0, 'Vasudev Heights, Siaya Lane off Siaya Road. Kileleshwa. Apartment A3'),
(1, 'Kiambu County', 36.699879, -1.257221, '2017-06-19 13:01:38', '2017-06-19 13:01:38', '5947cb3242e2f', 0, 'kinoo 87 house no.'),
(1, 'Thompson Estate', 36.763901, -1.294859, '2017-06-29 20:43:32', '2017-06-29 20:43:32', '59556674e34be', 0, 'apt BB2 cedar valley apartments'),
(1, 'Mawensi Road', 36.812485, -1.306530, '2017-07-02 16:15:58', '2017-07-02 16:15:58', '59591c3e128cc', 0, 'Opposite Strathmore University.');

-- --------------------------------------------------------

--
-- Table structure for table `gas_users`
--

CREATE TABLE `gas_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(11) NOT NULL DEFAULT '2',
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gas_users`
--

INSERT INTO `gas_users` (`id`, `name`, `email`, `type`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Gas Express', 'ge@gmail.com', 1, '$2y$10$4iQNIzAsQjl6D2QnMNbHJuzkO3tKa9uAFyA1g5AEnPpiV6Uy2zfLO', 'acfU1AYUdNZ7jYlY8mnpZX4itKOTeQOf8NKrhF5tCNbsNtfp7WsaSFmIfIgl', '2017-09-13 02:57:31', '2017-09-13 02:57:31');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `g_c_m_users`
--

CREATE TABLE `g_c_m_users` (
  `user` varchar(40) NOT NULL,
  `gcm_id` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `g_c_m_users`
--

INSERT INTO `g_c_m_users` (`user`, `gcm_id`, `created_at`, `updated_at`) VALUES
('14', 'fLHAYIR0AT4:APA91bHPYUeIp6E-0DBiDdHCsbZ_2FtJevF00H-vP3wX3AApP7IRxrBJW3_mJor6XUBJ0w-6wTOgrcNUAu3TTr0It2fG0Q6RCP7fbT6mZU5zhYsRTFAGK8VuiyZOfG9K8923TvNFfQNO', '2017-07-02 00:20:33', '2017-07-02 09:12:08');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hospital_insurance`
--

CREATE TABLE `hospital_insurance` (
  `id` int(10) UNSIGNED NOT NULL,
  `income_from` double(15,2) NOT NULL DEFAULT '0.00',
  `income_to` double(15,2) NOT NULL DEFAULT '0.00',
  `hi_amount` double(15,2) NOT NULL DEFAULT '0.00',
  `organization_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hospital_insurance`
--

INSERT INTO `hospital_insurance` (`id`, `income_from`, `income_to`, `hi_amount`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 0.00, 0.00, 0.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 1.00, 5999.00, 150.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 6000.00, 7999.00, 300.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 8000.00, 11999.00, 400.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 12000.00, 14999.00, 500.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 15000.00, 19999.00, 600.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 20000.00, 24999.00, 750.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 25000.00, 29999.00, 850.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 30000.00, 34999.00, 900.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 35000.00, 39999.00, 950.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 40000.00, 44999.00, 1000.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 45000.00, 49999.00, 1100.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 50000.00, 59999.00, 1200.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 60000.00, 69999.00, 1300.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, 70000.00, 79999.00, 1400.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, 80000.00, 89999.00, 1500.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 90000.00, 99999.00, 1600.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 100000.00, 99000000.00, 1700.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_make` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `purchase_price` double NOT NULL DEFAULT '0',
  `selling_price` double NOT NULL DEFAULT '0',
  `sku` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reorder_level` int(11) DEFAULT NULL,
  `receiver_id` int(11) NOT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `code` double NOT NULL,
  `item_size` int(11) NOT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_approved` int(11) DEFAULT NULL,
  `is_rejected` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_make`, `date`, `description`, `purchase_price`, `selling_price`, `sku`, `tag_id`, `reorder_level`, `receiver_id`, `confirmed_id`, `created_at`, `updated_at`, `code`, `item_size`, `confirmation_code`, `is_approved`, `is_rejected`) VALUES
(1, '50 kgs gas refill ', '2016-06-22', '50kgs gas refill', 5600, 9000, 'null', 'null', 0, 3, 1, '2016-06-22 07:51:38', '2017-09-29 08:15:15', 1, 50, 'cfa87ebddb84f0cae9952ec723ba2cd5', NULL, NULL),
(2, ' 13kgs gas refill', '2016-06-22', '13KG GAS REFILL', 1430, 2700, '', '', 0, 1, 1, '2016-06-22 07:52:29', '2017-10-04 09:29:18', 0, 13, NULL, NULL, NULL),
(3, '6kgs gas refill', '2016-06-22', 'HASHI', 672, 1500, '', '', 0, 1, 1, '2016-06-22 07:55:08', '2017-10-10 14:15:33', 0, 6, NULL, NULL, NULL),
(4, '35kgs refill', '2016-06-22', '', 4025, 4600, '', '', 0, 0, NULL, '2016-06-22 08:10:36', '2016-07-12 08:25:31', 0, 0, NULL, NULL, NULL),
(5, '13kgs regulator', '2016-06-23', 'Ampia', 1000, 1200, '', '', 0, 0, NULL, '2016-06-23 08:58:34', '2016-10-03 09:24:43', 0, 0, NULL, NULL, NULL),
(6, '50kg high pressure regulator', '2016-06-23', '', 1000, 2850, '', '', 0, 0, NULL, '2016-06-23 08:59:28', '2016-06-23 08:59:28', 0, 0, NULL, NULL, NULL),
(7, 'orgaz 6kgs burner', '2016-06-23', '6kgs burner', 200, 700, '', '', 0, 0, NULL, '2016-06-23 09:00:14', '2016-12-13 06:35:47', 0, 0, NULL, NULL, NULL),
(8, '13kgs Empty cylinder ', '2016-06-23', '', 5130, 4500, '', '', 0, 0, NULL, '2016-06-23 09:33:18', '2016-12-09 15:54:30', 0, 0, NULL, NULL, NULL),
(9, 'Hosepipe', '2016-07-05', '2 meters', 56, 350, '', '', 1, 0, NULL, '2016-07-05 12:45:39', '2016-09-15 10:07:37', 0, 0, NULL, NULL, NULL),
(10, '500 kgs BULK', '2016-07-30', '500 KG BULK GAS', 103, 51500, '', '', 0, 0, NULL, '2016-07-30 11:07:54', '2016-09-22 12:25:25', 0, 0, NULL, NULL, NULL),
(11, '50kgs empty cylinder', '2016-08-15', '', 9000, 10000, '', '', 0, 0, NULL, '2016-08-15 11:07:28', '2016-08-15 11:07:28', 0, 0, NULL, NULL, NULL),
(12, '6 kgs empty cylinder', '2016-08-15', '', 2500, 3500, '', '', 0, 0, NULL, '2016-08-15 11:08:01', '2016-08-15 11:08:01', 0, 0, NULL, NULL, NULL),
(13, '6kg regulator', '2016-09-15', 'ampia', 400, 1000, '', '', 0, 0, NULL, '2016-09-15 10:06:19', '2016-09-15 10:06:19', 0, 0, NULL, NULL, NULL),
(14, 'hosepie clips', '2016-09-15', '', 30, 30, '', '', 0, 0, NULL, '2016-09-15 10:11:07', '2016-09-15 10:11:07', 0, 0, NULL, NULL, NULL),
(15, '999.78KG BULK', '2016-09-22', '999.78KG BULK', 93, 92980, '', '', 0, 0, NULL, '2016-09-22 12:27:02', '2016-09-22 12:27:02', 0, 0, NULL, NULL, NULL),
(16, '3000kgs', '2016-10-21', 'bulk gas delivery', 80, 98, '', '', 0, 0, NULL, '2016-10-21 13:53:08', '2016-10-21 13:53:08', 0, 0, NULL, NULL, NULL),
(17, '13kg gas + cylinder', '2016-11-03', 'outright', 5130, 4500, '', '', 0, 0, NULL, '2016-11-03 15:18:26', '2016-12-09 15:55:15', 0, 0, NULL, NULL, NULL),
(18, '400kg gas', '2016-11-09', '400kg bulk', 105, 42000, '', '', 0, 0, NULL, '2016-11-09 15:40:31', '2016-11-09 15:40:31', 0, 0, NULL, NULL, NULL),
(19, '2925KG BULK', '2016-11-17', 'BULK', 100, 292500, '', '', 0, 0, NULL, '2016-11-17 15:03:51', '2016-11-17 15:03:51', 0, 0, NULL, NULL, NULL),
(20, '50KG GAS HASS REFILL', '2016-12-09', '5OKG HASS REFILL', 4500, 9000, '', '', 0, 0, NULL, '2016-12-09 15:49:56', '2016-12-09 15:51:07', 0, 0, NULL, NULL, NULL),
(21, '6kgs grill', '2017-02-06', '6kgs grill', 200, 500, '', '', 0, 0, NULL, '2017-02-06 13:48:14', '2017-02-06 13:48:14', 0, 0, NULL, NULL, NULL),
(22, 'vomwaka12@gmail.com', '2017-09-16', 'None', 12000, 14000, '20', 'sample00\\109', 10, 0, NULL, '2017-09-16 21:54:42', '2017-09-16 21:54:42', 0, 0, NULL, NULL, NULL),
(23, 'Gas 3KG', '2017-09-16', 'None', 7000, 14000, '20', 'sample00\\10709', 10, 0, NULL, '2017-09-17 04:53:44', '2017-09-17 04:53:44', 0, 0, NULL, NULL, NULL),
(24, 'none', '2017-09-18', 'none', 12000, 14000, '20', 'sample00\\1067', 10, 0, NULL, '2017-09-18 14:56:47', '2017-09-18 14:56:47', 0, 0, NULL, NULL, NULL),
(25, 'K-GAS', '2017-09-20', 'None', 3000, 7000, '20', 'sample00\\1090', 10, 0, NULL, '2017-09-20 10:46:31', '2017-09-20 10:46:31', 0, 13, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `item_tracker`
--

CREATE TABLE `item_tracker` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `items_leased` tinyint(3) UNSIGNED NOT NULL,
  `items_returned` tinyint(3) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date_leased` date NOT NULL,
  `date_returned` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item_tracker`
--

INSERT INTO `item_tracker` (`id`, `item_id`, `items_leased`, `items_returned`, `location_id`, `client_id`, `status`, `date_leased`, `date_returned`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2, 1, 32, '2 Item(s) returned', '2016-11-12', '2017-09-01', '2016-11-12 15:56:55', '2017-09-01 12:21:21'),
(2, 1, 2, 2, 1, 291, '2 Item(s) returned', '2016-11-22', '2016-11-22', '2016-11-22 07:19:13', '2016-11-22 07:19:26'),
(3, 1, 2, 2, 1, 291, '2 Item(s) returned', '2016-11-22', '2017-09-01', '2016-11-22 07:20:13', '2017-09-01 12:06:45'),
(4, 11, 2, 2, 1, 1, '2 Item(s) returned', '2017-09-27', '2017-09-27', '2017-09-27 18:14:27', '2017-09-27 18:17:43'),
(5, 8, 2, 1, 1, 1, '1 Item(s) returned', '2017-09-27', '2017-09-27', '2017-09-27 18:18:53', '2017-09-27 18:19:50'),
(6, 8, 5, 0, 1, 1, '5 Item(s) Leased', '2017-09-28', '0000-00-00', '2017-09-28 10:29:19', '2017-09-28 10:29:19'),
(12, 1, 3, 3, 1, 7, '1 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 07:10:16', '2017-10-05 07:12:25'),
(13, 1, 4, 4, 1, 7, '4 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 08:37:37', '2017-10-05 08:38:04'),
(14, 1, 2, 2, 1, 7, '1 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 09:20:15', '2017-10-05 09:22:00'),
(15, 1, 1, 1, 1, 7, '1 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 09:20:46', '2017-10-05 09:21:57'),
(16, 1, 2, 2, 1, 7, '2 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 09:22:07', '2017-10-05 09:22:51'),
(17, 1, 2, 2, 1, 7, '2 Item(s) returned', '2017-10-05', '2017-10-05', '2017-10-05 09:22:38', '2017-10-05 09:23:00'),
(18, 2, 1, 0, 1, 1, '1 Item(s) Leased', '2017-10-09', '0000-00-00', '2017-10-09 10:25:35', '2017-10-09 10:25:35');

-- --------------------------------------------------------

--
-- Table structure for table `job_group`
--

CREATE TABLE `job_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `job_group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_group`
--

INSERT INTO `job_group` (`id`, `job_group_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Junior Staff', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Management', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Marketing', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `trans_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `amount` float(10,0) NOT NULL,
  `initiated_by` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `void` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`id`, `date`, `trans_no`, `account_id`, `amount`, `initiated_by`, `type`, `description`, `created_at`, `updated_at`, `void`) VALUES
(1, '2017-09-14', '1505405350', 3, 2700, 'superadmin', 'credit', 'cheque', '2017-09-14 19:12:10', '2017-09-14 19:12:10', 0),
(2, '2017-09-14', '1505405350', 3, 2700, 'superadmin', 'debit', 'cheque', '2017-09-14 19:12:10', '2017-09-14 19:12:10', 0),
(3, '2017-09-14', '1505405363', 2, 2700, 'superadmin', 'credit', 'mpesa', '2017-09-14 19:33:23', '2017-09-14 19:33:23', 0),
(4, '2017-09-14', '1505405363', 2, 2700, 'superadmin', 'debit', 'mpesa', '2017-09-14 19:33:23', '2017-09-14 19:33:23', 0),
(5, '2017-09-14', '1505405375', 2, 2700, 'superadmin', 'credit', 'mpesa', '2017-09-14 19:33:35', '2017-09-14 19:33:35', 0),
(6, '2017-09-14', '1505405375', 2, 2700, 'superadmin', 'debit', 'mpesa', '2017-09-14 19:33:35', '2017-09-14 19:33:35', 0),
(7, '2017-09-16', '1505567354', 1, 18000, 'superadmin', 'credit', 'None', '2017-09-16 23:02:14', '2017-09-16 23:02:14', 0),
(8, '2017-09-16', '1505567354', 1, 18000, 'superadmin', 'debit', 'None', '2017-09-16 23:02:14', '2017-09-16 23:02:14', 0),
(9, '2017-09-29', '1506679771', 1, 450, 'superadmin', 'credit', 'Payed an outstanding Expense Claim', '2017-09-29 10:11:31', '2017-09-29 10:11:31', 0),
(10, '2017-09-29', '1506679771', 2, 450, 'superadmin', 'debit', 'Payed an outstanding Expense Claim', '2017-09-29 10:11:31', '2017-09-29 10:11:31', 0),
(11, '2017-09-29', '1506679767', 8, 150, 'superadmin', 'credit', 'Bought office Bread', '2017-09-29 10:32:27', '2017-09-29 10:32:27', 0),
(12, '2017-09-29', '1506679767', 5, 150, 'superadmin', 'debit', 'Bought office Bread', '2017-09-29 10:32:27', '2017-09-29 10:32:27', 0),
(13, '2017-09-29', '1506679778', 8, 150, 'superadmin', 'credit', 'Bought office Bread', '2017-09-29 10:35:38', '2017-09-29 10:35:38', 0),
(14, '2017-09-29', '1506679778', 5, 150, 'superadmin', 'debit', 'Bought office Bread', '2017-09-29 10:35:38', '2017-09-29 10:35:38', 0),
(15, '2017-09-29', '1506679756', 8, 150, 'superadmin', 'credit', 'Bought office Bread', '2017-09-29 10:39:16', '2017-09-29 10:39:16', 0),
(16, '2017-09-29', '1506679756', 5, 150, 'superadmin', 'debit', 'Bought office Bread', '2017-09-29 10:39:16', '2017-09-29 10:39:16', 0),
(17, '2017-09-29', '1506679771', 8, 150, 'superadmin', 'credit', 'Bought office Bread', '2017-09-29 10:39:31', '2017-09-29 10:39:31', 0),
(18, '2017-09-29', '1506679771', 5, 150, 'superadmin', 'debit', 'Bought office Bread', '2017-09-29 10:39:31', '2017-09-29 10:39:31', 0),
(19, '2017-09-29', '1506679752', 8, 450, 'superadmin', 'credit', 'Bla', '2017-09-29 10:42:12', '2017-09-29 10:42:12', 0),
(20, '2017-09-29', '1506679752', 5, 450, 'superadmin', 'debit', 'Bla', '2017-09-29 10:42:12', '2017-09-29 10:42:12', 0),
(21, '2017-09-29', '1506679795', 8, 300, 'superadmin', 'credit', 'njsnd', '2017-09-29 10:44:55', '2017-09-29 10:44:55', 0),
(22, '2017-09-29', '1506679795', 5, 300, 'superadmin', 'debit', 'njsnd', '2017-09-29 10:44:55', '2017-09-29 10:44:55', 0),
(23, '2017-09-29', '1506679764', 5, 1000, 'superadmin', 'credit', 'Transferred cash from Fuel account to Petty Cash Account', '2017-09-29 10:46:24', '2017-09-29 10:46:24', 0),
(24, '2017-09-29', '1506679764', 5, 1000, 'superadmin', 'debit', 'Transferred cash from Fuel account to Petty Cash Account', '2017-09-29 10:46:24', '2017-09-29 10:46:24', 0),
(25, '2017-09-29', '1506679768', 2, 1000, 'superadmin', 'credit', 'Transferred Money to Petty Cash Account from Ken Wango', '2017-09-29 10:47:28', '2017-09-29 10:47:28', 0),
(26, '2017-09-29', '1506679768', 5, 1000, 'superadmin', 'debit', 'Transferred Money to Petty Cash Account from Ken Wango', '2017-09-29 10:47:28', '2017-09-29 10:47:28', 0),
(27, '2017-10-10', '1507615823', 1, 450, 'superadmin', 'credit', 'Payed an outstanding Expense Claim', '2017-10-10 06:34:23', '2017-10-10 06:34:23', 0),
(28, '2017-10-10', '1507615823', 2, 450, 'superadmin', 'debit', 'Payed an outstanding Expense Claim', '2017-10-10 06:34:23', '2017-10-10 06:34:23', 0),
(29, '2017-10-10', '1507648218', 8, 150, 'superadmin', 'credit', 'bla', '2017-10-10 15:16:18', '2017-10-10 15:16:18', 0),
(30, '2017-10-10', '1507648218', 5, 150, 'superadmin', 'debit', 'bla', '2017-10-10 15:16:18', '2017-10-10 15:16:18', 0),
(31, '2017-10-10', '1507648221', 8, 150, 'superadmin', 'credit', 'Bla', '2017-10-10 15:21:21', '2017-10-10 15:21:21', 0),
(32, '2017-10-10', '1507648221', 5, 150, 'superadmin', 'debit', 'Bla', '2017-10-10 15:21:21', '2017-10-10 15:21:21', 0);

-- --------------------------------------------------------

--
-- Table structure for table `kins`
--

CREATE TABLE `kins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rship` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `goodwill` float(10,0) DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `member_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaveapplications`
--

CREATE TABLE `leaveapplications` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `application_date` date DEFAULT NULL,
  `applied_start_date` date DEFAULT NULL,
  `applied_end_date` date DEFAULT NULL,
  `leavetype_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_approved` date DEFAULT NULL,
  `date_rejected` date DEFAULT NULL,
  `date_amended` date DEFAULT NULL,
  `date_cancelled` date DEFAULT NULL,
  `approved_start_date` date DEFAULT NULL,
  `approved_end_date` date DEFAULT NULL,
  `actual_start_date` date DEFAULT NULL,
  `actual_end_date` date DEFAULT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leavetypes`
--

CREATE TABLE `leavetypes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `days` int(11) DEFAULT '0',
  `organization_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanaccounts`
--

CREATE TABLE `loanaccounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `member_id` int(10) UNSIGNED NOT NULL,
  `loanproduct_id` int(10) UNSIGNED NOT NULL,
  `is_new_application` tinyint(1) NOT NULL DEFAULT '1',
  `application_date` date NOT NULL,
  `amount_applied` float(10,0) NOT NULL,
  `interest_rate` float(10,0) NOT NULL,
  `period` int(11) NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `date_approved` date DEFAULT NULL,
  `amount_approved` float(10,0) DEFAULT NULL,
  `is_rejected` tinyint(1) NOT NULL DEFAULT '0',
  `rejection_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_amended` tinyint(1) NOT NULL DEFAULT '0',
  `date_amended` date DEFAULT NULL,
  `is_disbursed` tinyint(1) NOT NULL DEFAULT '0',
  `amount_disbursed` float(10,0) DEFAULT NULL,
  `date_disbursed` date DEFAULT NULL,
  `repayment_start_date` date DEFAULT NULL,
  `is_matured` tinyint(1) NOT NULL DEFAULT '0',
  `is_written_off` tinyint(1) NOT NULL DEFAULT '0',
  `is_defaulted` tinyint(1) NOT NULL DEFAULT '0',
  `is_overpaid` tinyint(1) NOT NULL DEFAULT '0',
  `account_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `repayment_duration` int(11) DEFAULT NULL,
  `is_top_up` tinyint(1) DEFAULT '0',
  `top_up_amount` float(15,3) DEFAULT '0.000',
  `loan_purpose` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanguarantors`
--

CREATE TABLE `loanguarantors` (
  `id` int(10) UNSIGNED NOT NULL,
  `member_id` int(10) UNSIGNED NOT NULL,
  `loanaccount_id` int(10) UNSIGNED NOT NULL,
  `amount` float(10,0) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanpostings`
--

CREATE TABLE `loanpostings` (
  `id` int(10) UNSIGNED NOT NULL,
  `loanproduct_id` int(10) UNSIGNED NOT NULL,
  `transaction` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `debit_account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `credit_account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanproducts`
--

CREATE TABLE `loanproducts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `formula` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `interest_rate` float(10,0) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amortization` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'EI',
  `period` int(11) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanrepayments`
--

CREATE TABLE `loanrepayments` (
  `id` int(10) UNSIGNED NOT NULL,
  `loanaccount_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `principal_paid` float(12,2) NOT NULL DEFAULT '0.00',
  `interest_paid` float(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loantransactions`
--

CREATE TABLE `loantransactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `loanaccount_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trans_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float(10,0) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Main Store', 'Container city', '2016-06-22 08:07:49', '2016-06-22 08:07:49');

-- --------------------------------------------------------

--
-- Table structure for table `mails`
--

CREATE TABLE `mails` (
  `id` int(10) UNSIGNED NOT NULL,
  `driver` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'smtp',
  `host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `encryption` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sender_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `mails`
--

INSERT INTO `mails` (`id`, `driver`, `host`, `username`, `password`, `port`, `encryption`, `sender_name`, `created_at`, `updated_at`) VALUES
(1, 'smtp', 'mail.gx.co.ke', 'info@gx.co.ke', 'gx#2015', '25', '', 'info@lixnet.net', '2016-07-17 21:00:00', '2016-07-21 07:18:51');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `membership_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default_photo.png',
  `signature` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_number` bigint(20) DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `monthly_remittance_amount` float(15,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) DEFAULT '1',
  `is_css_active` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2015_11_13_192002_create_x_account_table', 1),
('2015_11_13_192002_create_x_accounts_table', 1),
('2015_11_13_192002_create_x_assigned_roles_table', 1),
('2015_11_13_192002_create_x_audits_table', 1),
('2015_11_13_192002_create_x_banking_table', 1),
('2015_11_13_192002_create_x_branches_table', 1),
('2015_11_13_192002_create_x_categories_table', 1),
('2015_11_13_192002_create_x_charge_loanproduct_table', 1),
('2015_11_13_192002_create_x_charge_savingproduct_table', 1),
('2015_11_13_192002_create_x_charges_table', 1),
('2015_11_13_192002_create_x_currencies_table', 1),
('2015_11_13_192002_create_x_groups_table', 1),
('2015_11_13_192002_create_x_journals_table', 1),
('2015_11_13_192002_create_x_kins_table', 1),
('2015_11_13_192002_create_x_loanaccounts_table', 1),
('2015_11_13_192002_create_x_loanguarantors_table', 1),
('2015_11_13_192002_create_x_loanpostings_table', 1),
('2015_11_13_192002_create_x_loanproducts_table', 1),
('2015_11_13_192002_create_x_loanrepayments_table', 1),
('2015_11_13_192002_create_x_loantransactions_table', 1),
('2015_11_13_192002_create_x_members_table', 1),
('2015_11_13_192002_create_x_orders_table', 1),
('2015_11_13_192002_create_x_organizations_table', 1),
('2015_11_13_192002_create_x_password_reminders_table', 1),
('2015_11_13_192002_create_x_permission_role_table', 1),
('2015_11_13_192002_create_x_permissions_table', 1),
('2015_11_13_192002_create_x_products_table', 1),
('2015_11_13_192002_create_x_roles_table', 1),
('2015_11_13_192002_create_x_savingaccounts_table', 1),
('2015_11_13_192002_create_x_savingpostings_table', 1),
('2015_11_13_192002_create_x_savingproducts_table', 1),
('2015_11_13_192002_create_x_savingtransactions_table', 1),
('2015_11_13_192002_create_x_shareaccounts_table', 1),
('2015_11_13_192002_create_x_shares_table', 1),
('2015_11_13_192002_create_x_sharetransactions_table', 1),
('2015_11_13_192002_create_x_tax_orders_table', 1),
('2015_11_13_192002_create_x_tax_table', 1),
('2015_11_13_192002_create_x_user_role_table', 1),
('2015_11_13_192002_create_x_users_table', 1),
('2015_11_13_192002_create_x_vendors_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_assigned_roles_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_charge_loanproduct_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_charge_savingproduct_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_journals_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_kins_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_loanaccounts_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_loanguarantors_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_loanpostings_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_loanrepayments_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_loantransactions_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_members_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_orders_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_permission_role_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_products_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_savingaccounts_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_savingpostings_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_savingtransactions_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_shareaccounts_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_sharetransactions_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_user_role_table', 1),
('2015_11_13_192006_add_foreign_keys_to_x_users_table', 1),
('2015_11_20_083755_create_autoprocesses_table', 1),
('2015_11_30_072830_create_employee_table', 1),
('2015_11_30_101925_create_departments_table', 1),
('2015_11_30_102341_create_job_group_table', 1),
('2015_11_30_103046_create_education_table', 1),
('2015_11_30_104021_create_employee_type_table', 1),
('2015_11_30_104621_create_bank_table', 1),
('2015_11_30_105006_create_deductions_table', 1),
('2015_11_30_105430_create_relief_table', 1),
('2015_11_30_105530_create_employee_relief_table', 1),
('2015_11_30_122642_create_earnings_table', 1),
('2015_11_30_125654_create_allowances_table', 1),
('2015_11_30_130039_create_employee_allowances_table', 1),
('2015_11_30_131641_create_bank_branches_table', 1),
('2015_11_30_132013_create_employee_deductions_table', 1),
('2015_11_30_132807_create_transact_allowances_table', 1),
('2015_11_30_132807_create_transact_deductions_table', 1),
('2015_11_30_133021_create_transact_earnings_table', 1),
('2015_11_30_133337_create_transact_table', 1),
('2015_11_30_134419_create_documents_table', 1),
('2015_11_30_134623_create_next_of_kin_table', 1),
('2015_11_30_135019_create_company_property_table', 1),
('2015_12_02_060131_create_nssf_table', 1),
('2015_12_02_060202_create_nhif_table', 1),
('2015_12_11_073943_create_leavetypes_table', 1),
('2015_12_11_074541_create_holidays_table', 1),
('2015_12_11_075243_create_leaveapplications_table', 1),
('2015_12_17_092634_create_items_table', 1),
('2015_12_17_093206_create_clients_table', 1),
('2015_12_17_093509_create_paymentmethods_table', 1),
('2015_12_17_094052_create_locations_table', 1),
('2015_12_17_094633_create_expenses_table', 1),
('2015_12_17_095700_create_erporders_table', 1),
('2015_12_17_101046_create_erporderitems_table', 1),
('2015_12_17_104147_create_payments_table', 1),
('2015_12_17_104738_create_stocks_table', 1),
('2016_07_08_192002_create_x_salestarget_table', 2),
('2015_06_29_104738_create_mails_table', 3),
('2015_07_13_104738_create_assigndrivers_table', 3),
('2015_07_13_104738_create_drivers_table', 3),
('2016_07_13_104738_create_vehicles_table', 3),
('2016_08_04_104739_create_prices_table', 4),
('2016_09_08_161324_add_comment_column_in_erporder', 5),
('2016_09_15_223520_add_category_to_client_table', 5),
('2016_09_19_110601_create_item_tracker', 5);

-- --------------------------------------------------------

--
-- Table structure for table `navigations`
--

CREATE TABLE `navigations` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `navigations`
--

INSERT INTO `navigations` (`id`, `type`, `name`, `route`, `created_at`, `updated_at`) VALUES
(1, 1, 'Manage Products', 'manage', '2017-09-10 05:48:03', '2017-09-10 05:48:03'),
(2, 1, 'Subsidiaries', 'subsidiary', '2017-09-10 05:48:40', '2017-09-10 05:48:40'),
(3, 1, 'Suppliers', 'suppliers', '2017-09-10 05:49:01', '2017-09-10 05:49:01'),
(4, 1, 'Stock', 'stock', '2017-09-10 05:49:29', '2017-09-10 05:49:29'),
(5, 1, 'Users', 'users', '2017-09-10 05:49:49', '2017-09-10 05:49:49'),
(6, 5, 'Dashboard', 'home', '2017-09-10 08:13:11', '2017-09-10 08:13:11');

-- --------------------------------------------------------

--
-- Table structure for table `next_of_kin`
--

CREATE TABLE `next_of_kin` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `kin_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `relation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `contact` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `confirmation_code` varchar(255) DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `confirmation_code`, `message`, `is_read`, `type`, `link`, `created_at`, `updated_at`) VALUES
(1, 1, 'ccd26a90dc7a9690d297daf566ec6762', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/138/50kg high pressure regulator/1/ccd26a90dc7a9690d297daf566ec6762', '2017-09-29 11:00:13', '2017-09-29 11:03:32'),
(2, 1, '06909a434f8cae275833ca3681836c5e', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/139/50kg high pressure regulator/1/06909a434f8cae275833ca3681836c5e', '2017-09-29 11:00:54', '2017-09-29 11:03:29'),
(3, 2, '06909a434f8cae275833ca3681836c5e', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/139/50kg high pressure regulator/2/06909a434f8cae275833ca3681836c5e', '2017-09-29 11:01:03', '2017-09-29 11:01:03'),
(4, 4, '06909a434f8cae275833ca3681836c5e', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/139/50kg high pressure regulator/4/06909a434f8cae275833ca3681836c5e', '2017-09-29 11:01:05', '2017-09-29 11:01:36'),
(5, 1, 'cfa87ebddb84f0cae9952ec723ba2cd5', 'Hello, Approval to update Item 50 kgs gas refill  is required', 1, 'item', 'approveitemupdate/50 kgs gas refill /50 kg/50kgs gas refill/5600/9000/null/null/0/3/1/cfa87ebddb84f0cae9952ec723ba2cd5/1', '2017-09-29 11:14:48', '2017-09-29 11:15:15'),
(6, 1, '862d32133b9de688195e4c3e22208706', 'Approval to pricing for item 13kgs gas refill is required', 1, 'price', 'approvepriceupdate/19/2/500/3/1/862d32133b9de688195e4c3e22208706/1', '2017-09-29 11:15:05', '2017-09-29 11:16:38'),
(7, 1, '', 'Hello, Purchase order 2017/09/02/0009 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/show/10', '2017-09-29 11:18:00', '2017-09-29 11:37:26'),
(8, 2, '', 'Hello, Purchase order 2017/09/02/0009 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/show/10', '2017-09-29 11:18:03', '2017-09-29 11:18:03'),
(9, 4, '', 'Hello, Purchase order 2017/09/02/0009 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/show/10', '2017-09-29 11:18:05', '2017-09-29 11:26:57'),
(10, 1, '', 'Hello, Purchase order 2017/09/02/0009 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/show/10', '2017-09-29 11:19:55', '2017-09-29 11:37:26'),
(11, 2, '', 'Hello, Purchase order 2017/09/02/0009 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/show/10', '2017-09-29 11:19:59', '2017-09-29 11:19:59'),
(12, 1, '', 'Hello, Purchase order 2017/09/02/0009 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/show/10', '2017-09-29 11:22:00', '2017-09-29 11:37:26'),
(13, 2, '', 'Hello, Purchase order 2017/09/02/0009 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/show/10', '2017-09-29 11:22:11', '2017-09-29 11:22:11'),
(14, 4, '', 'Hello, Purchase order 2017/09/02/0009 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/show/10', '2017-09-29 11:22:12', '2017-09-29 11:26:57'),
(15, 1, '879ff6a780e591cf9934e538c1ebf1be', 'Hello, Purchase order 2017/09/25/0079 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/1/80', '2017-09-29 11:33:37', '2017-09-29 11:37:27'),
(16, 2, '879ff6a780e591cf9934e538c1ebf1be', 'Hello, Purchase order 2017/09/25/0079 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/2/80', '2017-09-29 11:33:51', '2017-09-29 11:33:51'),
(17, 4, '879ff6a780e591cf9934e538c1ebf1be', 'Hello, Purchase order 2017/09/25/0079 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/4/80', '2017-09-29 11:33:52', '2017-09-29 11:39:51'),
(18, 1, '82cf4aa713de5704ed2e746f19ad11cd', 'Hello, Purchase order 2017/09/27/0081 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/82cf4aa713de5704ed2e746f19ad11cd/1/82', '2017-09-29 11:37:43', '2017-09-29 12:42:09'),
(19, 2, '82cf4aa713de5704ed2e746f19ad11cd', 'Hello, Purchase order 2017/09/27/0081 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/82cf4aa713de5704ed2e746f19ad11cd/2/82', '2017-09-29 11:37:48', '2017-09-29 11:37:48'),
(20, 4, '82cf4aa713de5704ed2e746f19ad11cd', 'Hello, Purchase order 2017/09/27/0081 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/82cf4aa713de5704ed2e746f19ad11cd/4/82', '2017-09-29 11:37:49', '2017-09-29 11:39:05'),
(21, 1, '792aa5730bf55f80f8e363551f1e607e', 'Hello, Purchase order 2017/09/27/0081 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/792aa5730bf55f80f8e363551f1e607e/1/82', '2017-09-29 11:39:26', '2017-09-29 12:42:09'),
(22, 2, '792aa5730bf55f80f8e363551f1e607e', 'Hello, Purchase order 2017/09/27/0081 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/792aa5730bf55f80f8e363551f1e607e/2/82', '2017-09-29 11:39:29', '2017-09-29 11:39:29'),
(23, 4, '792aa5730bf55f80f8e363551f1e607e', 'Hello, Purchase order 2017/09/27/0081 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/792aa5730bf55f80f8e363551f1e607e/4/82', '2017-09-29 11:39:31', '2017-09-29 11:39:43'),
(24, 1, 'a3af0a34bc7df13347a4a464b1126731', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/a3af0a34bc7df13347a4a464b1126731/1/88', '2017-09-29 16:35:20', '2017-09-29 17:01:03'),
(25, 2, 'a3af0a34bc7df13347a4a464b1126731', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/a3af0a34bc7df13347a4a464b1126731/2/88', '2017-09-29 16:35:42', '2017-09-29 16:35:42'),
(26, 4, 'a3af0a34bc7df13347a4a464b1126731', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/a3af0a34bc7df13347a4a464b1126731/4/88', '2017-09-29 16:35:42', '2017-09-29 16:35:42'),
(27, 1, '5236afc5a2dcf078c93277024249cdf2', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/5236afc5a2dcf078c93277024249cdf2/1/88', '2017-09-29 16:36:19', '2017-09-29 17:36:14'),
(28, 2, '5236afc5a2dcf078c93277024249cdf2', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/5236afc5a2dcf078c93277024249cdf2/2/88', '2017-09-29 16:36:40', '2017-09-29 16:36:40'),
(29, 4, '5236afc5a2dcf078c93277024249cdf2', 'Hello, Purchase order 2017/09/29/0087 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/5236afc5a2dcf078c93277024249cdf2/4/88', '2017-09-29 16:36:41', '2017-09-29 16:36:41'),
(30, 1, 'ad2593dd83bd2186086f38bae4e76618', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/144/50 kgs gas refill /1/ad2593dd83bd2186086f38bae4e76618', '2017-09-29 16:58:18', '2017-09-29 17:36:18'),
(31, 2, 'ad2593dd83bd2186086f38bae4e76618', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/144/50 kgs gas refill /2/ad2593dd83bd2186086f38bae4e76618', '2017-09-29 16:58:40', '2017-09-29 16:58:40'),
(32, 4, 'ad2593dd83bd2186086f38bae4e76618', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/144/50 kgs gas refill /4/ad2593dd83bd2186086f38bae4e76618', '2017-09-29 16:58:41', '2017-09-29 16:58:41'),
(33, 1, '81909701d7809a6ec852fdf14c497bda', 'Hello, Purchase order 2017/09/29/0087 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/81909701d7809a6ec852fdf14c497bda/1/88', '2017-09-29 17:01:07', '2017-09-29 17:35:05'),
(34, 2, '81909701d7809a6ec852fdf14c497bda', 'Hello, Purchase order 2017/09/29/0087 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/81909701d7809a6ec852fdf14c497bda/2/88', '2017-09-29 17:01:29', '2017-09-29 17:01:29'),
(35, 4, '81909701d7809a6ec852fdf14c497bda', 'Hello, Purchase order 2017/09/29/0087 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/81909701d7809a6ec852fdf14c497bda/4/88', '2017-09-29 17:01:30', '2017-09-29 17:01:30'),
(36, 1, 'dd0a48a0e55f9b5a76b13c347071465a', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/146/ 13kgs gas refill/1/dd0a48a0e55f9b5a76b13c347071465a', '2017-09-29 19:06:00', '2017-09-29 19:06:58'),
(37, 2, 'dd0a48a0e55f9b5a76b13c347071465a', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/146/ 13kgs gas refill/2/dd0a48a0e55f9b5a76b13c347071465a', '2017-09-29 19:06:22', '2017-09-29 19:06:22'),
(38, 4, 'dd0a48a0e55f9b5a76b13c347071465a', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/146/ 13kgs gas refill/4/dd0a48a0e55f9b5a76b13c347071465a', '2017-09-29 19:06:23', '2017-09-29 19:06:23'),
(39, 1, 'b1aca4c9c653358744e25ab569a113fa', 'Hello, Approval to receive stock is required', 1, 'stock', 'confirmstock/147/ 13kgs gas refill/1/b1aca4c9c653358744e25ab569a113fa', '2017-09-29 19:10:10', '2017-09-29 19:11:18'),
(40, 2, 'b1aca4c9c653358744e25ab569a113fa', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/147/ 13kgs gas refill/2/b1aca4c9c653358744e25ab569a113fa', '2017-09-29 19:10:32', '2017-09-29 19:10:32'),
(41, 4, 'b1aca4c9c653358744e25ab569a113fa', 'Hello, Approval to receive stock is required', 0, 'stock', 'confirmstock/147/ 13kgs gas refill/4/b1aca4c9c653358744e25ab569a113fa', '2017-09-29 19:10:33', '2017-09-29 19:10:33'),
(42, 1, 'bc7ce82a221b2d432a3c2c83a455b0dc', 'Hello, Purchase order 2017/10/04/0092 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/bc7ce82a221b2d432a3c2c83a455b0dc/1/93', '2017-10-04 12:34:58', '2017-10-04 12:35:31'),
(43, 2, 'bc7ce82a221b2d432a3c2c83a455b0dc', 'Hello, Purchase order 2017/10/04/0092 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/bc7ce82a221b2d432a3c2c83a455b0dc/2/93', '2017-10-04 12:35:09', '2017-10-04 12:35:09'),
(44, 4, 'bc7ce82a221b2d432a3c2c83a455b0dc', 'Hello, Purchase order 2017/10/04/0092 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/bc7ce82a221b2d432a3c2c83a455b0dc/4/93', '2017-10-04 12:35:11', '2017-10-04 12:35:11'),
(45, 1, '62ffca419cda3802ef35b71de41f0382', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/62ffca419cda3802ef35b71de41f0382/1/93', '2017-10-04 12:45:11', '2017-10-04 12:45:20'),
(46, 3, '62ffca419cda3802ef35b71de41f0382', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/62ffca419cda3802ef35b71de41f0382/3/93', '2017-10-04 12:45:12', '2017-10-04 13:19:43'),
(47, 4, '62ffca419cda3802ef35b71de41f0382', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/62ffca419cda3802ef35b71de41f0382/4/93', '2017-10-04 12:45:12', '2017-10-04 12:45:12'),
(48, 5, '62ffca419cda3802ef35b71de41f0382', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/62ffca419cda3802ef35b71de41f0382/5/93', '2017-10-04 12:45:12', '2017-10-04 12:45:12'),
(49, 1, '6219a5b4c41ca7250132223f21c9b659', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/6219a5b4c41ca7250132223f21c9b659/1/93', '2017-10-04 12:49:37', '2017-10-04 12:49:44'),
(50, 3, '6219a5b4c41ca7250132223f21c9b659', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/6219a5b4c41ca7250132223f21c9b659/3/93', '2017-10-04 12:49:37', '2017-10-04 13:19:41'),
(51, 4, '6219a5b4c41ca7250132223f21c9b659', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/6219a5b4c41ca7250132223f21c9b659/4/93', '2017-10-04 12:49:37', '2017-10-04 12:49:37'),
(52, 5, '6219a5b4c41ca7250132223f21c9b659', 'Hello, Purchase order 2017/10/04/0092 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/6219a5b4c41ca7250132223f21c9b659/5/93', '2017-10-04 12:49:38', '2017-10-04 12:49:38'),
(53, 1, '89dc9ca2f4a524d479f466ebe163f6de', 'Hello, Approval to receive stock is required', 1, 'stock', 'notificationshowstock/149/Glevak Investment Ltd/2017/10/04/0092 : 50 kgs gas refill  - (5)/1/89dc9ca2f4a524d479f466ebe163f6de', '2017-10-04 13:18:34', '2017-10-04 13:29:44'),
(54, 2, '89dc9ca2f4a524d479f466ebe163f6de', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/149/Glevak Investment Ltd/2017/10/04/0092 : 50 kgs gas refill  - (5)/2/89dc9ca2f4a524d479f466ebe163f6de', '2017-10-04 13:18:35', '2017-10-04 13:18:35'),
(55, 4, '89dc9ca2f4a524d479f466ebe163f6de', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/149/Glevak Investment Ltd/2017/10/04/0092 : 50 kgs gas refill  - (5)/4/89dc9ca2f4a524d479f466ebe163f6de', '2017-10-04 13:18:35', '2017-10-04 13:18:35'),
(56, 1, 'd5df1643ad481931cbc23b2b7b58742e', 'Hello, Approval to receive stock is required', 1, 'stock', 'notificationshowstock/151/Glevak Investment Ltd/93/1/d5df1643ad481931cbc23b2b7b58742e', '2017-10-04 14:04:29', '2017-10-04 14:04:51'),
(57, 2, 'd5df1643ad481931cbc23b2b7b58742e', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/151/Glevak Investment Ltd/93/2/d5df1643ad481931cbc23b2b7b58742e', '2017-10-04 14:04:29', '2017-10-04 14:04:29'),
(58, 4, 'd5df1643ad481931cbc23b2b7b58742e', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/151/Glevak Investment Ltd/93/4/d5df1643ad481931cbc23b2b7b58742e', '2017-10-04 14:04:29', '2017-10-04 14:04:29'),
(59, 1, 'ca5b3b0656a3376ff6d6e15033d24a84', 'Hello, Purchase order 2017/09/27/0082 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/ca5b3b0656a3376ff6d6e15033d24a84/1/83', '2017-10-05 09:14:22', '2017-10-05 09:14:36'),
(60, 2, 'ca5b3b0656a3376ff6d6e15033d24a84', 'Hello, Purchase order 2017/09/27/0082 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/ca5b3b0656a3376ff6d6e15033d24a84/2/83', '2017-10-05 09:14:22', '2017-10-05 09:14:22'),
(61, 4, 'ca5b3b0656a3376ff6d6e15033d24a84', 'Hello, Purchase order 2017/09/27/0082 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/ca5b3b0656a3376ff6d6e15033d24a84/4/83', '2017-10-05 09:14:22', '2017-10-05 09:14:22'),
(62, 1, '2a93bef7957cb70283423c3380642541', 'Hello, Purchase order 2017/09/04/0035 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/2a93bef7957cb70283423c3380642541/1/36', '2017-10-05 09:18:44', '2017-10-05 10:41:44'),
(63, 2, '2a93bef7957cb70283423c3380642541', 'Hello, Purchase order 2017/09/04/0035 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/2a93bef7957cb70283423c3380642541/2/36', '2017-10-05 09:18:44', '2017-10-05 09:18:44'),
(64, 4, '2a93bef7957cb70283423c3380642541', 'Hello, Purchase order 2017/09/04/0035 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/2a93bef7957cb70283423c3380642541/4/36', '2017-10-05 09:18:44', '2017-10-05 09:18:44'),
(65, 1, '11ebf393b756d2ee2b88e0c7aa337eb8', 'Hello, Purchase order 2017/09/04/0035 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/11ebf393b756d2ee2b88e0c7aa337eb8/1/36', '2017-10-05 09:19:15', '2017-10-05 10:41:45'),
(66, 3, '11ebf393b756d2ee2b88e0c7aa337eb8', 'Hello, Purchase order 2017/09/04/0035 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/11ebf393b756d2ee2b88e0c7aa337eb8/3/36', '2017-10-05 09:19:15', '2017-10-05 15:13:43'),
(67, 4, '11ebf393b756d2ee2b88e0c7aa337eb8', 'Hello, Purchase order 2017/09/04/0035 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/11ebf393b756d2ee2b88e0c7aa337eb8/4/36', '2017-10-05 09:19:15', '2017-10-05 09:19:15'),
(68, 5, '11ebf393b756d2ee2b88e0c7aa337eb8', 'Hello, Purchase order 2017/09/04/0035 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/11ebf393b756d2ee2b88e0c7aa337eb8/5/36', '2017-10-05 09:19:16', '2017-10-05 09:19:16'),
(69, 1, '16a895f283fe87aec9c8f966a5041c3f', 'Hello, Please approve cancellation of Sale order 2017/09/29/0088', 1, 'cancel sale order', 'erporders/notifyshow/16a895f283fe87aec9c8f966a5041c3f/1/89', '2017-10-05 15:19:09', '2017-10-05 15:50:10'),
(70, 1, '688570e77900e6d641098f44631a7883', 'Hello, Approval to receive stock is required', 1, 'stock', 'notificationshowstock/173/Glevak Investment Ltd/7/1/688570e77900e6d641098f44631a7883', '2017-10-05 16:01:50', '2017-10-05 16:36:00'),
(71, 2, '688570e77900e6d641098f44631a7883', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/173/Glevak Investment Ltd/7/2/688570e77900e6d641098f44631a7883', '2017-10-05 16:01:50', '2017-10-05 16:01:50'),
(72, 4, '688570e77900e6d641098f44631a7883', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/173/Glevak Investment Ltd/7/4/688570e77900e6d641098f44631a7883', '2017-10-05 16:01:50', '2017-10-05 16:01:50'),
(73, 1, '578fb46d67922d87e74ffba61e1895fd', 'Hello, Purchase order 2017/10/05/0094 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/578fb46d67922d87e74ffba61e1895fd/1/95', '2017-10-05 16:22:09', '2017-10-05 16:36:00'),
(74, 2, '578fb46d67922d87e74ffba61e1895fd', 'Hello, Purchase order 2017/10/05/0094 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/578fb46d67922d87e74ffba61e1895fd/2/95', '2017-10-05 16:22:09', '2017-10-05 16:22:09'),
(75, 4, '578fb46d67922d87e74ffba61e1895fd', 'Hello, Purchase order 2017/10/05/0094 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/578fb46d67922d87e74ffba61e1895fd/4/95', '2017-10-05 16:22:09', '2017-10-05 16:22:09'),
(76, 1, '9113d9d0b04fa6fa7938aabdcb6c57a4', 'Hello, Purchase order 2017/10/05/0094 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/9113d9d0b04fa6fa7938aabdcb6c57a4/1/95', '2017-10-05 16:22:12', '2017-10-05 16:36:00'),
(77, 3, '9113d9d0b04fa6fa7938aabdcb6c57a4', 'Hello, Purchase order 2017/10/05/0094 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/9113d9d0b04fa6fa7938aabdcb6c57a4/3/95', '2017-10-05 16:22:12', '2017-10-05 16:59:35'),
(78, 4, '9113d9d0b04fa6fa7938aabdcb6c57a4', 'Hello, Purchase order 2017/10/05/0094 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/9113d9d0b04fa6fa7938aabdcb6c57a4/4/95', '2017-10-05 16:22:12', '2017-10-05 16:22:12'),
(79, 5, '9113d9d0b04fa6fa7938aabdcb6c57a4', 'Hello, Purchase order 2017/10/05/0094 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/9113d9d0b04fa6fa7938aabdcb6c57a4/5/95', '2017-10-05 16:22:12', '2017-10-05 16:22:12'),
(80, 1, 'b33be6e4a20cea559f8907749393bc40', 'Hello, Approval to receive payment is required', 1, 'item', 'notificationshowpayment/3/1/b33be6e4a20cea559f8907749393bc40/9', '2017-10-05 17:06:55', '2017-10-05 17:47:54'),
(81, 2, 'b33be6e4a20cea559f8907749393bc40', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/2/b33be6e4a20cea559f8907749393bc40/9', '2017-10-05 17:06:55', '2017-10-05 17:06:55'),
(82, 4, 'b33be6e4a20cea559f8907749393bc40', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/4/b33be6e4a20cea559f8907749393bc40/9', '2017-10-05 17:06:55', '2017-10-05 17:06:55'),
(83, 1, 'facd9e328eaabb8d1d45b383c2f81bb4', 'Hello, Approval to receive payment is required', 1, 'item', 'notificationshowpayment/3/1/facd9e328eaabb8d1d45b383c2f81bb4/10', '2017-10-05 17:08:52', '2017-10-05 17:47:54'),
(84, 2, 'facd9e328eaabb8d1d45b383c2f81bb4', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/2/facd9e328eaabb8d1d45b383c2f81bb4/10', '2017-10-05 17:08:52', '2017-10-05 17:08:52'),
(85, 4, 'facd9e328eaabb8d1d45b383c2f81bb4', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/4/facd9e328eaabb8d1d45b383c2f81bb4/10', '2017-10-05 17:08:52', '2017-10-05 17:08:52'),
(86, 1, 'f489190da8badfa569695618db4486e7', 'Hello, Approval to receive payment is required', 1, 'item', 'notificationshowpayment/3/1/f489190da8badfa569695618db4486e7/11', '2017-10-05 17:50:15', '2017-10-05 17:57:48'),
(87, 2, 'f489190da8badfa569695618db4486e7', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/2/f489190da8badfa569695618db4486e7/11', '2017-10-05 17:50:15', '2017-10-05 17:50:15'),
(88, 4, 'f489190da8badfa569695618db4486e7', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/4/f489190da8badfa569695618db4486e7/11', '2017-10-05 17:50:15', '2017-10-05 17:50:15'),
(89, 1, '20f24cade4509d85ce38090e2ea51342', 'Hello, Approval to receive payment is required', 1, 'item', 'notificationshowpayment/3/1/20f24cade4509d85ce38090e2ea51342/13', '2017-10-05 18:16:09', '2017-10-05 18:19:36'),
(90, 2, '20f24cade4509d85ce38090e2ea51342', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/2/20f24cade4509d85ce38090e2ea51342/13', '2017-10-05 18:16:10', '2017-10-05 18:16:10'),
(91, 4, '20f24cade4509d85ce38090e2ea51342', 'Hello, Approval to receive payment is required', 0, 'item', 'notificationshowpayment/3/4/20f24cade4509d85ce38090e2ea51342/13', '2017-10-05 18:16:10', '2017-10-05 18:16:10'),
(92, 1, 'ebdd4ff35af27821449f502548a0d530', 'Hello, Approval for purchase payment is required', 1, 'payment', 'notificationshowpayment/3/1/ebdd4ff35af27821449f502548a0d530/15', '2017-10-05 18:22:10', '2017-10-05 18:22:25'),
(93, 2, 'ebdd4ff35af27821449f502548a0d530', 'Hello, Approval for purchase payment is required', 0, 'payment', 'notificationshowpayment/3/2/ebdd4ff35af27821449f502548a0d530/15', '2017-10-05 18:22:10', '2017-10-05 18:22:10'),
(94, 4, 'ebdd4ff35af27821449f502548a0d530', 'Hello, Approval for purchase payment is required', 0, 'payment', 'notificationshowpayment/3/4/ebdd4ff35af27821449f502548a0d530/15', '2017-10-05 18:22:10', '2017-10-05 18:22:10'),
(95, 1, 'ae95abc98cc09fe8b743c120eb7e0dbb', 'Hello, Purchase order 2017/10/06/0095 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/ae95abc98cc09fe8b743c120eb7e0dbb/1/96', '2017-10-06 15:52:08', '2017-10-06 15:53:24'),
(96, 2, 'ae95abc98cc09fe8b743c120eb7e0dbb', 'Hello, Purchase order 2017/10/06/0095 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/ae95abc98cc09fe8b743c120eb7e0dbb/2/96', '2017-10-06 15:52:08', '2017-10-06 15:52:08'),
(97, 4, 'ae95abc98cc09fe8b743c120eb7e0dbb', 'Hello, Purchase order 2017/10/06/0095 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/ae95abc98cc09fe8b743c120eb7e0dbb/4/96', '2017-10-06 15:52:08', '2017-10-06 15:52:08'),
(98, 1, '156171c757bd5413adb3bc6ebc739417', 'Hello, Purchase order 2017/10/06/0095 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/156171c757bd5413adb3bc6ebc739417/1/96', '2017-10-06 15:53:29', '2017-10-06 15:53:36'),
(99, 2, '156171c757bd5413adb3bc6ebc739417', 'Hello, Purchase order 2017/10/06/0095 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/156171c757bd5413adb3bc6ebc739417/2/96', '2017-10-06 15:53:29', '2017-10-06 15:53:29'),
(100, 4, '156171c757bd5413adb3bc6ebc739417', 'Hello, Purchase order 2017/10/06/0095 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/156171c757bd5413adb3bc6ebc739417/4/96', '2017-10-06 15:53:29', '2017-10-06 15:53:29'),
(101, 1, '45f6b895cdeec53782a1e8bf0fde92d6', 'Hello, Purchase order 2017/10/06/0095 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/45f6b895cdeec53782a1e8bf0fde92d6/1/96', '2017-10-06 15:53:32', '2017-10-06 15:53:36'),
(102, 3, '45f6b895cdeec53782a1e8bf0fde92d6', 'Hello, Purchase order 2017/10/06/0095 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/45f6b895cdeec53782a1e8bf0fde92d6/3/96', '2017-10-06 15:53:32', '2017-10-06 16:01:33'),
(103, 4, '45f6b895cdeec53782a1e8bf0fde92d6', 'Hello, Purchase order 2017/10/06/0095 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/45f6b895cdeec53782a1e8bf0fde92d6/4/96', '2017-10-06 15:53:32', '2017-10-06 15:53:32'),
(104, 5, '45f6b895cdeec53782a1e8bf0fde92d6', 'Hello, Purchase order 2017/10/06/0095 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/45f6b895cdeec53782a1e8bf0fde92d6/5/96', '2017-10-06 15:53:32', '2017-10-06 15:53:32'),
(105, 1, '541112a2bded72ddb19cabb51dc3664e', 'Hello, Purchase order 2017/10/06/0096 needs to be reviewed!', 1, 'review purchase order', 'erppurchases/notifyshow/541112a2bded72ddb19cabb51dc3664e/1/97', '2017-10-06 16:06:29', '2017-10-06 16:06:53'),
(106, 2, '541112a2bded72ddb19cabb51dc3664e', 'Hello, Purchase order 2017/10/06/0096 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/541112a2bded72ddb19cabb51dc3664e/2/97', '2017-10-06 16:06:29', '2017-10-06 16:06:29'),
(107, 4, '541112a2bded72ddb19cabb51dc3664e', 'Hello, Purchase order 2017/10/06/0096 needs to be reviewed!', 0, 'review purchase order', 'erppurchases/notifyshow/541112a2bded72ddb19cabb51dc3664e/4/97', '2017-10-06 16:06:29', '2017-10-06 16:06:29'),
(108, 1, '26da71f7f503b170763e922f43e39cf0', 'Hello, Purchase order 2017/10/06/0096 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/26da71f7f503b170763e922f43e39cf0/1/97', '2017-10-06 16:06:56', '2017-10-09 13:09:50'),
(109, 2, '26da71f7f503b170763e922f43e39cf0', 'Hello, Purchase order 2017/10/06/0096 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/26da71f7f503b170763e922f43e39cf0/2/97', '2017-10-06 16:06:56', '2017-10-06 16:06:56'),
(110, 4, '26da71f7f503b170763e922f43e39cf0', 'Hello, Purchase order 2017/10/06/0096 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/26da71f7f503b170763e922f43e39cf0/4/97', '2017-10-06 16:06:56', '2017-10-06 16:06:56'),
(111, 1, '7b831bc84c6cb33bc6b1e52fc0c69a85', 'Hello, Purchase order 2017/10/06/0096 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/7b831bc84c6cb33bc6b1e52fc0c69a85/1/97', '2017-10-06 16:06:57', '2017-10-09 13:09:50'),
(112, 3, '7b831bc84c6cb33bc6b1e52fc0c69a85', 'Hello, Purchase order 2017/10/06/0096 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/7b831bc84c6cb33bc6b1e52fc0c69a85/3/97', '2017-10-06 16:06:57', '2017-10-10 08:39:46'),
(113, 4, '7b831bc84c6cb33bc6b1e52fc0c69a85', 'Hello, Purchase order 2017/10/06/0096 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/7b831bc84c6cb33bc6b1e52fc0c69a85/4/97', '2017-10-06 16:06:58', '2017-10-06 16:06:58'),
(114, 5, '7b831bc84c6cb33bc6b1e52fc0c69a85', 'Hello, Purchase order 2017/10/06/0096 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/7b831bc84c6cb33bc6b1e52fc0c69a85/5/97', '2017-10-06 16:06:58', '2017-10-06 16:06:58'),
(115, 1, 'daca356ba927b870ee6947e13ff83579', 'Hello, Purchase order 2017/10/09/0101 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/daca356ba927b870ee6947e13ff83579/1/102', '2017-10-09 11:04:37', '2017-10-09 13:09:50'),
(116, 2, 'daca356ba927b870ee6947e13ff83579', 'Hello, Purchase order 2017/10/09/0101 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/daca356ba927b870ee6947e13ff83579/2/102', '2017-10-09 11:04:37', '2017-10-09 11:04:37'),
(117, 4, 'daca356ba927b870ee6947e13ff83579', 'Hello, Purchase order 2017/10/09/0101 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/daca356ba927b870ee6947e13ff83579/4/102', '2017-10-09 11:04:38', '2017-10-09 11:04:38'),
(118, 1, 'b6b3e00e85181386cc0b1682463255b1', 'Hello, Purchase order 2017/10/09/0101 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/b6b3e00e85181386cc0b1682463255b1/1/102', '2017-10-09 11:04:39', '2017-10-09 13:09:50'),
(119, 3, 'b6b3e00e85181386cc0b1682463255b1', 'Hello, Purchase order 2017/10/09/0101 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/b6b3e00e85181386cc0b1682463255b1/3/102', '2017-10-09 11:04:39', '2017-10-10 08:39:46'),
(120, 4, 'b6b3e00e85181386cc0b1682463255b1', 'Hello, Purchase order 2017/10/09/0101 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/b6b3e00e85181386cc0b1682463255b1/4/102', '2017-10-09 11:04:39', '2017-10-09 11:04:39'),
(121, 5, 'b6b3e00e85181386cc0b1682463255b1', 'Hello, Purchase order 2017/10/09/0101 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/b6b3e00e85181386cc0b1682463255b1/5/102', '2017-10-09 11:04:39', '2017-10-09 11:04:39'),
(122, 1, '870344ae10bb88e0fe5141de74e2d5d8', 'Hello, Purchase order 2017/10/09/0104 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/870344ae10bb88e0fe5141de74e2d5d8/1/105', '2017-10-09 17:12:16', '2017-10-09 17:36:51'),
(123, 2, '870344ae10bb88e0fe5141de74e2d5d8', 'Hello, Purchase order 2017/10/09/0104 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/870344ae10bb88e0fe5141de74e2d5d8/2/105', '2017-10-09 17:12:16', '2017-10-09 17:12:16'),
(124, 4, '870344ae10bb88e0fe5141de74e2d5d8', 'Hello, Purchase order 2017/10/09/0104 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/870344ae10bb88e0fe5141de74e2d5d8/4/105', '2017-10-09 17:12:16', '2017-10-09 17:12:16'),
(125, 1, '53fc572b74577897df83b693ff731ced', 'Hello, Purchase order 2017/10/09/0104 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/53fc572b74577897df83b693ff731ced/1/105', '2017-10-09 17:12:18', '2017-10-09 17:36:51'),
(126, 3, '53fc572b74577897df83b693ff731ced', 'Hello, Purchase order 2017/10/09/0104 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/53fc572b74577897df83b693ff731ced/3/105', '2017-10-09 17:12:18', '2017-10-10 08:39:46'),
(127, 4, '53fc572b74577897df83b693ff731ced', 'Hello, Purchase order 2017/10/09/0104 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/53fc572b74577897df83b693ff731ced/4/105', '2017-10-09 17:12:18', '2017-10-09 17:12:18'),
(128, 5, '53fc572b74577897df83b693ff731ced', 'Hello, Purchase order 2017/10/09/0104 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/53fc572b74577897df83b693ff731ced/5/105', '2017-10-09 17:12:18', '2017-10-09 17:12:18'),
(129, 1, 'b9e317ac2c9fa918a9a9105af158984d', 'Hello, Please approve expense Bread', 1, 'expense', 'notificationshowexpense/Bread/Expenditure/150/2017-10-10/8/3/1/b9e317ac2c9fa918a9a9105af158984d', '2017-10-10 08:57:10', '2017-10-10 09:09:03'),
(130, 1, '6950ec7b2c82fe4d278a25c7cb62a3dd', 'Hello, Purchase order 2017/10/10/0106 needs to be authorized!', 1, 'authorize purchase order', 'erppurchases/notifyshow/6950ec7b2c82fe4d278a25c7cb62a3dd/1/107', '2017-10-10 17:15:12', '2017-10-10 17:15:41'),
(131, 2, '6950ec7b2c82fe4d278a25c7cb62a3dd', 'Hello, Purchase order 2017/10/10/0106 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/6950ec7b2c82fe4d278a25c7cb62a3dd/2/107', '2017-10-10 17:15:12', '2017-10-10 17:15:12'),
(132, 4, '6950ec7b2c82fe4d278a25c7cb62a3dd', 'Hello, Purchase order 2017/10/10/0106 needs to be authorized!', 0, 'authorize purchase order', 'erppurchases/notifyshow/6950ec7b2c82fe4d278a25c7cb62a3dd/4/107', '2017-10-10 17:15:12', '2017-10-10 17:15:12'),
(133, 1, '9bbc4959a202b390a847883a2cc8abbf', 'Hello, Purchase order 2017/10/10/0106 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/9bbc4959a202b390a847883a2cc8abbf/1/107', '2017-10-10 17:15:16', '2017-10-10 17:15:42'),
(134, 3, '9bbc4959a202b390a847883a2cc8abbf', 'Hello, Purchase order 2017/10/10/0106 has successfully been authorized!', 1, 'view purchase order', 'erppurchases/notifyshow/9bbc4959a202b390a847883a2cc8abbf/3/107', '2017-10-10 17:15:16', '2017-10-10 17:19:23'),
(135, 4, '9bbc4959a202b390a847883a2cc8abbf', 'Hello, Purchase order 2017/10/10/0106 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/9bbc4959a202b390a847883a2cc8abbf/4/107', '2017-10-10 17:15:16', '2017-10-10 17:15:16'),
(136, 5, '9bbc4959a202b390a847883a2cc8abbf', 'Hello, Purchase order 2017/10/10/0106 has successfully been authorized!', 0, 'view purchase order', 'erppurchases/notifyshow/9bbc4959a202b390a847883a2cc8abbf/5/107', '2017-10-10 17:15:16', '2017-10-10 17:15:16'),
(137, 1, 'f405394ce302aa57887933060eb8a719', 'Hello, Approval to receive stock is required', 1, 'stock', 'notificationshowstock/12/Glevak Investment Ltd/107/1/f405394ce302aa57887933060eb8a719', '2017-10-10 17:19:14', '2017-10-10 17:19:48'),
(138, 2, 'f405394ce302aa57887933060eb8a719', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/12/Glevak Investment Ltd/107/2/f405394ce302aa57887933060eb8a719', '2017-10-10 17:19:14', '2017-10-10 17:19:14'),
(139, 4, 'f405394ce302aa57887933060eb8a719', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/12/Glevak Investment Ltd/107/4/f405394ce302aa57887933060eb8a719', '2017-10-10 17:19:14', '2017-10-10 17:19:14'),
(140, 1, '8db857f1acd7ebb459c42bf055053c98', 'Hello, Approval to receive stock is required', 1, 'stock', 'notificationshowstock/13/Glevak Investment Ltd/107/1/8db857f1acd7ebb459c42bf055053c98', '2017-10-10 17:20:34', '2017-10-10 17:21:01'),
(141, 2, '8db857f1acd7ebb459c42bf055053c98', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/13/Glevak Investment Ltd/107/2/8db857f1acd7ebb459c42bf055053c98', '2017-10-10 17:20:34', '2017-10-10 17:20:34'),
(142, 4, '8db857f1acd7ebb459c42bf055053c98', 'Hello, Approval to receive stock is required', 0, 'stock', 'notificationshowstock/13/Glevak Investment Ltd/107/4/8db857f1acd7ebb459c42bf055053c98', '2017-10-10 17:20:34', '2017-10-10 17:20:34');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `item_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `qty` int(10) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `type` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`item_id`, `order_id`, `qty`, `created_at`, `updated_at`, `type`) VALUES
('1', '11002', 1, '2017-06-07 19:45:53', '2017-06-07 19:45:53', 2),
('1', '11006', 1, '2017-06-09 04:54:44', '2017-06-09 04:54:44', 0),
('1', '11007', 1, '2017-06-09 06:10:50', '2017-06-09 06:10:50', 0),
('1', '11008', 1, '2017-06-09 08:31:46', '2017-06-09 08:31:46', 0),
('1', '11009', 1, '2017-06-09 08:32:34', '2017-06-09 08:32:34', 0),
('1', '11010', 1, '2017-06-09 14:53:15', '2017-06-09 14:53:15', 0),
('1', '11012', 1, '2017-06-11 14:40:08', '2017-06-11 14:40:08', 0),
('1', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 1, '2017-06-06 15:42:25', '2017-06-06 15:42:25', 0),
('1', '88659ab1-25d7-420d-8c3a-0f73330fc15d', 1, '2017-06-05 08:23:51', '2017-06-05 08:23:51', 0),
('1', '9b391040-3a79-4f4e-86ef-e08cc2dcb4d5', 1, '2017-06-07 08:03:28', '2017-06-07 08:03:28', 2),
('1', 'c48e7903-71b0-4586-892a-3d2e02a1b38a', 1, '2017-06-05 06:24:35', '2017-06-05 06:24:35', 0),
('1', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 0),
('1', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 2),
('10', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 1, '2017-06-06 15:42:25', '2017-06-06 15:42:25', 0),
('10', 'd112fbed-3131-4bcd-9bf6-01a667353a02', 1, '2017-06-06 13:48:50', '2017-06-06 13:48:50', 0),
('10099', '11002', 1, '2017-06-07 19:45:53', '2017-06-07 19:45:53', 1),
('10099', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 1),
('10100', '9b391040-3a79-4f4e-86ef-e08cc2dcb4d5', 1, '2017-06-07 08:03:28', '2017-06-07 08:03:28', 1),
('10100', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 1),
('10101', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 1),
('10102', '11013', 1, '2017-06-13 11:50:23', '2017-06-13 11:50:23', 1),
('10102', 'f1787f5d-5aab-454c-816f-1d4c830a7a97', 1, '2017-06-06 11:35:14', '2017-06-06 11:35:14', 1),
('10102', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 1),
('10103', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 1),
('11', '11011', 1, '2017-06-09 18:47:00', '2017-06-09 18:47:00', 0),
('11', '11016', 1, '2017-06-13 17:54:23', '2017-06-13 17:54:23', 0),
('13', '11005', 1, '2017-06-08 17:12:28', '2017-06-08 17:12:28', 0),
('13', '29f0d7bf-93a2-4e01-8473-a1965c916933', 1, '2017-06-06 14:53:36', '2017-06-06 14:53:36', 0),
('13', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 1, '2017-06-06 15:42:25', '2017-06-06 15:42:25', 0),
('15', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 0),
('16', '11020', 1, '2017-06-13 18:08:16', '2017-06-13 18:08:16', 0),
('2', '11003', 1, '2017-06-08 10:29:07', '2017-06-08 10:29:07', 0),
('2', '11010', 1, '2017-06-09 14:53:15', '2017-06-09 14:53:15', 0),
('2', '11014', 1, '2017-06-13 16:46:36', '2017-06-13 16:46:36', 0),
('2', '11022', 1, '2017-06-13 19:23:52', '2017-06-13 19:23:52', 0),
('2', '11023', 1, '2017-06-13 20:17:11', '2017-06-13 20:17:11', 0),
('2', '11025', 1, '2017-06-16 05:30:46', '2017-06-16 05:30:46', 0),
('2', '11035', 1, '2017-07-09 05:45:12', '2017-07-09 05:45:12', 0),
('2', 'a940d12a-023e-46a8-8c47-283c4b576de3', 1, '2017-06-03 04:42:45', '2017-06-03 04:42:45', 0),
('2', 'fa528d4d-bf56-40fd-8eb5-6b8142c6d911', 1, '2017-06-06 14:54:28', '2017-06-06 14:54:28', 0),
('3', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 0),
('4', '11001', 1, '2017-06-07 19:39:07', '2017-06-07 19:39:07', 0),
('4', '11015', 1, '2017-06-13 17:36:39', '2017-06-13 17:36:39', 0),
('4', '11018', 1, '2017-06-13 18:00:31', '2017-06-13 18:00:31', 0),
('4', '11021', 1, '2017-06-13 18:09:54', '2017-06-13 18:09:54', 0),
('4', '11024', 1, '2017-06-14 18:44:51', '2017-06-14 18:44:51', 0),
('4', '11027', 1, '2017-06-28 14:27:57', '2017-06-28 14:27:57', 0),
('4', '11028', 1, '2017-06-30 07:57:39', '2017-06-30 07:57:39', 0),
('4', '11030', 1, '2017-06-30 08:03:30', '2017-06-30 08:03:30', 0),
('4', '11031', 1, '2017-06-30 08:07:15', '2017-06-30 08:07:15', 0),
('4', '11034', 1, '2017-07-07 17:48:54', '2017-07-07 17:48:54', 0),
('4', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 1, '2017-06-06 15:42:25', '2017-06-06 15:42:25', 0),
('4', '88659ab1-25d7-420d-8c3a-0f73330fc15d', 1, '2017-06-05 08:23:51', '2017-06-05 08:23:51', 0),
('4', 'f1787f5d-5aab-454c-816f-1d4c830a7a97', 1, '2017-06-06 11:35:14', '2017-06-06 11:35:14', 0),
('5', '11014', 1, '2017-06-13 16:46:36', '2017-06-13 16:46:36', 0),
('5', '11017', 1, '2017-06-13 17:57:42', '2017-06-13 17:57:42', 0),
('5', '11023', 1, '2017-06-13 20:17:11', '2017-06-13 20:17:11', 0),
('5', '11026', 1, '2017-06-19 11:20:26', '2017-06-19 11:20:26', 0),
('5', '11033', 1, '2017-07-02 05:08:20', '2017-07-02 05:08:20', 0),
('5', '580db8d7-4a1d-49c6-8cad-4d05fc502d73', 1, '2017-06-06 15:41:24', '2017-06-06 15:41:24', 0),
('5', 'fa528d4d-bf56-40fd-8eb5-6b8142c6d911', 1, '2017-06-06 14:54:28', '2017-06-06 14:54:28', 0),
('6', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 0),
('7', '11021', 1, '2017-06-13 18:09:54', '2017-06-13 18:09:54', 0),
('7', '11032', 1, '2017-06-30 08:11:30', '2017-06-30 08:11:30', 0),
('7', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 1, '2017-06-06 15:42:25', '2017-06-06 15:42:25', 0),
('7', 'aa14a46b-62d3-4381-8d65-1c0ed01d0499', 2, '2017-06-05 06:15:11', '2017-06-05 06:15:11', 0),
('7', 'd112fbed-3131-4bcd-9bf6-01a667353a02', 1, '2017-06-06 13:48:50', '2017-06-06 13:48:50', 0),
('7', 'f1787f5d-5aab-454c-816f-1d4c830a7a97', 1, '2017-06-06 11:35:14', '2017-06-06 11:35:14', 0),
('8', '11019', 1, '2017-06-13 18:02:35', '2017-06-13 18:02:35', 0),
('8', '11023', 1, '2017-06-13 20:17:11', '2017-06-13 20:17:11', 0),
('8', '11029', 1, '2017-06-30 08:03:27', '2017-06-30 08:03:27', 0),
('9', '11004', 1, '2017-06-08 13:16:48', '2017-06-08 13:16:48', 0),
('9', 'ffad9b72-7423-4588-ac0c-80329777044c', 1, '2017-06-03 22:19:54', '2017-06-03 22:19:54', 0),
('d55bb04c-577f-43be-bfd1-7ea61d42ad5f', 'd55bb04c-577f-43be-bfd1-7ea61d42ad5f', 5, '2017-06-06 11:44:23', '2017-06-06 11:44:23', 3);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'XARA CBS',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kra_pin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nssf_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nhif_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `bank_branch_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `bank_account_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `swift_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `license_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'evaluation',
  `license_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `license_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licensed` bigint(20) DEFAULT '100',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `logo`, `email`, `website`, `address`, `phone`, `kra_pin`, `nssf_no`, `nhif_no`, `bank_id`, `bank_branch_id`, `bank_account_number`, `swift_code`, `license_type`, `license_code`, `license_key`, `licensed`, `created_at`, `updated_at`) VALUES
(1, 'Gas Express', 'NPZqjvuiOUiX.png', 'info@gx.co.ke', 'www.gx.co.ke', '', '0717890470', '', '', '', 0, 0, '', '', 'evaluation', NULL, NULL, 100, '2016-06-22 07:30:26', '2017-09-18 13:59:15');

-- --------------------------------------------------------

--
-- Table structure for table `password_reminders`
--

CREATE TABLE `password_reminders` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `paymentmethods`
--

CREATE TABLE `paymentmethods` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `paymentmethods`
--

INSERT INTO `paymentmethods` (`id`, `name`, `account_id`, `created_at`, `updated_at`) VALUES
(1, 'Cash', 1, '2016-06-22 08:21:10', '2016-06-22 08:21:10'),
(2, 'Mpesa', 2, '2016-06-22 08:21:20', '2016-06-22 08:21:20'),
(3, 'Cheque', 3, '2016-06-22 08:21:40', '2016-06-22 08:21:40');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `erporder_id` int(10) UNSIGNED NOT NULL,
  `payment_date` date DEFAULT NULL,
  `date` date NOT NULL,
  `balance` float(15,2) DEFAULT NULL,
  `amount_paid` double NOT NULL DEFAULT '0',
  `prepared_by` int(11) DEFAULT NULL,
  `paymentmethod_id` int(10) UNSIGNED NOT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_approved` int(11) DEFAULT NULL,
  `is_rejected` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `client_id`, `account_id`, `erporder_id`, `payment_date`, `date`, `balance`, `amount_paid`, `prepared_by`, `paymentmethod_id`, `confirmed_id`, `confirmation_code`, `is_approved`, `is_rejected`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 78, '2017-10-04', '0000-00-00', NULL, 3000, 0, 0, NULL, '0', NULL, NULL, '2017-10-04 14:16:54', '2017-10-04 14:38:13'),
(2, 1, 1, 78, '2017-10-04', '0000-00-00', NULL, 3000, 0, 0, NULL, '0', NULL, NULL, '2017-10-04 14:42:20', '2017-10-04 14:42:42'),
(3, 6, 1, 7, '2017-10-04', '0000-00-00', NULL, 500, 0, 0, NULL, '0', NULL, NULL, '2017-10-04 15:36:00', '2017-10-04 15:38:37'),
(4, 6, 1, 7, '2017-10-04', '0000-00-00', NULL, 200, 0, 1, NULL, '0', NULL, NULL, '2017-10-04 15:39:08', '2017-10-04 15:39:08'),
(5, 6, 1, 94, '2017-10-05', '0000-00-00', NULL, 500, 0, 0, NULL, '0', NULL, NULL, '2017-10-05 06:47:09', '2017-10-05 06:47:40'),
(6, 1, 1, 78, '2017-10-05', '0000-00-00', NULL, 444000, 0, 1, NULL, '0', NULL, NULL, '2017-10-05 08:04:35', '2017-10-05 08:04:35'),
(7, 6, 1, 94, '2017-10-05', '0000-00-00', NULL, 2000, 0, 1, NULL, '0', NULL, NULL, '2017-10-05 08:05:32', '2017-10-05 08:05:32'),
(11, 1, 1, 79, '2017-10-05', '0000-00-00', NULL, 1000, 3, 1, 1, 'f489190da8badfa569695618db4486e7', 1, NULL, '2017-10-05 14:50:14', '2017-10-05 15:11:18'),
(12, 1, 1, 79, '2017-10-05', '0000-00-00', NULL, 2000, 1, 1, 1, NULL, 1, NULL, '2017-10-05 15:11:53', '2017-10-05 15:11:54'),
(13, 336, 1, 88, '2017-10-05', '0000-00-00', NULL, 20000, 3, 1, 1, '20f24cade4509d85ce38090e2ea51342', 1, NULL, '2017-10-05 15:16:09', '2017-10-05 15:19:41'),
(14, 6, 8, 7, '2017-10-05', '0000-00-00', NULL, 10000, 1, 1, 1, NULL, 1, NULL, '2017-10-05 15:20:24', '2017-10-05 15:20:26'),
(15, 6, 1, 80, '2017-10-05', '0000-00-00', NULL, 590, 3, 1, 1, 'ebdd4ff35af27821449f502548a0d530', 1, NULL, '2017-10-05 15:22:09', '2017-10-05 15:22:28'),
(16, 6, 1, 85, '2017-10-09', '0000-00-00', NULL, 110000, 1, 1, 1, NULL, 1, NULL, '2017-10-09 19:10:55', '2017-10-09 19:10:55'),
(17, 1, 1, 79, '2017-10-10', '0000-00-00', NULL, 11000, 1, 1, 1, NULL, 1, NULL, '2017-10-10 07:23:52', '2017-10-10 07:23:52'),
(18, 336, 8, 36, '2017-10-10', '0000-00-00', NULL, 307800, 1, 1, 1, NULL, 1, NULL, '2017-10-10 07:24:14', '2017-10-10 07:24:14'),
(19, 1, 1, 79, '2017-10-11', '0000-00-00', NULL, 4000, 1, 1, 1, NULL, 1, NULL, '2017-10-11 15:45:11', '2017-10-11 15:45:11'),
(20, 1, 1, 81, '2017-10-11', '0000-00-00', NULL, 2000, 1, 1, 1, NULL, 1, NULL, '2017-10-11 15:48:10', '2017-10-11 15:48:10'),
(21, 1, 1, 81, '2017-10-12', '0000-00-00', NULL, 2000, 1, 1, 1, NULL, 1, NULL, '2017-10-12 07:13:37', '2017-10-12 07:13:38');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `category`, `created_at`, `updated_at`) VALUES
(1, 'create_employee', 'Create employee', 'Employee', '2016-06-22 07:30:26', '2016-06-22 07:30:26'),
(2, 'update_employee', 'Update employee', 'Employee', '2016-06-22 07:30:26', '2016-06-22 07:30:26'),
(3, 'delete_employee', 'Deactivate employee', 'Employee', '2016-06-22 07:30:26', '2016-06-22 07:30:26'),
(4, 'view_employee', 'View employee', 'Employee', '2016-06-22 07:30:26', '2016-06-22 07:30:26'),
(5, 'manage_earning', 'Manage earnings', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(6, 'manage_deduction', 'Manage deductions', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(7, 'manage_allowance', 'Manage allowance', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(8, 'manage_relief', 'Manage releif', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(9, 'manage_benefit', 'Manage benefits', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(10, 'process_payroll', 'Process payroll', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(11, 'view_payroll_report', 'View reports', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(12, 'manage_settings', 'Manage settings', 'Payroll', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(13, 'view_application', 'View applications', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(14, 'amend_application', 'Amend applications', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(15, 'approve_application', 'Approve applications', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(16, 'reject_application', 'Reject applications', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(17, 'cancel_application', 'Cancel applications', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(18, 'manage_type', 'Manage leave types', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(19, 'manage_holiday', 'Manage holidays', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(20, 'view_leave_report', 'View reports', 'Leave', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(21, 'manage_organization', 'manage organization', 'Organization', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(22, 'manage_branch', 'manage branches', 'Organization', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(23, 'manage_group', 'manage groups', 'Organization', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(24, 'manage_organization_settings', 'manage settings', 'Organization', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(25, 'manage_user', 'manage users', 'System', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(26, 'manage_role', 'manage roles', 'System', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(27, 'manage_audit', 'manage audits', 'System', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(29, 'confirm_payments', 'confirm payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(30, 'confirm_stock', 'confirm stock', 'Stock', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(31, 'authorize_purchase_order', 'authorize purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(32, 'review_purchase_order', 'review purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(33, 'create_item', 'create item', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(34, 'update_item', 'update item', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(35, 'view_item', 'view item', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(36, 'delete_item', 'delete item', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(37, 'create_client', 'create client', 'Clients\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(38, 'update_client', 'update client', 'Clients\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(39, 'delete_client', 'delete client', 'Clients\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(40, 'view_client', 'view client', 'Clients\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(41, 'create_payments', 'create payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(42, 'update_payments', 'update payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(43, 'delete_payments', 'delete payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(44, 'view_daily_payments', 'view daily payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(45, 'create_payment_methods', 'create payment methods', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(46, 'update_payment_methods', 'update payment methods', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(47, 'delete_payment_methods', 'delete payment methods', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(48, 'create_purchase_order', 'create purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(49, 'view_purchase_order', 'view purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(50, 'cancel_purchase_order', 'cancel purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(51, 'create_sale_order', 'create sale order', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(52, 'view_sale_order', 'view sale order', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(53, 'cancel_sale_order', 'cancel sale order', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(54, 'approve_delivered_sale_order', 'approve delivered sale order', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(55, 'approve_delivered_purchase_order', 'approve delivered purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(56, 'create_sale_target', 'create sale target', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(57, 'update_sale_target', 'update sale target', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(58, 'delete_sale_target', 'delete sale target', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(59, 'create_quotation', 'create quotation', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(60, 'view_quotation', 'view quotation', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(61, 'approve_quotation', 'approve quotation', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(62, 'reject_quotation', 'reject quotation', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(63, 'edit_quotation', 'edit quotation', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(64, 'receive_stock', 'receive stock', 'Stock', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(65, 'track_stock', 'track stock', 'Stock', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(66, 'lease_item', 'lease item', 'Stock', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(67, 'create_store', 'create store', 'Store', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(68, 'update_store', 'update store', 'Store', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(69, 'delete_store', 'delete store', 'Store', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(70, 'create_tax', 'create tax', 'Tax', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(71, 'update_tax', 'update tax', 'Tax', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(72, 'delete_tax', 'delete tax', 'Tax', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(73, 'view_erp_reports', 'view erp reports', 'Erp Reports', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(74, 'create_driver', 'create driver', 'Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(75, 'update_driver', 'update driver', 'Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(76, 'view_driver', 'view driver', 'Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(77, 'delete_driver', 'delete driver', 'Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(78, 'create_vehicle', 'create vehicle', 'Vehicle', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(79, 'update_vehicle', 'update vehicle', 'Vehicle', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(80, 'view_vehicle', 'view vehicle', 'Vehicle', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(81, 'delete_vehicle', 'delete vehicle', 'Vehicle', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(82, 'assign_driver', 'assign driver', 'Assign Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(83, 'update_assigned_driver', 'update assigned driver', 'Assign Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(84, 'view_assigned_driver', 'view assigned driver', 'Assign Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(85, 'remove_assigned_driver', 'remove assigned driver', 'Assign Driver', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(86, 'view_store', 'view store', 'Store', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(87, 'view_tax', 'view tax', 'Tax', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(88, 'create_pricing', 'create pricing', 'Pricing', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(89, 'update_pricing', 'update pricing', 'Pricing', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(90, 'view_pricing', 'view pricing', 'Pricing', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(91, 'delete_pricing', 'delete pricing', 'Pricing', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(92, 'view_stock', 'view stock', 'Stock', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(93, 'view_sale_target', 'view sale target', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(94, 'view_payment_methods', 'view payment methods', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(95, 'view_payments', 'view payments', 'Payments', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(96, 'generate_invoice', 'generate invoice', 'Quotation', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(98, 'confirm_update_item', 'confirm update item', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(99, 'view_account', 'view account', 'Accounts', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(100, 'create_account', 'create account', 'Accounts', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(101, 'update_account', 'update account', 'Accounts', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(102, 'delete_account', 'delete account', 'Accounts', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(103, 'confirm_item_update', 'confirm item update', 'Items\r\n', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(104, 'confirm_pricing_update', 'confirm pricing update', 'Pricing', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(105, 'view_expense', 'view expense', 'Expenses', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(106, 'create_expense', 'create expense', 'Expenses', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(107, 'update_expense', 'update expense', 'Expenses', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(108, 'delete_expense', 'delete expense', 'Expenses', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(109, 'view_petty_cash', 'view petty cash', 'Petty Cash', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(116, 'create_new_transaction', 'create new transaction', 'Petty Cash', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(119, 'view_expense_claim', 'view expense claim', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(120, 'update_expense_claim', 'update expense claim', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(121, 'create_new_receipt', 'create new receipt', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(122, 'approve_expense_claim', 'approve expense claim', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(123, 'decline_expense_claim', 'decline expense claim', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(124, 'pay_expense_claim', 'pay expense claim', 'Expense Claim', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(125, 'view_asset_management', 'view asset management', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(126, 'create_asset_management', 'create asset management', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(127, 'update_asset_management', 'update asset management', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(128, 'depreciation', 'depreciation', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(129, 'dispose_asset', 'dispose_asset', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(130, 'delete_asset', 'delete_asset', 'Asset Management', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(131, 'transfer_money', 'transfer money', 'Petty Cash', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(132, 'receive_money', 'receive money', 'Petty Cash', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(133, 'email_purchase_order', 'email purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(134, 'approve_cancel_purchase_order', 'approve cancel purchase order', 'Purchase', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(135, 'create_users', 'create users', 'Users', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(136, 'view_users', 'view users', 'Users', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(137, 'update_users', 'update users', 'Users', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(138, 'delete_users', 'delete users', 'Users', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(140, 'approve_cancel_sale_order', 'approve cancel sale order', 'Sales', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(141, 'approve_expense', 'approve expense', 'Expenses', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(142, 'approve_petty_cash', 'approve petty cash', 'Petty Cash', '2016-06-22 07:30:27', '2016-06-22 07:30:27');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1),
(19, 19, 1),
(20, 20, 1),
(21, 21, 1),
(22, 22, 1),
(23, 23, 1),
(24, 24, 1),
(25, 25, 1),
(26, 26, 1),
(27, 27, 1),
(28, 1, 2),
(29, 2, 2),
(30, 3, 2),
(31, 4, 2),
(32, 5, 2),
(33, 6, 2),
(34, 7, 2),
(35, 8, 2),
(36, 9, 2),
(37, 10, 2),
(38, 11, 2),
(39, 12, 2),
(40, 13, 2),
(41, 14, 2),
(42, 15, 2),
(43, 16, 2),
(44, 17, 2),
(45, 18, 2),
(46, 19, 2),
(47, 20, 2),
(48, 21, 2),
(49, 22, 2),
(50, 23, 2),
(51, 24, 2),
(52, 25, 2),
(53, 26, 2),
(54, 27, 2),
(56, 29, 2),
(57, 30, 2),
(58, 31, 2),
(59, 32, 2),
(60, 32, 1),
(61, 35, 1),
(62, 29, 1),
(63, 41, 1),
(64, 42, 1),
(65, 43, 1),
(66, 44, 1),
(67, 45, 1),
(68, 46, 1),
(69, 47, 1),
(70, 94, 1),
(71, 95, 1),
(72, 30, 1),
(73, 64, 1),
(74, 65, 1),
(75, 66, 1),
(76, 92, 1),
(77, 31, 1),
(78, 48, 1),
(79, 49, 1),
(80, 50, 1),
(81, 55, 1),
(82, 33, 1),
(83, 34, 1),
(84, 36, 1),
(85, 37, 1),
(86, 38, 1),
(87, 39, 1),
(88, 40, 1),
(89, 51, 1),
(90, 52, 1),
(91, 53, 1),
(92, 54, 1),
(93, 56, 1),
(94, 57, 1),
(95, 58, 1),
(96, 93, 1),
(97, 59, 1),
(98, 60, 1),
(99, 61, 1),
(100, 62, 1),
(101, 63, 1),
(102, 96, 1),
(103, 67, 1),
(104, 68, 1),
(105, 69, 1),
(106, 86, 1),
(107, 70, 1),
(108, 71, 1),
(109, 72, 1),
(110, 87, 1),
(111, 73, 1),
(112, 74, 1),
(113, 75, 1),
(114, 76, 1),
(115, 77, 1),
(116, 78, 1),
(117, 79, 1),
(118, 80, 1),
(119, 81, 1),
(120, 82, 1),
(121, 83, 1),
(122, 84, 1),
(123, 85, 1),
(124, 88, 1),
(125, 89, 1),
(126, 90, 1),
(127, 91, 1),
(128, 41, 3),
(129, 44, 3),
(130, 45, 3),
(131, 46, 3),
(132, 94, 3),
(133, 95, 3),
(134, 64, 3),
(135, 65, 3),
(136, 66, 3),
(137, 92, 3),
(138, 48, 3),
(139, 49, 3),
(140, 33, 3),
(141, 35, 3),
(142, 37, 3),
(143, 38, 3),
(144, 40, 3),
(145, 51, 3),
(146, 52, 3),
(147, 56, 3),
(148, 93, 3),
(149, 59, 3),
(150, 60, 3),
(151, 67, 3),
(152, 68, 3),
(153, 86, 3),
(154, 70, 3),
(155, 71, 3),
(156, 74, 3),
(157, 75, 3),
(158, 76, 3),
(159, 78, 3),
(160, 79, 3),
(161, 80, 3),
(162, 82, 3),
(163, 84, 3),
(164, 88, 3),
(165, 90, 3),
(166, 21, 4),
(167, 22, 4),
(168, 23, 4),
(169, 24, 4),
(170, 25, 4),
(171, 26, 4),
(172, 27, 4),
(173, 29, 4),
(174, 41, 4),
(175, 42, 4),
(176, 43, 4),
(177, 44, 4),
(178, 45, 4),
(179, 46, 4),
(180, 47, 4),
(181, 94, 4),
(182, 95, 4),
(183, 30, 4),
(184, 64, 4),
(185, 65, 4),
(186, 66, 4),
(187, 92, 4),
(188, 31, 4),
(189, 32, 4),
(190, 48, 4),
(191, 49, 4),
(192, 50, 4),
(193, 55, 4),
(194, 33, 4),
(195, 34, 4),
(196, 35, 4),
(197, 36, 4),
(198, 37, 4),
(199, 38, 4),
(200, 39, 4),
(201, 40, 4),
(202, 51, 4),
(203, 52, 4),
(204, 53, 4),
(205, 54, 4),
(206, 56, 4),
(207, 57, 4),
(208, 58, 4),
(209, 93, 4),
(210, 59, 4),
(211, 60, 4),
(212, 61, 4),
(213, 62, 4),
(214, 63, 4),
(215, 96, 4),
(216, 67, 4),
(217, 68, 4),
(218, 69, 4),
(219, 86, 4),
(220, 70, 4),
(221, 71, 4),
(222, 72, 4),
(223, 87, 4),
(224, 73, 4),
(225, 74, 4),
(226, 75, 4),
(227, 76, 4),
(228, 77, 4),
(229, 78, 4),
(230, 79, 4),
(231, 80, 4),
(232, 81, 4),
(233, 82, 4),
(234, 83, 4),
(235, 84, 4),
(236, 85, 4),
(237, 88, 4),
(238, 89, 4),
(239, 90, 4),
(240, 91, 4),
(241, 98, 4),
(242, 98, 1),
(243, 34, 3),
(244, 99, 1),
(245, 100, 1),
(246, 101, 1),
(247, 102, 1),
(248, 103, 1),
(249, 104, 1),
(250, 89, 3),
(251, 105, 1),
(252, 106, 1),
(253, 107, 1),
(254, 108, 1),
(255, 109, 1),
(262, 119, 1),
(263, 120, 1),
(264, 121, 1),
(265, 122, 1),
(266, 123, 1),
(267, 124, 1),
(268, 125, 1),
(269, 126, 1),
(270, 127, 1),
(271, 116, 1),
(272, 131, 1),
(273, 132, 1),
(274, 135, 1),
(275, 136, 1),
(276, 137, 1),
(277, 138, 1),
(278, 134, 1),
(279, 140, 1),
(280, 50, 3),
(281, 53, 3),
(282, 141, 1),
(283, 142, 1),
(284, 99, 3),
(285, 105, 3),
(286, 106, 3),
(287, 107, 3),
(288, 108, 3),
(289, 109, 3),
(290, 116, 3),
(293, 119, 3),
(294, 120, 3),
(295, 121, 3);

-- --------------------------------------------------------

--
-- Table structure for table `pettycash_items`
--

CREATE TABLE `pettycash_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `ac_trns` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unit_price` float(8,2) NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pettycash_items`
--

INSERT INTO `pettycash_items` (`id`, `ac_trns`, `item_name`, `description`, `quantity`, `unit_price`, `receiver_id`, `confirmation_code`, `confirmed_id`, `created_at`, `updated_at`) VALUES
(1, 51, 'kifgdh', '', '3', 3400.00, NULL, NULL, NULL, '2017-09-29 10:34:11', '2017-09-29 10:34:11'),
(2, 13, 'Bread', 'bread', '1', 150.00, NULL, NULL, NULL, '2017-10-10 15:21:21', '2017-10-10 15:21:21');

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE `prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `Item_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Discount` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) NOT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_approved` int(11) DEFAULT NULL,
  `is_rejected` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `client_id`, `date`, `Item_id`, `Discount`, `confirmed_id`, `receiver_id`, `confirmation_code`, `is_approved`, `is_rejected`, `created_at`, `updated_at`) VALUES
(1, '19', '2017-09-29', '2', '500', 1, 3, '862d32133b9de688195e4c3e22208706', NULL, NULL, '2017-09-01 14:16:20', '2017-09-29 08:16:38'),
(2, '19', '2017-09-01', '3', '600', 0, 0, NULL, NULL, NULL, '2017-09-01 14:20:23', '2017-09-01 14:54:14'),
(3, '323', '2017-09-01', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-01 15:05:26', '2017-09-01 15:05:26'),
(4, '323', '2017-09-01', '2', '900', 0, 0, NULL, NULL, NULL, '2017-09-01 15:06:21', '2017-09-01 15:06:21'),
(5, '333', '2017-09-01', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-01 15:13:48', '2017-09-01 15:13:48'),
(6, '334', '2017-09-01', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-01 15:25:45', '2017-09-01 15:25:45'),
(7, '335', '2017-09-01', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-01 16:32:49', '2017-09-01 16:32:49'),
(8, '335', '2017-09-01', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-01 17:24:03', '2017-09-01 17:24:03'),
(9, '335', '2017-09-01', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-01 17:25:42', '2017-09-01 17:25:42'),
(10, '337', '2017-09-02', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-02 15:52:51', '2017-09-02 15:57:01'),
(11, '337', '2017-09-02', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-02 15:56:39', '2017-09-02 15:56:39'),
(12, '335', '2017-09-02', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-02 16:05:46', '2017-09-02 16:05:46'),
(13, '335', '2017-09-02', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-02 16:07:01', '2017-09-02 16:07:01'),
(14, '335', '2017-09-02', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-02 16:07:46', '2017-09-02 16:07:46'),
(15, '338', '2017-09-02', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-02 16:28:32', '2017-09-02 16:28:32'),
(16, '339', '2017-09-02', '1', '1800', 0, 0, NULL, NULL, NULL, '2017-09-02 16:32:52', '2017-09-02 16:32:52'),
(17, '340', '2017-09-02', '2', '900', 0, 0, NULL, NULL, NULL, '2017-09-02 16:44:23', '2017-09-02 16:44:23'),
(18, '341', '2017-09-02', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-02 16:54:31', '2017-09-02 16:54:31'),
(19, '342', '2017-09-02', '2', '400', 0, 0, NULL, NULL, NULL, '2017-09-02 16:59:16', '2017-09-02 16:59:16'),
(20, '343', '2017-09-02', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-02 17:09:51', '2017-09-02 17:09:51'),
(21, '344', '2017-09-02', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-02 17:25:23', '2017-09-02 17:25:23'),
(22, '344', '2017-09-02', '2', '900', 0, 0, NULL, NULL, NULL, '2017-09-02 17:28:33', '2017-09-02 17:28:33'),
(23, '335', '2017-09-03', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-03 04:35:34', '2017-09-03 04:35:34'),
(24, '345', '2017-09-03', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-03 09:12:18', '2017-09-03 09:12:18'),
(25, '346', '2017-09-03', '3', '0', 0, 0, NULL, NULL, NULL, '2017-09-03 12:32:49', '2017-09-03 12:32:49'),
(26, '347', '2017-09-04', '2', '', 0, 0, NULL, NULL, NULL, '2017-09-03 21:24:52', '2017-09-03 21:24:52'),
(27, '268', '2017-09-04', '1', '1700', 0, 0, NULL, NULL, NULL, '2017-09-04 14:36:34', '2017-09-04 14:36:34'),
(28, '268', '2017-09-04', '2', '802', 0, 0, NULL, NULL, NULL, '2017-09-04 14:37:30', '2017-09-04 14:37:30'),
(29, '349', '2017-09-04', '2', '500', 0, 0, NULL, NULL, NULL, '2017-09-04 15:54:25', '2017-09-04 15:54:25'),
(30, '351', '2017-09-05', '1', '1200', 0, 0, NULL, NULL, NULL, '2017-09-05 05:03:23', '2017-09-05 05:03:23'),
(31, '121', '2017-09-11', '2', '700', 0, 0, NULL, NULL, NULL, '2017-09-05 13:03:16', '2017-09-11 09:40:30'),
(32, '349', '2017-09-05', '1', '1800', 0, 0, NULL, NULL, NULL, '2017-09-05 13:10:33', '2017-09-05 13:10:33'),
(33, '302', '2017-09-05', '1', '1700', 0, 0, NULL, NULL, NULL, '2017-09-05 13:23:57', '2017-09-05 13:23:57'),
(34, '199', '2017-09-05', '1', '1700', 0, 0, NULL, NULL, NULL, '2017-09-05 13:28:02', '2017-09-05 13:28:02'),
(35, '99', '2017-09-05', '2', '400', 0, 0, NULL, NULL, NULL, '2017-09-05 13:30:31', '2017-09-05 13:30:31'),
(36, '31', '2017-09-06', '1', '1500', 0, 0, NULL, NULL, NULL, '2017-09-06 05:21:09', '2017-09-06 05:21:09'),
(37, '354', '2017-09-06', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-06 16:10:42', '2017-09-06 16:10:42'),
(38, '355', '2017-09-07', '3', '500', 0, 0, NULL, NULL, NULL, '2017-09-07 06:32:41', '2017-09-07 06:32:41'),
(39, '356', '2017-09-08', '2', '0', 0, 0, NULL, NULL, NULL, '2017-09-08 05:59:14', '2017-09-08 05:59:14'),
(40, '357', '2017-09-08', '2', '500', 0, 0, NULL, NULL, NULL, '2017-09-08 08:37:10', '2017-09-08 08:37:10'),
(41, '358', '2017-09-08', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-08 08:42:31', '2017-09-08 08:42:31'),
(42, '359', '2017-09-08', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-08 08:46:12', '2017-09-08 08:46:12'),
(43, '335', '2017-09-11', '2', '600', 0, 0, NULL, NULL, NULL, '2017-09-11 05:28:45', '2017-09-11 05:28:45'),
(44, '80', '2017-09-11', '1', '1000', 0, 0, NULL, NULL, NULL, '2017-09-11 09:43:12', '2017-09-11 09:43:12'),
(45, '121', '2017-09-11', '3', '500', 0, 0, NULL, NULL, NULL, '2017-09-11 09:45:32', '2017-09-11 09:45:32'),
(46, '246', '2017-09-11', '2', '200', 0, 0, NULL, NULL, NULL, '2017-09-11 15:31:51', '2017-09-11 15:31:51'),
(47, '3', '2017-09-14', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-14 19:05:29', '2017-09-14 19:05:29'),
(48, '3', '2017-09-14', '2', '500', 0, 0, NULL, NULL, NULL, '2017-09-14 19:05:56', '2017-09-14 19:05:56'),
(49, '1', '2017-09-16', '1', '2000', 0, 0, NULL, NULL, NULL, '2017-09-17 05:24:41', '2017-09-17 05:24:41'),
(50, '1', '2017-10-16', '2', '500', NULL, 0, NULL, NULL, NULL, '2017-10-16 11:15:00', '2017-10-16 11:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `vendor_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` float(10,0) NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `order` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL DEFAULT '5',
  `feedback` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relief`
--

CREATE TABLE `relief` (
  `id` int(10) UNSIGNED NOT NULL,
  `relief_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `relief`
--

INSERT INTO `relief` (`id`, `relief_name`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Insurance Relief', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `riders`
--

CREATE TABLE `riders` (
  `id` int(10) UNSIGNED NOT NULL,
  `rider` int(11) NOT NULL,
  `subsidiary` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rider_orders`
--

CREATE TABLE `rider_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `rider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rides`
--

CREATE TABLE `rides` (
  `id` int(10) UNSIGNED NOT NULL,
  `rider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(2, 'victor', '2016-06-22 07:30:27', '2016-06-22 07:30:27'),
(3, 'Desk', '2017-09-27 16:39:55', '2017-09-27 16:39:55'),
(4, 'Admin', '2017-09-27 16:41:43', '2017-09-27 16:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `sales_targets`
--

CREATE TABLE `sales_targets` (
  `id` int(10) UNSIGNED NOT NULL,
  `month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target_amount` double(15,2) NOT NULL DEFAULT '0.00',
  `target_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sales_targets`
--

INSERT INTO `sales_targets` (`id`, `month`, `target_amount`, `target_date`, `created_at`, `updated_at`) VALUES
(1, 'Sep-2017', 5000000.00, '2017-09-04', '2017-09-04 14:08:53', '2017-09-04 14:08:53'),
(2, 'Jan-2017', 20000000.00, '2017-09-16', '2017-09-17 05:27:49', '2017-09-17 05:27:49');

-- --------------------------------------------------------

--
-- Table structure for table `savingaccounts`
--

CREATE TABLE `savingaccounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `member_id` int(10) UNSIGNED NOT NULL,
  `savingproduct_id` int(10) UNSIGNED NOT NULL,
  `account_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savingpostings`
--

CREATE TABLE `savingpostings` (
  `id` int(10) UNSIGNED NOT NULL,
  `savingproduct_id` int(10) UNSIGNED NOT NULL,
  `transaction` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `debit_account` int(11) NOT NULL,
  `credit_account` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savingproducts`
--

CREATE TABLE `savingproducts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `opening_balance` float(10,0) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `currency` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savingtransactions`
--

CREATE TABLE `savingtransactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `savingaccount_id` int(10) UNSIGNED NOT NULL,
  `amount` float(12,2) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `transacted_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` int(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `created_at`, `updated_at`, `active`) VALUES
(1, 'Installation Service', '2017-06-01 13:08:51', '2017-06-18 08:50:44', 1),
(2, 'Service', '2017-07-29 18:59:41', '2017-07-29 18:59:41', 1),
(3, 'Pipeee', '2017-07-29 19:00:10', '2017-07-29 19:00:10', 1);

-- --------------------------------------------------------

--
-- Table structure for table `shareaccounts`
--

CREATE TABLE `shareaccounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `member_id` int(10) UNSIGNED NOT NULL,
  `account_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `opening_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

CREATE TABLE `shares` (
  `id` int(10) UNSIGNED NOT NULL,
  `value` float(10,0) NOT NULL DEFAULT '0',
  `transfer_charge` float(10,0) NOT NULL DEFAULT '0',
  `charged_on` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'donor',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `shares`
--

INSERT INTO `shares` (`id`, `value`, `transfer_charge`, `charged_on`, `created_at`, `updated_at`) VALUES
(1, 0, 0, 'donor', '2016-06-22 07:30:26', '2016-06-22 07:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `sharetransactions`
--

CREATE TABLE `sharetransactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shareaccount_id` int(10) UNSIGNED NOT NULL,
  `trans_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` float(10,0) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` int(11) NOT NULL,
  `size` int(3) NOT NULL,
  `price` float NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `gas_id` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` (`id`, `size`, `price`, `created_at`, `updated_at`, `gas_id`) VALUES
(2, 13, 2500, '2017-06-01 13:03:38', '2017-06-18 10:11:58', '1'),
(3, 50, 8500, '2017-06-01 13:03:51', '2017-06-01 13:03:51', '1'),
(4, 6, 1500, '2017-06-01 13:04:05', '2017-06-01 13:04:05', '2'),
(5, 13, 2500, '2017-06-01 13:06:16', '2017-06-01 13:06:16', '2'),
(6, 50, 8500, '2017-06-01 13:07:08', '2017-06-01 13:07:08', '2'),
(7, 6, 1500, '2017-06-01 13:07:19', '2017-06-01 13:07:19', '3'),
(8, 13, 2500, '2017-06-01 13:07:25', '2017-06-01 13:07:25', '3'),
(9, 50, 8500, '2017-06-01 13:07:31', '2017-06-01 13:07:31', '3'),
(10, 6, 1500, '2017-06-01 13:08:05', '2017-06-01 13:08:05', '4'),
(11, 13, 2500, '2017-06-01 13:08:10', '2017-06-01 13:08:10', '4'),
(12, 50, 8500, '2017-06-01 13:08:21', '2017-06-01 13:08:21', '4'),
(13, 6, 1500, '2017-06-03 18:05:14', '2017-06-03 18:05:14', '5'),
(14, 13, 2500, '2017-06-03 18:05:26', '2017-06-03 18:05:26', '5'),
(15, 50, 8500, '2017-06-03 18:05:39', '2017-06-03 18:05:39', '5'),
(16, 13, 2500, '2017-06-10 10:32:05', '2017-06-10 10:32:05', '6'),
(17, 50, 8500, '2017-06-10 10:32:18', '2017-06-10 10:32:18', '6'),
(18, 12, 200, '2017-07-29 17:37:22', '2017-07-29 17:37:22', '10'),
(19, 12, 200, '2017-07-30 12:00:57', '2017-07-30 12:00:57', '15'),
(20, 34, 12, '2017-07-30 14:43:29', '2017-07-30 14:43:29', '18'),
(21, 3, 3, '2017-07-31 08:05:12', '2017-07-31 08:05:12', '19');

-- --------------------------------------------------------

--
-- Table structure for table `social_security`
--

CREATE TABLE `social_security` (
  `id` int(10) UNSIGNED NOT NULL,
  `tier` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `income_from` double(15,2) NOT NULL DEFAULT '0.00',
  `income_to` double(15,2) NOT NULL DEFAULT '0.00',
  `ss_amount_employee` double(15,2) NOT NULL DEFAULT '0.00',
  `ss_amount_employer` double(15,2) NOT NULL DEFAULT '0.00',
  `organization_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `social_security`
--

INSERT INTO `social_security` (`id`, `tier`, `income_from`, `income_to`, `ss_amount_employee`, `ss_amount_employer`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Tier I', 0.00, 0.00, 0.00, 0.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Tier I', 1.00, 99000000.00, 200.00, 200.00, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `username` varchar(45) NOT NULL,
  `password` varchar(105) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`username`, `password`, `created_at`, `updated_at`) VALUES
('gasexpress', '$2y$10$1H/8vaPrttlDUZuLMDztcODAZN6xAaFamjzfmuvSCRCgt99KLLszS', '2017-06-08 18:55:22', '2017-06-08 18:55:22');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_id` int(255) DEFAULT NULL,
  `itm_id` int(11) DEFAULT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `quantity_in` int(11) DEFAULT NULL,
  `quantity_out` int(11) DEFAULT NULL,
  `is_confirmed` int(11) NOT NULL DEFAULT '1',
  `receiver_id` int(11) NOT NULL,
  `confirmed_id` int(11) DEFAULT NULL,
  `is_approved` int(11) DEFAULT NULL,
  `is_rejected` int(11) DEFAULT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `item_id`, `itm_id`, `location_id`, `quantity_in`, `quantity_out`, `is_confirmed`, `receiver_id`, `confirmed_id`, `is_approved`, `is_rejected`, `confirmation_code`, `date`, `created_at`, `updated_at`) VALUES
(1, 7, 2, 1, 2, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 11:06:05', '2017-10-09 11:06:05'),
(2, 93, 1, 1, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 11:06:22', '2017-10-09 11:06:22'),
(3, 97, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 11:06:35', '2017-10-09 11:06:35'),
(4, 102, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 14:10:08', '2017-10-09 14:10:08'),
(5, 105, 3, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 14:12:34', '2017-10-09 14:12:34'),
(6, 105, 3, 1, 2, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 14:56:27', '2017-10-09 14:56:27'),
(7, 105, 2, 1, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-09', '2017-10-09 15:03:14', '2017-10-09 15:03:14'),
(8, 105, 1, 1, 2, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-10', '2017-10-10 07:05:39', '2017-10-10 07:05:39'),
(9, NULL, 1, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, '2017-10-10', '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(10, NULL, 2, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, '2017-10-10', '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(11, NULL, 3, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, '2017-10-10', '2017-10-10 07:16:54', '2017-10-10 07:16:54'),
(12, 107, 3, 1, 1, NULL, 1, 3, 1, NULL, NULL, 'f405394ce302aa57887933060eb8a719', '2017-10-10', '2017-10-10 14:19:14', '2017-10-10 14:21:13'),
(13, 107, 1, 1, 2, NULL, 1, 3, 1, NULL, NULL, '8db857f1acd7ebb459c42bf055053c98', '2017-10-10', '2017-10-10 14:20:33', '2017-10-10 14:21:05'),
(14, 107, 3, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-10', '2017-10-10 14:44:45', '2017-10-10 14:44:45'),
(15, 93, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-11', '2017-10-11 07:32:12', '2017-10-11 07:32:12'),
(16, 102, 2, 1, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '2017-10-11', '2017-10-11 07:32:24', '2017-10-11 07:32:24'),
(17, NULL, 1, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, '2017-10-12', '2017-10-12 06:19:11', '2017-10-12 06:19:11'),
(18, NULL, 2, 1, NULL, 3, 1, 0, NULL, NULL, NULL, NULL, '2017-10-12', '2017-10-12 06:22:14', '2017-10-12 06:22:14');

-- --------------------------------------------------------

--
-- Table structure for table `stock_reports`
--

CREATE TABLE `stock_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `choices` enum('in','out') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_tracking`
--

CREATE TABLE `stock_tracking` (
  `id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `item_tracker_id` int(11) DEFAULT NULL,
  `erporder_id` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `subsidiaries`
--

CREATE TABLE `subsidiaries` (
  `id` int(10) UNSIGNED NOT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `supplier_name` varchar(45) NOT NULL,
  `item` int(1) NOT NULL,
  `item_type` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_name`, `item`, `item_type`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Omanga', 2, 0, '2017-07-28 07:46:35', '2017-07-28 09:59:53', 0),
(2, 'Edward', 3, 0, '2017-07-28 08:00:42', '2017-07-28 10:00:18', 0),
(3, 'Oirere', 3, 0, '2017-07-28 08:16:58', '2017-07-28 10:00:21', 0),
(4, 'Eddie', 10105, 1, '2017-07-28 08:23:01', '2017-09-13 03:27:42', 1),
(5, 'Eddie', 10102, 1, '2017-07-28 08:25:22', '2017-07-30 10:57:02', 1),
(6, 'Oirere', 10113, 1, '2017-07-28 08:26:29', '2017-08-19 17:30:58', 1),
(7, 'Supplier', 10, 2, '2017-07-28 08:31:26', '2017-08-19 17:31:17', 1),
(8, 'Supplier', 1, 0, '2017-07-28 09:46:37', '2017-07-28 10:00:31', 0),
(9, 'Edward', 1, 0, '2017-07-28 10:02:22', '2017-07-28 10:02:32', 1),
(10, 'Oirere Omanga', 10101, 0, '2017-07-30 10:21:28', '2017-07-30 10:21:28', 1),
(11, 'Me', 10099, 1, '2017-07-30 10:28:16', '2017-07-30 10:28:16', 1),
(12, 'Ed', 3, 2, '2017-07-30 10:45:43', '2017-07-30 10:45:43', 1),
(13, 'Heeep', 10099, 1, '2017-07-30 10:57:24', '2017-07-30 10:57:24', 1),
(14, 'EDOID', 10110, 1, '2017-07-30 12:41:26', '2017-07-30 12:41:26', 1),
(15, 'Oirere', 10111, 1, '2017-07-30 14:05:18', '2017-07-30 14:05:18', 1),
(16, 'Edd', 10112, 1, '2017-07-30 14:09:35', '2017-07-30 14:09:35', 1),
(17, 'Omlet', 1, 2, '2017-07-30 14:27:34', '2017-07-30 14:27:34', 1),
(18, 'Omlet 2', 1, 2, '2017-07-30 14:31:03', '2017-07-30 14:31:03', 1),
(19, 'Suppp', 18, 2, '2017-07-30 14:44:02', '2017-07-30 14:44:02', 1),
(20, 'Edd', 10113, 1, '2017-07-30 19:23:41', '2017-07-30 19:23:41', 1),
(21, 'NEEEW', 19, 2, '2017-07-31 08:06:12', '2017-07-31 08:06:57', 1),
(22, 'Another NEW G', 19, 2, '2017-07-31 08:07:47', '2017-07-31 08:07:47', 1);

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate` double(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `created_at`, `updated_at`) VALUES
(1, 'VAT', 16.00, '2016-08-18 06:42:46', '2016-08-18 06:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `tax_orders`
--

CREATE TABLE `tax_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `order_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tax_orders`
--

INSERT INTO `tax_orders` (`id`, `tax_id`, `order_number`, `amount`, `created_at`, `updated_at`) VALUES
(1, 1, '2017/08/28/1426', 2240.00, '2017-08-28 09:07:50', '2017-08-28 09:07:50'),
(2, 1, '2017/09/26/0080', 1120.00, '2017-09-26 08:06:53', '2017-09-26 08:06:53'),
(3, 1, '2017/10/07/0097', 2240.00, '2017-10-07 11:28:17', '2017-10-07 11:28:17'),
(4, 1, '2017/10/07/0098', 3536.00, '2017-10-07 11:29:06', '2017-10-07 11:29:06'),
(5, 1, '2017/10/07/0099', 3104.00, '2017-10-07 11:38:19', '2017-10-07 11:38:19');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` varchar(90) NOT NULL,
  `user` varchar(40) NOT NULL,
  `status` int(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `user`, `status`, `created_at`, `updated_at`) VALUES
('$1$.GgtFClg$OGz7.R6jGF9V5peVdOl9X.', '14', 1, '2017-07-01 23:09:44', '2017-07-01 23:10:49'),
('$1$/I0Q5g5i$ESLGXgEtKfxeKmrD4HvYd0', '14', 1, '2017-07-02 00:24:45', '2017-07-02 00:29:02'),
('$1$0JYrM34z$meHSV1.PPiiSk9XpSRULD0', '12', 0, '2017-06-05 11:23:23', '2017-06-05 11:23:23'),
('$1$1GRS3Rfo$.yhewZZx4Jmv23cLGbu1x1', '14', 1, '2017-07-01 23:34:39', '2017-07-01 23:37:59'),
('$1$1m2Kc/W2$dEG1ccLaDvwk981ow0yoi/', '10', 0, '2017-06-05 07:01:48', '2017-06-05 07:01:48'),
('$1$28mqogI6$pP0C5UTudcBY6jmfOREEz0', '1', 1, '2017-06-01 19:23:13', '2017-06-02 01:06:40'),
('$1$37UHlgQ1$uZpLzvVPQU3kaZzQ52u...', '24', 0, '2017-06-12 09:20:24', '2017-06-12 09:20:24'),
('$1$4OCbBrh1$/lDSsUY61HOTV.Zhj8ZTU/', '1', 1, '2017-06-02 01:06:40', '2017-06-02 02:57:14'),
('$1$6p4nvgq0$BaLBMyLV6rUBu0Kdav1d40', '14', 1, '2017-07-01 23:08:54', '2017-07-01 23:09:44'),
('$1$7dyAyp/e$aVeJnleeOrJHW7.tMNgcF1', '8', 0, '2017-06-05 06:26:01', '2017-06-05 06:26:01'),
('$1$7mKb9d7W$Ixq8X9n.gXelWZEYrW/mX1', '20', 0, '2017-06-10 14:52:42', '2017-06-10 14:52:42'),
('$1$8tH.r.n/$6JOdvCAGtSnUjdtjSwPTP/', '25', 0, '2017-06-12 15:12:08', '2017-06-12 15:12:08'),
('$1$A13ah0Wf$WBNmVbOmmMwmsh1t4JRvP.', '14', 1, '2017-07-02 00:05:57', '2017-07-02 00:09:59'),
('$1$A1zdzGAx$fM.XHE/xA4rQTk4XBWiyw0', '30', 0, '2017-06-19 07:46:23', '2017-06-19 07:46:23'),
('$1$aHZRDmJc$vZwSxnZfvBO7mXees873m1', '1', 1, '2017-06-13 04:49:39', '2017-06-19 16:17:51'),
('$1$aLGH27SG$1fXjkmHmDMu4BFZ3Vgzdl0', '1', 1, '2017-06-07 14:25:48', '2017-06-07 14:28:34'),
('$1$athNmXrA$ySZPifTA.jZccANjQiiPT.', '14', 1, '2017-07-01 23:29:51', '2017-07-01 23:32:15'),
('$1$aTt8OGOq$FN5fW3lfyBJ4DEJsL4twE/', '1', 1, '2017-06-07 14:23:53', '2017-06-07 14:24:23'),
('$1$Axh0rvgm$1QXKoSG2BD35V5JA8LZSM/', '1', 1, '2017-06-01 13:24:26', '2017-06-01 16:07:14'),
('$1$b9bgW3z5$/nDuFeOUwy5cuAl/61bcd.', '19', 0, '2017-06-09 22:11:06', '2017-06-09 22:11:06'),
('$1$BH8GDlw0$6DjCKvC/kQxiudAi0aARo0', '14', 1, '2017-07-02 00:09:59', '2017-07-02 00:12:19'),
('$1$BLwFqcla$cypmRBNV6XTW/yEcUYhsz.', '14', 1, '2017-07-02 08:12:56', '2017-07-02 08:14:49'),
('$1$Br1w3nqX$Ifn/uEaOQNEl8v.ImZKRx.', '10000001', 0, '2017-06-29 20:43:32', '2017-06-29 20:43:32'),
('$1$by4Im6Tm$ZLAsEgCH03EES.LHa3Irp1', '14', 1, '2017-07-01 23:32:15', '2017-07-01 23:34:39'),
('$1$cIxk0/3m$V9lDT/gvPluuJR4ZY3GH60', '23', 0, '2017-06-10 17:38:22', '2017-06-10 17:38:22'),
('$1$CmEGdqzX$h8zmF9VA0r7e1JqyMFDPH/', '18', 0, '2017-06-09 18:42:27', '2017-06-09 18:42:27'),
('$1$D9WY96vQ$sqirFvbnrz8cRo0kfoJT20', '14', 1, '2017-06-20 03:43:48', '2017-06-30 07:56:40'),
('$1$DGxxDVvr$M0bD9vagubSvRNjGE15WU0', '1', 1, '2017-06-02 13:43:44', '2017-06-07 14:23:53'),
('$1$DHOgD4cD$aKzrsNvrNBgdbVuh5zAAz/', '14', 1, '2017-07-02 00:04:32', '2017-07-02 00:05:57'),
('$1$dTyhGqWh$QN4NL53ZryVTWEYbN.zwN.', '14', 1, '2017-07-01 22:58:27', '2017-07-01 23:08:54'),
('$1$EmggU2d5$/qlQfnbPwpxBDAH8ydtul.', '14', 1, '2017-07-02 00:20:23', '2017-07-02 00:24:45'),
('$1$eP18XHje$Y37seofrY81OHluxVYSqW.', '14', 1, '2017-06-13 04:52:24', '2017-06-13 17:21:29'),
('$1$Ez4qgkAv$c9GCAkdMnKpgzTXxnLRUJ1', '14', 1, '2017-07-02 17:26:06', '2017-07-02 17:26:40'),
('$1$fDn7AEbh$1y2O9FrUqn3jKEu8veNSf0', '31', 0, '2017-06-19 11:19:31', '2017-06-19 11:19:31'),
('$1$fPh1BJJR$/p79f0F1K14E6.AKi7UvW1', '9', 0, '2017-06-05 06:51:16', '2017-06-05 06:51:16'),
('$1$FpyQqfdt$u8BT75Hk6PmRFs4mCv/5E0', '4', 0, '2017-06-03 09:45:28', '2017-06-03 09:45:28'),
('$1$fYgAkkPK$c8RdsgvYJ/1S35.2wSGcj1', '1', 1, '2017-06-25 07:50:22', '2017-06-25 16:06:16'),
('$1$Here9hat$k08saDd7/BxbpdD69y.RR.', '16', 0, '2017-06-09 09:13:28', '2017-06-09 09:13:28'),
('$1$HhIqtgSD$UpMcQz5xhPHjPH009BK36.', '14', 1, '2017-07-01 23:19:31', '2017-07-01 23:29:51'),
('$1$hTr/JrxG$K5rHdsKroy0cQuSSi9sSU/', '27', 0, '2017-06-16 19:13:18', '2017-06-16 19:13:18'),
('$1$i1suyq6w$aQ5UQu0/MvOACH/v8fSwc/', '14', 1, '2017-06-13 17:21:29', '2017-06-20 03:43:48'),
('$1$i5wMUpHe$dvpePqaofYcLqzpGK9LT5.', '30', 1, '2017-06-19 05:51:13', '2017-06-19 07:46:23'),
('$1$i9LQI.s8$1cDCj6cLfDFUmEs7Vo67J1', '14', 0, '2017-07-02 17:26:40', '2017-07-02 17:26:40'),
('$1$IBzW358n$w75gPBmj0gS2RpIg/nspM.', '1', 1, '2017-06-27 18:42:46', '2017-07-02 16:14:24'),
('$1$ixJ6B96Z$YO7ANspJ7fO8yphue93UZ.', '14', 1, '2017-07-02 00:29:02', '2017-07-02 00:30:03'),
('$1$j7L6sHyb$NHo/G4mvMXjsCQXj8hiZo1', '22', 0, '2017-06-10 16:35:29', '2017-06-10 16:35:29'),
('$1$JAyVg296$drgJs33.iPKHezBECMDFn/', '1', 0, '2017-07-03 16:56:42', '2017-07-03 16:56:42'),
('$1$JWtnNSzm$71hbGVdfODDUCWCf/xxYd1', '26', 0, '2017-06-15 15:35:56', '2017-06-15 15:35:56'),
('$1$kaj8NdBF$SMZX85pgZegTg5EIdD0mw/', '7', 0, '2017-06-05 06:12:56', '2017-06-05 06:12:56'),
('$1$KEqsXPqK$vT7BpPLp9amP9kTmKPN/J/', '1', 1, '2017-06-25 16:06:16', '2017-06-27 18:36:01'),
('$1$lBAsLxH2$gGSx6VZiVvxFPk1WzYUNw/', '1', 1, '2017-06-07 14:24:23', '2017-06-07 14:25:48'),
('$1$MkTQguuL$JF.oBtsLKLJ/omYo6Spvy/', '1', 1, '2017-06-27 18:36:01', '2017-06-27 18:42:46'),
('$1$MzmsVG3y$jqaAHVS4hhpeFAKEEry1F.', '5', 0, '2017-06-03 12:10:57', '2017-06-03 12:10:57'),
('$1$N4E2MbgE$tPZST/GGKMYD2D3SjsRms0', '14', 1, '2017-07-02 00:16:15', '2017-07-02 00:17:18'),
('$1$Nn6KiZGP$fhAXian3JX7fWUX7LKRAX.', '14', 1, '2017-07-01 23:37:59', '2017-07-02 00:04:32'),
('$1$nnydG9ge$3.P3GLrMaxoZ64aSGjgHu0', '28', 0, '2017-06-16 19:27:45', '2017-06-16 19:27:45'),
('$1$nPust127$JIeMa1TGYUN4RCB3QHaei1', '14', 1, '2017-06-07 14:36:04', '2017-06-13 04:52:24'),
('$1$nWgixHjn$VsdQ9eQhXmmxQ1jLL3THw0', '14', 1, '2017-07-02 00:30:03', '2017-07-02 08:03:16'),
('$1$nXqrZ0qA$Qwfk8u0AuWiBVWGT0kgS9.', '29', 0, '2017-06-17 07:31:21', '2017-06-17 07:31:21'),
('$1$owmnm2GD$SasKSupXJdzNq.8Dy2QgG0', '16', 1, '2017-06-08 15:52:53', '2017-06-09 09:13:28'),
('$1$P3x7qi1m$i1xjwHZHruM..M18rYYpy.', '1', 1, '2017-06-02 02:57:14', '2017-06-02 13:43:44'),
('$1$PAv1f54K$N6yZFsFFAlcA1tzo0hnx21', '14', 1, '2017-07-02 00:12:19', '2017-07-02 00:16:15'),
('$1$pH3ix/EA$41L4XnbL54UEHUs8VQWSw.', '14', 1, '2017-07-01 22:56:56', '2017-07-01 22:58:27'),
('$1$pKVMbiEV$yUGQAWneyBkacM6bLlf35.', '1', 1, '2017-06-01 18:53:49', '2017-06-01 19:23:13'),
('$1$PyiIVVgA$poa5Leqr7OkMvv4AAiNHI1', '6', 0, '2017-06-03 17:06:23', '2017-06-03 17:06:23'),
('$1$Q.0yO4jQ$0IXmSD6uYLumQs9tD2g6B1', '32', 0, '2017-06-19 13:01:38', '2017-06-19 13:01:38'),
('$1$q3wuuN6o$MIw3nWNdg6CAMZy8ugNrB0', '1', 1, '2017-06-07 14:33:52', '2017-06-13 04:49:39'),
('$1$QQqCpgB6$YIEka2RpApMUzDlEKsRJj/', '14', 1, '2017-07-02 00:17:18', '2017-07-02 00:20:23'),
('$1$rC3kfAwX$.lMwAGLZQfwbhE5f1GZou/', '1', 1, '2017-06-01 16:07:14', '2017-06-01 16:08:05'),
('$1$rO3y7lUf$mKJug2mVVP0bIIsX1NNRg0', '21', 0, '2017-06-10 16:03:15', '2017-06-10 16:03:15'),
('$1$rRULLSNl$lPGvpdokl2eGxcWBezSev1', '11', 0, '2017-07-11 12:44:36', '2017-07-11 12:44:36'),
('$1$RysYggXy$peo9DZksC8lWt4ji4zMdA/', '14', 1, '2017-07-01 22:53:01', '2017-07-01 22:54:39'),
('$1$RzEUUwqC$8vPTdy2a2WphoiWEmbsUs1', '14', 1, '2017-07-02 08:03:16', '2017-07-02 08:12:56'),
('$1$SdMu/8bf$oqZNd/8IVQX045ghJhSR1/', '1', 1, '2017-06-01 13:14:41', '2017-06-01 13:24:26'),
('$1$SJYPXykn$gG/wHrhQ.nzAtwEYnOscu1', '11', 1, '2017-06-28 14:25:23', '2017-07-11 12:44:36'),
('$1$sN78ILs6$djEY9vFkbWmmOYZ.KCUXv1', '16', 1, '2017-06-08 15:48:24', '2017-06-08 15:52:53'),
('$1$T4efg1sG$AO8GCvEHx85C5rk/mGW2i0', '1', 1, '2017-06-01 16:08:05', '2017-06-01 18:53:49'),
('$1$tcPlo.6J$K0wUvVpKnkVqOv7R0juM/0', '14', 1, '2017-07-01 22:54:39', '2017-07-01 22:56:56'),
('$1$TlxHUQnD$QhPvwU5fR/f1FeI6VgMsy/', '14', 1, '2017-06-30 07:56:40', '2017-07-01 22:53:01'),
('$1$tP/BeTL4$yOZsXn8uT.4RFLM9jQvcN1', '14', 1, '2017-07-01 23:10:49', '2017-07-01 23:14:59'),
('$1$TWirCvhi$/.PNbGhLwsByYdPxugSks1', '14', 1, '2017-07-02 08:14:49', '2017-07-02 17:26:06'),
('$1$Ubv6b2jN$C/jy564MQRK7RbsqT1kL./', '14', 1, '2017-07-01 23:14:59', '2017-07-01 23:19:31'),
('$1$UFvpj6nv$ikNICEfVYuHlGi6lSVqGH0', '1', 1, '2017-06-19 16:17:51', '2017-06-25 07:50:22'),
('$1$vB78opbI$SzdiQN3NApV2/EcI1x09L0', '17', 0, '2017-06-09 14:08:21', '2017-06-09 14:08:21'),
('$1$VGPoel30$9gkRovHFYY1cjHqQWrrsP/', '11', 1, '2017-06-05 11:20:50', '2017-06-28 14:25:23'),
('$1$VXYL9y4n$kpG/0b6XN9LyGtBpkpZYy.', '3', 0, '2017-06-03 04:40:47', '2017-06-03 04:40:47'),
('$1$wZ0JxRH7$N.6CmUUMndOZry0of805h1', '2', 0, '2017-06-02 14:41:02', '2017-06-02 14:41:02'),
('$1$xL46FNeU$T4rP4DNg6qU26tQulunHJ0', '13', 0, '2017-06-06 12:50:49', '2017-06-06 12:50:49'),
('$1$YxN.ck6J$0rDf6gyrMHupgoeJG3rn30', '1', 1, '2017-06-07 14:33:00', '2017-06-07 14:33:52'),
('$1$Z.4XSciA$4M2NlHEpGCo1Ti25ty6MU0', '22', 1, '2017-06-10 16:22:17', '2017-06-10 16:35:29'),
('$1$zbIMQpJB$gk.yIh9d0EgNHn3o.AUgE/', '1', 1, '2017-07-02 16:14:24', '2017-07-03 16:56:42'),
('$1$ZeNBULVq$L0uYL6aBSrxj.uAI6htLW1', '1', 1, '2017-06-07 14:28:34', '2017-06-07 14:33:00'),
('$1$zXTSiDGy$iNbt/EKw23AHEg6qpzDnl0', '15', 0, '2017-06-08 12:37:13', '2017-06-08 12:37:13');

-- --------------------------------------------------------

--
-- Table structure for table `transact`
--

CREATE TABLE `transact` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `basic_pay` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `earning_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `taxable_income` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `paye` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `nssf_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `vol_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `nhif_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `other_deductions` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `total_deductions` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `net` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `financial_month_year` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transact_allowances`
--

CREATE TABLE `transact_allowances` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `allowance_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `allowance_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `allowance_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `financial_month_year` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transact_deductions`
--

CREATE TABLE `transact_deductions` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deduction_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deduction_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deduction_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `financial_month_year` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transact_earnings`
--

CREATE TABLE `transact_earnings` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `earning_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `earning_amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `financial_month_year` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '1',
  `user_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT NULL,
  `branch_id` int(10) UNSIGNED DEFAULT NULL,
  `organization_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `confirmation_code`, `remember_token`, `confirmed`, `user_type`, `is_active`, `branch_id`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'superadmin@lixnet.net', '$2y$10$m513FsU.J8rQUDZalnUWaOApfhfy3PUmihLgq/929Gizen3MRpUmG', '5b161c557ca737183892ece749a4cc7d', 'NOUV19Ifgw9SkSSamCWoxhhSPielPo3TWUc1uGo5BNjyKxOZSCLJNz8ef2yg', 1, 'admin', NULL, NULL, 1, '2016-06-22 07:30:29', '2017-10-17 08:15:26'),
(2, 'vkotonya', 'victor.kotonya@lixnet.net', '$2y$10$F.zPvxFuzRQc/CIB..qURe/UKWp5Gd6EDeuebkj5IABJc7xoyjvkG', '5b161c557ca737183892ece749a4cc7d', 'BHUSyqVotBRmdV6ZkDGPyEUS6Imzzu1kJrtU4EiCNKh9X3yTxCGF9RzfIhbD', 1, 'admin', NULL, NULL, 1, '2016-06-22 07:30:29', '2017-09-29 08:16:21'),
(3, 'alice', 'alice.kimanzi@gx.co.ke', '$2y$10$CeHhqbhqwMgZDsePbVWarO96Ordh4Jqk/2vstFs/7.BZVWcqOYxGC', '6d60175335826925f4a190ae1b115dfd', 'DihgMJDfIkC5jnMbP0CU6AKR3x1b69b0UI9jQD1fS1W4gYrdtMxaF65TFqr8', 1, 'admin', NULL, NULL, 1, '2017-09-27 16:42:18', '2017-10-11 08:18:53'),
(4, 'admin', 'info@gx.co.ke', '$2y$10$MlCf1ISTAgxP.ZZ0t0EtVuj3f3hdXwuCS1Ri5k17CC923vacCRIyi', 'f997cca84bc134af1dafd7e3b74b8ae1', '0DuSpbqGlviR3qsPP1xi91Oc2oe8r2mnabKYtVJMbUN8JGsYdgXVNTEF1WKk', 1, 'admin', NULL, NULL, 1, '2017-09-27 16:42:45', '2017-09-29 08:44:02'),
(5, 'maureen', 'maureen.njeri@gx.co.ke', '$2y$10$iihYBFJ9AtaVXUNjhfwrr.oBQZczZxNeFGjJVrlN8IKgonYNm5JrC', '50e30f97ccc755942dad41bf8bbfba59', 'iYBACh3tgn71yOO8SBivhBLUyO6x5Rpv858uc1DsjYU8valJJqzifHnX7tYj', 1, 'admin', NULL, NULL, 1, '2017-09-27 17:29:53', '2017-09-29 19:10:46');

-- --------------------------------------------------------

--
-- Table structure for table `user_locations`
--

CREATE TABLE `user_locations` (
  `id` varchar(40) NOT NULL,
  `location_id` varchar(40) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_locations`
--

INSERT INTO `user_locations` (`id`, `location_id`, `created_at`, `updated_at`) VALUES
('1', '59333602b9383', '2017-06-03 22:19:46', '2017-06-03 22:19:46'),
('1', '5937b3da4f4e9', '2017-06-07 08:05:46', '2017-06-07 08:05:46'),
('1', '59591c3e128cc', '2017-07-02 16:15:58', '2017-07-02 16:15:58'),
('10', '593501dc3ae46', '2017-06-05 07:01:48', '2017-06-05 07:01:48'),
('10000001', '59556674e34be', '2017-06-29 20:43:32', '2017-06-29 20:43:32'),
('11', '59353e923e517', '2017-06-05 11:20:50', '2017-06-05 11:20:50'),
('12', '59353f2b311d5', '2017-06-05 11:23:23', '2017-06-05 11:23:23'),
('13', '5936a52960909', '2017-06-06 12:50:49', '2017-06-06 12:50:49'),
('14', '59380f549a83b', '2017-06-07 14:36:04', '2017-06-07 14:36:04'),
('14', '593f5b85806c7', '2017-06-13 03:27:01', '2017-06-13 03:27:01'),
('15', '593944f93e81e', '2017-06-08 12:37:13', '2017-06-08 12:37:13'),
('16', '593971c84455b', '2017-06-08 15:48:24', '2017-06-08 15:48:24'),
('17', '593aabd518616', '2017-06-09 14:08:21', '2017-06-09 14:08:21'),
('18', '593aec1374300', '2017-06-09 18:42:27', '2017-06-09 18:42:27'),
('19', '593b1cfa2a7cd', '2017-06-09 22:11:06', '2017-06-09 22:11:06'),
('2', '593178fe10b46', '2017-06-02 14:41:02', '2017-06-02 14:41:02'),
('20', '593c07b9e97ee', '2017-06-10 14:52:42', '2017-06-10 14:52:42'),
('21', '593c1842ed3d3', '2017-06-10 16:03:15', '2017-06-10 16:03:15'),
('22', '593c1cb9c02d6', '2017-06-10 16:22:17', '2017-06-10 16:22:17'),
('23', '593c2e8e4ffa9', '2017-06-10 17:38:22', '2017-06-10 17:38:22'),
('24', '593e5cd8416cc', '2017-06-12 09:20:24', '2017-06-12 09:20:24'),
('25', '593eaf483fa7e', '2017-06-12 15:12:08', '2017-06-12 15:12:08'),
('26', '5942a95c695b1', '2017-06-15 15:35:56', '2017-06-15 15:35:56'),
('27', '59442dce7b06f', '2017-06-16 19:13:18', '2017-06-16 19:13:18'),
('28', '594431316a6d1', '2017-06-16 19:27:45', '2017-06-16 19:27:45'),
('29', '5944dac9802ca', '2017-06-17 07:31:21', '2017-06-17 07:31:21'),
('3', '59323dcf05859', '2017-06-03 04:40:47', '2017-06-03 04:40:47'),
('30', '594766516c915', '2017-06-19 05:51:13', '2017-06-19 05:51:13'),
('31', '5947b343a53f2', '2017-06-19 11:19:31', '2017-06-19 11:19:31'),
('32', '5947cb3242e2f', '2017-06-19 13:01:38', '2017-06-19 13:01:38'),
('4', '5932853898d9d', '2017-06-03 09:45:28', '2017-06-03 09:45:28'),
('5', '5932a751ce1da', '2017-06-03 12:10:57', '2017-06-03 12:10:57'),
('6', '5932ec8f81b54', '2017-06-03 17:06:23', '2017-06-03 17:06:23'),
('7', '5934f66871c03', '2017-06-05 06:12:56', '2017-06-05 06:12:56'),
('8', '5934f97962233', '2017-06-05 06:26:01', '2017-06-05 06:26:01'),
('9', '5934ff64e850f', '2017-06-05 06:51:16', '2017-06-05 06:51:16');

-- --------------------------------------------------------

--
-- Table structure for table `user_orders`
--

CREATE TABLE `user_orders` (
  `user_id` varchar(40) NOT NULL,
  `order_id` varchar(40) NOT NULL,
  `viewed` int(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '0',
  `payment_method` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_orders`
--

INSERT INTO `user_orders` (`user_id`, `order_id`, `viewed`, `created_at`, `updated_at`, `status`, `payment_method`) VALUES
('1', '29f0d7bf-93a2-4e01-8473-a1965c916933', 0, '2017-06-06 14:53:36', '2017-06-08 10:56:18', 1, 'Cash'),
('1', '580db8d7-4a1d-49c6-8cad-4d05fc502d73', 0, '2017-06-06 15:41:24', '2017-06-07 18:51:17', 1, 'Cash'),
('1', '6876af20-943a-4fe0-9f3b-1649d4808d6f', 0, '2017-06-06 15:42:25', '2017-06-07 14:22:23', 1, 'Cash'),
('1', '9b391040-3a79-4f4e-86ef-e08cc2dcb4d5', 0, '2017-06-07 08:03:28', '2017-06-07 14:00:42', 1, 'Credit Card'),
('1', 'd112fbed-3131-4bcd-9bf6-01a667353a02', 0, '2017-06-06 13:48:50', '2017-06-08 10:56:40', 1, 'Cash'),
('1', 'd55bb04c-577f-43be-bfd1-7ea61d42ad5f', 0, '2017-06-06 11:44:23', '2017-06-06 11:57:24', 1, 'Mpesa'),
('1', 'f1787f5d-5aab-454c-816f-1d4c830a7a97', 0, '2017-06-06 11:35:14', '2017-06-08 10:56:51', 1, 'Cash'),
('1', 'fa528d4d-bf56-40fd-8eb5-6b8142c6d911', 0, '2017-06-06 14:54:28', '2017-06-08 10:56:04', 1, 'Cash'),
('1', 'ffad9b72-7423-4588-ac0c-80329777044c', 0, '2017-06-03 22:19:54', '2017-06-05 19:28:57', 1, 'Cash'),
('11', '11027', 0, '2017-06-28 14:27:57', '2017-06-28 14:32:27', 1, 'Cash'),
('14', '11001', 0, '2017-06-07 19:39:07', '2017-06-08 10:55:48', 1, 'Cash'),
('14', '11002', 0, '2017-06-07 19:45:53', '2017-06-08 10:55:33', 1, 'Cash'),
('14', '11014', 0, '2017-06-13 16:46:36', '2017-06-13 16:52:27', 1, 'Cash'),
('14', '11015', 0, '2017-06-13 17:36:39', '2017-06-13 17:38:01', 1, 'Cash'),
('14', '11016', 0, '2017-06-13 17:54:23', '2017-06-14 04:54:17', 1, 'Cash'),
('14', '11017', 0, '2017-06-13 17:57:42', '2017-06-14 04:54:32', 1, 'Cash'),
('14', '11018', 0, '2017-06-13 18:00:31', '2017-06-14 04:53:51', 1, 'Cash'),
('14', '11019', 0, '2017-06-13 18:02:35', '2017-06-14 04:53:58', 1, 'Cash'),
('14', '11020', 0, '2017-06-13 18:08:16', '2017-06-14 04:54:07', 1, 'Cash'),
('14', '11021', 0, '2017-06-13 18:09:54', '2017-06-14 04:53:42', 1, 'Cash'),
('14', '11022', 0, '2017-06-13 19:23:52', '2017-06-13 21:20:20', 1, 'Cash'),
('14', '11023', 0, '2017-06-13 20:17:11', '2017-06-19 06:22:46', 1, 'Cash'),
('14', '11028', 0, '2017-06-30 07:57:39', '2017-06-30 07:58:50', 1, 'Cash'),
('14', '11029', 0, '2017-06-30 08:03:27', '2017-07-06 17:40:56', 1, 'Cash'),
('14', '11031', 0, '2017-06-30 08:07:15', '2017-07-02 18:43:08', 1, 'Cash'),
('16', '11035', 0, '2017-07-09 05:45:12', '2017-07-09 06:51:09', 1, 'Mpesa'),
('18', '11011', 0, '2017-06-09 18:47:00', '2017-06-12 08:05:47', 1, 'Cash'),
('2', '11003', 0, '2017-06-08 10:29:07', '2017-06-08 10:30:00', 1, 'Credit Card'),
('2', '11004', 0, '2017-06-08 13:16:48', '2017-06-08 13:17:35', 1, 'Cash'),
('2', '11005', 0, '2017-06-08 17:12:28', '2017-06-08 17:47:06', 1, 'Credit Card'),
('2', '11008', 0, '2017-06-09 08:31:46', '2017-06-09 17:07:53', 1, 'Credit Card'),
('25', '11024', 0, '2017-06-14 18:44:51', '2017-06-19 06:22:37', 1, 'Cash'),
('25', '11033', 0, '2017-07-02 05:08:20', '2017-07-02 18:43:17', 1, 'Cash'),
('3', 'a940d12a-023e-46a8-8c47-283c4b576de3', 0, '2017-06-03 04:42:45', '2017-06-08 10:59:21', 1, 'Cash'),
('31', '11026', 0, '2017-06-19 11:20:26', '2017-06-20 06:24:40', 1, 'Cash'),
('7', 'aa14a46b-62d3-4381-8d65-1c0ed01d0499', 0, '2017-06-05 06:15:11', '2017-06-08 10:57:05', 1, 'Cash'),
('7', 'c48e7903-71b0-4586-892a-3d2e02a1b38a', 0, '2017-06-05 06:24:35', '2017-06-08 10:57:22', 1, 'Cash'),
('8', '11013', 0, '2017-06-13 11:50:23', '2017-06-13 12:24:51', 1, 'Cash'),
('8', '11025', 0, '2017-06-16 05:30:46', '2017-06-16 05:41:50', 1, 'Cash'),
('8', '88659ab1-25d7-420d-8c3a-0f73330fc15d', 0, '2017-06-05 08:23:51', '2017-06-08 10:57:33', 1, 'Cash'),
('9', '11006', 0, '2017-06-09 04:54:44', '2017-06-09 06:15:11', 1, 'Mpesa'),
('9', '11007', 0, '2017-06-09 06:10:50', '2017-06-09 06:15:04', 1, 'Mpesa'),
('9', '11009', 0, '2017-06-09 08:32:34', '2017-06-09 17:07:38', 1, 'Credit Card'),
('9', '11010', 0, '2017-06-09 14:53:15', '2017-06-09 17:07:17', 1, 'Mpesa'),
('9', '11012', 0, '2017-06-11 14:40:08', '2017-06-11 18:57:43', 1, 'Cash'),
('9', '11030', 0, '2017-06-30 08:03:30', '2017-06-30 08:03:50', 1, 'Cash'),
('9', '11032', 0, '2017-06-30 08:11:30', '2017-06-30 08:15:57', 1, 'Mpesa'),
('9', '11034', 0, '2017-07-07 17:48:54', '2017-07-07 17:50:08', 1, 'Mpesa');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(10) UNSIGNED NOT NULL,
  `reg_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tank_capacity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `reg_no`, `model`, `tank_capacity`, `date`, `created_at`, `updated_at`) VALUES
(1, 'KBK143A', 'Toyota', '65 Litres', '2017-09-01', '2017-09-01 11:26:21', '2017-09-01 11:26:30'),
(2, 'KMDX641R', 'TVS', '10 Litres', '2017-09-01', '2017-09-01 11:43:16', '2017-09-01 11:43:27'),
(3, 'KMDE698D', 'Boxer', '10', '2017-09-01', '2017-09-01 11:43:52', '2017-09-01 11:43:52'),
(4, 'KBK509A', 'Toyota', '60', '2017-09-01', '2017-09-01 11:44:44', '2017-09-01 11:44:44');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accessories`
--
ALTER TABLE `accessories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_transactions`
--
ALTER TABLE `account_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `allowances`
--
ALTER TABLE `allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `allowances_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assigndrivers`
--
ALTER TABLE `assigndrivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assigned_roles`
--
ALTER TABLE `assigned_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_roles_user_id_foreign` (`user_id`),
  ADD KEY `assigned_roles_role_id_foreign` (`role_id`);

--
-- Indexes for table `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `autoprocesses`
--
ALTER TABLE `autoprocesses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banking`
--
ALTER TABLE `banking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `banks_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_branches`
--
ALTER TABLE `bank_branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_branches_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `bank_statements`
--
ALTER TABLE `bank_statements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bulk_gas`
--
ALTER TABLE `bulk_gas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charge_loanproduct`
--
ALTER TABLE `charge_loanproduct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loancharges_charge_id_foreign` (`charge_id`),
  ADD KEY `loancharges_loanproduct_id_foreign` (`loanproduct_id`);

--
-- Indexes for table `charge_savingproduct`
--
ALTER TABLE `charge_savingproduct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `savingcharges_charge_id_foreign` (`charge_id`),
  ADD KEY `savingcharges_savingproduct_id_foreign` (`savingproduct_id`);

--
-- Indexes for table `claim_receipts`
--
ALTER TABLE `claim_receipts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `claim_receipt_items`
--
ALTER TABLE `claim_receipt_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_property`
--
ALTER TABLE `company_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_property_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deductions`
--
ALTER TABLE `deductions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deductions_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `delivery_locations`
--
ALTER TABLE `delivery_locations`
  ADD PRIMARY KEY (`order_id`,`location_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `earnings_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `education_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_personal_file_number_unique` (`personal_file_number`),
  ADD UNIQUE KEY `employee_identity_number_unique` (`identity_number`),
  ADD UNIQUE KEY `employee_passport_number_unique` (`passport_number`),
  ADD UNIQUE KEY `employee_pin_unique` (`pin`),
  ADD UNIQUE KEY `employee_social_security_number_unique` (`social_security_number`),
  ADD UNIQUE KEY `employee_hospital_insurance_number_unique` (`hospital_insurance_number`),
  ADD UNIQUE KEY `employee_work_permit_number_unique` (`work_permit_number`),
  ADD UNIQUE KEY `employee_bank_account_number_unique` (`bank_account_number`),
  ADD UNIQUE KEY `employee_bank_eft_code_unique` (`bank_eft_code`),
  ADD UNIQUE KEY `employee_swift_code_unique` (`swift_code`),
  ADD UNIQUE KEY `employee_email_office_unique` (`email_office`),
  ADD UNIQUE KEY `employee_email_personal_unique` (`email_personal`),
  ADD UNIQUE KEY `employee_telephone_office_unique` (`telephone_office`),
  ADD UNIQUE KEY `employee_telephone_extension_office_unique` (`telephone_extension_office`),
  ADD UNIQUE KEY `employee_telephone_mobile_unique` (`telephone_mobile`),
  ADD KEY `employee_organization_id_foreign` (`organization_id`),
  ADD KEY `employee_branch_id_foreign` (`branch_id`),
  ADD KEY `employee_department_id_foreign` (`department_id`),
  ADD KEY `employee_job_group_id_foreign` (`job_group_id`),
  ADD KEY `employee_type_id_foreign` (`type_id`),
  ADD KEY `employee_education_type_id_foreign` (`education_type_id`),
  ADD KEY `employee_bank_id_foreign` (`bank_id`);

--
-- Indexes for table `employee_allowances`
--
ALTER TABLE `employee_allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_allowances_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_allowances_allowance_id_foreign` (`allowance_id`);

--
-- Indexes for table `employee_deductions`
--
ALTER TABLE `employee_deductions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_deductions_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_deductions_deduction_id_foreign` (`deduction_id`);

--
-- Indexes for table `employee_relief`
--
ALTER TABLE `employee_relief`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_relief_relief_id_foreign` (`relief_id`),
  ADD KEY `employee_relief_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_type`
--
ALTER TABLE `employee_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_type_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `erporderitems`
--
ALTER TABLE `erporderitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `erporderitems_item_id_foreign` (`item_id`),
  ADD KEY `erporderitems_erporder_id_foreign` (`erporder_id`);

--
-- Indexes for table `erporders`
--
ALTER TABLE `erporders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `erporders_client_id_foreign` (`client_id`);

--
-- Indexes for table `erpquotations`
--
ALTER TABLE `erpquotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_account_id_foreign` (`account_id`);

--
-- Indexes for table `expense_claims`
--
ALTER TABLE `expense_claims`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gas`
--
ALTER TABLE `gas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gas_locations`
--
ALTER TABLE `gas_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gas_users`
--
ALTER TABLE `gas_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `g_c_m_users`
--
ALTER TABLE `g_c_m_users`
  ADD PRIMARY KEY (`user`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holidays_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `hospital_insurance`
--
ALTER TABLE `hospital_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_tracker`
--
ALTER TABLE `item_tracker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_tracker_item_id_foreign` (`item_id`),
  ADD KEY `item_tracker_location_id_foreign` (`location_id`),
  ADD KEY `item_tracker_client_id_foreign` (`client_id`);

--
-- Indexes for table `job_group`
--
ALTER TABLE `job_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_group_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journals_account_id_foreign` (`account_id`);

--
-- Indexes for table `kins`
--
ALTER TABLE `kins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kins_member_id_foreign` (`member_id`);

--
-- Indexes for table `leaveapplications`
--
ALTER TABLE `leaveapplications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leaveapplications_employee_id_foreign` (`employee_id`),
  ADD KEY `leaveapplications_leavetype_id_foreign` (`leavetype_id`),
  ADD KEY `leaveapplications_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `leavetypes`
--
ALTER TABLE `leavetypes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leavetypes_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `loanaccounts`
--
ALTER TABLE `loanaccounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loanaccounts_member_id_foreign` (`member_id`),
  ADD KEY `loanaccounts_loanproduct_id_foreign` (`loanproduct_id`);

--
-- Indexes for table `loanguarantors`
--
ALTER TABLE `loanguarantors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loanguarantors_member_id_foreign` (`member_id`),
  ADD KEY `loanguarantors_loanaccount_id_foreign` (`loanaccount_id`);

--
-- Indexes for table `loanpostings`
--
ALTER TABLE `loanpostings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loanpostings_loanproduct_id_foreign` (`loanproduct_id`);

--
-- Indexes for table `loanproducts`
--
ALTER TABLE `loanproducts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loanrepayments`
--
ALTER TABLE `loanrepayments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loanrepayments_loanaccount_id_foreign` (`loanaccount_id`);

--
-- Indexes for table `loantransactions`
--
ALTER TABLE `loantransactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loantransactions_loanaccount_id_foreign` (`loanaccount_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mails`
--
ALTER TABLE `mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `membership_no` (`membership_no`),
  ADD KEY `members_group_id_foreign` (`group_id`),
  ADD KEY `members_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `navigations`
--
ALTER TABLE `navigations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `next_of_kin`
--
ALTER TABLE `next_of_kin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `next_of_kin_contact_unique` (`contact`),
  ADD UNIQUE KEY `next_of_kin_id_number_unique` (`id_number`),
  ADD KEY `next_of_kin_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`item_id`,`order_id`,`type`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organization_bank_id_foreign` (`bank_id`),
  ADD KEY `organization_bank_branch_id_foreign` (`bank_branch_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `paymentmethods`
--
ALTER TABLE `paymentmethods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paymentmethods_account_id_foreign` (`account_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_erporder_id_foreign` (`erporder_id`),
  ADD KEY `payments_paymentmethod_id_foreign` (`paymentmethod_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `pettycash_items`
--
ALTER TABLE `pettycash_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pettycash_items_ac_trns_foreign` (`ac_trns`);

--
-- Indexes for table `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_vendor_id_index` (`vendor_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `relief`
--
ALTER TABLE `relief`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relief_organization_id_foreign` (`organization_id`);

--
-- Indexes for table `riders`
--
ALTER TABLE `riders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rider_orders`
--
ALTER TABLE `rider_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rides`
--
ALTER TABLE `rides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sales_targets`
--
ALTER TABLE `sales_targets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savingaccounts`
--
ALTER TABLE `savingaccounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `savingaccounts_member_id_foreign` (`member_id`),
  ADD KEY `x_savingaccounts_fk` (`savingproduct_id`);

--
-- Indexes for table `savingpostings`
--
ALTER TABLE `savingpostings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `savingpostings_savingproduct_id_foreign` (`savingproduct_id`);

--
-- Indexes for table `savingproducts`
--
ALTER TABLE `savingproducts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savingtransactions`
--
ALTER TABLE `savingtransactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `savingtransactions_savingaccount_id_foreign` (`savingaccount_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shareaccounts`
--
ALTER TABLE `shareaccounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shareaccounts_member_id_foreign` (`member_id`);

--
-- Indexes for table `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sharetransactions`
--
ALTER TABLE `sharetransactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sharetransactions_shareaccount_id_foreign` (`shareaccount_id`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_security`
--
ALTER TABLE `social_security`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stocks_item_id_foreign` (`item_id`),
  ADD KEY `stocks_location_id_foreign` (`location_id`);

--
-- Indexes for table `stock_reports`
--
ALTER TABLE `stock_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_tracking`
--
ALTER TABLE `stock_tracking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subsidiaries`
--
ALTER TABLE `subsidiaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subsidiaries_email_unique` (`email`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tax_orders`
--
ALTER TABLE `tax_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transact`
--
ALTER TABLE `transact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transact_employee_id_foreign` (`employee_id`),
  ADD KEY `transact_account_id_foreign` (`account_id`);

--
-- Indexes for table `transact_allowances`
--
ALTER TABLE `transact_allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transact_allowances_employee_id_foreign` (`employee_id`),
  ADD KEY `transact_allowances_allowance_id_foreign` (`allowance_id`);

--
-- Indexes for table `transact_deductions`
--
ALTER TABLE `transact_deductions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transact_deductions_employee_id_foreign` (`employee_id`),
  ADD KEY `transact_deductions_deduction_id_foreign` (`deduction_id`);

--
-- Indexes for table `transact_earnings`
--
ALTER TABLE `transact_earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transact_earnings_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `user_locations`
--
ALTER TABLE `user_locations`
  ADD PRIMARY KEY (`id`,`location_id`);

--
-- Indexes for table `user_orders`
--
ALTER TABLE `user_orders`
  ADD PRIMARY KEY (`user_id`,`order_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `x_user_role_fk1` (`role_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `account_transactions`
--
ALTER TABLE `account_transactions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `allowances`
--
ALTER TABLE `allowances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `assigndrivers`
--
ALTER TABLE `assigndrivers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `assigned_roles`
--
ALTER TABLE `assigned_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;
--
-- AUTO_INCREMENT for table `autoprocesses`
--
ALTER TABLE `autoprocesses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banking`
--
ALTER TABLE `banking`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `bank_branches`
--
ALTER TABLE `bank_branches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bank_statements`
--
ALTER TABLE `bank_statements`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `bulk_gas`
--
ALTER TABLE `bulk_gas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10100;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `charge_loanproduct`
--
ALTER TABLE `charge_loanproduct`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `charge_savingproduct`
--
ALTER TABLE `charge_savingproduct`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `claim_receipts`
--
ALTER TABLE `claim_receipts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `claim_receipt_items`
--
ALTER TABLE `claim_receipt_items`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=363;
--
-- AUTO_INCREMENT for table `company_property`
--
ALTER TABLE `company_property`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `deductions`
--
ALTER TABLE `deductions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_allowances`
--
ALTER TABLE `employee_allowances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_deductions`
--
ALTER TABLE `employee_deductions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_relief`
--
ALTER TABLE `employee_relief`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_type`
--
ALTER TABLE `employee_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `erporderitems`
--
ALTER TABLE `erporderitems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `erporders`
--
ALTER TABLE `erporders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;
--
-- AUTO_INCREMENT for table `erpquotations`
--
ALTER TABLE `erpquotations`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `expense_claims`
--
ALTER TABLE `expense_claims`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `gas_users`
--
ALTER TABLE `gas_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hospital_insurance`
--
ALTER TABLE `hospital_insurance`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `item_tracker`
--
ALTER TABLE `item_tracker`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `job_group`
--
ALTER TABLE `job_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `kins`
--
ALTER TABLE `kins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `leaveapplications`
--
ALTER TABLE `leaveapplications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `leavetypes`
--
ALTER TABLE `leavetypes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loanaccounts`
--
ALTER TABLE `loanaccounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loanguarantors`
--
ALTER TABLE `loanguarantors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loanpostings`
--
ALTER TABLE `loanpostings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loanproducts`
--
ALTER TABLE `loanproducts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loanrepayments`
--
ALTER TABLE `loanrepayments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loantransactions`
--
ALTER TABLE `loantransactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `mails`
--
ALTER TABLE `mails`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `navigations`
--
ALTER TABLE `navigations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `next_of_kin`
--
ALTER TABLE `next_of_kin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;
--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `paymentmethods`
--
ALTER TABLE `paymentmethods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;
--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;
--
-- AUTO_INCREMENT for table `pettycash_items`
--
ALTER TABLE `pettycash_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `relief`
--
ALTER TABLE `relief`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rider_orders`
--
ALTER TABLE `rider_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rides`
--
ALTER TABLE `rides`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sales_targets`
--
ALTER TABLE `sales_targets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `savingaccounts`
--
ALTER TABLE `savingaccounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `savingpostings`
--
ALTER TABLE `savingpostings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `savingproducts`
--
ALTER TABLE `savingproducts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `savingtransactions`
--
ALTER TABLE `savingtransactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `shareaccounts`
--
ALTER TABLE `shareaccounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shares`
--
ALTER TABLE `shares`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sharetransactions`
--
ALTER TABLE `sharetransactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `social_security`
--
ALTER TABLE `social_security`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `stock_reports`
--
ALTER TABLE `stock_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stock_tracking`
--
ALTER TABLE `stock_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `subsidiaries`
--
ALTER TABLE `subsidiaries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tax_orders`
--
ALTER TABLE `tax_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `transact`
--
ALTER TABLE `transact`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transact_allowances`
--
ALTER TABLE `transact_allowances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transact_deductions`
--
ALTER TABLE `transact_deductions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transact_earnings`
--
ALTER TABLE `transact_earnings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `assigned_roles`
--
ALTER TABLE `assigned_roles`
  ADD CONSTRAINT `assigned_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `assigned_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `charge_loanproduct`
--
ALTER TABLE `charge_loanproduct`
  ADD CONSTRAINT `loancharges_charge_id_foreign` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`),
  ADD CONSTRAINT `loancharges_loanproduct_id_foreign` FOREIGN KEY (`loanproduct_id`) REFERENCES `loanproducts` (`id`);

--
-- Constraints for table `charge_savingproduct`
--
ALTER TABLE `charge_savingproduct`
  ADD CONSTRAINT `savingcharges_charge_id_foreign` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`),
  ADD CONSTRAINT `savingcharges_savingproduct_id_foreign` FOREIGN KEY (`savingproduct_id`) REFERENCES `savingproducts` (`id`);

--
-- Constraints for table `erporderitems`
--
ALTER TABLE `erporderitems`
  ADD CONSTRAINT `erporderitems_erporder_id_foreign` FOREIGN KEY (`erporder_id`) REFERENCES `erporders` (`id`),
  ADD CONSTRAINT `erporderitems_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Constraints for table `erporders`
--
ALTER TABLE `erporders`
  ADD CONSTRAINT `erporders_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `holidays`
--
ALTER TABLE `holidays`
  ADD CONSTRAINT `holidays_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`);

--
-- Constraints for table `item_tracker`
--
ALTER TABLE `item_tracker`
  ADD CONSTRAINT `item_tracker_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `item_tracker_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `item_tracker_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `journals_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `kins`
--
ALTER TABLE `kins`
  ADD CONSTRAINT `kins_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `leaveapplications`
--
ALTER TABLE `leaveapplications`
  ADD CONSTRAINT `leaveapplications_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `leaveapplications_leavetype_id_foreign` FOREIGN KEY (`leavetype_id`) REFERENCES `leavetypes` (`id`),
  ADD CONSTRAINT `leaveapplications_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`);

--
-- Constraints for table `leavetypes`
--
ALTER TABLE `leavetypes`
  ADD CONSTRAINT `leavetypes_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`);

--
-- Constraints for table `loanaccounts`
--
ALTER TABLE `loanaccounts`
  ADD CONSTRAINT `loanaccounts_loanproduct_id_foreign` FOREIGN KEY (`loanproduct_id`) REFERENCES `loanproducts` (`id`),
  ADD CONSTRAINT `loanaccounts_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `loanguarantors`
--
ALTER TABLE `loanguarantors`
  ADD CONSTRAINT `loanguarantors_loanaccount_id_foreign` FOREIGN KEY (`loanaccount_id`) REFERENCES `loanaccounts` (`id`),
  ADD CONSTRAINT `loanguarantors_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `loanpostings`
--
ALTER TABLE `loanpostings`
  ADD CONSTRAINT `loanpostings_loanproduct_id_foreign` FOREIGN KEY (`loanproduct_id`) REFERENCES `loanproducts` (`id`);

--
-- Constraints for table `loanrepayments`
--
ALTER TABLE `loanrepayments`
  ADD CONSTRAINT `loanrepayments_loanaccount_id_foreign` FOREIGN KEY (`loanaccount_id`) REFERENCES `loanaccounts` (`id`);

--
-- Constraints for table `loantransactions`
--
ALTER TABLE `loantransactions`
  ADD CONSTRAINT `loantransactions_loanaccount_id_foreign` FOREIGN KEY (`loanaccount_id`) REFERENCES `loanaccounts` (`id`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `members_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

--
-- Constraints for table `paymentmethods`
--
ALTER TABLE `paymentmethods`
  ADD CONSTRAINT `paymentmethods_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`);

--
-- Constraints for table `savingaccounts`
--
ALTER TABLE `savingaccounts`
  ADD CONSTRAINT `savingaccounts_fk` FOREIGN KEY (`savingproduct_id`) REFERENCES `savingproducts` (`id`),
  ADD CONSTRAINT `savingaccounts_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `savingpostings`
--
ALTER TABLE `savingpostings`
  ADD CONSTRAINT `savingpostings_savingproduct_id_foreign` FOREIGN KEY (`savingproduct_id`) REFERENCES `savingproducts` (`id`);

--
-- Constraints for table `savingtransactions`
--
ALTER TABLE `savingtransactions`
  ADD CONSTRAINT `savingtransactions_savingaccount_id_foreign` FOREIGN KEY (`savingaccount_id`) REFERENCES `savingaccounts` (`id`);

--
-- Constraints for table `shareaccounts`
--
ALTER TABLE `shareaccounts`
  ADD CONSTRAINT `shareaccounts_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `sharetransactions`
--
ALTER TABLE `sharetransactions`
  ADD CONSTRAINT `sharetransactions_shareaccount_id_foreign` FOREIGN KEY (`shareaccount_id`) REFERENCES `shareaccounts` (`id`);

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_fk` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_role_fk1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
