
i number;
begin

  --select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'BUSI_TYPE_CODE';
  --if i = 1 then
  --   execute immediate 'alter table BGT_PERF_GOAL_INFO drop column busi_type_code';
  --end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add mof_div_name varchar2(360)';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'DEPT_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add DEPT_NAME varchar2(360)';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.DEPT_NAME is ''部门名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table BGT_PERF_GOAL_INFO add IS_LAST_INST number(1)';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.IS_LAST_INST is ''是否终审''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'VERSIONTYPE';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add VERSIONTYPE number(1) default 0';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.VERSIONTYPE is ''0 日常动态 1 编制 2 批复，3执行''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'IS_BACKUP';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add IS_BACKUP number(1) default 2';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.IS_BACKUP is ''1 版本记录 2 日常动态''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'VERSION';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add VERSION VARCHAR2(38)';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.VERSION is ''版本号''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'VERSION_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add VERSION_NAME VARCHAR2(400)';
     execute immediate 'comment on column BGT_PERF_GOAL_INFO.VERSION_NAME is ''版本说明''';
  end if;  
