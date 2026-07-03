--²ÆÕþÆÀ¼Û  pro_code×Ö¶Î
i number;
begin
  -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='PRO_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_FINEVALUATION add PRO_CODE VARCHAR2(40)';
    end if;
  
  execute immediate'
    create or replace view v_perf_t_finevaluation as
    select t.*
    from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  ';
