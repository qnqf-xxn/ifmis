i number;
begin

select count(*) into i from user_tables t where t.table_name ='PERF_T_DEPTPERFEVALTJ';
if i=0 then
execute immediate '
create table PERF_T_DEPTPERFEVALTJ
(
  guid           VARCHAR2(40) not null,
  dept_code      VARCHAR2(40),
  dept_name      VARCHAR2(4000),
  eval_pro_name  VARCHAR2(4000),
  eval_year      VARCHAR2(4),
  eval_pro_amt   NUMBER(20,2),
  eval_score     NUMBER(9,2),
  eval_type      NUMBER(1),
  inst_name      VARCHAR2(4000),
  report_time    VARCHAR2(17),
  create_time    VARCHAR2(17),
  update_time    VARCHAR2(17),
  year           CHAR(4) not null,
  province       VARCHAR2(9) not null,
  creater        VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  wfid           VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17),
  agencyguid     VARCHAR2(40),
  finintorgguid  VARCHAR2(40)
)';
end if;

execute immediate 'create or replace view V_PERF_T_DEPTPERFEVALTJ as
select t.* from PERF_T_DEPTPERFEVALTJ t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';