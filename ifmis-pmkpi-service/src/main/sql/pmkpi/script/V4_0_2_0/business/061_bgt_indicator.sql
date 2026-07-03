i number;
begin
  -- 表字段
  select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='KPIVALSOURCE';
      if i=0 then
      execute immediate 'alter table BGT_PERF_INDICATOR add KPIVALSOURCE VARCHAR2(32)';
  end if;
  
--重构视图
execute immediate'
create or replace view v_bgt_perf_indicator as
select t.*
 FROM BGT_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
