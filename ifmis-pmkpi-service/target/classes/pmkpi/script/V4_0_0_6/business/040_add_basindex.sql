i integer;
begin

  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='PROJTYPE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add PROJTYPE VARCHAR2(40)';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='WFID';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add WFID VARCHAR2(40)';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='WFSTATUS';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add WFSTATUS VARCHAR2(40)';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='AUDITOR';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add AUDITOR VARCHAR2(40)';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='LASTUPDATETIME';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add LASTUPDATETIME VARCHAR2(40)';
  end if;
  
  SELECT count(*) into i FROM Bus_t_Diccolumn t where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'PROJTYPE';
  if i=0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, 'IDEXCOMCLS', null, '1', 'PROJTYPE', '1', '2016', '87', 'AC79169FC8344B758B85C73BAF7D81F5', 'PROJTYPE', 'BAS_PERF_INDICATOR', '项目类型', 'S', '40', null, 1, 1, null, sysdate);
  end if;
  
  SELECT count(*) into i FROM Bus_t_Diccolumn t where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'WFID';
  if i=0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, null, null, '1', 'WFID', '1', '2021', '87', 'B09A4612ACF24003A7633EAE5610F1B3', 'WFID', 'BAS_PERF_INDICATOR', '工作流id', 'S', '40', null, 1, 0, null, sysdate);
  end if;
  
  SELECT count(*) into i FROM Bus_t_Diccolumn t where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'WFSTATUS';
  if i=0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, 'PMKPIWFSTATUS', null, '1', 'WFSTATUS', '1', '2021', '87', 'E1D077A9AF16400E9783FAD87EC733BB', 'WFSTATUS', 'BAS_PERF_INDICATOR', '工作流状态', 'S', '40', null, 1, 1, null, sysdate);
  end if;
  
  SELECT count(*) into i FROM Bus_t_Diccolumn t where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'AUDITOR';
  if i=0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, null, null, '0', 'AUDITOR', '1', '2021', '87', '6A7C6FCE7EF04128B23E8488385C9A7D', 'AUDITOR', 'BAS_PERF_INDICATOR', '审核人', 'S', '32', null, 1, 1, null, sysdate);
  end if;
  
  SELECT count(*) into i FROM Bus_t_Diccolumn t where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'LASTUPDATETIME';
  if i=0 then
     insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, null, null, '0', 'LASTUPDATETIME', '1', '2021', '87', 'BF5009AFD5324341A2C51D90BC990646', 'LASTUPDATETIME', 'BAS_PERF_INDICATOR', '时间戳', 'S', '17', null, 1, 1, null, sysdate);
  end if;
   
  execute immediate 'create or replace view V_BAS_PERF_INDICATOR as
  select *
  from BAS_PERF_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';