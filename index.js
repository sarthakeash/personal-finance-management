const express = require("express");
const res = require("express/lib/response");
const app = express();
const port = 6969;
var mysql = require("mysql");
const bodyParser = require("body-parser");

const ejsLint = require('ejs-lint');
ejsLint("info", "await")
app.set("view engine", "ejs");
app.use(express.static(__dirname + "/public"));
app.use(bodyParser.urlencoded({extended:true}));
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "fin_man",
});

var users;
var name;
var transactions;
var netWorth;
var accounts;
var owns;
con.connect(function(err) {
	if (err) throw err
});
app.get("/", (req, res) => {
    con.query("SELECT * FROM users", function (err, result, fields) {
      if (err) throw err;
      console.log(result);
      users = result
  res.render("home" ,{users:users});
    });
});

 function getUserData(uid, transactions, bankAccs) {
 
   
}

 

app.get("/user/:uid", async(req, res) => {
  var uid = req.params.uid;
  con.query(`SELECT name FROM users where aadharNo=${uid}`, function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    name = result
  });
  con.query(`SELECT * FROM weekly_transactions where aadharNo=${uid}`, function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    transactions = result
  });
  con.query(`SELECT * FROM accounts where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    accounts = result;
  });
  
  con.query(`SELECT net_worth FROM networth where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    netWorth = result;
  });

  con.query(`SELECT * FROM owns where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    owns = result;
    
  res.render("info", { transactions: transactions, accounts: accounts, owns: owns, netWorth: netWorth , name:name});
  });
});


app.listen(port, () => {
  console.log(`Example app listening yes on port ${port}!`);
});
