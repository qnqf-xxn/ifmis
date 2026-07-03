
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='RATING';
  if i=0 then
    execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD RATING VARCHAR2(20)';
  end if;

    select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='MONITORSCORE';
    if i=0 then
        execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD MONITORSCORE NUMBER(8,2)';
    end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='PUBLICTARGETSCORE';
if i=0 then
        execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD PUBLICTARGETSCORE NUMBER(8,2)';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='SELFEVALSCORE';
if i=0 then
        execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD SELFEVALSCORE NUMBER(8,2)';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='GOALACHIEVESCORE';
if i=0 then
        execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD GOALACHIEVESCORE NUMBER(8,2)';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WORKTASKASSIGN' and t.column_name='TOTALSCORE';
if i=0 then
        execute immediate 'ALTER TABLE PERF_T_WORKTASKASSIGN ADD TOTALSCORE NUMBER(8,2)';
end if;


execute immediate '
create or replace view V_PERF_T_WORKTASKASSIGN as
select *
 from PERF_T_WORKTASKASSIGN t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

