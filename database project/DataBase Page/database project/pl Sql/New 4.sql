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
