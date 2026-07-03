i number;
begin

--AI辅助审核任务
select count(*) into i from user_tables t where t.table_name ='PERF_T_AISUPPORTAUDITTASK';
if i=0 then
execute immediate '
create table PERF_T_AISUPPORTAUDITTASK
(
  guid        VARCHAR2(40) not null,
  province    VARCHAR2(9) not null,
  year        VARCHAR2(4) not null,
  tablecode   VARCHAR2(4000) not null, --需要同步的表
  wheresql    VARCHAR2(4000), --需要同步的表拼接的条件sql
  remark      VARCHAR2(400),
  status      VARCHAR2(40),	 --状态，默认为空，执行成功后为success
  config      VARCHAR2(4000),
  batchsize   NUMBER(9),  --每批处理的项目数量
  threadcount NUMBER(9),  --并行的线程数量
  timeoutmis  NUMBER(9),  --任务总超时等待时间-分钟
  url         VARCHAR2(400),
  singletimeoutms NUMBER(9)  --单次AI访问超时时间-毫秒
)';
end if;


--AI辅助审核结果
select count(*) into i from user_tables t where t.table_name ='PERF_T_AISUPPORTAUDIRESULT';
if i=0 then
execute immediate '
create table PERF_T_AISUPPORTAUDIRESULT
(
  guid            VARCHAR2(40) not null,
  province        VARCHAR2(40) not null,
  year            VARCHAR2(40) not null,
  pro_code        VARCHAR2(400),
  timestamps      VARCHAR2(400),
  prompt          CLOB,		--提示词
  thinkingprocess CLOB,		--思考过程
  resultdatas     CLOB,		--结果json
  status          VARCHAR2(40),	 --状态，AI执行成功后为success，失败为failure
  agency_code     VARCHAR2(40),
  agency_name     VARCHAR2(1000),
  pro_name        VARCHAR2(1000),
  auditpoint1     VARCHAR2(4000),
  auditpoint2     VARCHAR2(4000),
  auditpoint3     VARCHAR2(4000)
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_AISUPPORT_PARTITION';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AISUPPORT_PARTITION ON PERF_T_AISUPPORTAUDIRESULT(PRO_CODE, PROVINCE, YEAR)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AISUPPORT_TIMESTAMP';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AISUPPORT_TIMESTAMP ON PERF_T_AISUPPORTAUDIRESULT(TIMESTAMPS DESC)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AISUPPORT_STATUS';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AISUPPORT_STATUS ON PERF_T_AISUPPORTAUDIRESULT(STATUS)';
end if; 

--结果记录视图 默认取最新
execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_AISUPPORTAUDIRESULT AS
WITH ranked_data AS (
    SELECT 
        t.*,
        ROW_NUMBER() OVER (
            PARTITION BY pro_code, province, year 
            ORDER BY timestamps DESC
        ) AS rn
    FROM PERF_T_AISUPPORTAUDIRESULT t
    WHERE status = ''success''
		AND (auditpoint1 is not null OR auditpoint2 is not null OR auditpoint3 is not null)--三个维度审核项都为空的不展示
)
SELECT 
    pro_code, province, year, timestamps, 
    agency_code, agency_name, pro_name, auditpoint1, auditpoint2, auditpoint3
FROM ranked_data
WHERE rn = 1
AND province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
AND year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

--本年度指标聚合视图
execute immediate '
create or replace view v_pm_perf_indicatoragg as
select pro_code, xmlagg(xmlparse(content ''指标编码：''||t.code||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.indexval||'',计量单位：''||t.meterunit||'';'' wellformed) 
    order by 1).getclobval() as perfindex
FROM V_PM_PERF_INDICATOR t where yearflag = ''0''and is_deleted = ''2'' GROUP BY pro_code';

--上年度指标聚合视图
execute immediate '
create or replace view v_pm_perf_indicatoragglast as
select pro_code,province,year, xmlagg(xmlparse(content ''指标编码：''||t.code||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.actualvalue||'',计量单位：''||t.meterunit||'';'' wellformed) 
    order by 1).getclobval() as perfindex
FROM perf_t_selfperfindex t where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1)
and is_deleted = ''2'' GROUP BY pro_code,province,year';

