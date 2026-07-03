i number;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='IS_INTOINDEXLIB';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add IS_INTOINDEXLIB NUMBER(1) default 2';
end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='IS_INTOINDEXLIB';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add IS_INTOINDEXLIB NUMBER(1) default 2';
end if;

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

select count(*) into i from user_tables t where t.table_name ='PERF_T_INTOINDEXLIBEXPLAN';
if i=0 then
execute immediate '
create table PERF_T_INTOINDEXLIBEXPLAN(
  explan_type      VARCHAR2(40),
  explan_code      VARCHAR2(400),
  explan_desc      VARCHAR2(4000),
  ordernum		   NUMBER(9)
)';
end if;