i number;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTGOALTASK' and t.column_name='TASK_CONTEXT';
  if i=1 then
     execute immediate 'alter table PERF_T_DEPTGOALTASK modify TASK_CONTEXT VARCHAR2(4000)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_TMP_AUDIT' and t.column_name='REMARK';
  if i=1 then
     execute immediate 'alter table PERF_TMP_AUDIT modify REMARK VARCHAR2(4000)';
  end if;