 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='GOALGUID';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add GOALGUID varchar2(40)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='INDEXSTANDARDS';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add INDEXSTANDARDS VARCHAR2(2000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='ISSTANDPUSH';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add ISSTANDPUSH VARCHAR2(4000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='COMPUTETYPE';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add COMPUTETYPE VARCHAR2(4000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='REFERENCEVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add REFERENCEVAL VARCHAR2(1000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='REFERENCESTANDARDS';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add REFERENCESTANDARDS VARCHAR2(2000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='SNINDEXVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add SNINDEXVAL VARCHAR2(1000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='QNINDEXVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add QNINDEXVAL VARCHAR2(1000)';
     end if;          

execute immediate '
create or replace view v_pm_perf_indicator as
select *
from pm_perf_indicator t where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

