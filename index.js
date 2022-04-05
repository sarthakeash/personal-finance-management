const express = require('express')
const app = express();
const port = 6969;
var mysql = require('mysql');


var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database: "mydb"
  });
  
  con.connect(function(err) {
    if (err) throw err;
      console.log("Connected!");
      var sql = "CREATE TABLE custors (name VARCHAR(255), address VARCHAR(255))";
      con.query(sql, function (err, result) {
        if (err) throw err;
        console.log("Table created");
      });
  });



app.get('/', (req, res) => {
  res.send('Hello World!')
});
   
app.listen(port, () => {
  console.log(`Example app listening yes on port ${port}!`)
});