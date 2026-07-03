num number(9);
begin 
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('fun_res_code');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add fun_res_code VARCHAR2(40)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('indeximport');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add indeximport VARCHAR2(40)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('score');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add score NUMBER(5,2)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('scorerule');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add scorerule VARCHAR2(2000)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('kpi_val1');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add kpi_val1 VARCHAR2(1000)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('kpi_val2');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add kpi_val2 VARCHAR2(1000)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('kpi_val3');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add kpi_val3 VARCHAR2(1000)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('proselect');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add proselect VARCHAR2(40)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('isbudget');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add isbudget VARCHAR2(40)';
  end if;
  
  select count(1) into num from user_tab_cols  where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('sname');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add sname VARCHAR2(1000)';
  end if;
  
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'FUN_RES_CODE';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMFUNCRESP', null, '1', 'FUN_RES_CODE', '1', '2016', '87', 'C57C4F11635344DEB990671E5B3A3960', 'FUN_RES_CODE', 'BGT_PERF_INDICATOR', '职能职责', 'S', '40', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'INDEXIMPORT';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXIMPORT', null, '1', 'INDEXIMPORT', '1', '2016', '87', 'C57C4F22635344DEB990671E5B3A3960', 'INDEXIMPORT', 'BGT_PERF_INDICATOR', '指标重要性', 'S', '40', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'ISBUDGET';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISBUDGET', '1', '2016', '87', 'C57C4F99635344DEB990671E5B3A3960', 'ISBUDGET', 'BGT_PERF_INDICATOR', '是否预算挂钩', 'S', '40', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'KPI_VAL1';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_VAL1', '1', '2016', '87', 'C57C4F535344DEB990671E5B3A3960', 'KPI_VAL1', 'BGT_PERF_INDICATOR', '历年指标值1', 'S', '1000', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'KPI_VAL2';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_VAL2', '1', '2016', '87', 'C57C4F66635344DEB990671E5B3A3960', 'KPI_VAL2', 'BGT_PERF_INDICATOR', '历年指标值2', 'S', '1000', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'KPI_VAL3';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_VAL3', '1', '2016', '87', 'C57C477635344DEB990671E5B3A3960', 'KPI_VAL3', 'BGT_PERF_INDICATOR', '历年指标值3', 'S', '1000', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'SCORE';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SCORE', '1', '2016', '87', 'C57C4F33635344DEB990671E5B3A3960', 'SCORE', 'BGT_PERF_INDICATOR', '分值', 'N', '5', 2, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'SCORERULE';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SCORERULE', '1', '2016', '87', 'C57C4F44635344DEB990671E5B3A3960', 'SCORERULE', 'BGT_PERF_INDICATOR', '赋分原则', 'S', '2000', null, 1, 1, null, sysdate);

  end if;
  SELECT count(*) into num FROM Bus_t_Diccolumn t where t.tablecode = 'BGT_PERF_INDICATOR' and t.columncode = 'SNAME';
  if num = 0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SNAME', '1', '2016', '87', '1702580361B545E1AB3D4F56A06BA873', 'SNAME', 'BGT_PERF_INDICATOR', '二级指标名称', 'S', '1000', null, 1, 1, null, sysdate);

  end if;
  
execute immediate 'create or replace view V_BGT_PERF_INDICATOR as select * from BGT_PERF_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
     and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted<>1';