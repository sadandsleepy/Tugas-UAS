-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 27, 2022 at 11:32 PM
-- Server version: 5.7.38-cll-lve
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `niobesad_ignite4`
--

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id` int(11) NOT NULL,
  `nama` varchar(64) NOT NULL,
  `jurusan` varchar(128) NOT NULL,
  `nim` bigint(32) NOT NULL,
  `jenis_kelamin` varchar(64) NOT NULL,
  `alamat` varchar(128) NOT NULL,
  `picture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id`, `nama`, `jurusan`, `nim`, `jenis_kelamin`, `alamat`, `picture`) VALUES
(1, 'Candra', 'Teknik Informatika', 20190801153, 'laki-laki', 'Jl. Kampung Irian I, Gg. 15, No. 4', 'https://tugasuascrud.niobesad.xyz/imgs/example.png'),
(3, 'Marcopollo', 'Teknik Informatika', 20190801154, 'laki-laki', 'Jalan Toram 1', 'https://tugasuascrud.niobesad.xyz/imgs/scaled_image_picker689390024836685467.jpg'),
(6, 'Dhea Devita Oktaryana', 'Teknik Informatika', 20190801135, 'Perempuan', 'Jalan Jambu', 'https://tugasuascrud.niobesad.xyz/imgs/scaled_image_picker1766343997925190346.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
