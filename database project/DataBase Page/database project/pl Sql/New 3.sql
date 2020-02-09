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
