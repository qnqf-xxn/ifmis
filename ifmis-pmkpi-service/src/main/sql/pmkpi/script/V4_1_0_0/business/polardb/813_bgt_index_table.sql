
i number;
begin

  --select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'BUSI_TYPE_CODE';
  --if i = 1 then
   --  execute immediate 'alter table BGT_PERF_INDICATOR drop column busi_type_code';
  --end if;

  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'KPI_LV1';
  if i = 1 then
     execute immediate 'alter table BGT_PERF_INDICATOR rename column kpi_lv1 to LV1_PERF_IND_CODE';
     execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR'', ''lv1_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'KPI_LV2';
  if i = 1 then
     execute immediate 'alter table BGT_PERF_INDICATOR rename column kpi_lv2 to LV2_PERF_IND_CODE';
     execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR'', ''lv2_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'KPI_LV3';
  if i = 1 then
     execute immediate 'alter table BGT_PERF_INDICATOR rename column kpi_lv3 to LV3_PERF_IND_CODE';
     execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR'', ''lv3_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'DEPT_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add DEPT_NAME VARCHAR2(300)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.DEPT_NAME is ''部门名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'LV1_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add lv1_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.lv1_perf_ind_name is ''一级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'LV2_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add lv2_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.lv2_perf_ind_name is ''二级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'LV3_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add lv3_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.lv3_perf_ind_name is ''三级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table BGT_PERF_INDICATOR add IS_LAST_INST number(1)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.IS_LAST_INST is ''是否终审''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'VERSIONTYPE';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add VERSIONTYPE number(1) default 0';
     execute immediate 'comment on column BGT_PERF_INDICATOR.VERSIONTYPE is ''0 日常动态 1 编制 2 批复，3执行''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'IS_BACKUP';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add IS_BACKUP number(1) default 2';
     execute immediate 'comment on column BGT_PERF_INDICATOR.IS_BACKUP is ''1 版本记录 2 日常动态''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'VERSION';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add VERSION VARCHAR2(38)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.VERSION is ''版本号''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'VERSION_NAME';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add VERSION_NAME VARCHAR2(400)';
     execute immediate 'comment on column BGT_PERF_INDICATOR.VERSION_NAME is ''版本说明''';
  end if; 

