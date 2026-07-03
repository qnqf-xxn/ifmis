  i integer;
begin

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SELFEVALTASK';
  if i=0 then
  execute immediate '
create table PERF_T_SELFEVALTASK
(
  guid           VARCHAR2(40) not null,
  code           VARCHAR2(40),
  name           VARCHAR2(500),
  evalstatus     NUMBER(1),
  evalstart      VARCHAR2(17),
  evalend        VARCHAR2(17),
  c1             NUMBER(18,2),
  c2             NUMBER(18,2),
  c3             NUMBER(18,2),
  c4             NUMBER(18,2),
  c5             NUMBER(18,2),
  c6             NUMBER(18,2),
  c7             NUMBER(18,2),
  c8             NUMBER(18,2),
  c9             NUMBER(18,2),
  c10            NUMBER(18,2),
  c11            NUMBER(18,2),
  c12            NUMBER(18,2),
  c13            NUMBER(18,2),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  ordernum       NUMBER(9),
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  month          VARCHAR2(40),
  perfgoalguid   VARCHAR2(40),
  projguid       VARCHAR2(40),
  bustype        VARCHAR2(40),
  prokind        VARCHAR2(40),
  budgetamount   VARCHAR2(40),
  remainingdays  VARCHAR2(40),
  is_deleted     NUMBER(1) default 2
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_SELFEVALTASK
  add constraint PK_PERF_T_SELFEVALTASK primary key (GUID)
  using index ';
end if;
   
execute immediate '
create or replace view v_perf_t_selfevaltask as
select * from PERF_T_SELFEVALTASK t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';
  
  
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SELFPERFDESC';
if i=0 then
  execute immediate '
create table PERF_T_SELFPERFDESC
(
  guid           VARCHAR2(40) not null,
  mainguid       VARCHAR2(40),
  yeargoal       VARCHAR2(4000),
  allyeargoal    VARCHAR2(2000),
  selfaddinfo    VARCHAR2(2000),
  deviationanaly VARCHAR2(2000),
  rectification  VARCHAR2(2000),
  projguid       VARCHAR2(40),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  vcol1          VARCHAR2(200),
  vcol2          VARCHAR2(200),
  vcol3          VARCHAR2(200),
  vcol4          VARCHAR2(200),
  vcol5          VARCHAR2(200),
  vcol6          VARCHAR2(2000),
  vcol7          VARCHAR2(2000),
  vcol8          VARCHAR2(2000),
  vcol9          VARCHAR2(2000),
  vcol10         VARCHAR2(2000),
  score          NUMBER(5,2),
  warn           VARCHAR2(40),
  selfresult     VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_SELFPERFDESC
  add constraint PK_PERF_T_SELFPERFDESC primary key (GUID)
  using index ';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='WARN';
if i=0 then
	execute immediate 'alter table PERF_T_SELFPERFDESC add WARN VARCHAR2(40)';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFDESC' and t.column_name='SCORE';
if i=0 then
	execute immediate 'alter table PERF_T_SELFPERFDESC add SCORE NUMBER(5,2)';
end if;

execute immediate '
create or replace view v_PERF_T_SELFPERFDESC as
select * from PERF_T_SELFPERFDESC t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SELFPERFINDEX';
if i=0 then
  execute immediate '
create table PERF_T_SELFPERFINDEX
(
  guid          VARCHAR2(40) not null,
  code          VARCHAR2(200),
  name          VARCHAR2(200),
  taskguid      VARCHAR2(40),
  tindex        VARCHAR2(40),
  findex        VARCHAR2(40),
  sindex        VARCHAR2(40),
  isleaf        VARCHAR2(40),
  superid       VARCHAR2(40),
  levelno       VARCHAR2(40),
  mainguid      VARCHAR2(40),
  projguid      VARCHAR2(40),
  agencyguid    VARCHAR2(40),
  wfstatus      VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  creater       VARCHAR2(40) not null,
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null,
  ordernum      NUMBER(9),
  finintorgguid VARCHAR2(40),
  wfid          VARCHAR2(40),
  rule          VARCHAR2(200),
  kpi_remark    VARCHAR2(2000),
  kpi_evalstd   VARCHAR2(2000),
  indexval      VARCHAR2(1000),
  computesign   VARCHAR2(40),
  meterunit     VARCHAR2(200),
  actualvalue   VARCHAR2(1000),
  weight        NUMBER(5,2),
  score         NUMBER(5,2),
  operation     VARCHAR2(40),
  is_deleted    NUMBER(1) not null,
  kpivalsource  VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_SELFPERFINDEX
  add constraint PK_PERF_T_SELFPERFINDEX primary key (GUID, PROVINCE, YEAR, IS_DELETED)
  using index  ';
end if;

execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFBDGPAY AS
SELECT
 ''当年财政资金'' AMTNAME,
 0 AMT1,
0 AMT2,
0 AMT3,
0 AMT4,
0 AMT5,
'''' SCORE,
'''' proguid
FROM  dual

union all

 SELECT
''上年结转资金'' AMTNAME,
0 AMT1,
0 AMT2,
0 AMT3,
0 AMT4,
0 AMT5,
'''' SCORE,
'''' proguid
FROM  dual
union all
 SELECT
''其他资金'' AMTNAME,
0 AMT1,
0 AMT2,
0 AMT3,
0 AMT4,
0 AMT5,
'''' SCORE,
'''' proguid
FROM  dual';

execute immediate '
create or replace view v_PERF_T_SELFPERFINDEX as
select * from PERF_T_SELFPERFINDEX t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'create or replace view v_perf_v_selfevaltask as
select t.EVALSTART,
       t.GUID,
       t.AUDITOR,
       t.EVALSTATUS,
       t.FININTORGGUID,
       t.YEAR,
       t.CREATETIME,
       t.STATUS,
       t.EVALEND,
       t.WFSTATUS,
       t.LASTUPDATETIME,
       t.MONTH,
       t.CODE,
       t.PROKIND,
       t.NAME,
       t.AGENCYGUID,
       t.PERFGOALGUID,
       t.PROJGUID,
       t.CREATER,
       t.BUSTYPE,
       t.ORDERNUM,
       t.PROVINCE,
       t.WFID,
       t.UPDATETIME,
       0 as BUDGETAMOUNT,
       0 as EXECAMOUNT,
       a.amt5 EXECRATE,
       0 EXECRATENUM,
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') -
                        TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0 then
          TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') -
                    TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else
          0
       end as REMAININGDAYS,
       
       nvl(s.score,0) SCORE,
       case when nvl(s.score,0) > 90 then
         ''优''
       when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90)  then
         ''良''
       when (nvl(s.score, 0) >= 60 and nvl(s.score, 0) < 80) then
         ''中''
       when nvl(s.score, 0) < 60 then
         ''差''
       end as SELFRESULT,
       s.WARN
  from V_PERF_T_SELFEVALTASK t
  left join v_perf_t_selfperfdesc s
    on s.mainguid = t.guid
  left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,nvl(sum(amt5),0) amt5 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=t.projguid
  where t.BUSTYPE = 1
';

execute immediate 'create or replace view v_perf_dept_selfevaltask as
select t.EVALSTART,
       t.GUID,
       t.AUDITOR,
       t.EVALSTATUS,
       t.FININTORGGUID,
       t.YEAR,
       t.CREATETIME,
       t.STATUS,
       t.EVALEND,
       t.WFSTATUS,
       t.LASTUPDATETIME,
       t.MONTH,
       t.CODE,
       t.PROKIND,
       t.NAME,
       t.AGENCYGUID,
       t.PERFGOALGUID,
       t.PROJGUID,
       t.CREATER,
       t.BUSTYPE,
       t.ORDERNUM,
       t.PROVINCE,
       t.WFID,
       t.UPDATETIME,
       0 as BUDGETAMOUNT,
       0 as EXECAMOUNT,
       0 as EXECRATENUM,
       a.amt5 EXECRATE,
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') -
                        TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0 then
          TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') -
                    TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else
          0
       end as REMAININGDAYS,
       nvl(s.score,0) SCORE,
       case when nvl(s.score,0) > 90 then
         ''优''
       when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90)  then
         ''良''
       when (nvl(s.score, 0)>= 60 and nvl(s.score, 0) < 80) then
         ''中''
       when nvl(s.score, 0) < 60 then
         ''差''
       end as SELFRESULT,
       s.WARN
  from V_PERF_T_SELFEVALTASK t
  left join v_perf_t_selfperfdesc s
    on s.mainguid = t.guid
    left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,nvl(sum(amt5),0) amt5 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=t.projguid
  where t.BUSTYPE = 3';
  
execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFPERFDESC AS
SELECT t."GUID",
       s.MAINGUID,
       t."YEARGOAL",
       t."ALLYEARGOAL",
       t."SELFADDINFO",
       t."DEVIATIONANALY",
       t."RECTIFICATION",
       t."PROJGUID",
       t."AGENCYGUID",
       t."WFSTATUS",
       t."STATUS",
       t."CREATETIME",
       t."UPDATETIME",
       t."CREATER",
       t."PROVINCE",
       t."YEAR",
       t."FININTORGGUID",
       t."WFID",
       t."VCOL1",
       t."VCOL2",
       t."VCOL3",
       t."VCOL4",
       t."VCOL5",
       t."VCOL6",
       t."VCOL7",
       t."VCOL8",
       t."VCOL9",
       t."VCOL10",
       case when nvl(s.score,0) + nvl(a.bgtscore,0) > 90 then
         ''优''
       when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then
         ''良''
       when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then
         ''中''
       when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then
         ''差''
       end as SELFRESULT,
       nvl(s.score, 0) + nvl(a.bgtscore,0) score,
       case when nvl(s.score,0) = 0 then
         ''''
       when  (nvl(s.score,0)/90-bgtscore/10)/(nvl(s.score,0)/90)>0.05 then 
         ''red''
       when a.amt3 = 0 then
         ''yellow''
       when  (a.amt3-a.amt4)/a.amt3>0.2 then
         ''yellow''
         end warn
  FROM (select c.mainguid,c.projguid, sum(c.score) score
               from V_PERF_T_SELFPERFINDEX c
              group by c.mainguid,c.projguid) s
  left join V_PERF_T_SELFPERFDESC t
    on s.mainguid = t.mainguid
    left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=s.projguid
';

execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFEVALDEPT AS
SELECT nvl(b.GUID,sys_guid()) guid,
       b.PERFGOALGUID,
       t.guid as projguid,
       t.CODE as CODE,
       t.CODE as PROJCODE,
       t.NAME as NAME,
       t.agencyguid,
       t.finintorgguid,
       '''' as prokind,
       3 as bustype,
       '''' as procategory,
       '''' as func,
       '''' as perftype,
       t.PROVINCE,
       t.YEAR,
       '''' as projtype,
       b.remainingdays,
       b.evalend,
       b.evalstart,
       b.evalstatus,
       b.UPDATETIME,
       b.WFID,
       b.WFSTATUS,
       0 as budgetamount,
       0 as execamount,
       ''0%'' as EXECRATE
  FROM V_PERF_T_DEPTPERFDECLARE t
  LEFT JOIN V_PERF_T_SELFEVALTASK b
    on b.PERFGOALGUID = t.guid
   where t.wfstatus =''011''';
   
execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFEVALPROGRAMS AS
SELECT nvl(tsk.GUID,sys_guid()) guid,
       pro.guid as projguid,
       pro.pro_code as projcode,
       pro.pro_name as name,
       pro.agencyguid,
       pro.mof_dep_code finintorgguid,
       pro.YEAR,
       pro.PROVINCE,
       pro.projectkind as prokind,
       1 as bustype,
       pro.pro_cat_code as procategory,
       pro.exp_func_code as func,
       tsk.remainingdays,
       tsk.evalend,
       tsk.evalstart,
       tsk.evalstatus,
       tsk.UPDATETIME,
       tsk.WFID,
       tsk.WFSTATUS,
       0 as budgetamount,
       0 as execamount,
       a.amt5 as EXECRATE
  FROM V_PERF_PROJECT_INFO pro  --项目guid
  left join v_perf_t_selfevaltask tsk on pro.guid = tsk.PERFGOALGUID
  left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4, nvl(sum(amt5),0) amt5 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=tsk.projguid
  where pro.WFSTATUS=''011''';
  
execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFDEPTDESC AS
SELECT t."GUID",
       s.MAINGUID,
       t."YEARGOAL",
       t."ALLYEARGOAL",
       t."SELFADDINFO",
       t."DEVIATIONANALY",
       t."RECTIFICATION",
       t."PROJGUID",
       t."AGENCYGUID",
       t."WFSTATUS",
       t."STATUS",
       t."CREATETIME",
       t."UPDATETIME",
       t."CREATER",
       t."PROVINCE",
       t."YEAR",
       t."FININTORGGUID",
       t."WFID",
       t."VCOL1",
       t."VCOL2",
       t."VCOL3",
       t."VCOL4",
       t."VCOL5",
       t."VCOL6",
       t."VCOL7",
       t."VCOL8",
       t."VCOL9",
       t."VCOL10",
       case when nvl(s.score,0) + nvl(a.bgtscore,0) > 90 then
         ''优''
       when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then
         ''良''
       when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then
         ''中''
       when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then
         ''差''
       end as SELFRESULT,
       nvl(s.score,0) + nvl(a.bgtscore,0) score,
       case when nvl(s.score,0) = 0 then
         ''''
       when  (nvl(s.score,0)/90-bgtscore/10)/(nvl(s.score,0)/90)>0.05 then 
         ''red''
       when a.amt3 = 0 then
         ''yellow''
       when  (a.amt3-a.amt4)/a.amt3>0.2 then
         ''yellow''
         end warn
  FROM (select c.mainguid,c.projguid, sum(c.score) score
               from V_PERF_T_SELFPERFINDEX c
              group by c.mainguid,c.projguid) s
  left join V_PERF_T_SELFPERFDESC t
    on s.mainguid = t.mainguid
    left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=s.projguid
';