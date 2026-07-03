i number;
begin
  --项目级次
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='PRO_LEV';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add(PRO_LEV varchar2(40))';
  end if;  
  --上级项目
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='PRO_PARENT';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add(PRO_PARENT varchar2(2000))';
  end if; 
  
  --重构视图
  execute immediate'
    create or replace view v_bas_perf_indicator as
    select *
    FROM BAS_PERF_INDICATOR T
    WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
