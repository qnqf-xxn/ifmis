 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='GOALGUID';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add GOALGUID varchar2(40)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='INDEXSTANDARDS';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDEXSTANDARDS VARCHAR2(2000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='ISSTANDPUSH';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add ISSTANDPUSH VARCHAR2(4000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='COMPUTETYPE';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add COMPUTETYPE VARCHAR2(4000)';
     end if;
    select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='REFERENCEVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add REFERENCEVAL VARCHAR2(1000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='REFERENCESTANDARDS';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add REFERENCESTANDARDS VARCHAR2(2000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='SNINDEXVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add SNINDEXVAL VARCHAR2(1000)';
     end if;
         select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='QNINDEXVAL';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add QNINDEXVAL VARCHAR2(1000)';
     end if;          

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * FROM pm_perf_indicator_temp 
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = ''2''
';
