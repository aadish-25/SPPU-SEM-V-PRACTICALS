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
