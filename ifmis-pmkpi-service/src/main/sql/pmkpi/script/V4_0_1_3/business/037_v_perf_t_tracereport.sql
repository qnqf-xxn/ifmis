BEGIN
--修改视图-v_perf_t_tracereport
execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_TRACEREPORT AS
select
  (case when t.countpro = 1 then to_char(a.amt1) when t.countpro = 0 then to_char(b.amt1) else null end) as amt5, -- 预算安排数
  (case when t.countpro = 1 then to_char(a.amt4) when t.countpro = 0 then to_char(b.amt4) else null end) as amt8, -- 实际支出数
  (case when t.countpro = 1 then round(a.bgtget,2) when t.countpro = 0 then round(b.bgtget,2) else null end) as  bgtget, -- 完成进度(%)
  t.COUNTPRO,t.BUSGUID,t.PROGUID,t.PRO_NAME,t.PRO_START_YEAR,t.LEADER_NAME,t.LEADERNAME,t.LEADER_PHONE,t.AGENCY,t.GOALWARN,t.YEAR,t.JKJD,t.PROBLEMS,t.REMARK,t.MEASURES,t.DEVIATION,t.INSTITUTION,t.KPI_TARGET,t.TBTIME
from
  (SELECT
   (select count(1) from v_perf_project_info where pro_id = t.proguid) as countpro, --countpro=1  项目  ，countpro=0  部门
    t.guid AS busguid,
    t.proguid,
    t.pro_name,
    t.pro_code,
    t.agencyguid,
    f.PRO_START_YEAR,
    f.LEADER_NAME,
    f.LEADER_NAME AS LEADERNAME,
    f.LEADER_PHONE,
    a.name AS agency,
    CASE WHEN nvl( t.GOALWARN, 0 ) = ''0'' THEN '''' ELSE (CASE WHEN t.GOALWARN = ''red'' THEN ''红灯'' WHEN t.GOALWARN = ''yellow'' THEN ''黄灯'' WHEN t.GOALWARN = ''blue'' THEN ''蓝灯'' WHEN t.GOALWARN = ''green'' THEN ''绿灯'' END ) END AS GOALWARN,
    t.year,
    jd.name AS jkjd,
    jkfx.PROBLEMS,--项目进展情况
    jkfx.REMARK,--目标实际完成情况
    jkfx.MEASURES,--全年目标完成情况预计分析
    jkfx.DEVIATION,--绩效目标偏离原因分析
    jkfx.INSTITUTION,--整改措施及建议
    d.kpi_target,--年度绩效目标
    to_char( SYSDATE, ''YYYY-MM-DD'' ) AS tbtime
  FROM
    PERF_V_PROMONITOR t
    LEFT JOIN V_PERF_PROJECT_INFO f ON t.proguid = f.pro_id
    LEFT JOIN fasp_t_pubagency a ON t.agency_code = a.code
    LEFT JOIN ( SELECT t.* FROM perf_t_datasource t WHERE t.elementcode = ''taskstage'' ) jd ON t.TASKSTAGE = jd.code
    LEFT JOIN v_perf_t_protraceanalysis jkfx ON t.guid = jkfx.guid
    LEFT JOIN ( SELECT * FROM pm_perf_goal_info WHERE yearflag = ''0'' ) d ON t.proguid = d.mainguid
    LEFT JOIN PERF_V_PROMONITOR p ON d.mainguid = p.guid)  t
left join  v_perf_fund_project a on a.pro_code = t.pro_code
left join  v_perf_fund_dept b on b.agencyguid = t.agencyguid
';
