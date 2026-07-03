     i number;
begin
  --自评预算执行情况业务表 扩展字段长度
      select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='COMPLETION';
    if i = 1 then
      execute immediate 'alter table PERF_T_SELFPROFUND modify COMPLETION VARCHAR2(2000)';
      end if;
      
      --扩展字段长度
      select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='NAME';
    if i = 1 then
      execute immediate 'alter table PERF_T_SELFPROFUND modify NAME VARCHAR2(2000)';
      end if;
    
    --重构视图
    execute immediate'
    create or replace view v_perf_t_selfprofund as
    select *
    from perf_t_selfprofund t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
