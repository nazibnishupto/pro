insert into suppliers(supplier_code,supplier_name,supplier_address) values (1,'Rahim','Hospital Road');
    insert into suppliers(supplier_code,supplier_name,supplier_address) values (2,'Karim','Darbar bari');
    	insert into suppliers(supplier_code,supplier_name,supplier_address) values (3,'Bashir','Fulbari Gate');
    		insert into suppliers(supplier_code,supplier_name,supplier_address) values (4,'Rashik','Kuet Road');
    			insert into suppliers(supplier_code,supplier_name,supplier_address) values (5,'sourav','Daulotpur');


insert into customers(customer_id,first_name,last_name,gender,phone_number,customer_address) values(11,'Shumonto','Kumar','male',01734347007,'Lalmati Road');
	insert into customers(customer_id,first_name,last_name,gender,phone_number,customer_address) values(12,'Shanto','hossen','male',01734367207,'Hospital Road');
		insert into customers(customer_id,first_name,last_name,gender,phone_number,customer_address) values(13,'Abid','Hasan','male',01734347009,'Kumar Road');
			insert into customers(customer_id,first_name,last_name,gender,phone_number,customer_address) values(14,'Kabira','Rahman','female',01734757007,'Fulbari Road');
				insert into customers(customer_id,first_name,last_name,gender,phone_number,customer_address) values(15,'Ragib','Hasan','male',01734347177,'Mujib Road');


insert into products(product_id,product_name,supplier_code,product_price,discount) values (1,'shirt',1,100,2);
	insert into products(product_id,product_name,supplier_code,product_price,discount) values (2,'Tshirt',1,150,3);
		insert into products(product_id,product_name,supplier_code,product_price,discount) values (3,'Polo Shirt',5,170,4);
			insert into products(product_id,product_name,supplier_code,product_price,discount) values (4,'Jacket',4,500,5);
				insert into products(product_id,product_name,supplier_code,product_price,discount) values (5,'Formal Shirt',1,270,9);


insert into customers_payment_method(payment_method_id,customer_id,card_number) values(1,11,12987654);
	insert into customers_payment_method(payment_method_id,customer_id,card_number) values(2,12,12987098);
		insert into customers_payment_method(payment_method_id,customer_id,card_number) values(3,13,12909854);
			insert into customers_payment_method(payment_method_id,customer_id,card_number) values(4,11,10977654);
				insert into customers_payment_method(payment_method_id,customer_id,card_number) values(5,15,12985555);


insert into customers_order(order_id,customer_id,payment_method_id,date_order_placed,date_order_paid) values (1001,13,1,'22-MAY-2018','28-MAY-2018');
	insert into customers_order(order_id,customer_id,payment_method_id,date_order_placed,date_order_paid) values (1002,12,3,'18-APRIL-2018','22-APRIL-2018');
		insert into customers_order(order_id,customer_id,payment_method_id,date_order_placed,date_order_paid) values (1003,11,4,'22-JUNE-2018','24-JUNE-2018');
			insert into customers_order(order_id,customer_id,payment_method_id,date_order_placed,date_order_paid) values (1004,14,5,'26-JUNE-2018','01-JULY-2018');
				insert into customers_order(order_id,customer_id,payment_method_id,date_order_placed,date_order_paid) values (1005,14,2,'03-JANUARY-2018','09-JANUARY-2018');


insert into customers_order_products(order_id,product_id,quantity) values (1001,1,1);
	insert into customers_order_products(order_id,product_id,quantity) values (1001,2,4);
		insert into customers_order_products(order_id,product_id,quantity) values (1001,5,1);
			insert into customers_order_products(order_id,product_id,quantity) values (1004,4,2);
				insert into customers_order_products(order_id,product_id,quantity) values (1005,3,10);


insert into customers_order_delivary(order_id,date_repoted,delivary_status_code) values (1001,'28-MAY-2018','Done');
	insert into customers_order_delivary(order_id,date_repoted,delivary_status_code) values (1002,'22-APRIL-2018','Done');
		insert into customers_order_delivary(order_id,date_repoted,delivary_status_code) values (1003,'24-JUNE-2018','Due');
			insert into customers_order_delivary(order_id,date_repoted,delivary_status_code) values (1004,'01-JULY-2018','Done');
				insert into customers_order_delivary(order_id,date_repoted,delivary_status_code) values (1005,'09-JANUARY-2018','Due');


select * from suppliers;
select * from customers;
select * from products;
select * from customers_order;
select * from customers_payment_method;
select * from customers_order_products;
select * from customers_order_delivary;





commit;