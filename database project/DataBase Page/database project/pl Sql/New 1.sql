set serveroutput on
declare

c_name customers.first_name%type;

begin

select first_name into c_name from customers where customer_id=11;

dbms_output.put_line(c_name);

end;
/