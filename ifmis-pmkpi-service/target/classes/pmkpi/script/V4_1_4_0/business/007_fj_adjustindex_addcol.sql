 i number;
begin

--PERF_T_ADJUSTINDEX  ISFROMPARENT
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ISALLOWEDIT';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ISALLOWEDIT NUMBER(1)';
end if;

--PERF_T_ADJUSTINDEX  ONLYSELF
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ONLYSELF';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ONLYSELF NUMBER(1)';
end if;

execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';



