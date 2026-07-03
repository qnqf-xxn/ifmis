
i number(9);
begin 
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_T_IMPEXPSUB') and column_name = upper('IMPORTDS');
  if i = 0 then
     execute immediate 'alter table PERF_T_IMPEXPSUB add IMPORTDS varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_T_IMPEXPSUB') and column_name = upper('IMPORTDSCFG');
  if i = 0 then
     execute immediate 'alter table PERF_T_IMPEXPSUB add IMPORTDSCFG varchar2(4000)';
  end if;
  
  
execute immediate '
create or replace view v_perf_t_impexpsub as
select *
from perf_t_impexpsub where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
