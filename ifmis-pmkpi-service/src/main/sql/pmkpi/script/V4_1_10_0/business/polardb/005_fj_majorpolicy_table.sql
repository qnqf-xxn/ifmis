  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--重大政策全生命周期绩效管理表
select count(*) into i from user_tables t where t.table_name ='PERF_T_MAJORPOLICY';
if i=0 then
execute immediate '
create table PERF_T_MAJORPOLICY
(
  GUID        VARCHAR2(40) not null,
  PRO_CODE        VARCHAR2(40),
  PRO_NAME        VARCHAR2(1000),
  AGENCY_CODE      VARCHAR2(38),
  DEPT_CODE      VARCHAR2(38),
  FININTORGGUID   VARCHAR2(40),
  create_time VARCHAR2(17),
  update_time VARCHAR2(17),
  is_deleted  NUMBER(1) not null,
  year        NUMBER(4) not null,
  province    VARCHAR2(9) not null,
  yearcol1      VARCHAR2(40),
  yearcol2      VARCHAR2(40),
  yearcol3      VARCHAR2(40),
  yearcol4      VARCHAR2(40),
  yearcol5      VARCHAR2(40),
  yearcol6      VARCHAR2(40),
  yearcol7      VARCHAR2(40),
  linkman    VARCHAR2(1000),
  warn       VARCHAR2(40),
  ordernum   NUMBER(9),
  remark      VARCHAR2(1000),
  violationsnum   NUMBER(9),
  rectificationnum   NUMBER(9),
  selfevalguid1      VARCHAR2(40),
  selfevalguid2      VARCHAR2(40),
  selfevalguid3      VARCHAR2(40),
  selfevalresult1      VARCHAR2(40),
  selfevalresult2      VARCHAR2(40),
  selfevalresult3      VARCHAR2(40)
)';
end if;

v_sql :='create or replace view V_PERF_T_MAJORPOLICY as
select t.*,'''' as OBLIGATE1,'''' as OBLIGATE2,'''' as URL1,'''' as URL2
 FROM PERF_T_MAJORPOLICY T
    WHERE t.is_deleted=2 AND PROVINCE=global_multyear_cz.v_pmdivid
    AND YEAR=global_multyear_cz.v_pmyear';
select fn_alterview('V_PERF_T_MAJORPOLICY',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
	
	
v_sql :='create or replace view v_perf_project_selfresult as 
select t.*,
a1.selfevalguid as selfevalguid1,
a2.selfevalguid as selfevalguid2,
a3.selfevalguid as selfevalguid3,
a1.selfresult as selfevalresult1,
a2.selfresult as selfevalresult2,
a3.selfresult as selfevalresult3
 from V_PERF_PROJECT_INFO t
left join (select a.mainguid as selfevalguid,a.selfresult,a.pro_code from perf_t_selfperfdesc a where a.year = global_multyear_cz.v_pmyear-3)a1 
on t.pro_code = a1.pro_code
left join (select a.mainguid as selfevalguid,a.selfresult,a.pro_code from perf_t_selfperfdesc a where a.year = global_multyear_cz.v_pmyear-2)a2 
on t.pro_code = a2.pro_code
left join (select a.mainguid as selfevalguid,a.selfresult,a.pro_code from perf_t_selfperfdesc a where a.year = global_multyear_cz.v_pmyear-1)a3 
on t.pro_code = a3.pro_code';
select fn_alterview('V_PERF_PROJECT_SELFRESULT',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
