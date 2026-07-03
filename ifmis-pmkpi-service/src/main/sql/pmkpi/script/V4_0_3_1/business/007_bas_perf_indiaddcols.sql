i number;
begin
  -- 添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'FILED';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add FILED VARCHAR2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'OCCUPATION';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add OCCUPATION VARCHAR2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'HISTORYVAL';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add HISTORYVAL VARCHAR2(1000)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'OTHERVAL';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add OTHERVAL VARCHAR2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'INDUSTRYVAL';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add INDUSTRYVAL VARCHAR2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'PLANVAL';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add PLANVAL VARCHAR2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BAS_PERF_INDICATOR' and t.COLUMN_NAME = 'BGTVAL';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add BGTVAL VARCHAR2(200)';
  end if;
  --- 字段注册
  delete FROM bus_t_Diccolumn t where t.TABLECODE  = 'BAS_PERF_INDICATOR' and t.COLUMNCODE in ('FILED','OCCUPATION' ,'PLANVAL' ,'HISTORYVAL' ,'INDUSTRYVAL' ,'BGTVAL', 'OTHERVAL');

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'BGTVAL', '1', '2016', '87', sys_guid(), 'BGTVAL', 'BAS_PERF_INDICATOR', '预算支出标准', 'S', '1000', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'FILED', '1', '2016', '87', sys_guid(), 'FILED', 'BAS_PERF_INDICATOR', '职能', 'S', '200', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'HISTORYVAL', '1', '2016', '87', sys_guid(), 'HISTORYVAL', 'BAS_PERF_INDICATOR', '历史标准', 'S', '1000', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'INDUSTRYVAL', '1', '2016', '87', sys_guid(), 'INDUSTRYVAL', 'BAS_PERF_INDICATOR', '行业标准', 'S', '1000', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'OCCUPATION', '1', '2016', '87', sys_guid(), 'OCCUPATION', 'BAS_PERF_INDICATOR', '活动', 'S', '200', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'OTHERVAL', '1', '2016', '87', sys_guid(), 'OTHERVAL', 'BAS_PERF_INDICATOR', '其他标准', 'S', '1000', null, 1, 1, null, sysdate);

    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'PLANVAL', '1', '2016', '87', sys_guid(), 'PLANVAL', 'BAS_PERF_INDICATOR', '计划标准', 'S', '1000', null, 1, 1, null, sysdate);

  --- 重新构建视图
  execute immediate '
  create or replace view v_bas_perf_indicator as
  select * FROM BAS_PERF_INDICATOR T
  WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';