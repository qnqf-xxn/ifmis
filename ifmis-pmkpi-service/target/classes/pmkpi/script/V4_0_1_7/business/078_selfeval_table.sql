  i number;
begin
--绩效自评表
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='PRO_CODE';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add(PRO_CODE VARCHAR2(40))';
end if;

execute immediate 'create or replace view v_perf_t_selfevaltask as
select * from PERF_T_SELFEVALTASK t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2
';

--自评指标表
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='PRO_CODE';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add(PRO_CODE VARCHAR2(40))';
end if;

execute immediate 'create or replace view V_PERF_T_SELFPERFINDEX as
select * from PERF_T_SELFPERFINDEX t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';

--自评补充信息表
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='PRO_CODE';
    if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFDESC add(PRO_CODE VARCHAR2(40))';
end if;

execute immediate 'create or replace view v_perf_t_selfperfdesc as
select * from PERF_T_SELFPERFDESC t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
