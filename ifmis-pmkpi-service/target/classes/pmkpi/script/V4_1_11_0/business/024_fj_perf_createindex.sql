i number;
j number;
begin

--监控指标表，增加索引 PERF_TASK_ID（监控主数据ID 非任务ID）, MOF_DIV_CODE, FISCAL_YEAR
select count(1) into i from user_indexes t where t.index_name = 'IDX_PERF_MONITOR_INFO_01';
select count(1) into j from user_indexes t where t.index_name = 'IDX_PERF_MONITOR_INFO_02';
if i=1 and j=0 then
 execute immediate 'create index IDX_PERF_MONITOR_INFO_02 on PAY_PERF_MONITOR_INFO (PERF_TASK_ID, MOF_DIV_CODE, FISCAL_YEAR)';
end if;
   
if i = 0 then
 execute immediate 'create index IDX_PERF_MONITOR_INFO_01 on PAY_PERF_MONITOR_INFO (PERF_TASK_ID, MOF_DIV_CODE, FISCAL_YEAR)';
end if; 