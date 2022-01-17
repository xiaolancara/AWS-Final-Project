# Information Architechture Final Project Summer 2021
## *NYC Service Request & Median Income*

## Datasets:

Structured Dataset: obtained from https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9 using rest api method.

Unstructured Dataset: obtained from https://data.cccnewyork.org/data/table/66/median-incomes#66/107/62/a/a using chrome driver selenium method.

All datasets are stored in **S3 public bucket "ia-final-project-bucket"** on AWS cloud.

## AWS Architecture
![Architecture](https://github.com/xiaolancara/AWS-Final-Project/blob/main/InteriumDocuments/Final%20Project%20AWS%20Architechture%20work%20flow.png)

## Using following AWS services to implement the whole project:
**S3, RDS, GLUE, VPC, LAMBDA, IAM, CLOUD WATCH**

## Final Report & Presentation
This is the [Final Project Report](https://github.com/xiaolancara/AWS-Final-Project/blob/main/InteriumDocuments/Final%20Project%20Report.pdf)

This is the [Presentation File](https://github.com/xiaolancara/AWS-Final-Project/blob/main/InteriumDocuments/Final%20Project%20Presentation.pdf)
## ER Diagram
**Data Resources:**

![Data Resource](https://github.com/xiaolancara/AWS-Final-Project/blob/main/InteriumDocuments/Resource%20ER.png)


**Data WareHouse:**

![Data WareHouse](https://github.com/xiaolancara/AWS-Final-Project/blob/main/InteriumDocuments/Data%20Warehouse%20ER.png)

## Tableau Analysis
This is the link to [Tableau DashBoard](https://public.tableau.com/app/profile/cara.li/viz/FinalProjectTableauWorkbook_16294056513360/LocationvsCountofIncident?publish=yes)
