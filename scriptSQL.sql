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

INSERT into users value
(721721721692,'Mitul');

INSERT into accounts values
(1,123233443344,125,'SBI'),(1,123233443344,200,'Kotak'),(3,123233443344,500,'SBI'),(4,245365465464,1000,'SBI'),(4,245365465464,1000,'Kotak');

INSERT into accounts values
(3,721721721692,10000,'Kotak');
INSERT into owns(aadharNo,asset_class,asset_value) values
(245365465464,'Car',2000),(245365465464,'Stocks',4000);

INSERT into owns(aadharNo,asset_class,asset_value) values
(245365465464,'Car',1400),(245365465464,'Stocks',400),(245365465464,'Jewellery',1000),(245365465464,'Property',20000) ;

INSERT into owns(aadharNo,asset_class,asset_value) values
(123233443344,'Stocks',6000);

INSERT into owns(aadharNo,asset_class,asset_value) values
(123233443344,'Car',2400),(123233443344,'Stocks',4000),(123233443344,'Jewellery',2000),(123233443344,'Property',10000) ;

INSERT into owns(aadharNo,asset_class,asset_value) values
(721721721692,'Car',1000),(721721721692,'Stocks',1000);

INSERT into owns(aadharNo,asset_class,asset_value) values
(721721721692,'Jewellery',100),(721721721692,'Property',5000) ;

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
(1,300,3,'Kotak','2022-04-07'),(0,100,3,'Kotak','2022-04-04');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,250,3,'Kotak','2022-03-17'),(0,280,3,'Kotak','2022-04-01');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,540,3,'Kotak','2022-03-18'),(0,30,3,'Kotak','2022-04-18');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,130,3,'Kotak','2022-03-28'),(0,260,3,'Kotak','2022-04-17');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,750,3,'Kotak','2022-04-07'),(0,30,3,'Kotak','2022-04-20');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,700,3,'Kotak','2022-04-13'),(1,400,3,'Kotak','2022-04-11');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,500,3,'Kotak','2022-04-12'),(0,200,3,'Kotak','2022-04-08');

insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,350,4,'Kotak','2022-04-07'),(0,200,4,'Kotak','2022-04-04');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,25,4,'Kotak','2022-03-17'),(0,780,4,'Kotak','2022-04-01');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,500,4,'Kotak','2022-03-18'),(0,200,4,'Kotak','2022-04-18');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,150,4,'SBI','2022-03-28'),(0,250,4,'SBI','2022-04-17');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,790,4,'SBI','2022-04-07'),(0,330,4,'SBI','2022-04-20');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,70,4,'SBI','2022-04-13'),(1,20,4,'SBI','2022-04-11');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,500,4,'SBI','2022-04-12'),(0,300,4,'SBI','2022-04-08');

insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,50,1,'Kotak','2022-04-07'),(0,300,1,'Kotak','2022-04-04');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,250,1,'Kotak','2022-03-17'),(0,78,1,'Kotak','2022-04-01');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,300,1,'Kotak','2022-03-18'),(0,200,1,'Kotak','2022-04-18');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,50,1,'SBI','2022-03-28'),(0,250,1,'SBI','2022-04-17');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(0,90,1,'SBI','2022-04-07'),(0,300,1,'SBI','2022-04-20');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,300,3,'SBI','2022-04-13'),(1,200,3,'SBI','2022-04-11');
insert into transactions(isCredit,amount,accNo,bank,dates) values
(1,300,3,'SBI','2022-04-12'),(0,400,3,'SBI','2022-04-08');

create view weekly_transactions as 
select t.accNo,t.bank,t.isCredit,t.amount,t.dates, a.aadharNo from 
transactions t
natural join accounts a
where t.dates > current_date - interval 7 day
order by aadharNo;

create view monthly_transactions as 
select t.accNo,t.bank,t.isCredit,t.amount,t.dates, a.aadharNo from 
transactions t
natural join accounts a
where t.dates > current_date - interval 28 day
order by aadharNo;
 

create view weekly_expense as
select sum(t.amount) as expense,t.dates,a.aadharNo from 
transactions t
natural join accounts a
where (t.dates > current_date - interval 7 day) and (t.isCredit=0) 
group by t.dates,a.aadharNo
order by a.aadharNo;



-- demo query
INSERT into accounts values
(7,123233443344,50,'SBI')




