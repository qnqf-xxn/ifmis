
i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_DEPTFUNCTION' and column_name = 'NAME';
  if i = 1 then
     execute immediate 'alter table PERF_T_DEPTFUNCTION modify name VARCHAR2(300)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTFUNCTION' and column_name = 'NAME';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTFUNCTION modify name VARCHAR2(300)';
  end if;
