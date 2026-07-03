  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--PERF_T_DEPTPERFDECLARE add SUMMARY_INFO 摘要信息-数据完整性应用
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='SUMMARY_INFO';
if i=0 then
   execute immediate 'alter table PERF_T_DEPTPERFDECLARE add SUMMARY_INFO VARCHAR2(1000)';
end if;

--PERF_T_DEPTPERFDECLARE modify TELEPHONE 联系电话 字段长度扩充用于加密存储
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='TELEPHONE';
if i=1 then
   execute immediate 'select fn_altertablecol(''PERF_T_DEPTPERFDECLARE'', ''TELEPHONE'', ''VARCHAR2'', 1000)';
end if;

v_sql :='
create or replace view V_PERF_T_DEPTPERFDECLARE as
select * from PERF_T_DEPTPERFDECLARE
WHERE province = global_multyear_cz.v_pmdivid AND year = global_multyear_cz.v_pmyear';
select fn_alterview('V_PERF_T_DEPTPERFDECLARE',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

