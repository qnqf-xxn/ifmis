i number;
begin
  -- 财政评价表 添加字段： 是否财政评价新增项目 1：是  0否
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='ISADD';
  if i=0 then
      execute immediate 'alter table PERF_T_FINEVALUATION add ISADD NUMBER(1)';
  end if;
  
  --财政评价列表注册添加字段 是否财政新增项目
  select count(*) into i from busfw_t_uicolumn t where key ='/pmkpi/evaluation/financial/program/audit' and t.columncode='ISADD';
  if i=0 then
      execute immediate'
        insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
        values (''BD672DCCF3308602E053B11FA8C0BE00'', ''/pmkpi/evaluation/financial/program/audit'', ''ISADD'', ''是否财政新增项目'', 13, 1, 0, null, null, null, null, null, ''#name'', null, null, 80, 1, ''tree'', null, null, ''87'', ''2016'')';
  end if;
  
  --财政评价表字段注册添加字段 是否财政评价新增项目 字段 1：是  0否
  select count(*) into i from bus_t_diccolumn t where tablecode ='PERF_T_FINEVALUATION' and t.columncode ='ISADD';
  if i=0 then
      execute immediate '
          insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
          values (null, ''ISLEAF'', null, ''1'', ''ISADD'', ''1'', ''2016'', ''87'', ''BD25F32C9E9027B9E053B11FA8C041F0'', ''ISADD'', ''PERF_T_FINEVALUATION'', ''是否财政评价新增项目'', ''S'', ''10'', null, null, 1, null, sysdate)';
  end if;

 --重构视图
  execute immediate'
    create or replace view v_perf_t_finevaluation as
    select t.*
    from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
        and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
