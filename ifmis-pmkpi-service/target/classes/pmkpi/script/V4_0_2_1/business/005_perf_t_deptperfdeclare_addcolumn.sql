
  i number;
begin
  -- 部门整体表添加资金拓展字段
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='AMT1';
    if i=0 then
      execute immediate 'alter table PERF_T_DEPTPERFDECLARE add AMT1 NUMBER(20,5)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='AMT2';
    if i=0 then
      execute immediate 'alter table PERF_T_DEPTPERFDECLARE add AMT2 NUMBER(20,5)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='AMT3';
    if i=0 then
      execute immediate 'alter table PERF_T_DEPTPERFDECLARE add AMT3 NUMBER(20,5)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='AMT4';
    if i=0 then
      execute immediate 'alter table PERF_T_DEPTPERFDECLARE add AMT4 NUMBER(20,5)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='AMT5';
    if i=0 then
      execute immediate 'alter table PERF_T_DEPTPERFDECLARE add AMT5 NUMBER(20,5)';
  end if;
  
  DELETE FROM Bus_t_Diccolumn t WHERE t.tablecode='PERF_T_DEPTPERFDECLARE' and t.columncode in ('AMT1','AMT2','AMT3','AMT4','AMT5');
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'AMT1', '1', '2016', '87', 'D32B41FD5804419A8981E3A29FE4A0B0', 'AMT1', 'PERF_T_DEPTPERFDECLARE', 'AMT1', 'N', '20', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'AMT2', '1', '2016', '87', 'BE3F716B2EE04C2B8BCC7F928F518058', 'AMT2', 'PERF_T_DEPTPERFDECLARE', 'AMT2', 'N', '20', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'AMT3', '1', '2016', '87', '3AA643B667BF49B2887E56E6B8BDF7CF', 'AMT3', 'PERF_T_DEPTPERFDECLARE', 'AMT3', 'N', '20', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'AMT4', '1', '2016', '87', 'FBB5063CB3844C12B03E87F94D8118C0', 'AMT4', 'PERF_T_DEPTPERFDECLARE', 'AMT4', 'N', '20', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'AMT5', '1', '2016', '87', '07B675457CD74ACE9A82848AEB6181AF', 'AMT5', 'PERF_T_DEPTPERFDECLARE', 'AMT5', 'N', '20', null, 1, 1, null, sysdate);


  
  execute immediate 'create or replace view v_PERF_T_DEPTPERFDECLARE as 
  select * from PERF_T_DEPTPERFDECLARE 
  where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

