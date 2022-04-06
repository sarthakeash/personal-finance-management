const express = require('express')
const app = express();
const port = 6969;
var mysql = require('mysql');
const reload = require('livereload');
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));


var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database: "mydb"
  });
  
//   con.connect(function(err) {
//     if (err) throw err;
//       console.log("Connected!");
//       var sql = "CREATE TABLE custors (name VARCHAR(255), address VARCHAR(255))";
//       con.query(sql, function (err, result) {
//         if (err) throw err;
//         console.log("Table created");
//       });
//   });



app.get('/', (req, res) => {
    res.render('home');
});

app.get('/user/:uid', (req, res) => {
  var uid= req.params.uid
     res.render('info')
   })
app.listen(port, () => {
  console.log(`Example app listening yes on port ${port}!`)
});


