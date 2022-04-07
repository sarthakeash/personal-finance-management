const express = require("express");
const app = express();
const port = 6969;
var mysql = require("mysql");
app.set("view engine", "ejs");
app.use(express.static(__dirname + "/public"));

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "dtj@sql123",
  database: "fin_man",
});

con.connect(function(err) {
  if (err) throw err;
  con.query("SELECT * FROM users", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
  });
});

const users = [
  { uid: 123456789012, name: "Darshil Chutiya" },
  { uid: 123456789013, name: "Darshil Harami" },
  { uid: 123456789014, name: "Darshil Incel" },
  { uid: 123456789015, name: "Darshil Kutta" },
];

const transactions=[
{accNo:1234, nature:"credit", amt:988, bank:"icici"},{accNo:1434, nature:"debit", amt:800, bank:"axis"}
]


const bankAccs=[
  {accNo:1234, balance:988, bank:"icici"},{accNo:1434, balance:800, bank:"axis"}
  ]

app.get("/", (req, res) => {
  res.render("home" ,{users:users});
});

app.get("/user/:uid", (req, res) => {
  var uid = req.params.uid;
  res.render("info");
});
app.listen(port, () => {
  console.log(`Example app listening yes on port ${port}!`);
});
