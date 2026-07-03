i number;
begin
--目标草稿表
select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_GOAL_TEMP';
if i > 0 then
    select count(*) into i from user_constraints where table_name = 'PM_PERF_GOAL_TEMP' and constraint_type = 'P';
    if i > 0 then
        execute immediate 'alter table PM_PERF_GOAL_TEMP drop constraint PK_PM_PERF_GOAL_TEMP';
    end if;
    execute immediate 'alter table PM_PERF_GOAL_TEMP add constraint PK_PM_PERF_GOAL_TEMP primary key (GUID,PROVINCE,YEAR)';
end if;

--指标草稿表guid重复数据清理脚本
execute immediate '
update pm_perf_indicator_temp t set guid = sys_guid() where
exists(select 1 from (select count(1),guid from pm_perf_indicator_temp group by guid having count(1) > 1) a where t.guid = a.guid)
';
--指标草稿表
select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_INDICATOR_TEMP';
if i > 0 then
    select count(*) into i from user_constraints where table_name = 'PM_PERF_INDICATOR_TEMP' and constraint_type = 'P';
    if i > 0 then
        execute immediate 'alter table PM_PERF_INDICATOR_TEMP drop constraint PK_PM_PERF_INDICATOR_TEMP';
    end if;
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add constraint PK_PM_PERF_INDICATOR_TEMP primary key (GUID,PROVINCE,YEAR)';
end if;