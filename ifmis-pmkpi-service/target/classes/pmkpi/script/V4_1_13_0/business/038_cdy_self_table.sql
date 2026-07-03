
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='BGTRATE';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFDESC add BGTRATE NUMBER(8,2)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='BGTREMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFDESC add BGTREMARK VARCHAR2(4000)';
  end if;


execute immediate '
create or replace view v_perf_t_selfperfdesc as
select
    *
from perf_t_selfperfdesc where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
