i number;
begin

--PERF_T_DEPTPERFDECLARE add SUMMARY_INFO 摘要信息-数据完整性应用
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='SUMMARY_INFO';
if i=0 then
   execute immediate 'alter table PERF_T_DEPTPERFDECLARE add SUMMARY_INFO VARCHAR2(1000)';
end if;

--PERF_T_DEPTPERFDECLARE modify TELEPHONE 联系电话 字段长度扩充用于加密存储
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFDECLARE' and t.column_name='TELEPHONE';
if i=1 then
   execute immediate 'alter table PERF_T_DEPTPERFDECLARE modify TELEPHONE VARCHAR2(1000)';
end if;

execute immediate '
create or replace view V_PERF_T_DEPTPERFDECLARE as
select * from PERF_T_DEPTPERFDECLARE
WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') AND year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
