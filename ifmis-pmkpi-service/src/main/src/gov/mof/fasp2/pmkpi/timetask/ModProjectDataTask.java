package gov.mof.fasp2.pmkpi.timetask;

import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * 修改项目数据
 */
public class ModProjectDataTask {
    private static boolean istrue = false;
    private static Logger logger = LogFactory.getLog(ModProjectDataTask.class);
    /**
     * 项目修改基本信息同步修改绩效数据
     * @param args
     * @throws Throwable
     */
    public static void updateProjectDatas(String[] args) throws Throwable{
        try {
            if (!istrue) {
                PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
                logger.info("++++++++++++定时任务修改绩效数据相关项目信息开始");
                istrue = true;
                //通步处理项目名称
                List<String> tableList = new ArrayList<>();
                tableList.add("perf_t_promonitor");
                tableList.add("perf_t_selfevaltask");
                tableList.add("perf_t_finevaluation");
                tableList.add("perf_t_deptperfmiddeclare");
                tableList.add("perf_t_provisiondeclare");
                String wheresql = " (select t1.pro_code, t1.province, max(a.pro_name) as max_pro_name from #tablecode# t1 inner join pm_project_info a on a.pro_code = t1.pro_code and a.province = t1.province and a.lastaudit = 1 and a.is_backup = 2 where a.is_deleted = 2 and t1.pro_code is not null and a.pro_name != t1.name group by t1.pro_code, t1.province) s on (t.pro_code = s.pro_code and t.province = s.province)";
                String upsql = " t.name = s.max_pro_name";
                for (String tablecode : tableList) { //绩效表项目名称和项目库终审项目 项目名称进行同步
                    if ("perf_t_deptperfmiddeclare".equals(tablecode)) {
                        upsql = upsql.replace("t.name", "t.pro_name");
                        wheresql = wheresql.replace("t1.name", "t1.pro_name");
                    }
                    pmkpiDAO.batchUpdate(tablecode, upsql, wheresql);
                }

                //同步处理项目guid，否则总体绩效目标、指标查询不到数据
                tableList = new ArrayList<>();
                tableList.add("perf_t_deptperfmiddeclare");
                tableList.add("perf_t_provisiondeclare");
                upsql = " t.proguid = s.max_pro_id";
                wheresql = " (select t1.pro_code, t1.province, max(b.pro_id) as max_pro_id from #tablecode# t1 inner join pm_project_info b on b.pro_code = t1.pro_code and b.province = t1.province and b.lastaudit = 1 and b.is_backup = 2 where b.is_deleted = 2 and b.pro_id != t1.proguid and t1.pro_code is not null group by t1.pro_code, t1.province) s on (t.pro_code = s.pro_code and t.province = s.province)";
                for (String tablecode : tableList) { //绩效表项目guid和项目库调整项目guid同步
                    pmkpiDAO.batchUpdate(tablecode, upsql, wheresql);
                }
                //同步处理总体绩效数据mainguid和项目guid一直，编码不一致数据
                tableList = new ArrayList<>();
                tableList.add("pm_perf_goal_info");
                tableList.add("pm_perf_indicator");
                upsql = " t.pro_code = s.max_pro_code";
                wheresql = " (select t1.mainguid, t1.province, max(a.pro_code) as max_pro_code from #tablecode# t1 inner join pm_project_info a on a.pro_id = t1.mainguid and a.province = t1.province and a.is_backup = 2 and (a.ishistory = 2 or a.ishistory is null) where a.is_deleted = 2 and a.pro_code != t1.pro_code and t1.is_deleted = 2 and t1.year > '2025' and t1.yearflag = '1' group by t1.mainguid, t1.province) s on (t.mainguid = s.mainguid and t.province = s.province)";
                for (String tablecode : tableList) {
                    pmkpiDAO.batchUpdate(tablecode, upsql, wheresql);
                }
                //同步处理绩效数据pro_code和项目pro_code一致，单位编码不一致数据
                upsql = " t.agency_code = s.max_agency_code, t.agencyguid = s.max_agency_code, t.agency_name = s.max_agency_name";
                wheresql = " (select t1.pro_code, t1.province, max(a.agency_code) as max_agency_code, max(a.agency_name) as max_agency_name from #tablecode# t1 inner join pm_project_info a on a.pro_code = t1.pro_code and a.province = t1.province and a.is_backup = 2 and (a.ishistory = 2 or a.ishistory is null) where a.is_deleted = 2 and t1.is_deleted = 2 and t1.year > '2025' and a.agency_code != t1.agency_code group by t1.pro_code, t1.province) s on (t.pro_code = s.pro_code and t.province = s.province)";
                for (String tablecode : tableList) {
                    pmkpiDAO.batchUpdate(tablecode, upsql, wheresql);
                }
                logger.info("++++++++++++更新数据完成");
                //同步处理绩效保存数据成功，项目库没存，导致绩效产生的垃圾数据
                upsql = " t.is_deleted = 1";
                wheresql = " (select t1.guid from pm_perf_indicator t1 where t1.is_deleted = 2 and t1.year > '2025' and not exists (select 1 from pm_project_info a where a.is_deleted=2 and a.pro_code = t1.pro_code)) s on (t.guid = s.guid)";
                for (String tablecode : tableList) {
                    pmkpiDAO.batchUpdate(tablecode, upsql, wheresql);
                }
                logger.info("++++++++++++删除数据完成");
                istrue = false;
                logger.info("++++++++++++定时任务修改绩效数据相关项目信息结束");
            } else {
                logger.info("++++++++++++定时任务修改绩效数据相关项目信息上次执行未结束");
            }
        }catch (Throwable e) {
            istrue = false;
            throw e;
        }

    }

}

