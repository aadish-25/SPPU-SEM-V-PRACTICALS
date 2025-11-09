// SELECT DATABASE
// use DB2;

// Read all records
db.employee.find({}, {name:1}).pretty()

// Creating records
db.employee.insertOne({
  name: {
    firstname: "Aadish",
    lastname: "Sonawane",
  },
  company: "NVIDIA",
  salary: 100000,
  designation: "Senior Developer",
  age: 21,
  expertise: ["Java", "Python", "PostgreSQL"],
  dob: new Date("2004-03-25"),
  emailid: "aadish@test.com",
  contact: 9999999998,
  address: {
    paddr: "HOME1",
    laddr: "HOME2",
  },
});

db.employee.insertMany([
  {
    name: {
      firstname: "Aditi",
      lastname: "K",
    },
    company: "NVIDIA",
    salary: 99999,
    designation: "Programmer",
    age: 20,
    expertise: ["Mongodb", "Mysql", "Cassandra"],
    dob: new Date("2005-02-14"),
    emailid: "aditi@test.com",
    contact: 9999999998,
    address: {
      paddr: "HOME1",
      laddr: "HOME2",
    },
  },
  {
    name: {
      firstname: "Samyak",
      lastname: "G",
    },
    company: "Infosys",
    salary: 100000,
    designation: "Programmer",
    age: 20,
    expertise: ["Mongodb", "Mysql", "PostgreSQL"],
    dob: new Date("2005-06-22"),
    emailid: "sg@test.com",
    contact: 9922299998,
    address: {
      paddr: "Bunglow 2",
      laddr: "Flat 2",
    },
  },
  {
    name: {
      firstname: "Rahul",
      lastname: "Sharma",
    },
    company: "TCS",
    salary: 100000,
    designation: "Tester",
    age: 35,
    expertise: ["X", "Y", "Z"],
    dob: new Date("2005-01-22"),
    emailid: "rahul@test.com",
    contact: 8889999998,
    address: {
      paddr: "Rahul's Home",
      laddr: "Rahul's Home",
    },
  },
]);

db.employee.insertMany([
  {
    name: {
      firstname: "Aditya",
      lastname: "Verma",
    },
    company: "Infosys",
    salary: 80000,
    designation: "Developer",
    age: 25,
    expertise: ["MongoDB", "Node.js", "Express"],
    dob: new Date("2000-03-15"),
    emailid: "aditya.verma@test.com",
    contact: 9876543210,
    address: {
      paddr: "Flat 12, Green Park",
      laddr: "Flat 12, Green Park",
    },
  },
  {
    name: {
      firstname: "Neha",
      lastname: "Kumar",
    },
    company: "TCS",
    salary: 95000,
    designation: "Tester",
    age: 27,
    expertise: ["Java", "MongoDB", "AWS"],
    dob: new Date("1998-09-12"),
    emailid: "neha.kumar@test.com",
    contact: 9998877766,
    address: {
      paddr: "B-23, City Heights",
      laddr: "B-23, City Heights",
    },
  },
]);

// 1
db.employee.find({ salary: { $gt: 50000 }, age: { $lt: 30 } });

// 2
db.employee.updateOne(
  { designation: "Tester", company: "TCS", age: 25 },
  {
    $setOnInsert: {
      name: {
        firstname: "Ankita",
        lastname: "T",
      },
      company: "TCS",
      salary: 100000,
      designation: "Tester",
      age: 25,
      expertise: ["A", "B", "F"],
      dob: new Date("2001-01-22"),
      emailid: "ankita@test.com",
      contact: 8889249998,
      address: {
        paddr: "Ankita's Home",
        laddr: "Ankita's Home",
      },
    },
  },
  { upsert: true }
);

// 3
db.employee.find({
    $or : [
        {age : {$lt : 30}}, 
        {salary : {$gt : 40000}}
    ]
})

/*Displays only the firstname and age of the found records*/
db.employee.find({
    $or : [{age : {$lt : 30}}, {salary : {$gt : 40000}}]
}, {"name.firstname" : 1, age: 1, _id : 0})

// 4
db.employee.find({designation : {$ne : "Developer"}})

// 5
db.employee.find({company : "Infosys"}, {name : 1, designation : 1, address : 1})

// 6
db.employee.find({}, {"name.firstname" : 1, "name.lastname": 1, _id : 0})
