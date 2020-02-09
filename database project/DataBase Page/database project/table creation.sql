drop table customers_order_delivary;
drop table customers_order_products;
drop table customers_order;
drop table customers_payment_method;
drop table products;
drop table suppliers;
drop table customers;

CREATE table suppliers
(
	supplier_code NUMBER(2) NOT NULL,
	supplier_name VARCHAR2(20) NOT NULL,
	supplier_address VARCHAR2(35),
	primary key (supplier_code)
);

CREATE table customers
(
	customer_id NUMBER(2) NOT NULL,
	first_name VARCHAR2(10),
	last_name VARCHAR2(10),
	gender VARCHAR2(8),
	phone_number NUMBER(11) unique,
	customer_address VARCHAR2(35),
	primary key (customer_id)
);

CREATE table products
(
	product_id NUMBER(3) NOT NULL,
	product_name VARCHAR2(30),
	supplier_code NUMBER(2),
	product_price NUMBER(5) default 100 check (product_price>0 and product_price<=1000),
	discount number(2),
	primary key (product_id),
	foreign key (supplier_code) references suppliers (supplier_code) on delete cascade
);

CREATE table customers_payment_method
(
	payment_method_id NUMBER(3),
	customer_id NUMBER(2) ,
    /*payment_method_code NUMBER(1);*/
    card_number NUMBER(20),
    primary key(payment_method_id),
    foreign key (customer_id) references customers (customer_id) on delete cascade
);

CREATE table customers_order
(
	order_id number(4),
	customer_id NUMBER(2) ,
	payment_method_id NUMBER(3),
	date_order_placed DATE,
	date_order_paid DATE,
	primary key (order_id),
	foreign key (customer_id) references customers (customer_id) on delete cascade,
	foreign key (payment_method_id) references customers_payment_method(payment_method_id) on delete cascade
);

CREATE table customers_order_products
( 
	order_id number(4),
    product_id number(3),
    quantity number(2),
    primary key (order_id,product_id),
    foreign key (order_id) references customers_order(order_id) on delete cascade,
    foreign key (product_id) references products(product_id) on delete cascade
);

CREATE table customers_order_delivary
(
	order_id number(4),
	date_repoted DATE ,
	delivary_status_code VARCHAR2(10),
	primary key(order_id,date_repoted),
	foreign key(order_id) references customers_order(order_id) on delete cascade
);


commit;



 

