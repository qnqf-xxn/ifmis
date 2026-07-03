
  i integer;
begin
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROTRACEANALYSIS' and t.column_name='INSTITUTION';
    if i=0 then
    execute immediate 'alter table PERF_T_PROTRACEANALYSIS add(INSTITUTION varchar2(30))';
end if;

execute immediate '
create or replace view v_perf_t_protraceanalysis as
select *
  from perf_t_protraceanalysis t
 where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
