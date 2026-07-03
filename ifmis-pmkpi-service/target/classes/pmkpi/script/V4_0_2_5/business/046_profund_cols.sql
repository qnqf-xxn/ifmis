 i number;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROFUND' and t.column_name='BGTSOURCE';
  if i=0 then
     execute immediate 'alter table PERF_T_PROFUND add(BGTSOURCE varchar2(200))';
  end if;
