  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='PRO_LEV';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add(PRO_LEV VARCHAR2(40))';
end if;
--处理历史数据
execute immediate 'update PERF_T_ADJUST t set t.PRO_LEV = (select PRO_LEV from pm_project_info where guid = t.proguid)  where t.PRO_LEV is null';
--重建视图
execute immediate '
create or replace view v_perf_t_adjust as
select * from perf_t_adjust t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
