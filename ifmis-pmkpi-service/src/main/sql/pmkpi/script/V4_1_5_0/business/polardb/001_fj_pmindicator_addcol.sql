  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--PM_PERF_INDICATOR SUMTYPE
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='SUMTYPE';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR add SUMTYPE NUMBER(1)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2';
select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	 

--PM_PERF_INDICATOR_TEMP ISALLOWEDIT 
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR_TEMP' and t.column_name='SUMTYPE';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR_TEMP add SUMTYPE NUMBER(1)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	