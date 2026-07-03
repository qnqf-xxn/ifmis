
i number;
begin 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_TREETAB' and t.column_name='CONFIG';
  if i=0 then
    execute immediate 'alter table PERF_T_TREETAB add CONFIG VARCHAR2(2000)';
  end if;

execute immediate '
create or replace view v_perf_t_treetab as
select *
from perf_t_treetab t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
