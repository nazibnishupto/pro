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