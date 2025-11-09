// SELECT DATABASE
// use DB4;

// Read all records
db.employee.find({}, { name: 1 }).pretty();

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
    designation: "DBA",
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
  {
    name: {
      firstname: "Neha",
      lastname: "Patel",
    },
    company: "Wipro",
    salary: 85000,
    designation: "UI Developer",
    age: 26,
    expertise: ["HTML", "CSS", "React"],
    dob: new Date("1999-11-10"),
    emailid: "neha@test.com",
    contact: 9777777777,
    address: {
      paddr: "Wing A, Sunrise Apartments",
      laddr: "Wing A, Sunrise Apartments",
    },
  },
  {
    name: {
      firstname: "Rohit",
      lastname: "Verma",
    },
    company: "TCS",
    salary: 92000,
    designation: "Backend Engineer",
    age: 28,
    expertise: ["Node.js", "Express", "MongoDB"],
    dob: new Date("1997-05-19"),
    emailid: "rohit@test.com",
    contact: 9666666666,
    address: {
      paddr: "Flat 23, Maple Residency",
      laddr: "Flat 23, Maple Residency",
    },
  },
  {
    name: {
      firstname: "Sneha",
      lastname: "Gupta",
    },
    company: "Infosys",
    salary: 87000,
    designation: "Data Analyst",
    age: 24,
    expertise: ["Python", "SQL", "PowerBI"],
    dob: new Date("2001-07-08"),
    emailid: "sneha@test.com",
    contact: 9555555555,
    address: {
      paddr: "House 14, Green Valley",
      laddr: "House 14, Green Valley",
    },
  },
  {
    name: {
      firstname: "Karan",
      lastname: "Mehta",
    },
    company: "Accenture",
    salary: 94000,
    designation: "DBA",
    age: 29,
    expertise: ["Java", "Spring", "Hibernate"],
    dob: new Date("1996-09-03"),
    emailid: "karan@test.com",
    contact: 9444444444,
    address: {
      paddr: "Plot 8, Blue Sky Colony",
      laddr: "Plot 8, Blue Sky Colony",
    },
  },
]);

// 1 -  Using aggregation Return Designation with Total Salary is Above 200000
db.employee.aggregate([
  {
    $group: {
      _id: "$designation",
      totalSalary: { $sum: "$salary" },
    },
  },
  {
    $match: {
      totalSalary: { $gt: 20000 },
    },
  },
]);

// 2 -  Using Aggregate method returns names and _id in upper case and in alphabetical order.
db.employee.aggregate([
  {
    $project: {
      _id: { $toUpper: { $toString: "$_id" } },
      firstname: { $toUpper: "$name.firstname" },
      lastname: { $toUpper: "$name.lastname" },
    },
  },
  {
    $sort: { firstname: 1 },
  },
]);

// 3 - Using aggregation method find Employee with Total Salary for Each City with Designation="DBA".
db.employee.aggregate([
  { $match: { designation: "DBA" } },
  {
    $group: {
      _id: "$city",
      totalSalary: { $sum: "$salary" },
    },
  },
]);

// 4 - Create a Single Field Index on Designation
db.employee.createIndex({ designation: 1 });
db.employee.getIndexes();

// 5 - To Create Multikey Indexes on Expertise field of employee collection
db.employee.createIndex({ expertise: 1 });

// 6
for (let i = 1; i <= 1000; i++) {
  db.employee.insertOne({
    Emp_id: i,
    name: { firstname: "Emp" + i, lastname: "Test" + i },
    salary: Math.floor(Math.random() * 100000) + 30000,
    designation: "Developer",
    expertise: ["MongoDB"],
    address: { city: "Pune" },
  });
}

var start = new Date();
db.employee.find({ Emp_id: 9000 }).toArray();
var end = new Date();
print("Time without index (ms):", end - start);

db.employee.createIndex({ Emp_id: 1 });

var start = new Date();
db.employee.find({ Emp_id: 9000 }).toArray();
var end = new Date();
print("Time with index (ms):", end - start);

// 7 - Return a List of Indexes on created on employee Collection
db.employee.getIndexes();

// --------------------------------------------

// 1. Using aggregation Return separates value in the Expertise array and return sum of each element of array.
db.employee.aggregate([
  { $unwind: "$expertise" },
  {
    $group: {
      _id: "$expertise",
      totalCount: { $sum: 1 },
    },
  },
  { $sort: { totalCount: -1 } },
]);

// 2. Using Aggregate method return Max and Min Salary for each company.
db.employee.aggregate([
  {
    $group: {
      _id: "$company",
      maxSalary: { $max: "$salary" },
      minSalary: { $min: "$salary" },
    },
  },
]);

// 3. Using Aggregate method find Employee with Total Salary for Each City with Designation="DBA".
db.employee.aggregate([
  { $match: { designation: "DBA" } },
  {
    $group: {
      _id: "$address.paddr",
      totalSalary: { $sum: "$salary" },
    },
  },
]);

// 4. Using aggregation method Return separates value in the Expertise array for employee name where Swapnil Jadhav
db.employee.aggregate([
  {
    $match: {
      "name.firstname": "Aadish",
      "name.lastname": "Sonawane",
    },
  },
  {
    $unwind: "$expertise",
  },
  {
    $project: {
      "name.firstname": 1,
      "name.lastname": 1,
      _id: 1,
      expertise: 1,
    },
  },
]);

// 5 - To Create Compound Indexes on Name: 1, Age: -1
db.employee.createIndex({"name.firstname": 1, age:-1})

// 6 and 7 same as previous
