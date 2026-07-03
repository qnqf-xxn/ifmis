  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--add col PERF_T_IMPTEMP.ENDNUM
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_IMPTEMP' and t.column_name='ENDNUM';
if i=0 then
   execute immediate 'alter table PERF_T_IMPTEMP add ENDNUM NUMBER(3)';
end if;

v_sql :='create or replace view V_PERF_T_IMPTEMP as
select * from perf_t_imptemp t
where t.year = global_multyear_cz.v_pmyear
and t.province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_IMPTEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

