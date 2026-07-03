  i number;
begin

--1、总体目标指标-预算年度字段置空处理
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_INFO' and t.column_name='FISCAL_YEAR' and t.nullable = 'N';
if i = 1 then
  execute immediate 'ALTER TABLE PM_PERF_GOAL_INFO MODIFY FISCAL_YEAR NULL';
end if;
update pm_perf_goal_info set fiscal_year = null, update_time = to_char(SYSDATE,'yyyyMMddHH24miss') where yearflag = '1';
select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='FISCAL_YEAR' and t.nullable = 'N';
if i = 1 then
  execute immediate 'ALTER TABLE PM_PERF_INDICATOR MODIFY FISCAL_YEAR NULL';
end if;
update pm_perf_indicator set fiscal_year = null, update_time = to_char(SYSDATE,'yyyyMMddHH24miss') where yearflag = '1';

--2、停掉指标表目标表触发器
--判断触发器  TABLE_NAME 是否存在（区分大小写）
select count(0) into i  from user_triggers where trigger_name = 'TR_PM_PERF_INDICATOR';
if i > 0 then
    execute immediate 'alter trigger TR_PM_PERF_INDICATOR disable';
end if;
select count(0) into i  from user_triggers where trigger_name = 'TR_PM_PERF_GOAL_INFO';
if i > 0 then
    execute immediate 'alter trigger TR_PM_PERF_GOAL_INFO disable';
end if;

--3、绩效目标修订-总体目标指标-预算年度字段置空处理
select count(1) into i from user_tab_cols t where t.table_name='PERF_PROVISION_GOAL_INFO' and t.column_name='FISCAL_YEAR' and t.nullable = 'N';
if i = 1 then
  execute immediate 'ALTER TABLE PERF_PROVISION_GOAL_INFO MODIFY FISCAL_YEAR NULL';
end if;
update perf_provision_goal_info set fiscal_year = null, update_time = to_char(SYSDATE,'yyyyMMddHH24miss') where yearflag = '1';
select count(1) into i from user_tab_cols t where t.table_name='PERF_PROVISION_INDICATOR' and t.column_name='FISCAL_YEAR' and t.nullable = 'N';
if i = 1 then
  execute immediate 'ALTER TABLE PERF_PROVISION_INDICATOR MODIFY FISCAL_YEAR NULL';
end if;
update perf_provision_indicator set fiscal_year = null, update_time = to_char(SYSDATE,'yyyyMMddHH24miss') where yearflag = '1';


