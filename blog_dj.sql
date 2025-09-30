-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: blog_dj
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b_fk_django_co` (`content_type_id`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add profile',7,'add_profile'),(26,'Can change profile',7,'change_profile'),(27,'Can delete profile',7,'delete_profile'),(28,'Can view profile',7,'view_profile'),(29,'Can add tag',8,'add_tag'),(30,'Can change tag',8,'change_tag'),(31,'Can delete tag',8,'delete_tag'),(32,'Can view tag',8,'view_tag'),(33,'Can add post',9,'add_post'),(34,'Can change post',9,'change_post'),(35,'Can delete post',9,'delete_post'),(36,'Can view post',9,'view_post'),(37,'Can add follow',10,'add_follow'),(38,'Can change follow',10,'change_follow'),(39,'Can delete follow',10,'delete_follow'),(40,'Can view follow',10,'view_follow'),(41,'Can add comment',11,'add_comment'),(42,'Can change comment',11,'change_comment'),(43,'Can delete comment',11,'delete_comment'),(44,'Can view comment',11,'view_comment'),(45,'Can add post request',12,'add_postrequest'),(46,'Can change post request',12,'change_postrequest'),(47,'Can delete post request',12,'delete_postrequest'),(48,'Can view post request',12,'view_postrequest');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$0JSdpwNGW89izghmexmRFT$MkJh2qyGx6kBs/rqx2tZVK0oZDt4s5V9pD/G2p31eKk=','2025-09-30 12:24:30.662902',1,'admin','Администратор','Системы','admin@example.com',1,1,'2025-01-06 12:00:00.000000'),(2,'pbkdf2_sha256$720000$UGBTrvmPD2TPclxALMgAtP$YNLZ3LTIbhSj3UIairld3yRxb82LpqJz4jOrKz1X5iI=',NULL,0,'alex_dev','Александр','Разработчиков','alex@example.com',0,1,'2025-01-06 12:00:00.000000'),(3,'pbkdf2_sha256$720000$UGBTrvmPD2TPclxALMgAtP$YNLZ3LTIbhSj3UIairld3yRxb82LpqJz4jOrKz1X5iI=',NULL,0,'maria_design','Мария','Дизайнерова','maria@example.com',0,1,'2025-01-06 12:00:00.000000'),(4,'pbkdf2_sha256$720000$UGBTrvmPD2TPclxALMgAtP$YNLZ3LTIbhSj3UIairld3yRxb82LpqJz4jOrKz1X5iI=',NULL,0,'john_blogger','Иван','Блогеров','john@example.com',0,1,'2025-01-06 12:00:00.000000'),(5,'pbkdf2_sha256$720000$UGBTrvmPD2TPclxALMgAtP$YNLZ3LTIbhSj3UIairld3yRxb82LpqJz4jOrKz1X5iI=',NULL,0,'anna_photo','Анна','Фотографова','anna@example.com',0,1,'2025-01-06 12:00:00.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(11,'social','comment'),(10,'social','follow'),(9,'social','post'),(12,'social','postrequest'),(7,'social','profile'),(8,'social','tag');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-01-06 12:00:00.000000'),(2,'auth','0001_initial','2025-01-06 12:00:00.000000'),(3,'admin','0001_initial','2025-01-06 12:00:00.000000'),(4,'admin','0002_logentry_remove_auto_add','2025-01-06 12:00:00.000000'),(5,'admin','0003_logentry_add_action_flag_choices','2025-01-06 12:00:00.000000'),(6,'contenttypes','0002_remove_content_type_name','2025-01-06 12:00:00.000000'),(7,'auth','0002_alter_permission_name_max_length','2025-01-06 12:00:00.000000'),(8,'auth','0003_alter_user_email_max_length','2025-01-06 12:00:00.000000'),(9,'auth','0004_alter_user_username_opts','2025-01-06 12:00:00.000000'),(10,'auth','0005_alter_user_last_login_null','2025-01-06 12:00:00.000000'),(11,'auth','0006_require_contenttypes_0002','2025-01-06 12:00:00.000000'),(12,'auth','0007_alter_validators_add_error_messages','2025-01-06 12:00:00.000000'),(13,'auth','0008_alter_user_username_max_length','2025-01-06 12:00:00.000000'),(14,'auth','0009_alter_user_last_name_max_length','2025-01-06 12:00:00.000000'),(15,'auth','0010_alter_group_name_max_length','2025-01-06 12:00:00.000000'),(16,'auth','0011_update_proxy_permissions','2025-01-06 12:00:00.000000'),(17,'auth','0012_alter_user_first_name_max_length','2025-01-06 12:00:00.000000'),(18,'sessions','0001_initial','2025-01-06 12:00:00.000000'),(19,'social','0001_initial','2025-01-06 12:00:00.000000');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('idy9jmhbzk35u504c8q4v8omgtb4t3dh','.eJxVjDEOwjAMRe-SGUVxiePCyM4ZIid2SQGlUtNOiLtDpQ6w_vfef5nI61Li2nSOo5izAXP43RLnh9YNyJ3rbbJ5qss8JrspdqfNXifR52V3_w4Kt_KtSf2RSROREkAAZicDBPE8dEzIAR2reOBwAvEpaYdKGZF61N4FNO8P8Lk3_A:1v3ZGb:k4GR5hQ-sYKuskVAJtQQB_5KCGfaSSrCQDrvwtvCMnM','2025-10-14 12:15:37.292221'),('sr1i4au2p36q6w9ywgatuvfje9bhsn7a','.eJxVjDEOwjAMRe-SGUVxiePCyM4ZIid2SQGlUtNOiLtDpQ6w_vfef5nI61Li2nSOo5izAXP43RLnh9YNyJ3rbbJ5qss8JrspdqfNXifR52V3_w4Kt_KtSf2RSROREkAAZicDBPE8dEzIAR2reOBwAvEpaYdKGZF61N4FNO8P8Lk3_A:1v3ZPC:pRtBYG1qHOQEbKIBBtDI8FfdrEtcm7I4lN8Ycdeg0eI','2025-10-14 12:24:30.666720');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_comment`
--

DROP TABLE IF EXISTS `social_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_comment_author_id_bf8f8e8d_fk_auth_user_id` (`author_id`),
  KEY `social_comment_post_id_cf8f8e8d_fk_social_post_id` (`post_id`),
  KEY `social_comment_created_at_df8f8e8d_idx` (`created_at`),
  KEY `idx_social_comment_post_created` (`post_id`,`created_at`),
  CONSTRAINT `social_comment_author_id_bf8f8e8d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `social_comment_post_id_cf8f8e8d_fk_social_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_comment`
--

LOCK TABLES `social_comment` WRITE;
/*!40000 ALTER TABLE `social_comment` DISABLE KEYS */;
INSERT INTO `social_comment` VALUES (1,'Отличный пост! Я тоже изучаю Django и согласна, что официальный туториал - лучшее место для старта.','2025-01-06 12:30:00.000000','2025-01-06 12:30:00.000000',3,2),(2,'Согласен с Александром. Django действительно отличный выбор для веб-разработки на Python.','2025-01-06 13:00:00.000000','2025-01-06 13:00:00.000000',1,2),(3,'Очень важные принципы! Особенно нравится пункт про предотвращение ошибок - это экономит много времени всем.','2025-01-06 12:00:00.000000','2025-01-06 12:00:00.000000',2,3),(4,'Спасибо за добро пожаловать! Уже начал изучать функционал платформы 😊','2025-01-06 10:30:00.000000','2025-01-06 10:30:00.000000',4,1),(5,'Классные локации! А можно узнать адрес того моста? Очень хочется там поснимать!','2025-01-06 08:30:00.000000','2025-01-06 08:30:00.000000',3,5),(6,'Вдохновляющая история! Тоже думаю начать вести блог, но пока не решаюсь.','2025-01-06 07:30:00.000000','2025-01-06 07:30:00.000000',5,6),(7,'Полностью поддерживаю! Регулярность - это действительно ключ к успеху в блогинге.','2025-01-06 07:15:00.000000','2025-01-06 07:15:00.000000',2,6),(8,'тут','2025-09-30 12:18:35.157783','2025-09-30 12:18:35.157818',1,2);
/*!40000 ALTER TABLE `social_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_follow`
--

DROP TABLE IF EXISTS `social_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `follower_id` int NOT NULL,
  `following_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_follow_follower_id_following_id_9f8f8e8d_uniq` (`follower_id`,`following_id`),
  KEY `social_follow_following_id_af8f8e8d_fk_auth_user_id` (`following_id`),
  KEY `idx_social_follow_follower` (`follower_id`),
  KEY `idx_social_follow_following` (`following_id`),
  CONSTRAINT `social_follow_follower_id_9f8f8e8d_fk_auth_user_id` FOREIGN KEY (`follower_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `social_follow_following_id_af8f8e8d_fk_auth_user_id` FOREIGN KEY (`following_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_follow`
--

LOCK TABLES `social_follow` WRITE;
/*!40000 ALTER TABLE `social_follow` DISABLE KEYS */;
INSERT INTO `social_follow` VALUES (1,'2025-01-06 12:00:00.000000',1,2),(2,'2025-01-06 12:00:00.000000',1,3),(3,'2025-01-06 12:00:00.000000',2,3),(4,'2025-01-06 12:00:00.000000',3,2),(5,'2025-01-06 12:00:00.000000',4,1),(6,'2025-01-06 12:00:00.000000',4,2),(7,'2025-01-06 12:00:00.000000',4,5),(8,'2025-01-06 12:00:00.000000',5,3),(9,'2025-01-06 12:00:00.000000',5,4);
/*!40000 ALTER TABLE `social_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_post`
--

DROP TABLE IF EXISTS `social_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visibility` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_post_author_id_4b8b8e8d_fk_auth_user_id` (`author_id`),
  KEY `social_post_created_at_b8e8b8e8_idx` (`created_at`),
  KEY `idx_social_post_author_created` (`author_id`,`created_at`),
  KEY `idx_social_post_visibility` (`visibility`),
  CONSTRAINT `social_post_author_id_4b8b8e8d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_post`
--

LOCK TABLES `social_post` WRITE;
/*!40000 ALTER TABLE `social_post` DISABLE KEYS */;
INSERT INTO `social_post` VALUES (1,'Добро пожаловать в нашу социальную сеть!','Приветствуем всех пользователей нашей платформы!\n\nЗдесь вы можете:\n✅ Создавать посты и делиться своими мыслями\n✅ Подписываться на интересных авторов\n✅ Комментировать и лайкать публикации\n✅ Использовать теги для организации контента\n✅ Настраивать приватность постов\n\nМы постоянно работаем над улучшением платформы. Если у вас есть предложения или вопросы - пишите!\n\nУдачного общения! 🚀','https://images.pexels.com/photos/1181263/pexels-photo-1181263.jpeg?auto=compress&cs=tinysrgb&w=800',NULL,'public','2025-01-06 10:00:00.000000','2025-01-06 10:00:00.000000',1),(2,'Начинаем изучать Django','Django - это мощный веб-фреймворк для Python, который позволяет быстро создавать безопасные и масштабируемые веб-приложения.\n\nОсновные преимущества Django:\n• Быстрая разработка\n• Встроенная админка\n• ORM для работы с базой данных\n• Система аутентификации\n• Безопасность из коробки\n\nЕсли вы только начинаете изучать Django, рекомендую начать с официального туториала!','https://images.pexels.com/photos/1181671/pexels-photo-1181671.jpeg?auto=compress&cs=tinysrgb&w=800',NULL,'public','2025-01-06 12:00:00.000000','2025-01-06 12:00:00.000000',2),(3,'Принципы хорошего UI дизайна','Сегодня хочу поделиться основными принципами, которые помогут создать качественный пользовательский интерфейс:\n\n1. **Простота** - интерфейс должен быть понятным и не перегруженным\n2. **Последовательность** - единый стиль во всем приложении\n3. **Видимость статуса системы** - пользователь всегда должен понимать, что происходит\n4. **Контроль пользователя** - возможность отменить действия\n5. **Предотвращение ошибок** - лучше предотвратить, чем исправлять\n\nПомните: хороший дизайн незаметен, плохой - раздражает!','https://images.pexels.com/photos/196644/pexels-photo-196644.jpeg?auto=compress&cs=tinysrgb&w=800',NULL,'public','2025-01-06 11:30:00.000000','2025-01-06 11:30:00.000000',3),(4,'Секретные советы по Python','Несколько малоизвестных, но очень полезных возможностей Python:\n\n1. **Walrus operator (:=)** - присвоение в выражениях\n2. **F-strings с отладкой** - f\'{variable=}\' покажет и имя, и значение\n3. **Contextlib для простых менеджеров контекста**\n4. **Pathlib вместо os.path** - более удобная работа с путями\n5. **Dataclasses** - автогенерация __init__, __repr__ и других методов\n\nЭти фичи могут значительно упростить ваш код!',NULL,NULL,'request','2025-01-06 09:00:00.000000','2025-01-06 09:00:00.000000',2),(5,'Мои любимые места для фотосессий','Как фотограф, я всегда ищу интересные локации. Вот мои топ-5 мест в городе:\n\n📸 Старый мост на закате\n📸 Парк с вековыми дубами\n📸 Крыши исторического центра\n📸 Набережная в золотой час\n📸 Заброшенная фабрика (с разрешения!)\n\nКаждое место имеет свою атмосферу и подходит для разных стилей съемки. Главное - безопасность и уважение к окружающим!','https://images.pexels.com/photos/1264210/pexels-photo-1264210.jpeg?auto=compress&cs=tinysrgb&w=800',NULL,'public','2025-01-06 08:00:00.000000','2025-01-06 08:00:00.000000',5),(6,'Как я стал блогером','История моего пути в мир контент-мейкинга началась случайно. Просто решил поделиться своими мыслями о технологиях...\n\nЧто я понял за год ведения блога:\n\n🔥 Регулярность важнее качества (но качество тоже важно!)\n🔥 Аудитория ценит честность и личный опыт\n🔥 Взаимодействие с читателями - это кайф\n🔥 Не бойтесь экспериментировать с форматами\n\nСейчас у меня 10К подписчиков и куча планов на будущее!','https://images.pexels.com/photos/267350/pexels-photo-267350.jpeg?auto=compress&cs=tinysrgb&w=800',NULL,'public','2025-01-06 07:00:00.000000','2025-01-06 07:00:00.000000',4),(7,'Приватные мысли о работе','Иногда работа в IT может быть очень стressful. Важно находить баланс и не выгорать.\n\nМои способы борьбы со стрессом:\n- Медитация по утрам\n- Прогулки без телефона\n- Хобби, не связанные с компьютером\n- Общение с близкими\n\nЗдоровье важнее любых дедлайнов!',NULL,NULL,'private','2025-01-06 06:00:00.000000','2025-01-06 06:00:00.000000',2),(8,'Тест скрытый','Тест скрытый',NULL,'','private','2025-09-30 12:21:51.697129','2025-09-30 12:21:51.697177',1);
/*!40000 ALTER TABLE `social_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_post_likes`
--

DROP TABLE IF EXISTS `social_post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_post_likes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_post_likes_post_id_user_id_7d8d8e8d_uniq` (`post_id`,`user_id`),
  KEY `social_post_likes_user_id_8e8e8e8d_fk_auth_user_id` (`user_id`),
  CONSTRAINT `social_post_likes_post_id_7d8d8e8d_fk_social_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`),
  CONSTRAINT `social_post_likes_user_id_8e8e8e8d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_post_likes`
--

LOCK TABLES `social_post_likes` WRITE;
/*!40000 ALTER TABLE `social_post_likes` DISABLE KEYS */;
INSERT INTO `social_post_likes` VALUES (1,1,2),(2,1,3),(3,1,4),(4,2,1),(5,2,3),(6,3,1),(7,3,2),(8,3,4),(9,5,1),(10,5,2),(11,5,3),(12,6,2),(13,6,3),(14,6,5);
/*!40000 ALTER TABLE `social_post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_post_tags`
--

DROP TABLE IF EXISTS `social_post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_post_tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_post_tags_post_id_tag_id_5b8b8e8d_uniq` (`post_id`,`tag_id`),
  KEY `social_post_tags_tag_id_6c8c8e8d_fk_social_tag_id` (`tag_id`),
  CONSTRAINT `social_post_tags_post_id_5b8b8e8d_fk_social_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`),
  CONSTRAINT `social_post_tags_tag_id_6c8c8e8d_fk_social_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `social_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_post_tags`
--

LOCK TABLES `social_post_tags` WRITE;
/*!40000 ALTER TABLE `social_post_tags` DISABLE KEYS */;
INSERT INTO `social_post_tags` VALUES (1,1,8),(2,1,10),(5,2,1),(3,2,3),(4,2,4),(6,2,5),(7,3,2),(8,3,9),(10,4,1),(9,4,3),(11,5,6),(12,5,7),(14,6,8),(13,6,10),(15,7,1);
/*!40000 ALTER TABLE `social_post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_postrequest`
--

DROP TABLE IF EXISTS `social_postrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_postrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approved` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `post_id` bigint NOT NULL,
  `requester_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_postrequest_post_id_requester_id_ef8f8e8d_uniq` (`post_id`,`requester_id`),
  KEY `social_postrequest_requester_id_ff8f8e8d_fk_auth_user_id` (`requester_id`),
  CONSTRAINT `social_postrequest_post_id_ef8f8e8d_fk_social_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`),
  CONSTRAINT `social_postrequest_requester_id_ff8f8e8d_fk_auth_user_id` FOREIGN KEY (`requester_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_postrequest`
--

LOCK TABLES `social_postrequest` WRITE;
/*!40000 ALTER TABLE `social_postrequest` DISABLE KEYS */;
INSERT INTO `social_postrequest` VALUES (1,1,'2025-01-06 09:30:00.000000',4,1),(2,1,'2025-01-06 09:45:00.000000',4,3),(3,0,'2025-01-06 10:00:00.000000',4,4);
/*!40000 ALTER TABLE `social_postrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_profile`
--

DROP TABLE IF EXISTS `social_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bio` longtext COLLATE utf8mb4_unicode_ci,
  `avatar_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `social_profile_user_id_0a0b9e15_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_profile`
--

LOCK TABLES `social_profile` WRITE;
/*!40000 ALTER TABLE `social_profile` DISABLE KEYS */;
INSERT INTO `social_profile` VALUES (1,'Главный администратор системы. Разрабатываю и поддерживаю платформу.','https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400','',NULL,'Москва, Россия','https://example.com','2025-01-06 12:00:00.000000',1),(2,'Fullstack разработчик. Увлекаюсь Python, Django, React. Люблю делиться знаниями и помогать начинающим.','https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400',NULL,NULL,'Санкт-Петербург, Россия','https://github.com/alexdev','2025-01-06 12:00:00.000000',2),(3,'UI/UX дизайнер с 5-летним опытом. Создаю красивые и функциональные интерфейсы.','https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=400',NULL,NULL,'Екатеринбург, Россия','https://dribbble.com/mariadesign','2025-01-06 12:00:00.000000',3),(4,'Блогер и контент-мейкер. Пишу о технологиях, путешествиях и жизни.','https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=400',NULL,NULL,'Новосибирск, Россия','https://blog.johnblogger.com','2025-01-06 12:00:00.000000',4),(5,'Фотограф и визуальный художник. Ловлю моменты и создаю красоту.','https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400',NULL,NULL,'Казань, Россия','https://instagram.com/anna_photo','2025-01-06 12:00:00.000000',5);
/*!40000 ALTER TABLE `social_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_tag`
--

DROP TABLE IF EXISTS `social_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_social_tag_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_tag`
--

LOCK TABLES `social_tag` WRITE;
/*!40000 ALTER TABLE `social_tag` DISABLE KEYS */;
INSERT INTO `social_tag` VALUES (1,'программирование','#007bff','2025-01-06 12:00:00.000000'),(2,'дизайн','#e83e8c','2025-01-06 12:00:00.000000'),(3,'python','#28a745','2025-01-06 12:00:00.000000'),(4,'django','#17a2b8','2025-01-06 12:00:00.000000'),(5,'веб-разработка','#fd7e14','2025-01-06 12:00:00.000000'),(6,'фотография','#6f42c1','2025-01-06 12:00:00.000000'),(7,'путешествия','#20c997','2025-01-06 12:00:00.000000'),(8,'технологии','#dc3545','2025-01-06 12:00:00.000000'),(9,'ui-ux','#ffc107','2025-01-06 12:00:00.000000'),(10,'блог','#6c757d','2025-01-06 12:00:00.000000');
/*!40000 ALTER TABLE `social_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-30 15:30:09
