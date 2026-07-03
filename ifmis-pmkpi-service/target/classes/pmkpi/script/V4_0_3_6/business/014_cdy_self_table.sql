
i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='BUDGETAMOUNT';
  if i=0 then
     execute immediate 'alter table PERF_T_SELFEVALTASK add BUDGETAMOUNT NUMBER(20,2)';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='EXECAMOUNT';
  if i=0 then
     execute immediate 'alter table PERF_T_SELFEVALTASK add EXECAMOUNT NUMBER(20,2)';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='BGTAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_SELFEVALTASK add BGTAMT NUMBER(20,2)';
  end if;
  
execute immediate '
create or replace view v_perf_t_selfevaltask as
select t.*
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2
  '
;