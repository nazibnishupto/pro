drop table orders;
drop table product;
drop table customer;
create table customer
(
	cust_id integer,
	name varchar(10),
	contact_no integer unique,
	primary key(cust_id)
);

create table product
(
	product_id integer,
	name varchar(10),
	price integer check(price<=5000),
	p_type varchar(10),
	primary key(product_id)
);

create table orders
(
	c_id integer,
	p_id integer,
	order_date DATE,
	foreign key(c_id) references customer(cust_id) on delete cascade,
	foreign key(p_id) references product(product_id) on delete cascade
);

describe customer;
describe product;
describe orders;

alter table product rename column p_type to type;

describe product;


insert into customer(cust_id,name,contact_no) values(1,'farid',01712010101);
insert into customer(cust_id,name,contact_no) values(2,'anik',01712010102);
insert into customer(cust_id,name,contact_no) values(3,'ruma',01712010103);
insert into customer(cust_id,name,contact_no) values(4,'aalok',01712010104);


insert into product(product_id,name,price, type) values(1,'e',1000,'food');
insert into product(product_id,name,price, type) values(2,'f',2000,'food');
insert into product(product_id,name,price, type) values(3,'g',3000,'cloth');
insert into product(product_id,name,price, type) values(4,'h',4000,'cloth');

insert into orders(c_id,p_id,order_date) values(1,1,'28-feb-2018');			
insert into orders(c_id,p_id,order_date) values(2,3,'7-feb-2018');
insert into orders(c_id,p_id,order_date) values(3,4,'1-feb-2018');
insert into orders(c_id,p_id,order_date) values(4,4,'4-feb-2018');


select * from customer;
select * from product;
select * from orders;

select cust_id,name from customer where name like '%k';
select avg(price) from product group by(type);
select name from product where product_id in(select p_id from)











