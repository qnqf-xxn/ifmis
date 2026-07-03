  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_INFO' and t.column_name='RATIO';
if i=0 then
    execute immediate 'alter table PM_PERF_GOAL_INFO add RATIO NUMBER(4,1)';
end if;

--重建视图
execute immediate'create or replace view v_pm_perf_goal_info as
select
    *
from
    pm_perf_goal_info
where
    year = global_multyear_cz.v_pmyear and
     province = global_multyear_cz.v_pmdivid and is_deleted = 2
';

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFPERFGOAL' and t.column_name='RATIO';
if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFGOAL add RATIO NUMBER(4,1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFPERFGOAL' and t.column_name='WEIGHTSCORE';
if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFGOAL add WEIGHTSCORE NUMBER(20,2)';
end if;

--重建视图
execute immediate'create or replace view v_perf_t_selfperfgoal as
select
    *
from
    perf_t_selfperfgoal
where
    year = global_multyear_cz.v_pmyear and
     province = global_multyear_cz.v_pmdivid and is_deleted = 2
';
