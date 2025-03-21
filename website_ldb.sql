CREATE DATABASE  IF NOT EXISTS `website_ldb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `website_ldb`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: website_ldb
-- ------------------------------------------------------
-- Server version	9.2.0

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
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add customer',7,'add_customer'),(26,'Can change customer',7,'change_customer'),(27,'Can delete customer',7,'delete_customer'),(28,'Can view customer',7,'view_customer'),(29,'Can add user',8,'add_customuser'),(30,'Can change user',8,'change_customuser'),(31,'Can delete user',8,'delete_customuser'),(32,'Can view user',8,'view_customuser'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can add settings',11,'add_settings'),(42,'Can change settings',11,'change_settings'),(43,'Can delete settings',11,'delete_settings'),(44,'Can view settings',11,'view_settings'),(45,'Can add featured',12,'add_featured'),(46,'Can change featured',12,'change_featured'),(47,'Can delete featured',12,'delete_featured'),(48,'Can view featured',12,'view_featured');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_jewelry_d` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_jewelry_d` FOREIGN KEY (`user_id`) REFERENCES `jewelry_demo_app_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
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
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'jewelry_demo_app','category'),(7,'jewelry_demo_app','customer'),(8,'jewelry_demo_app','customuser'),(12,'jewelry_demo_app','featured'),(10,'jewelry_demo_app','order'),(9,'jewelry_demo_app','product'),(11,'jewelry_demo_app','settings'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-10 09:02:03.955512'),(2,'contenttypes','0002_remove_content_type_name','2025-03-10 09:02:04.039543'),(3,'auth','0001_initial','2025-03-10 09:02:04.266138'),(4,'auth','0002_alter_permission_name_max_length','2025-03-10 09:02:04.309856'),(5,'auth','0003_alter_user_email_max_length','2025-03-10 09:02:04.309856'),(6,'auth','0004_alter_user_username_opts','2025-03-10 09:02:04.325068'),(7,'auth','0005_alter_user_last_login_null','2025-03-10 09:02:04.329730'),(8,'auth','0006_require_contenttypes_0002','2025-03-10 09:02:04.329730'),(9,'auth','0007_alter_validators_add_error_messages','2025-03-10 09:02:04.340378'),(10,'auth','0008_alter_user_username_max_length','2025-03-10 09:02:04.356360'),(11,'auth','0009_alter_user_last_name_max_length','2025-03-10 09:02:04.360142'),(12,'auth','0010_alter_group_name_max_length','2025-03-10 09:02:04.375021'),(13,'auth','0011_update_proxy_permissions','2025-03-10 09:02:04.376685'),(14,'auth','0012_alter_user_first_name_max_length','2025-03-10 09:02:04.385606'),(15,'jewelry_demo_app','0001_initial','2025-03-10 09:02:04.889108'),(16,'admin','0001_initial','2025-03-10 09:02:05.011676'),(17,'admin','0002_logentry_remove_auto_add','2025-03-10 09:02:05.017679'),(18,'admin','0003_logentry_add_action_flag_choices','2025-03-10 09:02:05.028217'),(19,'sessions','0001_initial','2025-03-10 09:02:05.067758'),(20,'jewelry_demo_app','0002_remove_product_category_remove_product_image_url_and_more','2025-03-11 02:17:26.170381'),(21,'jewelry_demo_app','0003_featured','2025-03-11 04:08:52.756798'),(22,'jewelry_demo_app','0004_product_is_featured','2025-03-11 04:23:11.536038'),(23,'jewelry_demo_app','0005_category_note','2025-03-11 06:39:18.474980'),(24,'jewelry_demo_app','0006_remove_product_show_stock_product_note_and_more','2025-03-11 08:26:46.882367');
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
INSERT INTO `django_session` VALUES ('atzfza4o6arw0g0eokze1lchnvkv2e6v','.eJxVjDsOwjAQBe_iGllZeze2Kek5g7X-4QBypDipEHeHSCmgfTPzXsLztla_9bz4KYmzAHH63QLHR247SHdut1nGua3LFOSuyIN2eZ1Tfl4O9--gcq_fWkebM2EJhqMdk1NkdeCiSGunCiRMjGQosuYhAtCo0aGx6EApGNiI9wfl6TcO:1trq3H:oqZ1UMI6FvTB168bj6L41E9ViZtiqHIZvD8Fx_ouQgg','2025-03-25 03:13:07.151364'),('idijenycj5yqsjzo2ph2lnqhjtl2suxy','.eJxVjDsOwjAQBe_iGllZeze2Kek5g7X-4QBypDipEHeHSCmgfTPzXsLztla_9bz4KYmzAHH63QLHR247SHdut1nGua3LFOSuyIN2eZ1Tfl4O9--gcq_fWkebM2EJhqMdk1NkdeCiSGunCiRMjGQosuYhAtCo0aGx6EApGNiI9wfl6TcO:1trtfa:i4OlXNfZvLPZA-mbJTsGPBgivIfm7tPzJ3UqOeqkXiU','2025-03-25 07:04:54.656805'),('pdkjpn0jycl8g2dkzblsht9xqz70oxbi','.eJxVjDsOwjAQBe_iGllZeze2Kek5g7X-4QBypDipEHeHSCmgfTPzXsLztla_9bz4KYmzAHH63QLHR247SHdut1nGua3LFOSuyIN2eZ1Tfl4O9--gcq_fWkebM2EJhqMdk1NkdeCiSGunCiRMjGQosuYhAtCo0aGx6EApGNiI9wfl6TcO:1trvbC:nQwyWqVZ443DutKRFQAQUTSSgjSDn73PL_aOr28UruA','2025-03-25 09:08:30.528453'),('r5u9fplbfis9jtgu7kxb4fprutciv142','.eJxVjDsOwjAQBe_iGllZeze2Kek5g7X-4QBypDipEHeHSCmgfTPzXsLztla_9bz4KYmzAHH63QLHR247SHdut1nGua3LFOSuyIN2eZ1Tfl4O9--gcq_fWkebM2EJhqMdk1NkdeCiSGunCiRMjGQosuYhAtCo0aGx6EApGNiI9wfl6TcO:1trZ4B:5eilsrUQ1y24G1hkZi0uJTd3IRB9o8uewgAkZkTUpPE','2025-03-24 09:04:55.294508');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_category`
--

DROP TABLE IF EXISTS `jewelry_demo_app_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `jewelry_demo_app_cat_parent_id_50951cf6_fk_jewelry_d` (`parent_id`),
  CONSTRAINT `jewelry_demo_app_cat_parent_id_50951cf6_fk_jewelry_d` FOREIGN KEY (`parent_id`) REFERENCES `jewelry_demo_app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_category`
--

LOCK TABLES `jewelry_demo_app_category` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_category` DISABLE KEYS */;
INSERT INTO `jewelry_demo_app_category` VALUES (6,'黃金',NULL,''),(7,'鑽石',NULL,''),(8,'戒指',6,'');
/*!40000 ALTER TABLE `jewelry_demo_app_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_customer`
--

DROP TABLE IF EXISTS `jewelry_demo_app_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_address` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_customer`
--

LOCK TABLES `jewelry_demo_app_customer` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_customuser`
--

DROP TABLE IF EXISTS `jewelry_demo_app_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
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
  `level` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_customuser`
--

LOCK TABLES `jewelry_demo_app_customuser` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_customuser` DISABLE KEYS */;
INSERT INTO `jewelry_demo_app_customuser` VALUES (1,'pbkdf2_sha256$870000$q60QCvpdBuYfsoB3HjxQqc$ZJ3438keODztOf4aCLkBYanVs5TjKGOfCj1DJloBZ8g=','2025-03-11 09:08:30.525455',1,'sakamata199','','','',1,1,'2025-03-10 09:02:27.163018','designer',NULL,NULL);
/*!40000 ALTER TABLE `jewelry_demo_app_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_customuser_groups`
--

DROP TABLE IF EXISTS `jewelry_demo_app_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jewelry_demo_app_customu_customuser_id_group_id_c65ae907_uniq` (`customuser_id`,`group_id`),
  KEY `jewelry_demo_app_cus_group_id_29f86292_fk_auth_grou` (`group_id`),
  CONSTRAINT `jewelry_demo_app_cus_customuser_id_d17edb65_fk_jewelry_d` FOREIGN KEY (`customuser_id`) REFERENCES `jewelry_demo_app_customuser` (`id`),
  CONSTRAINT `jewelry_demo_app_cus_group_id_29f86292_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_customuser_groups`
--

LOCK TABLES `jewelry_demo_app_customuser_groups` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_customuser_user_permissions`
--

DROP TABLE IF EXISTS `jewelry_demo_app_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jewelry_demo_app_customu_customuser_id_permission_34ea7e7c_uniq` (`customuser_id`,`permission_id`),
  KEY `jewelry_demo_app_cus_permission_id_2cafb4ae_fk_auth_perm` (`permission_id`),
  CONSTRAINT `jewelry_demo_app_cus_customuser_id_2c02d4e8_fk_jewelry_d` FOREIGN KEY (`customuser_id`) REFERENCES `jewelry_demo_app_customuser` (`id`),
  CONSTRAINT `jewelry_demo_app_cus_permission_id_2cafb4ae_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_customuser_user_permissions`
--

LOCK TABLES `jewelry_demo_app_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_featured`
--

DROP TABLE IF EXISTS `jewelry_demo_app_featured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_featured` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_featured`
--

LOCK TABLES `jewelry_demo_app_featured` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_featured` DISABLE KEYS */;
INSERT INTO `jewelry_demo_app_featured` VALUES (1,'','');
/*!40000 ALTER TABLE `jewelry_demo_app_featured` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_featured_featured_products`
--

DROP TABLE IF EXISTS `jewelry_demo_app_featured_featured_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_featured_featured_products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `featured_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jewelry_demo_app_feature_featured_id_product_id_e2bf1708_uniq` (`featured_id`,`product_id`),
  KEY `jewelry_demo_app_fea_product_id_3aba6621_fk_jewelry_d` (`product_id`),
  CONSTRAINT `jewelry_demo_app_fea_featured_id_9037b017_fk_jewelry_d` FOREIGN KEY (`featured_id`) REFERENCES `jewelry_demo_app_featured` (`id`),
  CONSTRAINT `jewelry_demo_app_fea_product_id_3aba6621_fk_jewelry_d` FOREIGN KEY (`product_id`) REFERENCES `jewelry_demo_app_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_featured_featured_products`
--

LOCK TABLES `jewelry_demo_app_featured_featured_products` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_featured_featured_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_featured_featured_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_order`
--

DROP TABLE IF EXISTS `jewelry_demo_app_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jewelry_demo_app_ord_customer_id_fd14f1f3_fk_jewelry_d` (`customer_id`),
  KEY `jewelry_demo_app_ord_product_id_05883556_fk_jewelry_d` (`product_id`),
  CONSTRAINT `jewelry_demo_app_ord_customer_id_fd14f1f3_fk_jewelry_d` FOREIGN KEY (`customer_id`) REFERENCES `jewelry_demo_app_customer` (`id`),
  CONSTRAINT `jewelry_demo_app_ord_product_id_05883556_fk_jewelry_d` FOREIGN KEY (`product_id`) REFERENCES `jewelry_demo_app_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_order`
--

LOCK TABLES `jewelry_demo_app_order` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_product`
--

DROP TABLE IF EXISTS `jewelry_demo_app_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `image_urls` json NOT NULL DEFAULT (_utf8mb3'[]'),
  `stock` int NOT NULL,
  `style_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `product_data` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `style_code` (`style_code`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_product`
--

LOCK TABLES `jewelry_demo_app_product` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_product_categories`
--

DROP TABLE IF EXISTS `jewelry_demo_app_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_product_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jewelry_demo_app_product_product_id_category_id_c7b583bf_uniq` (`product_id`,`category_id`),
  KEY `jewelry_demo_app_pro_category_id_ef0dabc1_fk_jewelry_d` (`category_id`),
  CONSTRAINT `jewelry_demo_app_pro_category_id_ef0dabc1_fk_jewelry_d` FOREIGN KEY (`category_id`) REFERENCES `jewelry_demo_app_category` (`id`),
  CONSTRAINT `jewelry_demo_app_pro_product_id_702f6ca6_fk_jewelry_d` FOREIGN KEY (`product_id`) REFERENCES `jewelry_demo_app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_product_categories`
--

LOCK TABLES `jewelry_demo_app_product_categories` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_product_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `jewelry_demo_app_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jewelry_demo_app_settings`
--

DROP TABLE IF EXISTS `jewelry_demo_app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jewelry_demo_app_settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `style_code_format` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auto_generate_style_code` tinyint(1) NOT NULL,
  `show_stock_to_customer` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `jewelry_demo_app_set_user_id_59e7c174_fk_jewelry_d` FOREIGN KEY (`user_id`) REFERENCES `jewelry_demo_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jewelry_demo_app_settings`
--

LOCK TABLES `jewelry_demo_app_settings` WRITE;
/*!40000 ALTER TABLE `jewelry_demo_app_settings` DISABLE KEYS */;
INSERT INTO `jewelry_demo_app_settings` VALUES (1,'JWL-####',1,1,1);
/*!40000 ALTER TABLE `jewelry_demo_app_settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-11 17:59:59
