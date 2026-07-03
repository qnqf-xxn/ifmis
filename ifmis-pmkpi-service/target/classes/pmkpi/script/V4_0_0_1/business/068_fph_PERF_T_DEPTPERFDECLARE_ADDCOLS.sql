

--政府性基金  GOVTFUNDS
--其他资金  OTHERFUNDS
--国有资本经营预算  STATECAPITALBUDGET
--一般公共预算  PUBBUDGET


 
  i integer;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='GOVTFUNDS';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(GOVTFUNDS number(20,5))';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='OTHERFUNDS';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(OTHERFUNDS number(20,5))';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='STATECAPITALBUDGET';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(STATECAPITALBUDGET number(20,5))';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='PUBBUDGET';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(PUBBUDGET number(20,5))';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='SUMFUNDS';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(SUMFUNDS number(20,5))';
  end if;

execute immediate '
create or replace view v_PERF_T_DEPTPERFDECLARE as
select * 
from PERF_T_DEPTPERFDECLARE where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
