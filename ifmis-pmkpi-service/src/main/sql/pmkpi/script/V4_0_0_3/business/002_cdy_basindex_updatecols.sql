
i integer;
begin

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='NAME';
   if i=1 then
     execute immediate 'alter table BAS_PERF_INDICATOR modify name VARCHAR2(80)';
   end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='PERF_IND_NAME';
   if i=1 then
     execute immediate 'alter table BAS_PERF_INDICATOR modify PERF_IND_NAME VARCHAR2(80)';
   end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='OLDGUID';
     if i=0 then
       execute immediate 'alter table BAS_PERF_INDICATOR add oldguid VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='INDUSTRYCATEGORY';
     if i=0 then
       execute immediate 'alter table BAS_PERF_INDICATOR add industrycategory VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDS';
     if i=0 then
       execute immediate 'alter table BAS_PERF_INDICATOR add indexstandards VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='INDEXCATEGORY';
     if i=0 then
       execute immediate 'alter table BAS_PERF_INDICATOR add indexcategory VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='INDEXCATEGORIES';
     if i=0 then
       execute immediate 'alter table BAS_PERF_INDICATOR add indexcategories VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='NAME';
   if i=1 then
     execute immediate 'alter table PERF_T_DEPTINDICATOR modify name VARCHAR2(80)';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='TARGETVALUE';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify targetvalue VARCHAR2(60)';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='NAME';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify name VARCHAR2(80)';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='TARGETVALUE';
     if i=0 then
       execute immediate 'alter table BGT_PERF_INDICATOR add targetvalue VARCHAR2(60)';
   end if;
   
   
   select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='NAME';
   if i=1 then
     execute immediate 'alter table BGT_PERF_INDICATOR modify name VARCHAR2(80)';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='VALUE_DESC';
   if i=1 then
     execute immediate 'alter table BAS_PERF_INDICATOR modify value_desc null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='SUB_MOF_CODE';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify sub_mof_code null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='BUSI_TYPE';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify busi_type null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='KPI_EVALSTD';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify kpi_evalstd null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='KPI_CONTENT';
   if i=1 then
     execute immediate 'alter table PM_PERF_INDICATOR modify kpi_content null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='KPI_EVALSTD';
   if i=1 then
     execute immediate 'alter table BGT_PERF_INDICATOR modify kpi_evalstd null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='KPI_CONTENT';
   if i=1 then
     execute immediate 'alter table BGT_PERF_INDICATOR modify kpi_content null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_INFO' and t.column_name='BUSI_TYPE';
   if i=1 then
     execute immediate 'alter table PM_PERF_GOAL_INFO modify busi_type null';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_INFO' and t.column_name='SUB_MOF_CODE';
   if i=1 then
     execute immediate 'alter table PM_PERF_GOAL_INFO modify sub_mof_code null';
   end if;
   
	execute immediate 'create or replace view v_bas_perf_indicator as
	select *
	from bas_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

	execute immediate 'create or replace view v_bgt_perf_indicator as
	select *
	from bgt_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
