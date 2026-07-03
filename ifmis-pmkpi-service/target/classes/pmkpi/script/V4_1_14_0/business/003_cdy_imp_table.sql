
i number;
begin
  
  select count(*) into i from user_constraints where constraint_name = 'UK_PERF_IMPEXPSUB' and table_name = 'PERF_T_IMPEXPSUB';
  if i=1 then    
  execute immediate 'ALTER TABLE PERF_T_IMPEXPSUB DROP CONSTRAINT UK_PERF_IMPEXPSUB';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_IMPEXPSUB' and t.column_name='REDDEN';
  if i=0 then
    execute immediate 'alter table PERF_T_IMPEXPSUB add redden VARCHAR2(100)';
  end if;
  
execute immediate '
create or replace view v_perf_t_impexpsub as
select *
from perf_t_impexpsub where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
