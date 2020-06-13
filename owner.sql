-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2020 at 11:33 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `owner`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PropertyAddOrEdit` (IN `_PropId` INT(100), IN `_UserId` INT(100), IN `_PropDetails` VARCHAR(500), IN `_PropAddress` VARCHAR(200), IN `_PropArea` INT(10), IN `_PropAreaD` VARCHAR(10), IN `_PropCovered` VARCHAR(100), IN `_PropLeaseType` VARCHAR(100), IN `_PropServices` VARCHAR(100), IN `_PropDocuments` TEXT, IN `_PropVerification` VARCHAR(100), IN `_PropAvailable` VARCHAR(100), IN `_PropImage` TEXT)  BEGIN
	IF _PropId = 0 THEN
		INSERT INTO `property`(`propId`,`userId`,`propDetails`, `propAddress`, `propArea`, `propAreaD`, `propCovered`, `propLeaseType`, `propServices`, `propDocuments`, `propVerification`, `propAvailable`, `propImage`)
        VALUES (_PropId,_UserId,_PropDetails,_PropAddress,_PropArea,_PropAreaD,_PropCovered,_PropLeaseType,_PropServices,_PropDocuments,_PropVerification,_PropAvailable,_PropImage);
	
        SET _PropId = LAST_INSERT_ID();
	ELSE
		UPDATE property
        SET
        `propId`= _PropId,
        `userId`= _UserId,
        `propDetails`= _PropDetails,
        `propAddress`= _PropAddress,
        `propArea`= _PropArea,
        `propAreaD`= _PropAreaD,
        `propCovered`= _PropCovered,
        `propLeaseType`= _PropLeaseType,
        `propServices`= _PropServices,
        `propDocuments`= _PropDocuments,
        `propVerification`= _PropVerification,
        `propAvailable`= _PropAvailable,
        `propImage`= _PropImage
        where propId = _PropId;
	END IF;
    
    SELECT _PropId AS 'propId';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `propId` int(100) NOT NULL,
  `userId` int(100) NOT NULL,
  `propDetails` varchar(500) NOT NULL,
  `propAddress` varchar(200) NOT NULL,
  `propArea` int(10) NOT NULL,
  `propAreaD` varchar(10) NOT NULL,
  `propCovered` varchar(100) NOT NULL,
  `propLeaseType` varchar(100) NOT NULL,
  `propServices` varchar(100) NOT NULL,
  `propDocuments` text NOT NULL,
  `propVerification` varchar(100) NOT NULL,
  `propAvailable` varchar(100) NOT NULL,
  `propImage` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`propId`, `userId`, `propDetails`, `propAddress`, `propArea`, `propAreaD`, `propCovered`, `propLeaseType`, `propServices`, `propDocuments`, `propVerification`, `propAvailable`, `propImage`) VALUES
(1, 0, 'Parking lot', 'Red Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg'),
(3, 0, 'Parking lot', 'Red Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg'),
(4, 0, 'Parking lot', 'Anantagiri Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg'),
(5, 0, 'Parking lot', 'Shah Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg'),
(6, 0, 'Parking lot', 'kutchi Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg'),
(7, 2, 'Parking lot', 'Blue Hills', 100, 'Sqft', 'Covered', 'Rental', 'Car wash center', 'doc.txt', 'Verified', 'Available', 'prop-img1.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`propId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `propId` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
