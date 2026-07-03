  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='INDSOURCE';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDSOURCE varchar2(1)';
end if;

v_sql :='create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;