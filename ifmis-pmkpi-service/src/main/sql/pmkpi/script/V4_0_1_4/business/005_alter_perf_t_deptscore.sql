
  i integer;
begin
--部门评分表01
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTSCORE' and t.column_name='TARGETVALUE';
    if i=0 then
    execute immediate 'alter table PERF_T_DEPTSCORE add(TARGETVALUE varchar2(255))';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTSCORE' and t.column_name='EVALUATIONRULE';
    if i=0 then
    execute immediate 'alter table PERF_T_DEPTSCORE add(EVALUATIONRULE varchar2(255))';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTSCORE' and t.column_name='REMARKS';
    if i=0 then
    execute immediate 'alter table PERF_T_DEPTSCORE add(REMARKS varchar2(4000))';
end if;

execute immediate '
create or replace view V_PERF_T_DEPTSCORE as
select * from perf_t_deptscore where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
 and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
