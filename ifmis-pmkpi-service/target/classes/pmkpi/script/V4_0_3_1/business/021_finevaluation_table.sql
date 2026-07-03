
  i number;
begin
  select count(1) into i from user_tab_cols where table_name = 'PERF_T_FINEVALUATION' and  column_name = 'UPDATETIME';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add UPDATETIME VARCHAR2(17)';
  end if;
  
execute immediate ' 
create or replace view v_perf_t_finevaluation as
select *
    from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
        and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
