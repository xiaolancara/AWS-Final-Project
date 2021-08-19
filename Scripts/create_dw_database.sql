DROP DATABASE IF EXISTS `final_dw`;
CREATE DATABASE  IF NOT EXISTS `final_dw`;
USE `final_dw`;

DROP TABLE IF EXISTS `dim_income_district`;
CREATE TABLE `dim_income_district` (
  `district_id` int NOT NULL AUTO_INCREMENT,
  `district_name` varchar(20) DEFAULT NULL,
  `median_income` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`district_id`)
);

DROP TABLE IF EXISTS `dim_income_borough`;
CREATE TABLE `dim_income_borough` (
  `borough_id` int NOT NULL AUTO_INCREMENT,
  `borough_name` varchar(20) DEFAULT NULL,
  `median_income` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`borough_id`)
);

DROP TABLE IF EXISTS `dim_income_zipcode`;
CREATE TABLE `dim_income_zipcode` (
  `zipcode_id` int NOT NULL AUTO_INCREMENT,
  `zipcode` varchar(20) DEFAULT NULL,
  `median_income` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`zipcode_id`)
);

DROP TABLE IF EXISTS `dim_agency`;
CREATE TABLE `dim_agency` (
  `agency_id` int NOT NULL AUTO_INCREMENT,
  `agency_code` varchar(5) DEFAULT NULL,
  `agency_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`agency_id`)
);

DROP TABLE IF EXISTS `dim_incident`;
CREATE TABLE `dim_incident` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `complaint_type` varchar(200) DEFAULT NULL,
  `descriptor` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `borough` varchar(200) DEFAULT NULL,
  `district` varchar(200) DEFAULT NULL,
  `zip_code` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`incident_id`)
);

DROP TABLE IF EXISTS `dim_date`;
CREATE TABLE `dim_date` (
  `date_id` int NOT NULL AUTO_INCREMENT,
  `date_string` varchar(45) DEFAULT NULL,
  `date_year` int DEFAULT NULL,
  `date_month` int DEFAULT NULL,
  `date_day` int DEFAULT NULL,
  `date_quarter` int DEFAULT NULL,
  `date_weekday` int DEFAULT NULL,
  `date_week` int DEFAULT NULL,
  PRIMARY KEY (`date_id`)
);

DROP TABLE IF EXISTS `fact_table`;
CREATE TABLE `fact_table` (
case_key int NOT NULL AUTO_INCREMENT,
incident_key int DEFAULT NULL,
agency_key int DEFAULT NULL,
borough_key int DEFAULT NULL,
district_key int DEFAULT NULL,
zipcode_key int DEFAULT NULL,
date_key int DEFAULT NULL,
`time_to_close(min)` int DEFAULT NULL,

PRIMARY KEY (case_key),
FOREIGN KEY (incident_key) references `dim_incident` (incident_id),
FOREIGN KEY (agency_key) references `dim_agency` (agency_id),
FOREIGN KEY (borough_key) references `dim_income_borough` (borough_id),
FOREIGN KEY (district_key) references `dim_income_district` (district_id),
FOREIGN KEY (zipcode_key) references `dim_income_zipcode` (zipcode_id),
FOREIGN KEY (date_key) references `dim_date` (date_id)
);