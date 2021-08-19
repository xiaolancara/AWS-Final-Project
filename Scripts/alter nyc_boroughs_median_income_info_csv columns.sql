use final_project_db;
alter table nyc_boroughs_median_income_info_csv change col0 location VARCHAR(225);
alter table nyc_boroughs_median_income_info_csv change col1 all_households VARCHAR(225);
alter table nyc_boroughs_median_income_info_csv change col2 familes VARCHAR(225);
alter table nyc_boroughs_median_income_info_csv change col3 families_with_children VARCHAR(225);
alter table nyc_boroughs_median_income_info_csv change col4 families_without_children VARCHAR(225);
delete from nyc_boroughs_median_income_info_csv LIMIT 1;

select * from nyc_boroughs_median_income_info_csv;