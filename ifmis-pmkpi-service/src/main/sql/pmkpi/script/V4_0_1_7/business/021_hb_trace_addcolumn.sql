num number(9);
begin
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_PROINDEXTRACE') and column_name = upper('DEVIATE');
  IF num = 0 THEN 
     execute immediate 'alter table PERF_T_PROINDEXTRACE add DEVIATE varchar2(40)';
  END IF;
  execute immediate 'create or replace view v_perf_t_proindextrace as
  select * from perf_t_proindextrace t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
  DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROINDEXTRACE' and t.columncode='DEVIATE';
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'DEVIATE', '1', '2020', '87', 'E353D5B75FBA46D7993D7A6531984C34', 'DEVIATE', 'PERF_T_PROINDEXTRACE', '偏离度', 'S', '40', null, 1, 1, null, sysdate);
  
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_PROMONITOR') and column_name = upper('GZDEVIATE');
  IF num = 0 THEN 
     execute immediate 'alter table PERF_T_PROMONITOR add GZDEVIATE varchar2(40)';
  END IF;
  
  
  DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='GZDEVIATE';
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'GZDEVIATE', '1', '2020', '87', 'CDA73BCC4503421AB0860CEB3D7D0122', 'GZDEVIATE', 'PERF_T_PROMONITOR', '偏离度', 'S', '40', null, 1, 1, null, sysdate);

  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_PROMONITOR') and column_name = upper('GZFUNDDEVIATE');
  IF num = 0 THEN 
     execute immediate 'alter table PERF_T_PROMONITOR add GZFUNDDEVIATE varchar2(40)';
  END IF;
  
  DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='GZFUNDDEVIATE';
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'GZFUNDDEVIATE', '1', '2020', '87', '488B4AAA3FBF4E6787FC6E3C07ED0135', 'GZFUNDDEVIATE', 'PERF_T_PROMONITOR', '资金偏离度', 'S', '40', null, 1, 1, null, sysdate);
  
  execute immediate 'create or replace view v_PERF_T_PROMONITOR as
  select * from PERF_T_PROMONITOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
