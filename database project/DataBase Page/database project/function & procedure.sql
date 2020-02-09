CREATE OR REPLACE PROCEDURE procedure1 (price IN OUT number) 
IS

p_id products.product_id%TYPE;

BEGIN

select product_id into p_id from products where product_price=price;
dbms_output.put_line('product id is :'||p_id);
procedure2(price,p_id);

END;





CREATE OR REPLACE PROCEDURE procedure2(price In number,p_id IN number)  IS    

o_id CUSTOMERS_ORDER_PRODUCTS.ORDER_ID%TYPE;
quan CUSTOMERS_ORDER_PRODUCTS.quantity%TYPE;

s1 number(4);
s2 number(3);
    
 BEGIN 
	
    select order_id,quantity into o_id,quan from CUSTOMERS_ORDER_PRODUCTS where product_id=p_id;
    dbms_output.put_line('order id is :'||o_id);
    dbms_output.put_line('quantity of the product is :'||quan);
    dbms_output.put_line('Actual price of the product :'||price);
    
    
    
    s1:=function1(price,quan);
    
    dbms_output.put_line('discounted net price :');
    dbms_output.put_line(s1-(s1*0.2));
    procedure3(o_id);
    
 
 END;
 / 
 
 
 
 CREATE OR REPLACE PROCEDURE procedure3 (o_id IN number) 
IS

c_id products.product_id%TYPE;

BEGIN

select customer_id into c_id from customers_order where order_id=o_id;
dbms_output.put_line('Lucky customer id is :'||c_id);


END;
/

 

CREATE OR REPLACE FUNCTION function1(price in number,quan in number) return number
IS
   
BEGIN
    
   return(price*quan);

END;
/




