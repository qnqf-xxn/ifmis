
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='ISSUESNUM';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add ISSUESNUM number(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='RECTIFIEDNUM';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add RECTIFIEDNUM number(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='COMPAREDBDGAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add COMPAREDBDGAMT number(16,4)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='RECOVEREDAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add RECOVEREDAMT number(16,4)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='CANCELEDPRONUM';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add CANCELEDPRONUM number(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='ADJUSTPRONUM';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add ADJUSTPRONUM number(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='FUNDSNUM';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add FUNDSNUM number(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='OTHERLINKED';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add OTHERLINKED varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='MEASURESTOIMPROVE';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add MEASURESTOIMPROVE varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='IMPACTREMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add IMPACTREMARK varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='RESPONSIBLEPERSON';
  if i=0 then
    execute immediate 'alter table PERF_T_RECTIFY add RESPONSIBLEPERSON varchar2(100)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_RECTIFY' and t.column_name='ADJUSTADVICE';
  if i=1 then
    execute immediate 'alter table PERF_T_RECTIFY modify ADJUSTADVICE VARCHAR2(4000)';
  end if;
  

execute immediate '
create or replace view v_perf_t_rectify as
select *
from PERF_T_RECTIFY t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
