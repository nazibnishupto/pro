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




CREATE OR REPLACE FUNCTION function1(price in number,quan in number) return number
IS  
BEGIN    
   return(price*quan);
END;
/ 




set serveroutput on
create or replace trigger dis
before insert or update of product_price on products for each row  
begin 
    if :new.product_price<200
    then :new.discount:=1;
    else if :new.product_price>200 and :new.product_price<500
    then :new.discount:=5;
    else if :new.product_price>500 and :new.product_price<1000
    then :new.discount:=7;
    else
         :new.discount:=10;    
    end if; 
    end if;
    end if;    
end;
/
insert into products(product_id,product_name,supplier_code,product_price) values (8,'shirt',4,990);
select * from products;





set serveroutput on
declare
    cursor cust is select first_name, customer_id from customers;
    custRecord cust%rowtype;
    cursor ord is select date_order_placed,order_id from customers_order where customer_id=custRecord.customer_id;
    ordRecord ord%rowtype;
    cursor cod is select delivary_status_code from customers_order_delivary where order_id=ordRecord.order_id;
    codRecord cod%rowtype; 
begin
    open cust;
    loop
        fetch cust into custRecord;
        exit when cust%notfound;
        dbms_output.put_line(custRecord.first_name || ':');
        open ord;
        loop
            fetch ord into ordRecord;
            exit when ord%notfound;
            dbms_output.put_line('  >' || ordRecord.date_order_placed);
            open cod;
            loop
                fetch cod into codRecord;
                exit when cod%notfound;
                dbms_output.put_line('     -' || codRecord.delivary_status_code);
            end loop;
            close cod;
        end loop;
        close ord;        
    end loop;
    close cust;
end;
/




set serveroutput on
declare
   f utl_file.file_type;
   line varchar(10000);
   supplier_code suppliers.supplier_code%type;
   supplier_name suppliers.supplier_name%type;
   supplier_address suppliers.supplier_address%type;   
begin
   f:=utl_file.fopen('MYD','suppliers.csv','R');
   if utl_file.is_open(f)
   then utl_file.get_line(f,line,10000);
   loop
   begin
   utl_file.get_line(f,line,10000);
   supplier_code:=regexp_substr(line,'[^,]+',1,1);
   supplier_name:=regexp_substr(line,'[^,]+',1,2);
   supplier_address:=regexp_substr(line,'[^,]+',1,3);
   insert into suppliers values(supplier_code,supplier_name,supplier_address);
   commit;
   exception
   when no_data_found then exit;
   end;
   end loop;
   end if;
   utl_file.fclose(f);
   end;
   /
 select * from suppliers;





 set serveroutput on
declare 
   f utl_file.file_type;
   cursor d is
   select * from suppliers;
begin 
   f:=utl_file.fopen('MYD','test4.csv','W');
   utl_file.put(f,'supplier_code'||','||'supplier_name'||','||'supplier_address');
   utl_file.new_line(f);
   for d_record in d
   loop
   utl_file.put(f,d_record.supplier_code||','||d_record.supplier_name||','||d_record.supplier_address);
   utl_file.new_line(f);
   end loop;
   utl_file.fclose(f);
end;
/






SET SERVEROUTPUT ON
Declare
male number(2);
female number(2);
Begin
select count(gender) into male from customers where gender='male';
select count(gender) into female from customers where gender='female';
if male<female 
    then
    DBMS_OUTPUT.PUT_LINE('20% discount for the male customers');
else 
   DBMS_OUTPUT.PUT_LINE('20% discount for the female customers');   
   end if;
END;
/





SET SERVEROUTPUT ON
DECLARE
   counter number(2):=11;
   d number(2):=1;
   c1_name customers.first_name%TYPE;
   c2_name customers.last_name%TYPE;
   address  customers.customer_address%TYPE;     
BEGIN
    while
    counter<=13 
   LOOP
      SELECT first_name,last_name,customer_address INTO c1_name,c2_name, address FROM customers WHERE  customer_id = counter;
      DBMS_OUTPUT.PUT_LINE ('Customer ' || d);
      DBMS_OUTPUT.PUT_LINE (c1_name || '-' ||c2_name || '  ' || address);
      DBMS_OUTPUT.PUT_LINE ('_____________');
     counter:=counter+1;
     d:=d+1;
   END LOOP;
   EXCEPTION
      WHEN others THEN
         DBMS_OUTPUT.PUT_LINE ('Error occured!');
END;
/






SET SERVEROUTPUT ON
DECLARE
   counter number(2);
   type name is varray(5) of SUPPLIERS.SUPPLIER_NAME%type;
   s_name name:=name();
   begin
    for counter in 1..3
    loop
    s_name.extend();
    select supplier_name into s_name(counter) from suppliers where supplier_code=counter;
    DBMS_OUTPUT.PUT_LINE (s_name(counter));
    end loop;   
   end;
   /
