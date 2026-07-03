i integer;
begin
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='CALCULATEBY';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column calculateby';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='CALCTYPE';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column calctype';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='CALCFORMULA';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column calcformula';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='CALCDISPLAY';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column calcdisplay';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='CALCEXPLAIN';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column calcexplain';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='SCORETYPE';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column scoretype';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='SCOREDISPLAY';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column scoredisplay';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='SCOREFORMULA';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column scoreformula';
  end if;
  select count(*) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='SCOREEXPLAIN';
  if i>0 then
    execute immediate 'alter table BAS_PERF_INDICATOR drop column scoreexplain';
  end if;
  
  execute immediate '
  create or replace view v_bas_perf_indicator as
  select * from bas_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  ';
  
  delete FROM BUS_t_Diccolumn t where t.TABLECODE = 'BAS_PERF_INDICATOR' and t.columncode in ('CALCULATEBY','CALCTYPE','CALCFORMULA','CALCDISPLAY','CALCEXPLAIN','SCORETYPE','SCOREDISPLAY','SCOREFORMULA','SCOREEXPLAIN');