How to start the project at your localhost?

Requirements: NodeJS, mySQL

Steps:
Download the zip file
Extract the zip folder 
Open the terminal inside the zip folder
Run the following commands:
       1) cd personal-finance-management
       2) npm i
Open the folder in any IDE
Open the file index.js

In the line no: 15, change the root password according to your MySQL instance

Open MySQL workbench, and run the given SQL file. (fin_man.sql)

Now go back to the terminal, where we initially left and do npm run serve

If it shows an error, run the following script in MySQL:
 ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY <your password> ; and do npm run serve again
 The app is now hosted at localhost:4000
