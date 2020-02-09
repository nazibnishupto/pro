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