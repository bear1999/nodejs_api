-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 14, 2021 lúc 05:53 PM
-- Phiên bản máy phục vụ: 10.4.13-MariaDB
-- Phiên bản PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `train01`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPhone` (IN `email` VARCHAR(20), OUT `sdt` VARCHAR(20))  BEGIN
  SELECT NumberPhone FROM `user` WHERE Email = email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrInsert` (IN `_nameProduct` VARCHAR(30), IN `_codeProduct` VARCHAR(20), IN `_amountProduct` INT, IN `_priceProduct` DECIMAL(11,0))  BEGIN
	DECLARE count INT DEFAULT 0;
  SET count = (SELECT idProduct FROM `product` WHERE codeProduct = _codeProduct);
	IF count > 0 THEN
		UPDATE `product` SET nameProduct = _nameProduct, amountProduct = amountProduct + _amountProduct, priceProduct = _priceProduct 
		WHERE codeProduct = _codeProduct;
	ELSE
		INSERT INTO `product` (nameProduct, codeProduct, amountProduct, priceProduct) VALUES (_nameProduct, _codeProduct, _amountProduct, _priceProduct);
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrRemove` (IN `_nameProduct` VARCHAR(30), IN `_codeProduct` VARCHAR(20), IN `_amountProduct` INT, IN `_priceProduct` DECIMAL(11,0))  BEGIN
	DECLARE count INT DEFAULT 0;
  SET count = (SELECT idProduct FROM `product` WHERE codeProduct = _codeProduct);
	IF count > 0 THEN
		UPDATE `product` SET nameProduct = _nameProduct, amountProduct = amountProduct + _amountProduct, priceProduct = _priceProduct 
		WHERE codeProduct = _codeProduct;
	ELSE
		INSERT INTO `product` (nameProduct, codeProduct, amountProduct, priceProduct) VALUES (_nameProduct, _codeProduct, _amountProduct, _priceProduct);
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `position`
--

CREATE TABLE `position` (
  `IdPosition` int(11) NOT NULL,
  `namePosition` varchar(40) DEFAULT NULL,
  `groupPosition` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `position`
--

INSERT INTO `position` (`IdPosition`, `namePosition`, `groupPosition`) VALUES
(1, 'Khách hàng', 1),
(2, 'Quản lý', 2),
(3, 'Kinh doanh', 2),
(4, 'Admin', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL,
  `nameProduct` varchar(30) DEFAULT NULL,
  `codeProduct` varchar(20) DEFAULT NULL,
  `amountProduct` int(11) DEFAULT NULL,
  `priceProduct` decimal(11,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`idProduct`, `nameProduct`, `codeProduct`, `amountProduct`, `priceProduct`) VALUES
(1, 'Chanh dây', 'CD001', 6, '15000'),
(2, 'Cafe Sữa', 'CF001', 1, '14000'),
(3, 'Cafe Đen', 'CF002', 2, '10000'),
(5, 'Chanh đà lạt', 'CD005', 10, '15000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `store`
--

CREATE TABLE `store` (
  `idStore` int(11) NOT NULL,
  `nameStore` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `store`
--

INSERT INTO `store` (`idStore`, `nameStore`) VALUES
(1000, 'Cửa hàng 1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `IDUser` int(11) NOT NULL,
  `Username` varchar(35) DEFAULT NULL,
  `Gender` varchar(6) DEFAULT NULL,
  `Email` varchar(70) DEFAULT NULL,
  `Password` varchar(60) DEFAULT NULL,
  `NumberPhone` varchar(16) DEFAULT NULL,
  `IdPosition` int(11) DEFAULT NULL,
  `imageAvatar` varchar(25) DEFAULT NULL,
  `idStore` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`IDUser`, `Username`, `Gender`, `Email`, `Password`, `NumberPhone`, `IdPosition`, `imageAvatar`, `idStore`) VALUES
(85, 'Ngoc Sy', 'Nam', 'bearof1999@gmail.com', '$2b$10$ihirGAiGBCTWd4ceGn6kguuk/YbPdAepA1OV/UQDWXdb8KuozjwQ6', '0586209147', 1, NULL, 1000),
(202, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$PiCkmzib0UtIRFUQnHmEjOqkidxxRYlHeiTfAEvHgSq/zBAqsa2iG', '6587987965', 1, '61189_1615476621073.png', 1000),
(203, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$PiCkmzib0UtIRFUQnHmEjOqkidxxRYlHeiTfAEvHgSq/zBAqsa2iG', '6587987965', 1, '61189_1615476621073.png', 1000),
(288, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$ajlNRuOVbU/iSaofo8eYsuTXtWuf6tpMIMR7a8DZJNMN8Td4UDRFq', '6587987965', 3, '87487_1616166092774.png', 1000),
(289, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$YALco4.JysgkyPc5FjCkWugPnfyMb/8Xl2MLeye63mMWsYMeq.YH6', '6587987965', 3, '14025_1616167020467.png', 1000),
(290, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$4VXKcnfA00.5SflnS1EX.eQQlkM0vGsOTxlnoMING2Nd2Pkhj3ike', '6587987965', 3, NULL, 1000),
(291, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$LXP50LZzajpONn/WzwwvpOi5fzKaVp8O3hPEKA9jGa.1jYYVzQwe6', '6587987965', 3, NULL, 1000),
(292, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$Wm5XlzWbmVQnxq88i06mtecFYZLXjqUs4W7Dppjo7Qz1zxc6CdqIa', '6587987965', 3, NULL, 1000),
(293, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$Et.DSHOQCd2CMp403Lz3cO7P1xeI/O.XVX9l/79UQbzwhFlL52R1a', '6587987965', 3, NULL, 1000),
(294, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$5FScGlmFeCKYoXrMfBSZ6uvLdO0ESNqsQqlvZLXUuqF7oQ/M4NgJ6', '6587987965', 3, '11936_1616167653522.png', 1000),
(295, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$BQpjAvYwvOWNlkWvwSlsHuAjDTMDHU50AdHUCP6sKugbF55iX.SNW', '6587987965', 3, '70568_1616168343061.png', 1000),
(296, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$wS6NfmNojODjfmQhApxSvuRuMz956ixv8N7pyPKiw/lbzAU6sjVty', '6587987965', 3, '51449_1616168346840.png', 1000),
(297, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$ckD7s/UMppmLU6sX3H/rkOAyNSB7UqjpnRdJpI23yw8oITEbOzSJq', '6587987965', 3, '105263_1616168962072.png', 1000),
(298, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$DzRtjlIwZBvwxtthXBgVPeRAnvYBiSoU/i7DBZ9hdy2FX4cYMvkLi', '6587987965', 3, '22350_1616169012962.png', 1000),
(299, 'Ha Cao', 'Nữ', 'hacao23@gmail.com', '$2b$10$oRFwsf4YHEEx8Jq0lg9fy.eLxrYzVEZ5lOgeO262/rRmXX2VlX5Aq', '6587987965', 3, '73069_1616169058223.png', 1000);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`IdPosition`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`idProduct`);

--
-- Chỉ mục cho bảng `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`idStore`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`IDUser`),
  ADD KEY `_Position` (`IdPosition`),
  ADD KEY `idStore` (`idStore`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `position`
--
ALTER TABLE `position`
  MODIFY `IdPosition` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `store`
--
ALTER TABLE `store`
  MODIFY `idStore` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `IDUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `_Position` FOREIGN KEY (`IdPosition`) REFERENCES `position` (`IdPosition`),
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`idStore`) REFERENCES `store` (`idStore`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
