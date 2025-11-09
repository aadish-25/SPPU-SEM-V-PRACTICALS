// SELECT DATABASE
// use DB3;

// Read all records
db.employee.find({}, {name:1}).pretty()

// Creating records
db.employee.insertOne({
  name: {
    firstname: "Aadish",
    lastname: "Sonawane"
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
    city: "Pune",
    pincode: 411001
  }
});

db.employee.insertMany([
  {
    name: {
      firstname: "Aditi",
      lastname: "K"
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
      city: "Pune",
      pincode: 411001
    }
  },
  {
    name: {
      firstname: "Samyak",
      lastname: "G"
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
      city: "Hyderabad",
      pincode: 500032
    }
  },
  {
    name: {
      firstname: "Rahul",
      lastname: "Sharma"
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
      city: "Delhi",
      pincode: 110001
    }
  }
]);

// 1
db.employee.updateOne(
  { designation: "Tester", company: "TCS", age: 25 },
  {
    $setOnInsert: {
      name: {
        firstname: "NEW",
        lastname: "NEW",
      },
      company: "TCS",
      salary: 103330,
      designation: "Tester",
      age: 25,
      expertise: ["X", "Y", "Z"],
      dob: new Date("2005-01-22"),
      emailid: "NEW@test.com",
      contact: 8881999998,
      address: {
        paddr: "NEW's Home",
        laddr: "NEW's Home",
        city: "Pune",
        pincode: 411062
      },
    },
  },
  { upsert: true }
);

// 2
db.employee.updateMany({company: "TCS"}, {$inc : {salary : 2000}})

// 3
db.employee.find({"address.city": "Pune", "address.pincode": 411001}, {name: 1})

// 4
db.employee.find({
    $or : [{designation: "Developer"}, {designation: "Tester"}]
})

db.employee.find({ designation : { $in : ["Developer", "Tester"]}})

// 5
db.employee.deleteOne({designation: "Developer"})

// 6
db.employee.countDocuments()
