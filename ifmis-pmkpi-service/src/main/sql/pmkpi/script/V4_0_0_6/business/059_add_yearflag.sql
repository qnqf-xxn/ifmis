i integer;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='YEARFLAG';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add YEARFLAG VARCHAR2(9)';
  end if;
  SELECT count(1) into i FROM bus_t_Diccolumn t where t.tablecode = 'PM_PERF_INDICATOR' and t.columncode = 'YEARFLAG';
  if i = 0 then
    insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'YEARFLAG', '1', '2021', '87', 'B9C87ABFFA3FD684E053B11FA8C0EE85', 'YEARFLAG', 'PM_PERF_INDICATOR', '指标类型', 'S', '9', null, 1, 0, null, sysdate);
  end if;
  execute immediate 'create or replace view v_pm_perf_indicator as
select *
from pm_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';