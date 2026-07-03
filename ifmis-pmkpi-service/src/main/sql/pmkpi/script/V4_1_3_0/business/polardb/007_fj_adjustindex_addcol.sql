  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--PERF_T_ADJUSTINDEX（调整指标表增加字段ISFROMPARENT-是否为继承父级指标）
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ISFROMPARENT';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ISFROMPARENT NUMBER(1)';
end if;

--PERF_T_ADJUSTINDEX（调整指标表增加字段ISAPPLY-是否适用）默认为1是
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ISAPPLY';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ISAPPLY NUMBER(1) default 1';
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTINDEX as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_ADJUSTINDEX',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;  


