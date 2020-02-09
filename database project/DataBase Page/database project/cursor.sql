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