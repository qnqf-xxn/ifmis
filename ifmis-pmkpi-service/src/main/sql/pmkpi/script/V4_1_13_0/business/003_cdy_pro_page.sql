
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='INDSOURCE';

  if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add INDSOURCE varchar2(1)';
  end if;
  
execute immediate '
create or replace view v_pm_perf_indicator as
select *
 from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';
