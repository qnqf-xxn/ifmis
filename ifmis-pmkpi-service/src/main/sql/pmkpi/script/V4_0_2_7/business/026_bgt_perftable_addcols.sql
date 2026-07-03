i number(3);
begin
  --湖北部门整体添加字段目标说明，是否总体，排序
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='REMARK';
  if i=0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add(REMARK VARCHAR2(2000))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='YEARFLAG';
  if i=0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add(YEARFLAG VARCHAR2(1))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='ORDERNUM';
  if i=0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add(ORDERNUM NUMBER(4))';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view V_BGT_PERF_GOAL_INFO as
    select *
    from BGT_PERF_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
  --注册字段
  delete from Bus_t_Diccolumn t where t.columncode in ('REMARK','YEARFLAG','ORDERNUM') and t.tablecode = 'BGT_PERF_GOAL_INFO';
  
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'DFE793E8A4704CB3E0533315A8C00BD4', 'ORDERNUM', 'BGT_PERF_GOAL_INFO', '排序', 'N', '4', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'REMARK', '1', '2016', '87', 'DF1D5DC35A5864FFE0533315A8C0BB0E', 'REMARK', 'BGT_PERF_GOAL_INFO', '指标说明', 'S', '2000', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'YEARFLAG', '1', '2016', '87', 'DF1D5DC34A5864FFE0533315A8C0BB0E', 'YEARFLAG', 'BGT_PERF_GOAL_INFO', '中长期标识', 'S', '1', null, 1, 1, null, sysdate);
  
  --指标表
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='YEARFLAG';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(YEARFLAG VARCHAR2(1))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='KPI_DEP_ID';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(KPI_DEP_ID VARCHAR2(38))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='SNINDEXVAL';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(SNINDEXVAL VARCHAR2(1000))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='QNINDEXVAL';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(QNINDEXVAL VARCHAR2(1000))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='COMPUTETYPE';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(COMPUTETYPE VARCHAR2(4000))';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='INDEXSTANDARDS';
  if i=0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add(INDEXSTANDARDS VARCHAR2(2000))';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view V_BGT_PERF_INDICATOR as
    select *
    from BGT_PERF_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
      
  --注册字段
  delete from Bus_t_Diccolumn t where t.columncode in ('KPI_DEP_ID','YEARFLAG','SNINDEXVAL','QNINDEXVAL','COMPUTETYPE','INDEXSTANDARDS') and t.tablecode = 'BGT_PERF_INDICATOR';
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'KPI_DEP_ID', '1', '2016', '87', 'DFE793E8A4714CB3E0533315A8C00BD4', 'KPI_DEP_ID', 'BGT_PERF_INDICATOR', '目标主键', 'S', '38', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'QNINDEXVAL', '1', '2016', '87', 'E0FE8D98483A24E7E0533315A8C0763F', 'QNINDEXVAL', 'BGT_PERF_INDICATOR', '前年指标值', 'S', '1000', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'SNINDEXVAL', '1', '2016', '87', 'E0FE8D98483924E7E0533315A8C0763F', 'SNINDEXVAL', 'BGT_PERF_INDICATOR', '上年指标值', 'S', '1000', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'YEARFLAG', '1', '2016', '87', 'DFE793E8A4724CB3E0533315A8C00BD4', 'YEARFLAG', 'BGT_PERF_INDICATOR', '绩效类型', 'S', '1', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'COMPUTETYPE', '1', '2016', '87', 'DA61946DC9F5101EE0533315A8C0D73D', 'COMPUTETYPE', 'BGT_PERF_INDICATOR', '计算公式', 'S', '4000', null, 1, 1, null, sysdate);

  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, 'INDEXSTANDARDS', null, '1', 'INDEXSTANDARDS', '1', '2016', '87', 'DA61946DC9F6101EE0533315A8C0D73D', 'INDEXSTANDARDS', 'BGT_PERF_INDICATOR', '指标值设定依据', 'S', '2000', null, 1, 1, null, sysdate);


