
i number(9);
begin 
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_FILE') and column_name = upper('billguid');
  if i = 1 then
     execute immediate 'alter table PERF_FILE modify billguid VARCHAR2(50)';
  end if;

