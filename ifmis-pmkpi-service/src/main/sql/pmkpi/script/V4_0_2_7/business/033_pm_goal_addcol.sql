i number(3);
begin
  --项目目标表添加字段  目标名称
  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_INFO' and t.column_name='GOALNAME';
  if i=0 then
     execute immediate 'alter table PM_PERF_GOAL_INFO add goalname VARCHAR2(100)';
  end if;
  
    --项目目标暂存表添加字段  目标名称
  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_TEMP' and t.column_name='GOALNAME';
  if i=0 then
     execute immediate 'alter table PM_PERF_GOAL_TEMP add goalname VARCHAR2(100)';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view v_pm_perf_goal_info as
select t.*
from pm_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
  
  execute immediate '
create or replace view V_PM_PERF_GOAL_TEMP as
select * FROM pm_perf_goal_temp  
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = ''2''
';

  --注册字段
  delete from Bus_t_Diccolumn t where t.columncode = 'GOALNAME' and t.tablecode = 'PM_PERF_GOAL_INFO';
  
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', '5E0FEF07471270710E0D2C68DD0DCDFC', 'GOALNAME', 'PM_PERF_GOAL_INFO', '名称', 'S', '100', null, 1, 1, null, sysdate);

delete from Bus_t_Diccolumn t where t.columncode = 'GOALNAME' and t.tablecode = 'PM_PERF_GOAL_TEMP';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', '0316B49E2D143F4DAD277D091751944C', 'GOALNAME', 'PM_PERF_GOAL_TEMP', '名称', 'S', '100', null, 1, 1, null, sysdate);
