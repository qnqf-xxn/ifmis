
i integer;
begin

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='OLDGUID';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTINDICATOR add oldguid VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='INDUSTRYCATEGORY';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTINDICATOR add industrycategory VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='INDEXSTANDARDS';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTINDICATOR add indexstandards VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='INDEXCATEGORY';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTINDICATOR add indexcategory VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTINDICATOR' and t.column_name='INDEXCATEGORIES';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTINDICATOR add indexcategories VARCHAR2(40)';
     end if;
   
   
  execute immediate 'create or replace view v_perf_t_deptindicator as
  select *
  from PERF_T_DEPTINDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
