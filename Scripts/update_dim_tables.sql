SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';
#Update Date Dimension
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE  final_dw.dim_date;
INSERT INTO final_dw.dim_date(date_string, date_year,date_month, date_day, date_quarter, date_weekday, date_week) 
SELECT  distinct
Date(created_date) as 'Date String',
YEAR(created_date) as Year,
MONTH(created_date) as Month,
Day(created_date) as Day,
Quarter(created_date) as Quarter,
WeekDay(created_date) as WeekDay,
Week(created_date) as Week
FROM final_project_db.`311_service_request`
ORDER BY YEAR,MONTH, DAY;

TRUNCATE TABLE  final_dw.dim_agency;
INSERT INTO final_dw.dim_agency(agency_code, agency_name)
SELECT  DISTINCT 
agency as agency_code,
agency_name as agency_name
FROM final_project_db.`311_service_request`;

TRUNCATE TABLE  final_dw.dim_incident;
INSERT INTO final_dw.dim_incident(incident_id, complaint_type, descriptor, description, borough, district, zip_code, latitude, longitude)
SELECT  DISTINCT 
unique_key as incident_id,
complaint_type as complaint_type,
descriptor as descriptor,
resolution_description as description,
borough as borough,
city as district,
incident_zip as zip_code,
latitude as latitude,
longitude as longitude
FROM final_project_db.`311_service_request`
ORDER BY CAST(incident_id AS SIGNED INTEGER);

TRUNCATE TABLE  final_dw.dim_income_borough;
INSERT INTO final_dw.dim_income_borough(borough_name, median_income)
SELECT  DISTINCT 
location as borough_name,
all_households as median_income
FROM final_project_db.nyc_boroughs_median_income_info_csv;

TRUNCATE TABLE  final_dw.dim_income_district;
INSERT INTO final_dw.dim_income_district(district_name, median_income)
SELECT  DISTINCT 
location as district_name,
all_households as median_income
FROM final_project_db.nyc_districts_median_income_info_csv;

TRUNCATE TABLE  final_dw.dim_income_zipcode;
INSERT INTO final_dw.dim_income_zipcode(zipcode, median_income)
SELECT  DISTINCT 
location as zipcode,
all_households as median_income
FROM final_project_db.nyc_zipcodes_median_income_info_csv;
SET FOREIGN_KEY_CHECKS=1