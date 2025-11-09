// SELECT DATABASE
// use DB5;

// Read all records
db.employee.find({}, { name: 1 }).pretty();

// Creating records
db.employee.insertMany([
  {
    name: { firstname: "Aadish", lastname: "Sonawane" },
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
    },
  },
  {
    name: { firstname: "Aditi", lastname: "K" },
    company: "NVIDIA",
    salary: 95000,
    designation: "Programmer",
    age: 24,
    expertise: ["MongoDB", "MySQL", "Cassandra"],
    dob: new Date("2001-02-14"),
    emailid: "aditi@test.com",
    contact: 9999999997,
    address: {
      paddr: "Flat 5, Sunrise Residency",
      laddr: "Flat 5, Sunrise Residency",
      city: "Mumbai",
    },
  },
  {
    name: { firstname: "Samyak", lastname: "G" },
    company: "Infosys",
    salary: 87000,
    designation: "Programmer",
    age: 29,
    expertise: ["MongoDB", "MySQL", "PostgreSQL"],
    dob: new Date("1996-06-22"),
    emailid: "sg@test.com",
    contact: 9922299998,
    address: {
      paddr: "Bungalow 2",
      laddr: "Flat 2",
      city: "Hyderabad",
    },
  },
  {
    name: { firstname: "Rahul", lastname: "Sharma" },
    company: "TCS",
    salary: 120000,
    designation: "DBA",
    age: 41,
    expertise: ["Oracle", "SQL", "MongoDB"],
    dob: new Date("1984-01-22"),
    emailid: "rahul@test.com",
    contact: 8889999998,
    address: {
      paddr: "Rahul's Home",
      laddr: "Rahul's Home",
      city: "Pune",
    },
  },
  {
    name: { firstname: "Sneha", lastname: "Patel" },
    company: "TCS",
    salary: 110000,
    designation: "DBA",
    age: 35,
    expertise: ["MySQL", "PostgreSQL"],
    dob: new Date("1990-11-12"),
    emailid: "sneha@test.com",
    contact: 9888888888,
    address: {
      paddr: "Flat 3A, Lake View",
      laddr: "Flat 3A, Lake View",
      city: "Pune",
    },
  },
  {
    name: { firstname: "Karan", lastname: "Mehta" },
    company: "Accenture",
    salary: 95000,
    designation: "Developer",
    age: 27,
    expertise: ["Java", "Spring", "Hibernate"],
    dob: new Date("1998-05-03"),
    emailid: "karan@test.com",
    contact: 9444444444,
    address: {
      paddr: "Plot 8, Blue Sky Colony",
      laddr: "Plot 8, Blue Sky Colony",
      city: "Delhi",
    },
  },
  {
    name: { firstname: "Swapnil", lastname: "Jadhav" },
    company: "Infosys",
    salary: 102000,
    designation: "Tester",
    age: 38,
    expertise: ["Selenium", "Cypress", "MongoDB"],
    dob: new Date("1987-09-25"),
    emailid: "swapnil@test.com",
    contact: 9777777777,
    address: {
      paddr: "Wing B, Tech Park",
      laddr: "Wing B, Tech Park",
      city: "Pune",
    },
  },
  {
    name: { firstname: "Neha", lastname: "Patil" },
    company: "Wipro",
    salary: 87000,
    designation: "UI Developer",
    age: 28,
    expertise: ["HTML", "CSS", "React"],
    dob: new Date("1997-12-10"),
    emailid: "neha@test.com",
    contact: 9666666666,
    address: {
      paddr: "Wing A, Green Gardens",
      laddr: "Wing A, Green Gardens",
      city: "Bangalore",
    },
  },
]);

// QUESTIONS
// 1. Display the total salary of per company
// 2. Display the total salary of company Name:"TCS"
// 3. Return the average salary of company whose address is “Pune".
// 4. Display total count for “City=Pune”
// 5. Return count for city pune and age greater than 40.

// 1
db.employee.mapReduce(
  function () {
    emit(this.company, this.salary);
  },
  function (key, value) {
    return Array.sum(value);
  },
  { out: { inline: 1 } }
);

// 2
db.employee.mapReduce(
    function() {emit(this.company, this.salary);},
    function(key, value) {return Array.sum(value);},
    {
        query: {company: "TCS"},
        out: {inline: 1}
    }
)

// 3
db.employee.mapReduce(
  function() { emit(this.company, { total: this.salary, count: 1 }); },
  function(key, values) {
    let result = { total: 0, count: 0 };
    values.forEach(v => {
      result.total += v.total;
      result.count += v.count;
    });
    return result;
  },
  {
    query: { "address.city": "Pune" },
    out: { inline: 1 },
    finalize: function(key, reducedVal) {
      reducedVal.avg = reducedVal.total / reducedVal.count;
      return reducedVal;
    }
  }
)

// 4
db.employee.mapReduce(
  function() { emit(this.address.city, 1); },
  function(key, values) { return Array.sum(values); },
  {
    query: { "address.city": "Pune" },
    out: { inline: 1 }
  }
)

// 5
db.employee.mapReduce(
  function() { emit(this.address.city, 1); },
  function(key, values) { return Array.sum(values); },
  {
    query: { "address.city": "Pune", age: { $gt: 40 } },
    out: { inline: 1 }
  }
)

