i number(3);
begin
  --监控主表添加字段  填报人
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='GOALNAME';
  if i=0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add goalname VARCHAR2(100)';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view V_BGT_PERF_GOAL_INFO as
    select *
    from BGT_PERF_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
  --注册字段
  delete from Bus_t_Diccolumn t where t.columncode = 'GOALNAME' and t.tablecode = 'BGT_PERF_GOAL_INFO';
  
  insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', 'E1D979BEC9EA09F7E0533315A8C0482C', 'GOALNAME', 'BGT_PERF_GOAL_INFO', '名称', 'S', '100', null, 1, 1, null, sysdate);
