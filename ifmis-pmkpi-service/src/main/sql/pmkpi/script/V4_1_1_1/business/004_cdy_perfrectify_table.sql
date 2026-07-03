
  i number;
begin
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_RECTIFY' and t.column_name='FEEDBACKAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add FEEDBACKAMT NUMBER(18,2)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_RECTIFY' and t.column_name='FEEDBACKREMARK';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add FEEDBACKREMARK VARCHAR2(4000)';
  end if;

execute immediate '
create or replace view v_perf_t_rectify as
select *
from PERF_T_RECTIFY t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
