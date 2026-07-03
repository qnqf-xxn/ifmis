i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RECTIFY' and t.column_name='PRO_LEV';
  if i<1 then
  execute immediate 'alter table PERF_T_RECTIFY add pro_lev VARCHAR2(40)';
  end if;
  
  execute immediate '
  create or replace view v_perf_t_rectify as
	select
	  *
	from
	  perf_t_rectify t
	where
	  year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
	  ';