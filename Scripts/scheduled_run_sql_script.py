#https://downloads.mysql.com/docs/connector-python-en.a4.pdf


import mysql.connector

# connect to server
connection = mysql.connector.connect(user='admin',password='finalproject',host='final-project-db-rds.c1hgka2potxp.us-east-1.rds.amazonaws.com',port ='3306')


print('Connected to database.')
cursor = connection.cursor()

##Test query to see if you can connect
query = "select * from final_dw.dim_date;"
cursor.execute(query)
result = cursor.fetchall()
print(result)

#Call Dimension Tables Stored Procedure
with open("./update_dim_tables.sql", encoding="utf-8") as f:
    commands = f.read().split(';')

for command in commands:
    cursor.execute(command)
    print(command)

print('Dimension tables updated.')


#Call Fact Tables Stored Procedure
with open("./update_fact_table.sql", encoding="utf-8") as f:
    commands = f.read().split(';')

for command in commands:
    cursor.execute(command)
    print(command)

print('Fact tables updated.')


connection.commit()
connection.close()
print('Disconnected from database.')
