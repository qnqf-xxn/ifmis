
i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='VALUE_CHANGE';
  if i=0 then
    execute immediate 'alter table BAS_PERF_INDICATOR add VALUE_CHANGE varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='TINDEX';
  if i=0 then
    execute immediate 'alter table BAS_PERF_INDICATOR add TINDEX varchar2(300)';
  end if;

execute immediate 'create or replace view v_bas_perf_indicator as
select *
FROM BAS_PERF_INDICATOR T
WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
