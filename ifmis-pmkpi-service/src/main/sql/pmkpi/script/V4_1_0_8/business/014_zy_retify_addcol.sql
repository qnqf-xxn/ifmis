  i number;
begin

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_RECTIFY' and t.column_name='FINADJUSTADVICE';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add(FINADJUSTADVICE VARCHAR2(40))';
  end if;


execute immediate '
create or replace view V_PERF_T_RECTIFY as
select * 
from PERF_T_RECTIFY t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
