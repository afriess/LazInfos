-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: CTR-NEU
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `CTR-NEU`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `CTR-NEU` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `CTR-NEU`;

--
-- Table structure for table `ctr_Business`
--

DROP TABLE IF EXISTS `ctr_Business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctr_Business` (
  `OID` char(36) NOT NULL,
  `OIDContactTitle` char(36) DEFAULT NULL,
  `Name1` varchar(50) DEFAULT NULL,
  `Name2` varchar(50) DEFAULT NULL,
  `Name3` varchar(50) DEFAULT NULL,
  `Addition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`OID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctr_Business`
--

LOCK TABLES `ctr_Business` WRITE;
/*!40000 ALTER TABLE `ctr_Business` DISABLE KEYS */;
INSERT INTO `ctr_Business` VALUES ('17C445C7-C5FB-4328-B894-EF417EEAFED6','D2D00F3E-1DE4-4A7E-BC48-16DC9EA9027A','CTR Klaus Riesterer','Computertechnik','its me :-)',''),('535B18A8-8AE2-46BE-BBCA-E087AECFA46E','5D89ED10-353C-4972-B222-2EA9506E0EC0','Hotel Adlon','','',''),('965DA620-E822-41BE-8FBB-0AFFE555FF32','5D89ED10-353C-4972-B222-2EA9506E0EC0','Riverside Hotel','','','');
/*!40000 ALTER TABLE `ctr_Business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctr_ContactTitle`
--

DROP TABLE IF EXISTS `ctr_ContactTitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctr_ContactTitle` (
  `OID` char(36) NOT NULL,
  `TitleType` tinyint(3) DEFAULT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `SearchTitle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`OID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctr_ContactTitle`
--

LOCK TABLES `ctr_ContactTitle` WRITE;
/*!40000 ALTER TABLE `ctr_ContactTitle` DISABLE KEYS */;
INSERT INTO `ctr_ContactTitle` VALUES ('5D89ED10-353C-4972-B222-2EA9506E0EC0',1,'Group for Hotels','Hotel'),('D2D00F3E-1DE4-4A7E-BC48-16DC9EA9027A',0,'Group for People','');
/*!40000 ALTER TABLE `ctr_ContactTitle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-12 12:27:52
