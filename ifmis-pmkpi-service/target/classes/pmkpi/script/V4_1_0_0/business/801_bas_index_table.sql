
i number;
begin
  select count(1) into i from user_tab_columns where table_name = 'BAS_PERF_INDICATOR' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add mof_div_name varchar2(360)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BAS_PERF_INDICATOR' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add agency_name varchar2(300)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.agency_name is ''部门（单位）名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BAS_PERF_INDICATOR' and column_name = 'IS_PM_PERF_IND';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add IS_PM_PERF_IND varchar2(1)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.IS_PM_PERF_IND is ''是否项目绩效指标''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'BAS_PERF_INDICATOR' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table BAS_PERF_INDICATOR add IS_LAST_INST number(1)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.IS_LAST_INST is ''是否终审''';
  end if;
  
execute immediate '  
create or replace view v_bas_perf_indicator as
select *
FROM BAS_PERF_INDICATOR T
WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

