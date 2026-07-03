  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--预算上年项目关系视图
v_sql :='create or replace view v_perf_bgtprolastyear as 
select t.* from BGT_T_PROLASTYEAR t 
where t.year = global_multyear_cz.v_pmyear
and t.province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_BGTPROLASTYEAR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--绩效复制目标指标选择上年项目关系表
select count(*) into i from user_tables t where t.table_name ='PERF_T_PROLASTYEAR';
if i=0 then
execute immediate '
create table PERF_T_PROLASTYEAR
(
  pro_code      VARCHAR2(21) not null,
  pro_name      VARCHAR2(180),
  last_pro_code VARCHAR2(21) not null,
  last_pro_name VARCHAR2(180),
  year          VARCHAR2(9) not null,
  province      VARCHAR2(9) not null
)';
end if;

v_sql :='create or replace view v_perf_prolastyear as select t.* from PERF_T_PROLASTYEAR t 
where t.year = global_multyear_cz.v_pmyear
and t.province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_PROLASTYEAR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;