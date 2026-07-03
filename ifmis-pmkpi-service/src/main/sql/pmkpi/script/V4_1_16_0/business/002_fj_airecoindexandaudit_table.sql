i number;
begin

select count(*) into i from user_tables t where t.table_name ='PERF_T_AIRECOINDEXMAIN';
if i=0 then
execute immediate '
create table PERF_T_AIRECOINDEXMAIN
(
  guid             VARCHAR2(40) not null,
  pro_code         VARCHAR2(40),
  prompt           clob,
  thinkingprocess  clob,
  yearflag		   VARCHAR2(40),
  province         VARCHAR2(32) not null,
  year             NUMBER(4) not null,
  create_time      VARCHAR2(17)
     
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_AIRECOINDEXMAIN_PARTITION';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AIRECOINDEXMAIN_PARTITION ON PERF_T_AIRECOINDEXMAIN(PRO_CODE, PROVINCE, YEAR)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AIRECOINDEXMAIN_TIMESTAMP';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AIRECOINDEXMAIN_TIMESTAMP ON PERF_T_AIRECOINDEXMAIN(CREATE_TIME DESC)';
end if; 

select count(*) into i from user_tables t where t.table_name ='PERF_T_AIRECOINDEX';
if i=0 then
execute immediate '
create table PERF_T_AIRECOINDEX
(
  guid             VARCHAR2(40) not null,
  pro_code         VARCHAR2(40),
  kpi_target       VARCHAR2(400),
  findex           VARCHAR2(40),
  findexname       VARCHAR2(400),
  sindex           VARCHAR2(40),
  sindexname       VARCHAR2(400),
  name             VARCHAR2(400),
  computesign      VARCHAR2(40),
  indexval         VARCHAR2(400),
  meterunit        VARCHAR2(40),
  ai_recoindexmark VARCHAR2(40),
  yearflag		   VARCHAR2(40),
  province         VARCHAR2(32) not null,
  year             NUMBER(4) not null,
  create_time      VARCHAR2(17),
  ordernum         NUMBER(4)
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_AIRECOINDEX_PARTITION';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AIRECOINDEX_PARTITION ON PERF_T_AIRECOINDEX(PRO_CODE, PROVINCE, YEAR)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AIRECOINDEX_TIMESTAMP';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AIRECOINDEX_TIMESTAMP ON PERF_T_AIRECOINDEX(CREATE_TIME DESC)';
end if; 

execute immediate 'create or replace view PERF_V_AIRECOINDEXMAIN as
SELECT
    t1.*
FROM perf_t_airecoindexmain t1
WHERE create_time = (
    SELECT MAX(create_time)
    FROM perf_t_airecoindexmain t2
    WHERE t2.pro_code = t1.pro_code
      AND t2.yearflag = t1.yearflag
	  AND t2.province = t1.province
      AND t2.year = t1.year
)
and t1.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t1.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';



execute immediate 'CREATE OR REPLACE VIEW PERF_V_AIRECOINDEX AS
SELECT
    t1.*
FROM perf_t_airecoindex t1
WHERE create_time = (
    SELECT MAX(create_time)
    FROM perf_t_airecoindex t2
    WHERE t2.pro_code = t1.pro_code
	  AND t2.yearflag = t1.yearflag
      AND t2.province = t1.province
      AND t2.year = t1.year
)
and t1.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t1.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';


select count(*) into i from user_tables t where t.table_name ='PERF_T_AISUPPORTAUDITEXE';
if i=0 then
execute immediate '
create table PERF_T_AISUPPORTAUDITEXE
(
  guid           VARCHAR2(40) not null,
  pro_code      VARCHAR2(40) not null,
  province      VARCHAR2(9) not null,
  year          VARCHAR2(4) not null,
  status        VARCHAR2(40),
  api_code      VARCHAR2(40),
  pro_name      VARCHAR2(4000),
  agencyguid    VARCHAR2(40),
  finintorgguid VARCHAR2(40),
  create_time   VARCHAR2(17),
  update_time   VARCHAR2(17),
  agency_code   VARCHAR2(40),
  agency_name   VARCHAR2(4000)
)';
end if;

execute immediate 'create or replace view V_PERF_T_AISUPPORTAUDITEXE as
select t.* from PERF_T_AISUPPORTAUDITEXE t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


execute immediate '
create or replace view V_PERF_T_AISUPPORTAUDITWAITING
as select 
t.guid,t.pro_code,t.pro_name,t.province,t.year,
t.agencyguid,t.finintorgguid,
t.agency_code,'''' as agency_name,'''' as api_code, ''待审核'' as status,'''' as create_time, '''' as update_time
from V_PERF_PROJECT_YEAR t';