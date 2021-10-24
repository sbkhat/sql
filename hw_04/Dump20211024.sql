CREATE DATABASE  IF NOT EXISTS `vk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vk`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: vk
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `admin_user_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'commodi',3),(2,'aut',3),(3,'itaque',2),(4,'consequuntur',3),(5,'optio',1);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint unsigned NOT NULL,
  `target_user_id` bigint unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') DEFAULT NULL,
  `requested_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,4,'unfriended','1978-07-31 10:20:18','1988-09-05 13:14:29'),(1,5,'requested','1996-01-11 21:25:02','2012-06-30 19:08:48'),(1,6,'unfriended','1996-02-23 14:40:19','1984-06-15 08:11:51'),(2,3,'declined','1981-06-20 05:03:12','1970-05-30 04:10:17'),(2,4,'approved','1974-08-02 06:38:22','1975-03-31 17:30:12'),(2,5,'unfriended','1979-09-03 01:08:17','2019-05-30 07:59:25'),(3,4,'unfriended','1975-06-15 00:13:45','1970-09-10 22:38:23'),(3,6,'approved','1997-04-30 03:30:26','1992-11-09 11:04:31'),(3,7,'approved','1981-11-20 11:51:26','2007-08-01 16:03:22'),(3,8,'unfriended','2018-01-11 19:02:14','1986-10-30 05:23:19');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `likes_fk` (`media_id`),
  KEY `likes_fk_1` (`user_id`),
  CONSTRAINT `likes_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `likes_fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,6,2,'1998-02-25 23:20:18'),(2,1,1,'1979-03-21 18:27:27'),(3,9,2,'1986-06-10 02:05:07'),(4,6,2,'1984-03-07 17:32:14'),(5,9,1,'1979-09-16 05:12:03'),(6,7,1,'2000-04-22 08:40:00'),(7,6,1,'2009-06-06 00:05:32'),(8,7,2,'2019-09-29 09:12:24'),(9,9,2,'2015-11-28 07:44:17'),(10,2,1,'2000-04-04 19:05:04');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `body` text,
  `filename` varchar(255) DEFAULT NULL,
  `size` int DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,2,3,'Sunt sit necessitatibus et illo hic quisquam quia. Sunt itaque voluptas quis mollitia omnis.','eum',70946293,NULL,'1978-01-07 13:19:07','1983-01-13 00:33:37'),(2,1,10,'Qui eos officiis odio. Nostrum et officia quae porro voluptas. Mollitia labore ex fugit sed.','mollitia',78813191,NULL,'1985-08-22 10:04:32','1999-11-19 01:44:48'),(3,2,5,'Ut dolores et in esse. Vel officiis tempore fugiat cumque distinctio. Dolor maxime aut vitae doloremque. Et officiis tempore quia et.','ut',0,NULL,'2006-10-01 17:09:32','2013-08-01 21:24:50'),(4,2,10,'Tempore tempore ut optio cumque beatae omnis. Ipsam et rerum et quod ipsa. Ea suscipit culpa temporibus quia consectetur maiores ea. Natus ea saepe nobis.','nulla',43,NULL,'2021-04-10 21:34:42','2010-11-11 02:51:33'),(5,2,10,'Dolores illum vitae odio unde vero non consectetur est. Veritatis dignissimos unde deserunt animi voluptatibus laborum nobis. Veniam alias ea dolor aut et hic dolorum. Eum iure et et error. Laborum doloremque laborum id commodi facilis.','corporis',0,NULL,'2002-02-02 03:44:41','1987-07-03 00:15:09'),(6,2,4,'Autem dicta harum ducimus molestiae. Nam officia enim commodi vel et. Dolorem ipsa quidem architecto dolorum harum in ea. Esse tempora quidem officia.','explicabo',7079,NULL,'1971-05-26 16:33:57','2004-06-09 20:45:13'),(7,1,6,'Porro dolore ut numquam. Aliquid a error quibusdam aut eos. Ut vel molestiae aliquid in molestias.','numquam',6,NULL,'2015-02-16 15:51:30','2008-11-08 14:38:56'),(8,2,5,'Et tenetur soluta reiciendis dolorum blanditiis optio. Soluta quas distinctio et quisquam ut. Porro qui aperiam libero ad ex ut. Vel voluptatem perferendis voluptates aut.','aut',80772646,NULL,'1994-03-18 17:36:39','1972-05-01 20:27:11'),(9,1,7,'Reiciendis recusandae blanditiis ut. Neque consequatur similique harum temporibus est. Ipsa velit esse reprehenderit iste molestias officia accusantium.','aspernatur',147,NULL,'2012-07-16 17:01:06','2013-12-16 04:27:18'),(10,1,5,'Itaque non eius ut omnis repudiandae quia perferendis. Aspernatur sint voluptates repudiandae tempora consequatur. Molestias delectus illo qui soluta. Praesentium consequatur aspernatur voluptatem molestiae doloribus aliquid sint. Aut vitae et maxime soluta.','iste',0,NULL,'1975-05-11 17:59:27','1990-04-11 09:26:33');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'aut','2013-02-20 00:19:33','2017-02-05 01:47:25'),(2,'qui','1990-06-08 11:02:28','2020-05-03 02:08:19'),(3,'officia','1983-08-05 01:53:05','1982-03-09 08:15:37'),(4,'molestias','2008-06-22 08:43:39','1973-10-01 15:29:09'),(5,'inventore','1989-11-07 18:24:12','2004-11-02 02:50:24');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `body` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,3,10,'Cum et dolor eaque autem laborum voluptatem est. Nostrum aut expedita impedit veniam dolorem aut eos. Ab ullam nisi autem laborum possimus. Aut esse repellat beatae sit illo soluta nulla.','1996-05-28 13:39:36'),(2,3,1,'Nemo ut voluptate quo maxime praesentium vero harum. Minus repellat unde sunt voluptatem accusantium. Ex delectus aut ea ratione hic minus. Qui ipsam odit sint facere aperiam nam illo quia.','1988-05-23 02:34:17'),(3,8,6,'Aut dicta magni omnis ut voluptates qui. Occaecati eligendi ut nisi. Vitae optio quos porro commodi delectus sapiente dolore rem. Reiciendis rem hic voluptatem facilis sit ut saepe.','1973-07-02 02:54:11'),(4,5,5,'Nostrum aut eaque deleniti sit asperiores atque quas repellat. Voluptates quaerat exercitationem vel ut. Architecto labore nisi enim non et inventore. Vel ad nostrum laudantium sed.','2012-10-20 22:34:18'),(5,9,9,'Rerum quos ratione quia optio id consequuntur. Officia quod sunt est quibusdam.','1980-09-15 21:38:28'),(6,8,8,'Vel accusamus amet qui voluptas asperiores. Rerum quis id velit rerum ullam officia ut. Suscipit et et et eveniet vero voluptate. Qui vel voluptas error ut dolore.','1991-06-13 02:42:32'),(7,5,1,'Totam qui est consequuntur sunt nesciunt. Et vero cumque aut non excepturi. Veritatis beatae perferendis architecto est.','1977-12-02 02:24:51'),(8,4,9,'Debitis voluptatem voluptatem qui corporis sit quod facere qui. Deleniti sunt aut ex aut ut. Reprehenderit iusto aliquam omnis et.','2019-11-25 23:41:31'),(9,7,8,'Similique voluptatum laborum quis sunt velit assumenda ipsam. Hic ut veniam voluptatem maxime voluptate quia. Expedita odio et earum quidem qui.','2000-09-13 12:20:09'),(10,9,6,'Consequuntur expedita sit voluptatem a quo sit. Laborum rem consequuntur veritatis sed. In voluptas fugit voluptas quia doloremque voluptas. Fugiat officia labore et eum.','1983-11-10 17:55:03'),(11,5,9,'Voluptatibus aut alias molestias repellat voluptatem. Quibusdam est placeat aut quisquam aut ab. Qui sit ab reiciendis libero iure. Fugit architecto nemo beatae totam aperiam nam eius.','2015-01-08 06:32:52'),(12,9,9,'Nobis veritatis architecto labore tempora aut impedit necessitatibus velit. Cupiditate tenetur deleniti dolorem sint a ipsa. Quas quis id dolorem incidunt. Sunt minus deserunt id nesciunt rerum totam eius dolores.','2020-05-20 07:50:36'),(13,10,4,'Sint sunt doloremque corrupti quidem. Quasi enim est eum error incidunt. In velit et est esse a illum.','1981-03-23 02:47:15'),(14,3,9,'Nobis aut fugit facere necessitatibus nisi quia. Occaecati exercitationem eius omnis delectus esse et est. Culpa sit culpa aliquid iure deserunt. Laborum neque culpa qui aliquam. Sed amet fugit soluta qui corporis.','2004-04-30 06:51:18'),(15,9,10,'Doloribus dolorem commodi molestiae voluptate at vel laudantium. Voluptatibus enim asperiores quia est accusamus doloribus. Autem quae consequatur rem quia. Ut delectus repellendus quia occaecati voluptatem dolorem. Rerum perspiciatis est aperiam beatae facere beatae.','2007-02-24 20:28:24'),(16,9,4,'Temporibus nisi reiciendis beatae necessitatibus. Hic possimus voluptas tempore cumque et. Eos quisquam quia dolor architecto repellat vitae iure ipsum. Tempora dolores autem eum unde excepturi.','1979-03-21 10:57:52'),(17,3,10,'Quo consequuntur officia quaerat et. Blanditiis fuga necessitatibus consequatur dolor optio. Ea velit reprehenderit aut asperiores aspernatur qui. Nostrum inventore qui inventore eius. Aut minima rerum distinctio sapiente.','2021-06-07 17:26:38'),(18,8,10,'Soluta nihil voluptas nesciunt eveniet ipsum qui. Pariatur atque quae doloribus minus incidunt beatae dolor.','1982-10-26 17:04:08'),(19,2,7,'Vero repellat autem neque. Sunt quis est ab possimus officiis odio commodi. Est sequi vel veritatis vel non facere doloremque.','1984-10-22 21:00:21'),(20,1,6,'Neque autem et unde molestiae. Commodi dolor et reiciendis mollitia quia commodi expedita. Deleniti minus consequatur et est. Sed molestias inventore est ut.','2004-03-01 11:31:19');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo_albums` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'distinctio',8),(2,'explicabo',9),(3,'labore',5),(4,'eaque',1),(5,'nulla',8),(6,'ullam',5),(7,'iusto',7),(8,'accusantium',5),(9,'voluptatem',8),(10,'distinctio',8);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint unsigned DEFAULT NULL,
  `media_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,2,1),(2,4,8),(3,4,10),(4,2,2),(5,1,6),(6,4,8),(7,3,1),(8,2,4),(9,3,7),(10,4,9);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `hometown` varchar(100) DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  KEY `profiles_fk_1` (`photo_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `profiles_fk_1` FOREIGN KEY (`photo_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'o','1983-08-23',5,'1976-05-31 08:52:24','mollitia'),(2,'g','1982-07-31',5,'1979-09-14 10:15:17','sunt'),(3,'q','2016-03-21',7,'1985-08-12 06:42:28','et'),(4,'w','2005-06-08',8,'1973-06-16 00:57:37','illum'),(5,'t','1975-03-22',10,'2006-02-26 01:52:40','ipsum'),(6,'t','2016-11-09',8,'1999-09-11 18:26:52','quia'),(7,'m','2004-09-28',5,'1998-10-24 18:49:46','doloremque'),(8,'e','2012-03-28',1,'1970-01-28 02:24:27','eius'),(9,'q','2010-01-28',8,'2007-06-06 09:02:39','similique'),(10,'w','1996-10-05',1,'1971-11-19 16:39:41','vel');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) DEFAULT NULL,
  `password_hash` varchar(100) DEFAULT NULL,
  `phone` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='юзеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Doyle','Auer','wilkinson.angie@example.org','0ec6685b56d37002fe646ac424516ae7e1935a4d',1),(2,'Rory','Miller','parker.weimann@example.net','e41db89151bdabefab2a8461478f2a9844e68650',176),(3,'Jaunita','Boehm','maggio.selina@example.net','6c04bc6ccebb758f9762b75ab959dd5457befb18',35376),(4,'Armand','Dach','fritsch.judson@example.com','2281e441f7871fcf2e16b2b615e74463bee33148',0),(5,'Amir','Spinka','russel.lina@example.com','d15308db5d66cd07fa0431137d88e29188657d47',18),(6,'Maybell','Schulist','deondre92@example.org','ab83ec79891448b2ba99d9e6b74a35508f8d95cc',709616),(7,'Joyce','Jaskolski','champlin.garrick@example.com','68f4afc5a6de58120bb5a98922585f9a13c3c141',52),(8,'Carolanne','Berge','cschuster@example.com','77eaa019d96a8d3fade3e5520599c4b35636a888',563134),(9,'Lori','Tremblay','wellington.towne@example.com','0934c1f8fca7f31de0663e7901386e5b3010910a',146273),(10,'Maymie','Gerhold','cecilia65@example.com','04ffd6b7300b033fb1754f893e99dfc488705e56',35),(11,'Abdiel','Koepp','ghickle@example.com','4f2eab09eb127f7ed0fd872cf5e1eb21ffebb9d9',3057681885);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_communities` (
  `user_id` bigint unsigned NOT NULL,
  `community_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,1),(1,2),(2,3),(3,4),(3,5);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vk'
--

--
-- Dumping routines for database 'vk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-24 18:11:03
