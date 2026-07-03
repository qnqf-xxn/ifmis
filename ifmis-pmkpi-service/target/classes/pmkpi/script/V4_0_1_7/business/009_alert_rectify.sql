i number;
begin
  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_T_RECTIFY' and t.COLUMN_NAME='RECTYPE';
  if i = 0 then
    execute immediate'alter table PERF_T_RECTIFY add RECTYPE VARCHAR2(50)';
  end if;
  
  -- ÷ÿππ ‘Õº
  execute immediate'
  create or replace view v_perf_t_rectify as
  select *
  from PERF_T_RECTIFY t 
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and 
  PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
