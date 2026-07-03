i number;
begin
  --添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'PERF_T_RECTIFY'  and t.COLUMN_NAME = 'SXSTATE';
  if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add SXSTATE NUMBER(1)';
  end if;
  
  --重构视图
  execute immediate' create or replace view v_perf_t_rectify as
     select t.* from perf_t_rectify t
     where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
