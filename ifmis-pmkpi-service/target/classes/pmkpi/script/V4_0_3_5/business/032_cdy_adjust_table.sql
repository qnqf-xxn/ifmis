
i number;
begin

    select count(*) into i from user_tab_cols t where TABLE_NAME = 'PERF_T_ADJUST' and t.COLUMN_NAME='NAME';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add name varchar2(1000)';
    end if;
    
    select count(*) into i from user_tables t where TABLE_NAME = 'PM_PROJECT_INFO';
    if i=1 then
      update perf_t_adjust t set t.name = (select pro_name from pm_project_info a where a.guid=t.proguid) where t.bustype='program' and t.name is null;
    else
      update perf_t_adjust t set t.name = (select pro_name from perf_project_info a where a.guid=t.proguid) where t.bustype='program' and t.name is null;
    end if;
    
update perf_t_adjust t set t.pro_code = null where t.bustype='dept' and t.pro_code is not null;

update perf_t_adjust t set t.name = (select name from perf_t_deptperfdeclare a where a.guid=t.proguid) where t.bustype='dept' and t.name is null;

execute immediate '
create or replace view v_perf_t_adjust as
select t.*
 from perf_t_adjust t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
