i number;
begin
  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_FILE' and t.COLUMN_NAME='BILLGUID';
  if i > 0 then
execute immediate'alter table PERF_FILE  modify BILLGUID VARCHAR2(100)';
  end if;