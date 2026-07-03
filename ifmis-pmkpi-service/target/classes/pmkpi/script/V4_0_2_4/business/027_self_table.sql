
 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPROFUND' and t.column_name='AGENCY_NAME';
     if i=0 then
       execute immediate 'alter table PERF_T_SELFPROFUND add AGENCY_NAME VARCHAR2(500)';
     end if;

execute immediate ' 
create or replace view v_perf_t_selfprofund as
select *
    from perf_t_selfprofund t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
      and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
