 i number;
begin
  -- PERF_T_PROINDEXTRACE 扩展字段长度
  --NAME  长度 80 改为 1000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='NAME';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify NAME VARCHAR2(1000)';
     end if;
  --TARGETVALUE 长度 60 改为 1000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='TARGETVALUE';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify TARGETVALUE VARCHAR2(1000)';
     end if;
