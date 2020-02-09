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
