SET @@SESSION.sql_mode='ALLOW_INVALID_DATES';
#Update Date Dimension
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE  final_dw.fact_table;
INSERT INTO final_dw.fact_table(incident_key, agency_key, borough_key, district_key, zipcode_key, date_key, `time_to_close(min)`)
SELECT CASE WHEN a.unique_key = '' OR a.unique_key IS NULL 
THEN -1
ELSE  incident_id END as 'incident_key',
CASE WHEN a.agency = '' OR a.agency IS NULL
THEN -1
ELSE agency_id END as 'agency_key',
CASE WHEN a.borough = '' OR a.borough IS NULL
THEN -1
ELSE borough_id END as 'borough_key',
CASE WHEN a.city = '' OR a.city IS NULL
THEN -1
ELSE district_id END as 'district_key',
CASE WHEN a.incident_zip = '' OR a.incident_zip IS NULL
THEN -1
ELSE zipcode_id END as 'zipcode_key',
CASE WHEN a.created_date = '' OR a.created_date IS NULL
THEN -1
ELSE date_id END as 'date_key',
CASE WHEN a.closed_date = '' OR a.closed_date IS NULL
THEN -1
ELSE `time_to_close(min)` END as 'time_to_close(min)'
FROM (SELECT unique_key, 
agency,
borough, 
city, 
incident_zip,  
Date(created_date) as created_date,
closed_date,
ROUND(TIMESTAMPDIFF(SECOND,created_date, closed_date)/60, 0) as `time_to_close(min)`
FROM final_project_db.`311_service_request`) a

LEFT JOIN final_dw.dim_incident ON a.unique_key = final_dw.dim_incident.incident_id
LEFT JOIN final_dw.dim_agency ON a.agency = final_dw.dim_agency.agency_code 
LEFT JOIN final_dw.dim_income_borough ON a.borough = final_dw.dim_income_borough.borough_name
LEFT JOIN final_dw.dim_income_district ON a.city = final_dw.dim_income_district.district_name
LEFT JOIN final_dw.dim_income_zipcode ON a.incident_zip = final_dw.dim_income_zipcode.zipcode
LEFT JOIN final_dw.dim_date ON a.created_date = final_dw.dim_date.date_string
GROUP BY incident_key, agency_key, borough_key, district_key, zipcode_key, date_key
ORDER BY incident_key, agency_key, borough_key, district_key, zipcode_key, date_key;
SET FOREIGN_KEY_CHECKS=1;
