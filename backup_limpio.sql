-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: bienesraices_node_mvc
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Current Database: `bienesraices_node_mvc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bienesraices_node_mvc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bienesraices_node_mvc`;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Casa','2025-07-23 14:21:33','2025-07-23 14:21:33'),(2,'Apartamento','2025-07-23 14:21:33','2025-07-23 14:21:33'),(3,'Bodega','2025-07-23 14:21:33','2025-07-23 14:21:33'),(4,'Terreno','2025-07-23 14:21:33','2025-07-23 14:21:33'),(5,'Caba├▒a','2025-07-23 14:21:33','2025-07-23 14:21:33'),(6,'Negocio','2025-07-23 14:21:33','2025-07-23 14:21:33');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mensaje` varchar(200) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propiedadId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `usuarioId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `propiedadId` (`propiedadId`),
  KEY `usuarioId` (`usuarioId`),
  CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`propiedadId`) REFERENCES `propiedades` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
INSERT INTO `mensajes` VALUES (1,'Hola, quiero saber acerca de la casa','2025-08-23 22:55:23','2025-08-23 22:55:23','7e25e564-cb1a-4b09-bba1-3671e8f63b54',3);
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precios`
--

DROP TABLE IF EXISTS `precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `precios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precios`
--

LOCK TABLES `precios` WRITE;
/*!40000 ALTER TABLE `precios` DISABLE KEYS */;
INSERT INTO `precios` VALUES (1,'0 - $10,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(2,'$10,000 - $30,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(3,'$30,000 - $50,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(4,'$50,000 - $75,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(5,'$75,000 - $100,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(6,'$100,000 - $150,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(7,'$150,000 - $200,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(8,'$200,000 - $300,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(9,'$300,000 - $500,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33'),(10,'+ $500,000 USD','2025-07-23 14:21:33','2025-07-23 14:21:33');
/*!40000 ALTER TABLE `precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propiedades`
--

DROP TABLE IF EXISTS `propiedades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propiedades` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `habitaciones` int NOT NULL,
  `estacionamiento` int NOT NULL,
  `wc` int NOT NULL,
  `calle` varchar(60) NOT NULL,
  `lat` varchar(255) NOT NULL,
  `lng` varchar(255) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `publicado` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `precioId` int DEFAULT NULL,
  `categoriaId` int DEFAULT NULL,
  `usuarioId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `precioId` (`precioId`),
  KEY `categoriaId` (`categoriaId`),
  KEY `usuarioId` (`usuarioId`),
  CONSTRAINT `propiedades_ibfk_1` FOREIGN KEY (`precioId`) REFERENCES `precios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `propiedades_ibfk_2` FOREIGN KEY (`categoriaId`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `propiedades_ibfk_3` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedades`
--

LOCK TABLES `propiedades` WRITE;
/*!40000 ALTER TABLE `propiedades` DISABLE KEYS */;
INSERT INTO `propiedades` VALUES ('211a508e-96ff-4080-b66e-310ce8f41399','Sapo','Sapo',8,2,2,'Calle 7','4.807228','-75.684937','1j2de0jn9cmngc4k4p98.jpg',1,'2025-08-11 20:44:02','2025-08-25 16:58:08',3,3,2),('59081e9a-0994-479f-b01d-e21c7d172ff2','Monda','Monda',2,1,1,'Americas','4.807598896487','-75.711231595098','1j2de6d4p9oj5hou0q6o.jpg',1,'2025-08-11 20:47:09','2025-08-11 20:47:18',8,1,2),('5f0202a2-d2cb-47de-8891-609a24c68575','Hola x2','Hola x2',2,1,1,'Calle 8 12 B 17','4.807743','-75.68571','1j2ddtve8osad1lijc1o.jpg',1,'2025-08-11 20:42:36','2025-08-11 20:42:42',4,3,2),('6dc9e2e8-9a24-4da5-8501-9c38dba0b41a','Sapo','Sapo x2',3,1,2,'Carrera 8B 31 B 27','4.8144322','-75.7037869','1j2de25dnsb15ncqrdj.jpg',1,'2025-08-11 20:44:54','2025-08-11 20:44:59',2,2,2),('7e25e564-cb1a-4b09-bba1-3671e8f63b54','ppppp','ppp',1,1,2,'Carrera 15 13 41','4.806583013761','-75.681300878376','1j2de33jvt0h6gradt5g.jpg',1,'2025-08-11 20:45:24','2025-08-11 20:45:30',1,1,2),('9ff4a518-05fa-4b25-9ab3-a25fe0a53908','Casa en la Playa (Actualizado)','Casa en la Playa',3,1,2,'Carrera 11B 1 A 13','4.809096','-75.67986','1j1br4so62gso17bi2a.jpg',1,'2025-07-29 19:39:21','2025-08-05 19:57:09',10,2,2),('adae41d2-0574-4e33-ae96-f333cd7f8179','Finca en Venta ','Finca con 2 habitaciones, remodelada, con terraza',2,1,2,'Calle 10 10 22','4.809398','-75.687565','1j1rmte0fptkaq4jmfmg.jpg',1,'2025-08-04 23:33:03','2025-08-04 23:33:21',5,1,2),('c6ca5ecc-3c22-403d-a6eb-cd8283caff67','Apartamento remodelado','apto',2,2,1,'Calle 11 10B 13','4.810869016131','-75.687764918286','1j2de43njhrsu5ei0cqo.jpg',1,'2025-08-11 20:45:57','2025-08-23 23:28:01',5,2,2),('d3d531e1-fbea-4b93-a547-24c993d6f83a','Finca ','Finca',5,2,2,'Calle 2 Este 9A 55','4.809671502912','-75.678105579557','1j2deae1fi2hjcvhnsn8.jpg',1,'2025-08-11 20:49:20','2025-08-11 20:49:30',2,1,2),('f3219261-51cf-47d6-9b99-77d4082b7d4e','Hola x3','Hola x3',9,1,3,'Calle 14 13 72','4.8081913','-75.6908092','1j2ddv50ko991cjn8d3.jpg',1,'2025-08-11 20:43:11','2025-08-11 20:43:20',2,2,2),('fd9867c4-1060-4566-934f-4ae237fe8700','Care monda','Caremonda',3,1,2,'Carrera 12','4.808558451309','-75.681361153564','1j2de1bjghlgo8ofmgq.jpg',1,'2025-08-11 20:44:28','2025-08-11 20:44:32',2,1,2);
/*!40000 ALTER TABLE `propiedades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `confirmado` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (2,'Marito','mariodelgado616@hotmail.com','$2b$10$2qFaNRVR5LqEg9BfvvrqluhmKWqC5hJTZJBZKbKVsd5Ya5QbCvNM.',NULL,1,'2025-07-25 15:26:13','2025-07-25 15:26:17'),(3,'libi','libi@libi.com','$2b$10$Ac/cdKr7VxCoSrsQZCJsf.y9chldVLrf.0WQ9tHUPStnEbrXD9zza',NULL,1,'2025-07-25 15:45:05','2025-07-25 15:45:10'),(4,'Cesar','laxel37533@frisbook.com','$2b$10$.t5jsOBwV6Q5HEzGnW.YlOKXw0Q/gz.K0dRIU0sg69wHphpgQPtDe','',1,'2025-07-29 16:11:07','2025-07-29 16:11:07');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-28 20:31:16

