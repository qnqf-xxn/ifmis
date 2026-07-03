
i number;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_RECTIFY' and t.column_name='FINFEEDBACKAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add FINFEEDBACKAMT NUMBER(18,2)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_RECTIFY' and t.column_name='FINFEEDBACKREMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add FINFEEDBACKREMARK VARCHAR2(4000)';
  end if;

execute immediate '
create or replace view v_perf_t_rectify as
select *
from PERF_T_RECTIFY t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
