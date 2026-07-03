
i number(9);
begin 
  
  select count(1) into i from user_tab_cols t where table_name = 'PM_PERF_GOAL_INFO' and column_name = 'SUB_MOF_CODE' and t.NULLABLE='N';
  if i = 1 then
     execute immediate 'alter table pm_perf_goal_info modify SUB_MOF_CODE null';
  end if;
  select count(1) into i from user_tab_cols t where table_name = 'PM_PERF_INDICATOR' and column_name = 'SUB_MOF_CODE' and t.NULLABLE='N';
  if i = 1 then
     execute immediate 'alter table pm_perf_indicator modify SUB_MOF_CODE null';
  end if;
  
  update pm_perf_goal_info t set t.sub_mof_code=null;
  update pm_perf_indicator t set t.sub_mof_code=null;