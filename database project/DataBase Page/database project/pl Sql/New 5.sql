set serveroutput on
declare

price number(3):=100;

p_price products.product_price%TYPE;

code products.supplier_code%TYPE;

counter number(2);

begin

    for counter in 1..5
    
    loop
    
    SELECT product_price INTO p_price FROM products WHERE  product_id = counter;
 
       if (price<p_price) then
            price:=p_price;
        end if;
        
              
    end loop;
    
    select supplier_code into code from products where product_price = price;
    
     
    dbms_output.put_line('supplier_code : '|| code ||' and price : '|| price);
    
    procedure1(price);
        
exception
    when others then
        dbms_output.put_line('Error occured!');
end;

/