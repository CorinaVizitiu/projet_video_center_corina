-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 27, 2023 at 12:42 PM
-- Server version: 5.7.36
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: ` video_center_corina_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230725073743', '2023-07-25 07:39:01', 25),
('DoctrineMigrations\\Version20230725074602', '2023-07-25 07:47:11', 40),
('DoctrineMigrations\\Version20230731091810', '2023-07-31 11:21:39', 57),
('DoctrineMigrations\\Version20230801143922', '2023-08-01 16:40:18', 212),
('DoctrineMigrations\\Version20230808115833', '2023-08-08 13:58:55', 115),
('DoctrineMigrations\\Version20230808122837', '2023-08-08 14:29:20', 129),
('DoctrineMigrations\\Version20230810125053', '2023-08-10 14:51:38', 92);

-- --------------------------------------------------------

--
-- Table structure for table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  `is_verified` tinyint(1) NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `is_verified`, `image_name`, `image_size`) VALUES
(1, 'corina.vizitiu@yahoo.com', '[]', '$2y$13$D9TNIQefiESMMX3ErQ0ts.oWFNaOgwElwumS.nAFcMO.89F675RJ6', 'Corina', 'Vizitiu', '2023-07-31 11:13:07', '2023-08-10 14:55:49', 1, 'r-64d4de5522527520503330.jpeg', 142996),
(2, 'ecaterina.vizitiu@yahoo.ro', '[]', '$2y$13$i2DEODRpcYoeZ9jboHIzT.rp.1nm0HHw4JxRWYbFiGebO.jdWlYLO', 'Ecaterina', 'Vizitiu', '2023-07-31 11:13:07', '2023-08-21 14:04:46', 1, 'default-64e352deb8662285345544.jpg', 5434),
(3, 'vasile.vizitiu@yahoo.com', '[]', '$2y$13$sZZPZGDS6VmddwAq1QD1ju/If4dR7r4k7PCwS/RmEuIoer/20KMJG', 'vasile', 'vizitiu', '2023-08-01 17:33:28', '2023-08-01 17:34:17', 0, NULL, NULL),
(5, 'ana.maria@yahoo.com', '[]', '$2y$13$xauqTvfFJvt9E78BZM3NkepQTw6LmQ.tbs0nxZL6B9pwpcznccdxC', 'ana', 'maria', '2023-08-10 15:02:25', '2023-08-10 15:06:11', 1, 'anasmith-64d4e0c3eca74281337495.jpg', 83011);

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_link` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `user_id` int(11) NOT NULL,
  `premium_video` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29AA6432A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `user_id`, `premium_video`) VALUES
(2, 'Bella Santiago-Linistea', 'https://www.youtube.com/embed/s6Uko__5ocQ', 'Booking & Management:\r\nbooking@bella-santiago.com | https://www.bella-santiago.com/\r\n\r\nSubscribe la canalul de Youtube:\r\n  \r\n\r\n / @resciebelle01   \r\nSpotify : https://open.spotify.com/artist/7p6wh...\r\nApple Music: https://music.lnk.to/7WfCqG', '2023-07-29 18:07:40', '2023-07-29 18:11:37', 2, 0),
(3, 'Stefania - Soarele meu', 'https://www.youtube.com/embed/kjqRJb2ycQk', 'Follow #Stefania:\r\nFacebook: http://www.facebook.com/cristinastefa...\r\nInstagram: https://www.instagram.com/cristinaa.s...\r\nSpotify: https://spoti.fi/2oEubTF', '2023-08-08 10:47:52', '2023-08-08 10:47:52', 5, 0),
(4, 'MIRA x VESCAN - Alo, Alo', 'https://www.youtube.com/embed/dDPcPm3y4yU', '🎵 Descarcă sau ascultă „Alo, Alo” aici: https://bfan.link/alo-alo-2\r\n📱 Creează un TikTok viral pe piesă: https://vm.tiktok.com/ZGJ4HXUCL/\r\n🔔 Abonează-te la canalul meu: https://bit.ly/SubscribeMIRA', '2023-08-08 16:04:18', '2023-08-12 13:51:19', 1, 1),
(5, 'Florin Ristei - Aripile', 'https://www.youtube.com/embed/67uMT9-2zvc', 'qsdfghjklmùmmùlmkljkhgjfhdgsfq', '2023-08-16 09:17:52', '2023-08-20 13:22:31', 1, 0),
(6, 'Mi-e frica sa mai vorbesc', 'https://www.youtube.com/embed/6-20h1wsL4g', 'Management & Sales:\r\nMonica Munteanu | monica.munteanu22@gmail.com \r\nGiovanni Francesco | giovanni.francesco@gmail.com', '2023-08-20 14:23:15', '2023-08-22 10:36:59', 1, 1),
(7, 'Andrei Banuta - Jur, Te Voi Iubi', 'https://www.youtube.com/embed/JFYCEQA1Qyk', '2,5 mil. de vizionări  acum 1 lună  #AndreiBanuta #MattmanMusic\r\nMi-am dorit mult sa fac varianta in romana pentru piesa \r\n“Hoy Tengo Ganas de Ti” pentru ca este una dintre piesele cu care am crescut.', '2023-08-20 15:28:24', '2023-08-20 15:28:24', 1, 0),
(8, 'O iubire de-o vară', 'https://www.youtube.com/embed/O_F81cMR7Yw', 'Noul single al trupei Monday Shadows ce va fi prezent pe al doilea album.\r\n\r\nVă mulțumim foarte mult pentru susținere și abia așteptăm să ne vedem la concerte !\r\n\r\nRock on ! \\m/', '2023-08-20 15:29:56', '2023-08-22 10:37:29', 1, 0),
(9, 'Jain - Makeba', 'https://www.youtube.com/embed/z7hyiWAIWkQ', 'Follow Jain:\r\nFacebook : https://www.facebook.com/JAINMUSIC \r\nTwitter : https://twitter.com/jainmusic \r\nInstagram : https://www.instagram.com/jainmusic/ \r\nOfficial website : http://www.jain-music.com', '2023-08-20 15:32:16', '2023-08-20 15:32:16', 2, 0),
(10, 'Tiësto - Lay Low', 'https://www.youtube.com/embed/-aLC2RiCXws', 'Had a blast making this one! A tad bit more energetic than my usual stuff but this is a sneak peek of the style I\'m currently heading towards.\r\nHope you all enjoy!', '2023-08-20 15:34:34', '2023-08-22 10:40:45', 2, 0),
(11, 'Baby Don\'t Hurt Me', 'https://www.youtube.com/embed/mSj3isHutro', '24.816 vizionări  28 apr. 2023\r\nProvided to YouTube by DistroKid\r\n\r\nBaby Don\'t Hurt Me · J3icob\r\n\r\nBaby Don\'t Hurt Me', '2023-08-20 15:36:14', '2023-08-20 15:36:14', 5, 0),
(12, 'Mira x Lora - Eu singura', 'https://www.youtube.com/embed/T4UwLTCbbHw', '94.595 de vizionări  23 iul. 2023  #Mira #Lora\r\n#Mira #Lora #TuCuEa', '2023-08-21 13:24:57', '2023-08-21 13:24:57', 5, 1),
(13, 'Dj Sava, MD Dj, Adriana Onci - Bora Bora (Official', 'https://www.youtube.com/embed/tRCxYYTUX_Q', 'Follow @DjSavaOfficial \r\nFacebook: https://www.facebook.com/DjSavaOfficial/\r\nInstagram: https://www.instagram.com/djsava/', '2023-08-21 13:26:28', '2023-08-21 13:26:28', 5, 1),
(14, 'Misha Miller x Sasha Lopez - Mahala', 'https://www.youtube.com/embed/NYxoAgOgjaw', '5,8 mil. de vizionări  acum 9 luni  #MishaMiller #Mahala #SashaLopez\r\nSubscribe to @MishaMiller YouTube Channel🔔:   \r\n\r\n / @mishamiller  \r\nCreate a viral TikTok on the track📱: https://www.tiktok.com/music/Mahala-7...', '2023-08-21 13:34:08', '2023-08-21 13:34:08', 5, 1),
(15, 'Calvin Harris - Desire', 'https://www.youtube.com/embed/uRRP0K0wjwE', '7.363 de vizionări  14 aug. 2023\r\nSubscribe and press (🔔) to join the notification squad and stay updated with new uploads', '2023-08-21 13:38:04', '2023-08-21 13:38:04', 5, 1),
(16, 'Barbie - Ryan Gosling Performs \"I\'m Just Ken\"', 'https://www.youtube.com/embed/meZbLQMR8rE', 'About E! News:\r\nThe E! News team brings you the latest breaking entertainment, fashion and Pop Culture news. Featuring exclusive segments, celebrity highlights, trend reports and more, the E! News channel is the only destination Pop Culture fans need to stay in the know.', '2023-08-21 13:41:24', '2023-08-21 13:41:24', 1, 1),
(17, 'Jungle - Back On 74', 'https://www.youtube.com/embed/q3lX2p_Uy9I', '1 mil. de vizionări  acum 10 zile  #jungle #volcano #jungle4eva\r\nOfficial Video for \"Back On 74\" by Jungle from the new studio album, Volcano.', '2023-08-21 13:43:49', '2023-08-21 13:43:49', 1, 1),
(18, 'Salvatore Ganacci - Your Mother', 'https://www.youtube.com/embed/KqTGdXfNmA8', '163.100 de vizionări  18 aug. 2023\r\nOfficial Music Video for Salvatore Ganacci - Your Mother\r\nListen to Your Mother here: https://mdlbeast.lnk.to/your-mother', '2023-08-21 13:46:13', '2023-08-21 13:46:13', 2, 1),
(19, 'Jumping the Gun', 'https://www.youtube.com/embed/z7AhEFt6MAk', 'Jumping the Gun · Kayla DiVenere · Cooper Holzman · Cal Shapiro · Kayla DiVenere\r\n\r\nJumping the Gun\r\n\r\n℗ Sound Factory Records\r\n\r\nReleased on: 2023-08-11', '2023-08-21 13:48:06', '2023-08-21 13:48:06', 2, 1),
(20, 'Barbara Palvin\'s and Dylan Sprouse Wedding | Hunga', 'https://www.youtube.com/embed/0QMJImxUoGA', '819 K de vizionări  acum 4 săptămâni  HUNGARY\r\nFollow me: https://www.instagram.com/koduriprana... & Hit Susbcribe', '2023-08-21 13:49:43', '2023-08-21 13:49:43', 2, 1),
(21, 'Sia - We Can Hurt Together', 'https://www.youtube.com/embed/tFVhJ4_fr5A', '1.706.883 de vizionări  11 oct. 2022\r\nSia - We Can Hurt Together LYRICS\r\nYou say you are fine\r\nBut I see pain\r\nBehind those eyes', '2023-08-21 13:52:07', '2023-08-21 13:52:07', 2, 1),
(22, 'Anti-boredom campaign', 'https://www.youtube.com/embed/dluvin9c4K4', '7.334 de vizionări  28 mar. 2011\r\nCampania antiplictiseala initiata de Antena1 acum cativa ani', '2023-08-25 09:45:03', '2023-08-25 09:45:03', 1, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_29AA6432A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
