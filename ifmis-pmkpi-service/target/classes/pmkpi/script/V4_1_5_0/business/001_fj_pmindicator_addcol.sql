 i number;
begin

--PM_PERF_INDICATOR SUMTYPE
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='SUMTYPE';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR add SUMTYPE NUMBER(1)';
end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2';


--PM_PERF_INDICATOR_TEMP ISALLOWEDIT 
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR_TEMP' and t.column_name='SUMTYPE';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR_TEMP add SUMTYPE NUMBER(1)';
end if;

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';