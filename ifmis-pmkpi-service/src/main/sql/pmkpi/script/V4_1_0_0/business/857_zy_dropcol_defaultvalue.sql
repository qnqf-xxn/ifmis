i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO' and column_name = 'BUSI_TYPE_CODE';
  if i = 1 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO modify busi_type_code default ''2''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'BUSI_TYPE_CODE';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify busi_type_code default ''1''';
  end if;  
  
  select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR' and column_name = 'BUSI_TYPE_CODE';
  if i = 1 then
     execute immediate 'alter table BGT_PERF_INDICATOR modify busi_type_code default ''2''';
  end if;
  
  select count(1) into i from user_tables where table_name = 'PM_PERF_INDICATOR_ONE';
  if i = 1 then
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'BUSI_TYPE_CODE';
    if i = 1 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE modify busi_type_code default ''2''';
    end if;  
  end if;    
    
  select count(1) into i from user_tables where table_name = 'BGT_PERF_GOAL_INFO_ONE';
  if i = 1 then
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO_ONE' and column_name = 'BUSI_TYPE_CODE';
    if i = 1 then
       execute immediate 'alter table BGT_PERF_GOAL_INFO_ONE modify busi_type_code default ''2''';
    end if;
  end if;     
    
  select count(1) into i from user_tables where table_name = 'BGT_PERF_INDICATOR_ONE';
  if i = 1 then
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'BUSI_TYPE_CODE';
    if i = 1 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE modify busi_type_code default ''2''';
    end if; 
  end if;   
