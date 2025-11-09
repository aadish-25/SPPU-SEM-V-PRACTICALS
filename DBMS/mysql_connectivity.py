# Install packages : 
# pip install mysql-connector or pip install mysql-connector-python

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


# Menu Driven
import mysql.connector

my_db = mysql.connector.connect(host = "localhost", user = "root", database = "newdb")
my_cursor = my_db.cursor()

table_name = ""

while True:
    print("ENTER CHOICE : ")
    print("1. Create a table") 
    print("2. Insert data")
    print("3. Display data")
    print("4. Exit")

    choice = input("Enter your choice: ")

    if choice == '1':
        table_name = input("ENTER TABLE NAME : ")
        sql1 = f"CREATE TABLE IF NOT EXISTS {table_name} (sid int(5), sname varchar(50), rollno int(10))"
        my_cursor.execute(sql1)
        my_db.commit()
        print("Table created successfully.")

    elif choice == '2':
        if not table_name:
            print("Option 1 first to create table")
            continue

        print("Enter student id, name and rollno")
        id1 = int(input("Student id : "))
        name = input("Student name : ")
        rollno = int(input("Roll number : "))

        sql1 = f"INSERT INTO {table_name} (sid, sname, rollno) VALUES (%s, %s, %s)"
        my_cursor.execute(sql1, (id1, name, rollno))
        my_db.commit()
        print(f"{my_cursor.rowcount} record inserted.")

    elif choice == '3':
        table_name = input("Enter the table name to display data from: ")
        sql1 = f"SELECT * FROM {table_name}"
        my_cursor.execute(sql1)
        result = my_cursor.fetchall()

        if result:
            for row in result:
                print(row)
        else:
            print("No records found.")

    elif choice == '4':
        print("Exiting program...")
        break
    else:
        print("Invalid choice. Please select a valid option.")

print(my_cursor.rowcount, "Table created")

print(mycursor.rowcount, "record inserted.")



