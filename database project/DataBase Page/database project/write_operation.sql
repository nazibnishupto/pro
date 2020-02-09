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