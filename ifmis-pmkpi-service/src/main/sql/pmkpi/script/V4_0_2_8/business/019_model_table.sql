
i number;
begin 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MODEL' and t.column_name='IS_DELETED';
  if i=0 then
    execute immediate 'alter table PERF_T_MODEL add IS_DELETED NUMBER(1)';
  end if;

execute immediate '
create or replace view v_perf_t_model as
select t.*
FROM PERF_T_MODEL T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') and t.is_deleted=2';
