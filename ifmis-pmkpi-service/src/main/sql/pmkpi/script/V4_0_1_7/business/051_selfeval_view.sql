 begin
--1.查询、填报、审核列表
--1-1.项目支出
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
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE, --预算执行率
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0
         then TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else 0
       end as REMAININGDAYS,
       nvl(s.score,0) SCORE,
       case
         when nvl(s.score,0) > 90 then ''优''
         when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90) then ''良''
         when (nvl(s.score, 0) >= 60 and nvl(s.score, 0) < 80) then ''中''
         when nvl(s.score, 0) < 60 then ''差''
       end as SELFRESULT,
       s.WARN,
       t.PRO_CODE
  from V_PERF_T_SELFEVALTASK t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join (select pro_code,nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by pro_code) a on a.pro_code = t.pro_code
  where t.BUSTYPE = 1
';

--1-2.项目支出-河北
execute immediate 'create or replace view v_perf_v_selfevaltask_hb as
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
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE, --预算执行率
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0
         then TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else 0
       end as REMAININGDAYS,
       nvl(s.score,0) SCORE,
       case
         when nvl(s.score,0) > 90 then ''优''
         when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90) then ''良''
         when (nvl(s.score, 0) >= 60 and nvl(s.score, 0) < 80) then ''中''
         when nvl(s.score, 0) < 60 then ''差''
       end as SELFRESULT,
       s.WARN,
       pro.PRO_CODE
  from V_PERF_T_SELFEVALTASK t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join v_perf_project_info pro on pro.guid = t.PROJGUID
    left join (select pro_code,nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by pro_code) a on a.pro_code = t.pro_code
  where t.BUSTYPE = 1
';
--1-3.部门整体
execute immediate '
    create or replace view v_perf_dept_selfevaltask as
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
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE, --预算执行率
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0
         then TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else 0
       end as REMAININGDAYS,
       nvl(s.score,0) SCORE,
       case
         when nvl(s.score,0) > 90 then ''优''
         when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90) then ''良''
         when (nvl(s.score, 0)>= 60 and nvl(s.score, 0) < 80) then ''中''
         when nvl(s.score, 0) < 60 then ''差''
       end as SELFRESULT,
       s.WARN,
       t.PRO_CODE
  from V_PERF_T_SELFEVALTASK t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
  left join v_perf_project_info pro on pro.guid = t.PROJGUID
  left join (select agencyguid, nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by agencyguid) a on a.agencyguid=t.AGENCYGUID
  where t.BUSTYPE = 3
';

--1-4.部门整体-河北
execute immediate 'create or replace view v_perf_dept_selfevaltask_hb as
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
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE, --预算执行率
       case
         when TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > 0
         then TO_NUMBER(TO_DATE(evalend, ''yyyymmdd'') - TO_DATE(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd''))
         else 0
       end as REMAININGDAYS,
       nvl(s.score,0) SCORE,
       case
         when nvl(s.score,0) > 90 then ''优''
         when (nvl(s.score, 0) >= 80 and nvl(s.score, 0) < 90) then ''良''
         when (nvl(s.score, 0)>= 60 and nvl(s.score, 0) < 80) then ''中''
         when nvl(s.score, 0) < 60 then ''差''
       end as SELFRESULT,
       s.WARN,
       pro.PRO_CODE,
       pub.code as agency_code
  from V_PERF_T_SELFEVALTASK t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join v_perf_project_info pro on pro.guid = t.PROJGUID
    left join PMKPI_FASP_T_PUBAGENCY pub on pub.guid = t.AGENCYGUID
    left join (select agencyguid, nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by agencyguid) a on a.agencyguid = pub.guid
  where t.BUSTYPE = 3
';

--2.工作布置列表
--2-1.项目支出
execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFEVALPROGRAMS AS
SELECT nvl(tsk.GUID,sys_guid()) as guid,
       pro.guid as projguid,
       pro.pro_code,
       pro.pro_name as name,
       pro.agencyguid,
       pro.mof_dep_code as finintorgguid,
       pro.YEAR,
       pro.PROVINCE,
       pro.projectkind as prokind,
       1 as bustype,
       pro.pro_cat_code as procategory,
       pro.exp_func_code as func,
       pro.WFSTATUS as WFSTATUS,
       tsk.remainingdays,
       tsk.evalend,
       tsk.evalstart,
       tsk.evalstatus,
       tsk.UPDATETIME,
       tsk.WFID,
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE --预算执行率
  FROM V_PERF_PROJECT_INFO pro  --项目guid
    left join v_perf_t_selfevaltask tsk on pro.pro_code = tsk.pro_code
    left join (select pro_code, nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4, to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by pro_code) a on a.pro_code = tsk.pro_code
';

--2-2.部门整体
execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFEVALDEPT AS
SELECT nvl(b.GUID,sys_guid()) as guid,
       b.PERFGOALGUID,
       t.guid as projguid,
       t.CODE as CODE,
       t.CODE as PRO_CODE,
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
       t.WFID,
       t.WFSTATUS,
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE, --预算执行率
       pub.code as agency_code
  FROM V_PERF_T_DEPTPERFDECLARE t
    LEFT JOIN V_PERF_T_SELFEVALTASK b on b.PERFGOALGUID = t.guid
    left join PMKPI_FASP_T_PUBAGENCY pub on t.agencyguid = pub.guid
    left join (select agencyguid, nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by agencyguid) a on a.agencyguid = pub.guid
  where t.wfstatus =''011''
';