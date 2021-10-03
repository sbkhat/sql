CREATE DATABASE  IF NOT EXISTS `booking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `booking`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: booking
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
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название Города',
  `region_id` bigint NOT NULL COMMENT 'Идентификатор Региона',
  `country_id` bigint NOT NULL COMMENT 'Идентификатор Страны',
  PRIMARY KEY (`id`),
  KEY `cities_region_id` (`region_id`),
  KEY `cities_country_id` (`country_id`),
  CONSTRAINT `cities_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `cities_region_id` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Москва',1,1),(2,'Мытищи',2,1),(3,'Балашиха',2,1),(4,'Курск',3,1),(5,'Чехов',4,1),(6,'Челябинск',5,1),(7,'Минск',6,2);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `hotel_id` bigint NOT NULL COMMENT 'Идентификатор строки',
  `user_id` bigint NOT NULL COMMENT 'Идентификатор строки',
  `description` text NOT NULL COMMENT 'Идентификатор строки',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `comments_user_id` (`user_id`),
  CONSTRAINT `comments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,1,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.','2021-10-03 23:04:05','2021-10-03 23:04:05'),(2,2,1,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.','2021-10-03 23:04:05','2021-10-03 23:04:05'),(3,3,2,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.','2021-10-03 23:04:05','2021-10-03 23:04:05'),(4,4,2,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.','2021-10-03 23:04:05','2021-10-03 23:04:05');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название Региона',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Российская Федерация'),(2,'Беларусия');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genders`
--

DROP TABLE IF EXISTS `genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genders` (
  `id` smallint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название пола',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genders`
--

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;
INSERT INTO `genders` VALUES (1,'Мужчина'),(2,'Женщина');
/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_photos`
--

DROP TABLE IF EXISTS `hotel_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_photos` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `hotel_id` bigint NOT NULL COMMENT 'Идентификатор отеля',
  `value` varchar(255) NOT NULL COMMENT 'Ссылка на изображения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `hotel_photos_hotel_id` (`hotel_id`),
  CONSTRAINT `hotel_photos_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_photos`
--

LOCK TABLES `hotel_photos` WRITE;
/*!40000 ALTER TABLE `hotel_photos` DISABLE KEYS */;
INSERT INTO `hotel_photos` VALUES (1,1,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),(2,1,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),(3,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),(4,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),(5,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46');
/*!40000 ALTER TABLE `hotel_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_statuses`
--

DROP TABLE IF EXISTS `hotel_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_statuses` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(100) NOT NULL COMMENT 'Название',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_statuses`
--

LOCK TABLES `hotel_statuses` WRITE;
/*!40000 ALTER TABLE `hotel_statuses` DISABLE KEYS */;
INSERT INTO `hotel_statuses` VALUES (1,'Сдается'),(2,'Удален'),(3,'Скрыт');
/*!40000 ALTER TABLE `hotel_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_types`
--

DROP TABLE IF EXISTS `hotel_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_types` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(100) NOT NULL COMMENT 'Название',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_types`
--

LOCK TABLES `hotel_types` WRITE;
/*!40000 ALTER TABLE `hotel_types` DISABLE KEYS */;
INSERT INTO `hotel_types` VALUES (1,'Дом'),(2,'Аппартаменты'),(3,'Комната'),(4,'Квартира');
/*!40000 ALTER TABLE `hotel_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(100) NOT NULL COMMENT 'Идентификатор строки',
  `description` text NOT NULL COMMENT 'Описание',
  `type_id` int NOT NULL COMMENT 'Идентификатор типа',
  `cost` decimal(10,0) NOT NULL COMMENT 'Стоимость за сутки',
  `city_id` bigint NOT NULL COMMENT 'Идентификатор Города',
  `user_id` bigint NOT NULL COMMENT 'Идентификатор польователя',
  `address` text NOT NULL COMMENT 'Адрес',
  `status_id` int NOT NULL COMMENT 'Идентификатор статуса',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `hotel_type_id` (`type_id`),
  KEY `hotel_status_id` (`status_id`),
  KEY `hotel_user_id` (`user_id`),
  CONSTRAINT `hotel_status_id` FOREIGN KEY (`status_id`) REFERENCES `hotel_statuses` (`id`),
  CONSTRAINT `hotel_type_id` FOREIGN KEY (`type_id`) REFERENCES `hotel_types` (`id`),
  CONSTRAINT `hotel_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,1,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',1,'2021-10-03 23:04:05','2021-10-03 23:04:05'),(2,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,2,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',2,'2021-10-03 23:04:05','2021-10-03 23:04:05'),(3,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,3,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',3,'2021-10-03 23:04:05','2021-10-03 23:04:05'),(4,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,1,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',1,'2021-10-03 23:04:05','2021-10-03 23:04:05'),(5,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,2,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',2,'2021-10-03 23:04:05','2021-10-03 23:04:05');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `hotel_id` bigint NOT NULL COMMENT 'Идентификатор отеля',
  `user_id` bigint NOT NULL COMMENT 'Идентификатор пользователя',
  `status_id` int NOT NULL COMMENT 'Идентификатор статуса',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`),
  KEY `logs_hotel_id` (`hotel_id`),
  KEY `logs_user_id` (`user_id`),
  KEY `logs_status_id` (`status_id`),
  CONSTRAINT `logs_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`),
  CONSTRAINT `logs_status_id` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`),
  CONSTRAINT `logs_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Идентификатор строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'В ожидании'),(2,'Оплачен'),(3,'Отменен');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `hotel_id` bigint NOT NULL COMMENT 'Идентификатор отеля',
  `user_id` bigint NOT NULL COMMENT 'Идентификатор пользователя',
  `status_id` int NOT NULL COMMENT 'Идентификатор статуса',
  `date_from` date DEFAULT NULL COMMENT 'С какой даты заказ',
  `date_to` date DEFAULT NULL COMMENT 'По какую дату заказ',
  `comment` text COMMENT 'Комментарий заказчика',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  `cost` decimal(10,0) DEFAULT '0' COMMENT 'Стоимость',
  PRIMARY KEY (`id`),
  KEY `orders_hotel_id` (`hotel_id`),
  KEY `orders_user_id` (`user_id`),
  KEY `orders_status_id` (`status_id`),
  CONSTRAINT `orders_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`),
  CONSTRAINT `orders_status_id` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`),
  CONSTRAINT `orders_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(2,2,2,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(3,3,2,3,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(4,4,3,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(5,5,3,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(6,1,3,3,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(7,2,3,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0),(8,3,3,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.','2021-10-03 23:04:05','2021-10-03 23:04:05',0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orders_log_insert_after_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    INSERT INTO logs (hotel_id, user_id, status_id) VALUE (NEW.hotel_id, NEW.user_id, NEW.status_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `orders_view`
--

DROP TABLE IF EXISTS `orders_view`;
/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orders_view` AS SELECT 
 1 AS `id`,
 1 AS `date_from`,
 1 AS `date_to`,
 1 AS `cost`,
 1 AS `owner_id`,
 1 AS `owner_phone`,
 1 AS `user_id`,
 1 AS `user_phone`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `profile_statuses`
--

DROP TABLE IF EXISTS `profile_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_statuses` (
  `id` smallint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название Региона',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_statuses`
--

LOCK TABLES `profile_statuses` WRITE;
/*!40000 ALTER TABLE `profile_statuses` DISABLE KEYS */;
INSERT INTO `profile_statuses` VALUES (1,'активен'),(2,'требует подтверждения email'),(3,'требует подтверждения телефона'),(4,'удален');
/*!40000 ALTER TABLE `profile_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` bigint NOT NULL COMMENT 'Ссылка на пользователя',
  `birthday` date DEFAULT NULL COMMENT 'Дата рождения',
  `city_id` bigint DEFAULT NULL COMMENT 'Идентификатор проживания',
  `status_id` smallint NOT NULL DEFAULT '1',
  `gender_id` smallint NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `profiles_user_id` (`user_id`),
  KEY `profiles_city_id` (`city_id`),
  KEY `profiles_status_id` (`status_id`),
  CONSTRAINT `profiles_city_id` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `profiles_status_id` FOREIGN KEY (`status_id`) REFERENCES `profile_statuses` (`id`),
  CONSTRAINT `profiles_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'1991-01-12',1,1,1,'1972-09-28 13:27:19','1976-10-16 17:04:34'),(2,2,'2009-02-02',2,2,2,'1992-10-12 03:48:27','1987-12-01 23:36:29'),(3,3,'2009-02-02',3,3,1,'1992-10-12 03:48:27','1987-12-01 23:36:29'),(4,3,'2009-02-02',4,2,2,'1992-10-12 03:48:27','1987-12-01 23:36:29');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название Региона',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'Москва'),(2,'Московская область'),(3,'Курская Область'),(4,'Чеховская область'),(5,'Уральская область'),(6,'Минская область');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_phones`
--

DROP TABLE IF EXISTS `user_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_phones` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `value` varchar(10) NOT NULL COMMENT 'Номер телефона',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_phones`
--

LOCK TABLES `user_phones` WRITE;
/*!40000 ALTER TABLE `user_phones` DISABLE KEYS */;
INSERT INTO `user_phones` VALUES (1,'7513348062','1974-04-11 11:11:45','2016-03-29 04:15:47'),(2,'7513348063','1974-04-11 11:11:45','2016-03-29 04:15:47'),(3,'7513348064','1974-04-11 11:11:45','2016-03-29 04:15:47'),(4,'7513348065','1974-04-11 11:11:45','2016-03-29 04:15:47');
/*!40000 ALTER TABLE `user_phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_photos`
--

DROP TABLE IF EXISTS `user_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_photos` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `value` varchar(255) NOT NULL COMMENT 'Ссылка на изображения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_photos`
--

LOCK TABLES `user_photos` WRITE;
/*!40000 ALTER TABLE `user_photos` DISABLE KEYS */;
INSERT INTO `user_photos` VALUES (1,'http://lorempixel.com/600/400/','1996-03-09 08:31:52','1994-06-19 23:35:38'),(2,'http://lorempixel.com/600/400/','1970-05-04 17:29:13','2019-09-12 00:33:21'),(3,'http://lorempixel.com/600/400/','2010-07-27 22:48:08','1978-11-01 10:29:49'),(4,'http://lorempixel.com/600/400/','1981-06-26 13:48:05','1992-04-24 02:32:26');
/*!40000 ALTER TABLE `user_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_statuses`
--

DROP TABLE IF EXISTS `user_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_statuses` (
  `id` smallint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) NOT NULL COMMENT 'Название статуса',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_statuses`
--

LOCK TABLES `user_statuses` WRITE;
/*!40000 ALTER TABLE `user_statuses` DISABLE KEYS */;
INSERT INTO `user_statuses` VALUES (1,'активен','2021-10-03 23:04:05','2021-10-03 23:04:05'),(2,'требует подтверждения email','2021-10-03 23:04:05','2021-10-03 23:04:05'),(3,'требует подтверждения телефона','2021-10-03 23:04:05','2021-10-03 23:04:05'),(4,'заблокирован','2021-10-03 23:04:05','2021-10-03 23:04:05'),(5,'удален','2021-10-03 23:04:05','2021-10-03 23:04:05');
/*!40000 ALTER TABLE `user_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `firstname` varchar(100) DEFAULT NULL COMMENT 'Имя пользователяа',
  `lastname` varchar(100) DEFAULT NULL COMMENT 'Фамилия пользователя',
  `login` varchar(100) NOT NULL COMMENT 'Логин пользователя',
  `password` varchar(100) NOT NULL COMMENT 'Пароль пользователя',
  `last_activity` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата последней активности',
  `status_id` smallint NOT NULL DEFAULT '1' COMMENT 'Идентификатор статуса',
  `phone_id` bigint DEFAULT '1' COMMENT 'Идентификатор номера телефона',
  `photo_id` bigint DEFAULT '1' COMMENT 'Идентификатор картинки',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `users_phone_id` (`phone_id`),
  KEY `users_photo_id` (`photo_id`),
  KEY `users_status_id` (`status_id`),
  CONSTRAINT `users_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `user_phones` (`id`),
  CONSTRAINT `users_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `user_photos` (`id`),
  CONSTRAINT `users_status_id` FOREIGN KEY (`status_id`) REFERENCES `user_statuses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Devante1','Stiedemann1','et1','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',1,1,1,'1978-10-16 14:34:26','1996-11-11 05:48:39'),(2,'Devante2','Stiedemann2','et2','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',2,2,2,'1978-10-16 14:34:26','1996-11-11 05:48:39'),(3,'Devante3','Stiedemann3','et3','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',3,3,3,'1978-10-16 14:34:26','1996-11-11 05:48:39');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'booking'
--

--
-- Dumping routines for database 'booking'
--
/*!50003 DROP FUNCTION IF EXISTS `get_age` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_age`(birthday DATETIME) RETURNS int
    DETERMINISTIC
BEGIN
    RETURN (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(birthday,5));
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_age_text` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_age_text`(birthday DATETIME) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = get_age(birthday);
    RETURN CASE
           WHEN age <= 10 THEN 'возраст от 0 до 10'
           WHEN age <= 20 THEN 'возраст от 10 до 20'
           WHEN age <= 30 THEN 'возраст от 20 до 30'
           WHEN age <= 40 THEN 'возраст от 30 до 40'
           WHEN age <= 50 THEN 'возраст от 40 до 50'
           WHEN age > 50 THEN  'возраст старше 50'
           END;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_price`(date_from DATETIME, date_to DATETIME, hotel_id BIGINT) RETURNS decimal(10,0)
    DETERMINISTIC
BEGIN
    RETURN ((DATEDIFF(date_to, date_from)) + 1) * (SELECT cost FROM hotels WHERE id = hotel_id);
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `orders_view`
--

/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orders_view` AS select `o`.`id` AS `id`,`o`.`date_from` AS `date_from`,`o`.`date_to` AS `date_to`,`get_price`(`o`.`date_to`,`o`.`date_from`,`h`.`id`) AS `cost`,`u2`.`id` AS `owner_id`,`up2`.`value` AS `owner_phone`,`u1`.`id` AS `user_id`,`up1`.`value` AS `user_phone` from (((((`orders` `o` join `users` `u1` on((`o`.`user_id` = `u1`.`id`))) join `user_phones` `up1` on((`u1`.`phone_id` = `up1`.`id`))) join `hotels` `h` on((`o`.`hotel_id` = `h`.`id`))) join `users` `u2` on((`h`.`user_id` = `u2`.`id`))) join `user_phones` `up2` on((`u2`.`phone_id` = `up2`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-03 23:08:45
