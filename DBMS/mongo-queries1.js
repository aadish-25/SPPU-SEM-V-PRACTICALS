// SELECT DATABASE
// use DB1;

// Read all records
db.employee.find({}, {name:1}).pretty()

// Creating records
db.employee.insertOne({
    name: {
        firstname : "Aadish",
        lastname : "Sonawane"
    },
    company: "NVIDIA",
    salary: 100000,
    designation: "Senior Developer",
    age : 21,
    expertise : ["Java", "Python", "PostgreSQL"],
    dob : new Date("2004-03-25"),
    emailid: "aadish@test.com",
    contact : 9999999998,
    address : {
        paddr : "HOME1",
        laddr : "HOME2"
    }
})

db.employee.insertMany([
    {
        name: {
        firstname : "Aditi",
        lastname : "K"
    },
    company: "NVIDIA",
    salary: 99999,
    designation: "Programmer",
    age : 20,
    expertise : ['Mongodb','Mysql','Cassandra'],
    dob : new Date("2005-02-14"),
    emailid: "aditi@test.com",
    contact : 9999999998,
    address : {
        paddr : "HOME1",
        laddr : "HOME2"
    }
    }, {
        name: {
        firstname : "Samyak",
        lastname : "G"
    },
    company: "Infosys",
    salary: 100000,
    designation: "Programmer",
    age : 20,
    expertise : ["Mongodb", "Mysql", "PostgreSQL"],
    dob : new Date("2005-06-22"),
    emailid: "sg@test.com",
    contact : 9922299998,
    address : {
        paddr : "Bunglow 2",
        laddr : "Flat 2"
    }
    }, 
    {
        name: {
        firstname : "Rahul",
        lastname : "Sharma"
    },
    company: "TCS",
    salary: 100000,
    designation: "Tester",
    age : 35,
    expertise : ["X", "Y", "Z"],
    dob : new Date("2005-01-22"),
    emailid: "rahul@test.com",
    contact : 8889999998,
    address : {
        paddr : "Rahul's Home",
        laddr : "Rahul's Home"
    }
    }
])

// 1
db.employee.find({
    designation : "Tester",
    salary : { $gt : 30000}
})

// 2
db.employee.updateOne(
    {designation: "Tester", company: "TCS", age: 25},
    {$setOnInsert : {
        name: {
        firstname : "Random",
        lastname : "Uncle"
    },
    company: "TCS",
    salary: 60000,
    designation: "Tester",
    age : 25,
    expertise : ["P", "Q", "R"],
    dob : new Date("2001-10-15"),
    emailid: "uncle@test.com",
    contact : 7777799998,
    address : {
        paddr : "Pune",
        laddr : "Maharashtra"
    }
    }},
    {upsert : true}
)

// 3
db.employee.updateMany({company : "Infosys"}, {$inc : {salary : 10000}}) // increases salary by 10000
db.employee.updateMany({company : "Infosys"}, {$set : {salary : 10000}}) // sets salary to 10000

// 4
db.employee.updateMany({company : "TCS"}, {$inc : {salary : -5000}})

// 5
db.employee.find({designation : {$ne : "Tester"}})
