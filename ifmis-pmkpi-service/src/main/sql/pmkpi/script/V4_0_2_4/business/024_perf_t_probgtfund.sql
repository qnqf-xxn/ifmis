i number;
begin
  -- PERF_T_PROBGTFUND 表添加AGENCY_NAME字段
  select count(*) INTO i from user_tab_columns where table_name = upper('PERF_T_PROBGTFUND') and column_name = upper('AGENCY_NAME');
    if i = 0 then
       execute immediate 'alter table PERF_T_PROBGTFUND add AGENCY_NAME VARCHAR2(2000)';
    end if;
    
   -- PERF_T_PROBGTFUND 表添加 PRO_NAME 字段
  select count(*) INTO i from user_tab_columns where table_name = upper('PERF_T_PROBGTFUND') and column_name = upper('PRO_NAME');
    if i = 0 then
       execute immediate 'alter table PERF_T_PROBGTFUND add PRO_NAME VARCHAR2(2000)';
    end if;
  
  --重构视图
  execute immediate'
    create or replace view v_perf_t_probgtfund as
      select t.*
      from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
      and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
