i number;
begin

--AI事前评估审核结果(ZJ)
select count(*) into i from user_tables t where t.table_name ='PERF_T_AIPREPERFAUDIT';
if i=0 then
execute immediate '
create table PERF_T_AIPREPERFAUDIT
(
  guid            VARCHAR2(40) not null,
  province        VARCHAR2(40) not null,
  year            VARCHAR2(40) not null, 
  agency_code     VARCHAR2(40),
  agency_name     VARCHAR2(1000),
  pro_code        VARCHAR2(400),  
  pro_name        VARCHAR2(1000),
  create_time     VARCHAR2(40),
  conclusion      VARCHAR2(4000),
  reportproblem   VARCHAR2(4000),
  indicator       VARCHAR2(4000),
  auditpoint1     VARCHAR2(4000),
  auditpoint2     VARCHAR2(4000),
  auditpoint3     VARCHAR2(4000),
  auditpoint4     VARCHAR2(4000),
  auditpoint5     VARCHAR2(4000)
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_AIPREPERFAUDIT_PARTITION';
if i = 0 then
 execute immediate 'create index IDX_AIPREPERFAUDIT_PARTITION on PERF_T_AIPREPERFAUDIT (PRO_CODE, PROVINCE, YEAR)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AIPREPERFAUDIT_TIMESTAMP';
if i = 0 then
 execute immediate 'create index IDX_AIPREPERFAUDIT_TIMESTAMP on PERF_T_AIPREPERFAUDIT (CREATE_TIME DESC)';
end if; 


--结果记录视图 默认取最新
execute immediate '
CREATE OR REPLACE VIEW PERF_V_AIPREPERFAUDIT AS
SELECT 
    province, year, create_time, 
    agency_code, agency_name, pro_code, pro_name, conclusion, reportProblem, indicator,auditpoint1, auditpoint2, auditpoint3, auditpoint4, auditpoint5
FROM PERF_T_AIPREPERFAUDIT t1
WHERE create_time = (
    SELECT MAX(create_time)
    FROM PERF_T_AIPREPERFAUDIT t2
    WHERE t2.pro_code = t1.pro_code 
      AND t2.province = t1.province 
      AND t2.year = t1.year
)
and t1.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
and t1.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDITEXE' and t.column_name='PRO_ID';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDITEXE add PRO_ID VARCHAR2(40)';
end if;

execute immediate 'create or replace view V_PERF_T_AISUPPORTAUDITEXE as
select t.* from PERF_T_AISUPPORTAUDITEXE t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view V_PERF_T_AISUPPORTAUDITWAITING
as select 
t.guid,t.pro_id,t.pro_code,t.pro_name,t.province,t.year,
t.agencyguid,t.finintorgguid,
t.agency_code,'''' as agency_name,'''' as api_code, ''待审核'' as status,'''' as create_time, '''' as update_time
from V_PERF_PROJECT_YEAR t';