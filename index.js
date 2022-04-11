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
var weekly_expense;
var monthly_expense = { week1: "", week2: "", week3: "", week4: "" };

con.connect(function(err) {
	if (err) throw err
});
app.get("/", (req, res) => {
    con.query("SELECT * FROM users", function (err, result, fields) {
      if (err) throw err;
            users = result
  res.render("home" ,{users:users});
    });
});

 

app.get("/user/:uid", async(req, res) => {
  var uid = req.params.uid;
  con.query(`SELECT name FROM users where aadharNo=${uid}`, function (err, result, fields) {
    if (err) throw err;
    name = result
  });


  con.query(`SELECT * FROM weekly_transactions where aadharNo=${uid}`, function (err, result, fields) {
    if (err) throw err;
    transactions = result
  });


  con.query(`SELECT * FROM accounts where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    accounts = result;
  });


  con.query(`SELECT * FROM weekly_expense where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    weekly_expense = result;
  });


  con.query(`SELECT net_worth FROM networth where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    netWorth = result;
  });

  con.query(`select sum(t.amount) as expense from transactions t natural join accounts a where (t.dates > current_date - interval 7 day) and (t.isCredit=0) and (a.aadharNo= ${uid}) order by aadharNo,dates;`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    monthly_expense.week1=result[0].expense;
  });

  con.query(`select sum(t.amount) as expense from transactions t natural join accounts a where (t.dates > current_date - interval 14 day) and (t.dates < current_date - interval 7 day) and (t.isCredit=0) and (a.aadharNo=${uid}) order by aadharNo,dates;`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    monthly_expense.week2=result[0].expense;
  });
  
  con.query(`select sum(t.amount) as expense from transactions t natural join accounts a where (t.dates > current_date - interval 21 day) and (t.dates < current_date - interval 14 day) and (t.isCredit=0) and (a.aadharNo=${uid}) order by aadharNo,dates;`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    monthly_expense.week3=result[0].expense;
  });


  con.query(`select sum(t.amount) as expense from transactions t natural join accounts a where (t.dates > current_date - interval 28 day) and (t.dates < current_date - interval 21 day) and (t.isCredit=0) and (a.aadharNo=${uid}) order by aadharNo,dates;`,  function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    monthly_expense.week4=result[0].expense;
  });

  con.query(`SELECT * FROM owns where aadharNo=${uid}`,  function (err, result, fields) {
    if (err) throw err;
    owns = result;
  res.render("info", { transactions: transactions, accounts: accounts, owns: owns, netWorth: netWorth , name:name, weekly_expense:weekly_expense, monthly_expense:monthly_expense});
  });
});


app.listen(port, () => {
  console.log(`Example app listening yes on port ${port}!`);
});
