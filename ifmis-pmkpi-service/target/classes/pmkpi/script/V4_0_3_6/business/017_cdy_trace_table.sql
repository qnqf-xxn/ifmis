
i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROMONITOR' and t.column_name='BUDGETAMOUNT';
  if i=0 then
     execute immediate 'alter table PERF_T_PROMONITOR add BUDGETAMOUNT NUMBER(20,2)';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROMONITOR' and t.column_name='EXECAMOUNT';
  if i=0 then
     execute immediate 'alter table PERF_T_PROMONITOR add EXECAMOUNT NUMBER(20,2)';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROMONITOR' and t.column_name='BGTGET';
  if i=0 then
     execute immediate 'alter table PERF_T_PROMONITOR add BGTGET NUMBER(9,2)';
  end if;
  
execute immediate '
create or replace view v_perf_t_promonitor as
select t.*
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  '
;
