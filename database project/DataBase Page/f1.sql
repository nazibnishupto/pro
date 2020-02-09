CREATE OR REPLACE PROCEDURE procedure2(price In number,p_id IN number)  IS    

o_id CUSTOMERS_ORDER_PRODUCTS.ORDER_ID%TYPE;
quan CUSTOMERS_ORDER_PRODUCTS.quantity%TYPE;
 
    
 BEGIN 
	
    select order_id,quantity into o_id,quan from CUSTOMERS_ORDER_PRODUCTS where product_id=p_id;
    dbms_output.put_line(o_id);
    dbms_output.put_line(quan);
    
 
 END;
 / 