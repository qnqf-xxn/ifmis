  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='ADJREASON';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_ADJUSTGOAL ADD ADJREASON VARCHAR2(40)';
end if;

v_sql :='create or replace view V_PERF_T_ADJUSTGOAL as
select * from PERF_T_ADJUSTGOAL t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid
  and t.is_deleted=2 and t.sub_mof_div_code is null';
select fn_alterview('V_PERF_T_ADJUSTGOAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;