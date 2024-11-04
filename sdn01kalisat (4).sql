-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 04, 2024 at 03:16 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sdn01kalisat`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_admin`
--

CREATE TABLE `tb_admin` (
  `admin_id` int NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_admin`
--

INSERT INTO `tb_admin` (`admin_id`, `nama`, `email`, `password`) VALUES
(1, 'admin', 'admin@gmail.com', 'f865b53623b121fd34ee5426c792e5c33af8c227');

-- --------------------------------------------------------

--
-- Table structure for table `tb_berita`
--

CREATE TABLE `tb_berita` (
  `berita_id` int NOT NULL,
  `judul` varchar(50) NOT NULL,
  `konten` text NOT NULL,
  `tanggal` date NOT NULL,
  `admin_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_guru`
--

CREATE TABLE `tb_guru` (
  `guru_id` int NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_hp` int NOT NULL,
  `jabatan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_guru`
--

INSERT INTO `tb_guru` (`guru_id`, `nama`, `email`, `password`, `nomor_hp`, `jabatan`) VALUES
(1, 'fadil', 'fadil@gmail.com', 'b2dc64b140354acaa798d6ec5288593ef18a9e02', 857484856, 'walikelas');

-- --------------------------------------------------------

--
-- Table structure for table `tb_hasil_latihan`
--

CREATE TABLE `tb_hasil_latihan` (
  `hasil_id` int NOT NULL,
  `soal_id` int DEFAULT NULL,
  `siswa_id` int DEFAULT NULL,
  `jawaban` char(1) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tanggal_pengumpulan` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_jadwal`
--

CREATE TABLE `tb_jadwal` (
  `jadwal_id` int NOT NULL,
  `hari` varchar(10) NOT NULL,
  `jam_mulai` time(6) NOT NULL,
  `jam_selesai` time(6) NOT NULL,
  `mapel_id` int NOT NULL,
  `guru_id` int NOT NULL,
  `kelas_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_kelas`
--

CREATE TABLE `tb_kelas` (
  `kelas_id` int NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `tahun_ajaran` varchar(15) NOT NULL,
  `guru_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_kelas`
--

INSERT INTO `tb_kelas` (`kelas_id`, `nama_kelas`, `tahun_ajaran`, `guru_id`) VALUES
(1, '1A', '2024', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_kursus`
--

CREATE TABLE `tb_kursus` (
  `kursus_id` int NOT NULL,
  `nama_kursus` varchar(50) NOT NULL,
  `deskripsi` text,
  `kode_kursus` varchar(10) DEFAULT NULL,
  `jadwal_mulai` datetime DEFAULT NULL,
  `jadwal_selesai` datetime DEFAULT NULL,
  `guru_id` int DEFAULT NULL,
  `mapel_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_latihan_soal`
--

CREATE TABLE `tb_latihan_soal` (
  `soal_id` int NOT NULL,
  `mapel_id` int DEFAULT NULL,
  `guru_id` int DEFAULT NULL,
  `pertanyaan` text,
  `opsi_a` varchar(50) DEFAULT NULL,
  `opsi_b` varchar(50) DEFAULT NULL,
  `opsi_c` varchar(50) DEFAULT NULL,
  `opsi_d` varchar(50) DEFAULT NULL,
  `jawaban_benar` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_mapel`
--

CREATE TABLE `tb_mapel` (
  `mapel_id` int NOT NULL,
  `nama_mapel` varchar(20) NOT NULL,
  `level_mapel` int NOT NULL,
  `keterangan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_pengumpulan_tugas`
--

CREATE TABLE `tb_pengumpulan_tugas` (
  `pengumpulan_id` int NOT NULL,
  `tugas_id` int DEFAULT NULL,
  `siswa_id` int DEFAULT NULL,
  `file_tugas` varchar(100) DEFAULT NULL,
  `tanggal_pengumpulan` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_penilaian_tugas`
--

CREATE TABLE `tb_penilaian_tugas` (
  `penilaian_id` int NOT NULL,
  `pengumpulan_id` int DEFAULT NULL,
  `nilai` int DEFAULT NULL,
  `komentar` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_siswa`
--

CREATE TABLE `tb_siswa` (
  `siswa_id` int NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_hp` varchar(13) NOT NULL,
  `NISN` varchar(20) NOT NULL,
  `kelas_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_siswa`
--

INSERT INTO `tb_siswa` (`siswa_id`, `nama`, `email`, `password`, `nomor_hp`, `NISN`, `kelas_id`) VALUES
(1, 'siswa', 'siswa@gmail.com', 'd2f1388066ebe854b0aa742fd9b7639975fdd516', '085748485612', '21231546454', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_siswa_kursus`
--

CREATE TABLE `tb_siswa_kursus` (
  `id` int NOT NULL,
  `kursus_id` int DEFAULT NULL,
  `siswa_id` int DEFAULT NULL,
  `tanggal_bergabung` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_tugas`
--

CREATE TABLE `tb_tugas` (
  `tugas_id` int NOT NULL,
  `judul_tugas` varchar(50) NOT NULL,
  `deskripsi` text,
  `tanggal_deadline` date DEFAULT NULL,
  `mapel_id` int DEFAULT NULL,
  `kelas_id` int DEFAULT NULL,
  `guru_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `tb_berita`
--
ALTER TABLE `tb_berita`
  ADD PRIMARY KEY (`berita_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `tb_guru`
--
ALTER TABLE `tb_guru`
  ADD PRIMARY KEY (`guru_id`);

--
-- Indexes for table `tb_hasil_latihan`
--
ALTER TABLE `tb_hasil_latihan`
  ADD PRIMARY KEY (`hasil_id`),
  ADD KEY `soal_id` (`soal_id`),
  ADD KEY `siswa_id` (`siswa_id`);

--
-- Indexes for table `tb_jadwal`
--
ALTER TABLE `tb_jadwal`
  ADD PRIMARY KEY (`jadwal_id`),
  ADD KEY `mapel_id` (`mapel_id`),
  ADD KEY `guru_id` (`guru_id`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indexes for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD PRIMARY KEY (`kelas_id`),
  ADD KEY `guru_id` (`guru_id`);

--
-- Indexes for table `tb_kursus`
--
ALTER TABLE `tb_kursus`
  ADD PRIMARY KEY (`kursus_id`),
  ADD UNIQUE KEY `kode_kursus` (`kode_kursus`),
  ADD KEY `guru_id` (`guru_id`),
  ADD KEY `mapel_id` (`mapel_id`);

--
-- Indexes for table `tb_latihan_soal`
--
ALTER TABLE `tb_latihan_soal`
  ADD PRIMARY KEY (`soal_id`),
  ADD KEY `mapel_id` (`mapel_id`),
  ADD KEY `guru_id` (`guru_id`);

--
-- Indexes for table `tb_mapel`
--
ALTER TABLE `tb_mapel`
  ADD PRIMARY KEY (`mapel_id`);

--
-- Indexes for table `tb_pengumpulan_tugas`
--
ALTER TABLE `tb_pengumpulan_tugas`
  ADD PRIMARY KEY (`pengumpulan_id`),
  ADD KEY `tugas_id` (`tugas_id`),
  ADD KEY `siswa_id` (`siswa_id`);

--
-- Indexes for table `tb_penilaian_tugas`
--
ALTER TABLE `tb_penilaian_tugas`
  ADD PRIMARY KEY (`penilaian_id`),
  ADD KEY `pengumpulan_id` (`pengumpulan_id`);

--
-- Indexes for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD PRIMARY KEY (`siswa_id`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indexes for table `tb_siswa_kursus`
--
ALTER TABLE `tb_siswa_kursus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kursus_id` (`kursus_id`),
  ADD KEY `siswa_id` (`siswa_id`);

--
-- Indexes for table `tb_tugas`
--
ALTER TABLE `tb_tugas`
  ADD PRIMARY KEY (`tugas_id`),
  ADD KEY `mapel_id` (`mapel_id`),
  ADD KEY `kelas_id` (`kelas_id`),
  ADD KEY `guru_id` (`guru_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_admin`
--
ALTER TABLE `tb_admin`
  MODIFY `admin_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_berita`
--
ALTER TABLE `tb_berita`
  MODIFY `berita_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_guru`
--
ALTER TABLE `tb_guru`
  MODIFY `guru_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_hasil_latihan`
--
ALTER TABLE `tb_hasil_latihan`
  MODIFY `hasil_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_jadwal`
--
ALTER TABLE `tb_jadwal`
  MODIFY `jadwal_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  MODIFY `kelas_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_kursus`
--
ALTER TABLE `tb_kursus`
  MODIFY `kursus_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_latihan_soal`
--
ALTER TABLE `tb_latihan_soal`
  MODIFY `soal_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_mapel`
--
ALTER TABLE `tb_mapel`
  MODIFY `mapel_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_pengumpulan_tugas`
--
ALTER TABLE `tb_pengumpulan_tugas`
  MODIFY `pengumpulan_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_penilaian_tugas`
--
ALTER TABLE `tb_penilaian_tugas`
  MODIFY `penilaian_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  MODIFY `siswa_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_siswa_kursus`
--
ALTER TABLE `tb_siswa_kursus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_tugas`
--
ALTER TABLE `tb_tugas`
  MODIFY `tugas_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_berita`
--
ALTER TABLE `tb_berita`
  ADD CONSTRAINT `tb_berita_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `tb_admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_hasil_latihan`
--
ALTER TABLE `tb_hasil_latihan`
  ADD CONSTRAINT `tb_hasil_latihan_ibfk_1` FOREIGN KEY (`soal_id`) REFERENCES `tb_latihan_soal` (`soal_id`),
  ADD CONSTRAINT `tb_hasil_latihan_ibfk_2` FOREIGN KEY (`siswa_id`) REFERENCES `tb_siswa` (`siswa_id`);

--
-- Constraints for table `tb_jadwal`
--
ALTER TABLE `tb_jadwal`
  ADD CONSTRAINT `tb_jadwal_ibfk_1` FOREIGN KEY (`mapel_id`) REFERENCES `tb_mapel` (`mapel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_jadwal_ibfk_2` FOREIGN KEY (`guru_id`) REFERENCES `tb_guru` (`guru_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_jadwal_ibfk_4` FOREIGN KEY (`kelas_id`) REFERENCES `tb_kelas` (`kelas_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD CONSTRAINT `tb_kelas_ibfk_1` FOREIGN KEY (`guru_id`) REFERENCES `tb_guru` (`guru_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_kursus`
--
ALTER TABLE `tb_kursus`
  ADD CONSTRAINT `tb_kursus_ibfk_1` FOREIGN KEY (`guru_id`) REFERENCES `tb_guru` (`guru_id`),
  ADD CONSTRAINT `tb_kursus_ibfk_2` FOREIGN KEY (`mapel_id`) REFERENCES `tb_mapel` (`mapel_id`);

--
-- Constraints for table `tb_latihan_soal`
--
ALTER TABLE `tb_latihan_soal`
  ADD CONSTRAINT `tb_latihan_soal_ibfk_1` FOREIGN KEY (`mapel_id`) REFERENCES `tb_mapel` (`mapel_id`),
  ADD CONSTRAINT `tb_latihan_soal_ibfk_2` FOREIGN KEY (`guru_id`) REFERENCES `tb_guru` (`guru_id`);

--
-- Constraints for table `tb_pengumpulan_tugas`
--
ALTER TABLE `tb_pengumpulan_tugas`
  ADD CONSTRAINT `tb_pengumpulan_tugas_ibfk_1` FOREIGN KEY (`tugas_id`) REFERENCES `tb_tugas` (`tugas_id`),
  ADD CONSTRAINT `tb_pengumpulan_tugas_ibfk_2` FOREIGN KEY (`siswa_id`) REFERENCES `tb_siswa` (`siswa_id`);

--
-- Constraints for table `tb_penilaian_tugas`
--
ALTER TABLE `tb_penilaian_tugas`
  ADD CONSTRAINT `tb_penilaian_tugas_ibfk_1` FOREIGN KEY (`pengumpulan_id`) REFERENCES `tb_pengumpulan_tugas` (`pengumpulan_id`);

--
-- Constraints for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD CONSTRAINT `tb_siswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `tb_kelas` (`kelas_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_siswa_kursus`
--
ALTER TABLE `tb_siswa_kursus`
  ADD CONSTRAINT `tb_siswa_kursus_ibfk_1` FOREIGN KEY (`kursus_id`) REFERENCES `tb_kursus` (`kursus_id`),
  ADD CONSTRAINT `tb_siswa_kursus_ibfk_2` FOREIGN KEY (`siswa_id`) REFERENCES `tb_siswa` (`siswa_id`);

--
-- Constraints for table `tb_tugas`
--
ALTER TABLE `tb_tugas`
  ADD CONSTRAINT `tb_tugas_ibfk_1` FOREIGN KEY (`mapel_id`) REFERENCES `tb_mapel` (`mapel_id`),
  ADD CONSTRAINT `tb_tugas_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `tb_kelas` (`kelas_id`),
  ADD CONSTRAINT `tb_tugas_ibfk_3` FOREIGN KEY (`guru_id`) REFERENCES `tb_guru` (`guru_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
