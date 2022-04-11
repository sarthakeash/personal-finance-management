drop database fin_man;
create database fin_man;
use fin_man;
show tables;
create table users(
aadharNo bigint unsigned not null check (aadharNo between 100000000000 and 999999999999),
name varchar(25) not null,
PRIMARY KEY (aadharNo)
);



create table accounts(
accNo bigint unsigned not null,
aadharNo bigint references users,
balance int not null,
bank varchar(25) not null,
PRIMARY KEY(bank,accNo)
);

create table transactions(
transaction_id int not null auto_increment,
isCredit int not null check (isCredit in (0,1)),
amount int not null,
accNo bigint references accounts,
bank varchar(25) references accounts,
dates DATE ,
PRIMARY KEY(transaction_id)
);


create table owns(
aadharNo bigint references users,
asset_class varchar(25) not null,
asset_id int not null auto_increment,
asset_value int not null,
PRIMARY KEY(asset_id)
);


INSERT into users value
(123233443344,'Darshil');

INSERT into users value
(245365465464,'Sarthak');

INSERT into accounts values
(1,123233443344,125,'SBI'),(1,123233443344,200,'Kotak'),(3,123233443344,500,'SBI'),(4,245365465464,1000,'SBI'),(4,245365465464,1000,'Kotak');

INSERT into owns(aadharNo,asset_class,asset_value) values
(123233443344,'Gold',1000),(123233443344,'Property',10000),(245365465464,'Gold',200),(245365465464,'Property',5000);

create view account_worth as
select aadharNo,sum(balance) as worth from accounts
group by aadharNo;

create view asset_worth as
select aadharNo,sum(asset_value) as worth from owns
group by aadharNo;

create view networth as
select aadharNo,sum(worth) as net_worth from (
select * from  account_worth 
union 
select * from asset_worth) as x
group by aadharNo;

select * from networth;
select * from transactions;

insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,500,1,'SBI','2022-04-07'),(0,200,1,'SBI','2022-04-04');

insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,500,1,'SBI','2022-03-17'),(0,200,1,'SBI','2022-04-01');


select * from transactions where
transactions.dates between date()-7 and date();
 
create view weekly_transactions as 
select t.accNo,t.bank,t.isCredit,t.amount,t.dates from 
transactions t
natural join accounts a
where t.dates > current_date - interval 7 day
order by aadharNo;
 
create view monthly_transactions as 
select t.accNo,t.bank,t.isCredit,t.amount,t.dates from 
transactions t
natural join accounts a
where t.dates > current_date - interval 28 day
order by aadharNo;
 
select * from monthly_transactions; 
 
select * from weekly_transactions;