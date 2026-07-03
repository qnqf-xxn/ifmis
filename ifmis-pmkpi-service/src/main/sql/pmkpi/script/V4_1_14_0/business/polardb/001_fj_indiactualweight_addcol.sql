  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='FRAMEWEIGHT';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add FRAMEWEIGHT NUMBER(5,2)';
end if;
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ACTUALWEIGHT';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add ACTUALWEIGHT NUMBER(5,2)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';
select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='FRAMEWEIGHT';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add FRAMEWEIGHT NUMBER(5,2)';
end if;
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='ACTUALWEIGHT';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add ACTUALWEIGHT NUMBER(5,2)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='FRAMEWEIGHT';
if i=0 then
   execute immediate 'alter table PERF_T_ADJUSTINDEX add FRAMEWEIGHT NUMBER(5,2)';
end if;
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='ACTUALWEIGHT';
if i=0 then
   execute immediate 'alter table PERF_T_ADJUSTINDEX add ACTUALWEIGHT NUMBER(5,2)';
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTINDEX as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2 and t.sub_mof_div_code is null';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;


v_sql :='
create or replace view v_perf_t_adjustallindex as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;


