  i number;
begin
  --预算执行情况业务表添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROBGTFUND' and t.COLUMN_NAME='SUPERGUID';
    if i=0 then
      execute immediate 'alter table PERF_T_PROBGTFUND add SUPERGUID VARCHAR2(40)';
    end if;  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROBGTFUND' and t.COLUMN_NAME='LEVELNO';
    if i=0 then
      execute immediate 'alter table PERF_T_PROBGTFUND add LEVELNO NUMBER(1)';
    end if;  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROBGTFUND' and t.COLUMN_NAME='CODE';
    if i=0 then
      execute immediate 'alter table PERF_T_PROBGTFUND add CODE VARCHAR2(40)';
    end if;  
    
    
    --重构视图
    execute immediate'
    create or replace view v_perf_t_probgtfund as
select t.*
      from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
