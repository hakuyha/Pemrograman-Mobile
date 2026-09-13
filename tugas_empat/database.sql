-- Database: db_penyedia_jasa
CREATE DATABASE IF NOT EXISTS `db_penyedia_jasa`;
USE `db_penyedia_jasa`;

-- Table structure for table `penyedia_jasa`
DROP TABLE IF EXISTS `penyedia_jasa`;
CREATE TABLE `penyedia_jasa` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(100) NOT NULL,
  `profesi` VARCHAR(150) NOT NULL,
  `harga` VARCHAR(100) NOT NULL,
  `bio` TEXT NOT NULL,
  `keahlian` JSON NOT NULL,
  `icon` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `penyedia_jasa`
INSERT INTO `penyedia_jasa` (`id`, `nama`, `profesi`, `harga`, `bio`, `keahlian`, `icon`, `created_at`) VALUES
(1, 'Harun Yahya', 'Mobile App Developer (Flutter)', 'Rp 3.500.000 / proyek', 'Spesialis pembuatan aplikasi mobile Android & iOS menggunakan Flutter. Berpengalaman dalam integrasi REST API, database lokal, dan publikasi aplikasi.', '["Flutter & Dart", "Integrasi API", "Firebase Setup"]', 'developer_mode', NOW()),
(2, 'Yahya Yahya', 'UI/UX Designer', 'Rp 1.500.000 / proyek', 'Menyediakan jasa desain antarmuka aplikasi dan website modern. Berfokus pada kemudahan interaksi pengguna (UX) dan desain visual yang elegan (UI).', '["Figma Design", "Wireframing & Prototyping", "Design System"]', 'design_services', NOW()),
(3, 'Harun Harun', 'Backend & Cloud Engineer', 'Rp 4.000.000 / proyek', 'Melayani pengembangan RESTful API berkinerja tinggi, manajemen database PostgreSQL/MySQL, serta konfigurasi server cloud & deployment.', '["REST API Architecture", "Database Optimization", "Cloud Server Setup"]', 'storage', NOW()),
(4, 'Siti Nurhaliza', 'Fullstack Web Developer', 'Rp 4.500.000 / proyek', 'Pengembangan aplikasi web end-to-end dengan React, Node.js, dan MySQL. Siap membantu pembuatan landing page, dashboard admin, hingga sistem e-commerce.', '["React.js", "Node.js", "Express & MySQL"]', 'code', NOW()),
(5, 'Budi Santoso', 'DevOps & Cyber Security', 'Rp 5.000.000 / proyek', 'Membantu otomatisasi CI/CD, manajemen server Linux, Docker containerization, dan pengujian penetrasi keamanan aplikasi.', '["Docker", "CI/CD Pipeline", "Linux Administration"]', 'security', NOW());
