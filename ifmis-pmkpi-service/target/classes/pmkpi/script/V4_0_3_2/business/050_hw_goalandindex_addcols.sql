  i number;
begin

--目标表-结转来源
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_INFO' and t.column_name='TRANSGUID';
if i=0 then
 execute immediate 'alter table PM_PERF_GOAL_INFO add(TRANSGUID VARCHAR2(40))';
end if;
--指标表-结转来源
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='TRANSGUID';
if i=0 then
 execute immediate 'alter table PM_PERF_INDICATOR add(TRANSGUID VARCHAR2(40))';
end if;

--注册字段
delete from bus_t_diccolumn where tablecode = 'PM_PERF_GOAL_INFO' and columncode = 'TRANSGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TRANSGUID', '1', '2016', '87', 'DA61946DCA27101EE0533315A8C0D73D', 'TRANSGUID', 'PM_PERF_GOAL_INFO', '结转来源guid', 'S', '40', null, 1, 1, null, sysdate);
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode = 'TRANSGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TRANSGUID', '1', '2016', '87', 'DA61946DCA26101EE0533315A8C0D73D', 'TRANSGUID', 'PM_PERF_INDICATOR', '结转来源guid', 'S', '40', null, 1, 1, null, sysdate);

--重构视图
execute immediate'create or replace view v_pm_perf_goal_info as
select
    *
from
    pm_perf_goal_info
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';

execute immediate'create or replace view v_pm_perf_indicator as
select
    *
from
    pm_perf_indicator
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
