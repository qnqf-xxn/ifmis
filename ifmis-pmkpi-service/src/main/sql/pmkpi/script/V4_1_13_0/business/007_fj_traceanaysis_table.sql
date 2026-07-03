  i number;
begin

--add col 项目年度绩效目标
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROTRACEANALYSIS' and t.column_name='YEARGOAL';
if i=0 then
   execute immediate 'alter table PERF_T_PROTRACEANALYSIS add YEARGOAL varchar2(4000)';
end if;

--add col 项目绩效目标执行总体情况
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROTRACEANALYSIS' and t.column_name='YEARGOAL_EXECUTION';
if i=0 then
   execute immediate 'alter table PERF_T_PROTRACEANALYSIS add YEARGOAL_EXECUTION varchar2(4000)';
end if;

--add col 完成目标可能性
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROTRACEANALYSIS' and t.column_name='COMPLETEPOSSIBILITY';
if i=0 then
   execute immediate 'alter table PERF_T_PROTRACEANALYSIS add COMPLETEPOSSIBILITY varchar2(40)';
end if;

execute immediate '
create or replace view v_perf_t_protraceanalysis as
select * from perf_t_protraceanalysis
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
