begin

--2.重构视图
execute immediate '
CREATE OR REPLACE VIEW bgt_330000.v_perf_t_tracereport
 AS
 SELECT name((a.*)::text) AS name,
    a.amt1,
    a.amt2,
    a.amt3,
    a.amt4,
    round(a.bgtget, 2) AS bgtget,
    t.busguid,
    t.pro_code,
    t.proguid,
    t.pro_name,
    t.pro_start_year,
    t.leader_name,
    t.leadername,
    t.leader_phone,
    t.agency,
    t.goalwarn,
    t.year,
    t.jkjd,
    t.problems,
    t.remark,
    t.measures,
    t.deviation,
    t.suggestions as institution,
    t.kpi_target,
    t.tbtime
   FROM (( SELECT t_1.guid AS busguid,
            t_1.proguid,
            f.pro_name,
            t_1.pro_code,
            t_1.agencyguid,
            f.pro_start_year,
            f.leader_name,
            f.leader_name AS leadername,
            f.leader_phone,
            a_1.name AS agency,
                CASE
                    WHEN ((t_1.goalwarn)::text = ''red''::text) THEN ''红灯''::text
                    WHEN ((t_1.goalwarn)::text = ''yellow''::text) THEN ''黄灯''::text
                    WHEN ((t_1.goalwarn)::text = ''blue''::text) THEN ''蓝灯''::text
                    WHEN ((t_1.goalwarn)::text = ''green''::text) THEN ''绿灯''::text
                    ELSE NULL::text
                END AS goalwarn,
            t_1.year,
            jd.name AS jkjd,
            jkfx.problems,
            jkfx.remark,
            jkfx.measures,
            jkfx.deviation,
            jkfx.suggestions,
            d.kpi_target,
            to_char(sysdate, ''YYYY-MM-DD''::character varying) AS tbtime
           FROM ((((((bgt_330000.perf_v_promonitor t_1
             LEFT JOIN bgt_330000.v_perf_project_info f ON (((t_1.proguid)::text = (f.pro_id)::text)))
             LEFT JOIN bgt_330000.fasp_t_pubagency a_1 ON (((t_1.agency_code)::text = (a_1.code)::text)))
             LEFT JOIN ( SELECT t_2.guid,
                    t_2.code,
                    t_2.name,
                    t_2.remark,
                    t_2.superguid,
                    t_2.levelno,
                    t_2.isleaf,
                    t_2.ordernum,
                    t_2.elementcode,
                    t_2.status,
                    t_2.createtime,
                    t_2.updatetime,
                    t_2.year,
                    t_2.province
                   FROM bgt_330000.perf_t_datasource t_2
                  WHERE ((t_2.elementcode)::text = ''taskstage''::text)) jd ON (((t_1.taskstage)::text = (jd.code)::text)))
             LEFT JOIN bgt_330000.v_perf_t_protraceanalysis jkfx ON (((t_1.guid)::text = (jkfx.mainguid)::text)))
             LEFT JOIN ( SELECT pm_perf_goal_info.guid,
                    pm_perf_goal_info.agencyguid,
                    pm_perf_goal_info.zqgoal,
                    pm_perf_goal_info.ndgoal,
                    pm_perf_goal_info.mainguid,
                    pm_perf_goal_info.createtime,
                    pm_perf_goal_info.updatetime,
                    pm_perf_goal_info.creater,
                    pm_perf_goal_info.province,
                    pm_perf_goal_info.year,
                    pm_perf_goal_info.kpi_per_id,
                    pm_perf_goal_info.mof_div_code,
                    pm_perf_goal_info.fiscal_year,
                    pm_perf_goal_info.pro_code,
                    pm_perf_goal_info.kpi_target,
                    pm_perf_goal_info.version,
                    pm_perf_goal_info.version_name,
                    pm_perf_goal_info.sub_mof_code,
                    pm_perf_goal_info.update_time,
                    pm_perf_goal_info.is_deleted,
                    pm_perf_goal_info.create_time,
                    pm_perf_goal_info.agency_code,
                    pm_perf_goal_info.proguid,
                    pm_perf_goal_info.fromguid,
                    pm_perf_goal_info.yearflag,
                    pm_perf_goal_info.busi_type_code,
                    pm_perf_goal_info.fromisdel
                   FROM bgt_330000.pm_perf_goal_info
                  WHERE ((pm_perf_goal_info.yearflag)::text = ''0''::text)) d ON (((t_1.proguid)::text = (d.mainguid)::text)))
             LEFT JOIN bgt_330000.perf_v_promonitor p ON (((d.mainguid)::text = (p.guid)::text)))) t
     LEFT JOIN ( SELECT v_perf_t_probgtfund.mainguid,
            sum(nvl(v_perf_t_probgtfund.amt1, (0)::numeric)) AS amt1,
            sum(nvl(v_perf_t_probgtfund.amt2, (0)::numeric)) AS amt2,
            sum(nvl(v_perf_t_probgtfund.amt3, (0)::numeric)) AS amt3,
            sum(nvl(v_perf_t_probgtfund.amt4, (0)::numeric)) AS amt4,
            sum((nvl(v_perf_t_probgtfund.bgtget, (0)::numeric))::numeric) AS bgtget
           FROM bgt_330000.v_perf_t_probgtfund
          GROUP BY v_perf_t_probgtfund.mainguid) a ON (((a.mainguid)::text = (t.busguid)::text)))';

