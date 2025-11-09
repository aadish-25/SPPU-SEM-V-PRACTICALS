# Install mongosh (Mongo Shell) in Linux : 
# Check if already exists : mongosh --version

# If not then : 
# sudo apt update
# sudo apt install -y mongodb-mongosh
# sudo systemctl start mongod
# mongosh

 

# Install required packages
# sudo python3 -m pip install pymongo


# Open mongosh : 
# use test1 
# db.createCollection("emp")

# Python code
from pymongo import MongoClient

client = MongoClient("mongodb://127.0.0.1:27017")
database = client.test1
collection = database.emp

# Insert
collection.insert_one({
    "name": "smartphone",
    "quantity": "10",
    "price": "50000"
})
print("Inserted")

# Update
collection.update_one(
    {"name": "smartphone"},
    {"$set": {"price": "45000"}}
)
print("Updated")

# Delete
collection.delete_one({"name": "smartphone"})
print("Deleted")

client.close()

# Verify in mongo shell : 
# use test1
# db.emp.find().pretty()


# Menu driven code
from pymongo import MongoClient

client = MongoClient("mongodb://127.0.0.1:27017")
database = client.test1
collection = database.emp

while True:
    print("\n1. Insert")
    print("2. Update")
    print("3. Delete")
    print("4. Display")
    print("5. Exit")

    choice = input("Enter your choice: ")

    if choice == '1':
        name = input("Enter name: ")
        qty = input("Enter quantity: ")
        price = input("Enter price: ")
        collection.insert_one({"name": name, "quantity": qty, "price": price})
        print("Record inserted.")

    elif choice == '2':
        name = input("Enter name to update: ")
        price = input("Enter new price: ")
        collection.update_one({"name": name}, {"$set": {"price": price}})
        print("Record updated.")

    elif choice == '3':
        name = input("Enter name to delete: ")
        collection.delete_one({"name": name})
        print("Record deleted.")

    elif choice == '4':
        print("\n--- Records ---")
        for doc in collection.find():
            print(doc)

    elif choice == '5':
        print("Exiting...")
        break

    else:
        print("Invalid choice.")

client.close()

