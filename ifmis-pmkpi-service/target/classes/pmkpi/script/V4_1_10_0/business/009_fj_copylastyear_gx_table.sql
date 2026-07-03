  i number;
begin

select count(*) into i from user_tables t where t.table_name ='BGT_T_PROLASTYEAR';
if i=0 then
execute immediate '
create table BGT_T_PROLASTYEAR
(
  pro_code      VARCHAR2(21) not null,
  pro_name      VARCHAR2(180) not null,
  last_pro_code VARCHAR2(21) not null,
  last_pro_name VARCHAR2(180) not null,
  year          VARCHAR2(9) not null,
  province      VARCHAR2(9) not null
)';
end if;

--预算上年项目关系视图
execute immediate 'create or replace view v_perf_bgtprolastyear as 
select t.* from BGT_T_PROLASTYEAR t 
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


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

execute immediate 'create or replace view v_perf_prolastyear as select t.* from PERF_T_PROLASTYEAR t 
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';