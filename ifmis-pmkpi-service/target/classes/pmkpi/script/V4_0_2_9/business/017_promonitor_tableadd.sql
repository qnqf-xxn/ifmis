
 i number;
begin

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROMONITOR' and t.column_name='TYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_PROMONITOR add TYPE VARCHAR2(40)';
     end if;

execute immediate '
create or replace view V_PERF_T_PROMONITOR as
select *
from PERF_T_PROMONITOR t where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
