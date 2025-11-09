# Install packages : 
# pip install mysql-connector

# # Remove root password : 
# sudo mysql -u root -p
# USE mysql;
# UPDATE user SET plugin='mysql_native_password' WHERE User='root';
# FLUSH PRIVILEGES;
# EXIT;
# sudo service mysql restart

# IN MYSQL
# CREATE DATABASE db3;
# USE db3;

# CREATE TABLE stud1 (
#     name VARCHAR(50),
#     rno INT
# );

import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",       
    database="db3"
)

mycursor = mydb.cursor()

sql = "INSERT INTO stud1 (name, rno) VALUES ('Aadish', 212)"
mycursor.execute(sql)

mydb.commit()

print(mycursor.rowcount, "record inserted.")

