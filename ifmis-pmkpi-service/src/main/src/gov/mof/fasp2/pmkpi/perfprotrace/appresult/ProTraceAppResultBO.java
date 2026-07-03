package gov.mof.fasp2.pmkpi.perfprotrace.appresult;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceAppResultBO extends PmkpiBO {

    private ProTraceAppResultDAO proTraceAppResultDAO;

    public void setProTraceAppResultDAO(ProTraceAppResultDAO proTraceAppResultDAO) {
        this.proTraceAppResultDAO = proTraceAppResultDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String tasktype = (String) sqlmap.get("tasktype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String deptwfststus = (String) sqlmap.get("deptwfststus");
        String jxwfststus = (String) sqlmap.get("jxwfststus");
        String columncodes = proTraceAppResultDAO.getColumncodes(tablecode, "t");
//        columncodes += ",nvl(a.isrectify,0) as isrectify,nvl(a.rectifyend,0) as rectifyend";
        if (!StringUtil.isEmpty(columncodes)) {
            columncodes += ",case when depttask='1' and provincetask='2' and wfstatus='" + deptwfststus + "' then '011'";
            if (PerfUtil.getIsGuangXi()) {
                columncodes += " when provincetask='1' and nvl(audittype,0) <> '2' and wfstatus='" + jxwfststus + "' then '011'";
            }
            columncodes += " else wfstatus end wfstatus";
        } else {
            columncodes = "t.*";
        }
        StringBuffer returnsql = new StringBuffer("select ");
        returnsql.append(columncodes).append(" from ");
        returnsql.append(tablecode).append(" t ");
//        returnsql.append(" left join perf_v_rectify a on t.taskguid = a.taskguid");
//        if ("depttrace".equals(tasktype)) {
//            returnsql.append(" and a.proguid = t.proguid");
//        } else {
//            returnsql.append(" and a.procode = t.pro_code");
//        }
        returnsql.append(" where t.tasktype='").append(tasktype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            wheresql = wheresql.toLowerCase().replaceAll("pro_code", "t.pro_code");
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceAppResultDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        String tasktype = (String) params.get("tasktype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        return proTraceAppResultDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 导入评审意见
     *
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importAppResultData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            logger.info("---impDatas：" + impDatas.toString());
            String bustype = (String) busParams.get("bustype");
            ProTraceAppResultBO proTraceAppResultBO = (ProTraceAppResultBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.appresult.ProTraceAppResultBOTX");
            proTraceAppResultBO.importAnalysisData(impDatas, bustype);
        }
    }

    public void importAnalysisData(ArrayList impDatas, String bustype) throws AppException {
        ProTraceAppResultDAO proTraceAppResultDAO = (ProTraceAppResultDAO) PerfServiceFactory.getBean("pmkpi.perfprotrace.appresult.ProTraceAppResultDAO");
        List<Map<String, Object>> addList = new ArrayList<>();
        List<Map<String, Object>> modList = new ArrayList<>();
        Map<String, Object> proMap = null;
        for (Object obj : impDatas) {
            Map<String, Object> analysisMap = new HashMap<>();
            /**
             * 项目编码、监控阶段、自行监控、重点监控四个条件唯一确定一笔监控数据。
             * 部门整体导入根据单位编码、监控阶段唯一确定一笔监控数据
             */
            Map<String, Object> map = (Map<String, Object>) obj;
            String proCode = (String) map.get("pro_code"); // 项目编码
            String taskstage = (String) map.get("taskstage"); // 监控阶段
            String depttask = (String) map.get("depttask"); // 自行监控-1是2否
            String provincetask = (String) map.get("provincetask"); // 重点监控-1是2否
            String treatmentMeasure = (String) map.get("treatment_measure"); // 处理措施
            String appresultDetails = (String) map.get("appresult_details"); // 结果运用情况
            String agencyguid = (String) map.get("agencyguid"); // 单位编码
            String promonitorSql = "";
            if ("protrace".equals(bustype)) { // 项目支出
                promonitorSql = "select * from perf_v_promonitor_appresult where tasktype = 'protrace' and pro_code = '"
                        + proCode + "' and taskstage = '" + taskstage + "' and depttask = '" + depttask + "' and provincetask = '" + provincetask + "'";
            } else { // 部门整体 "depttrace".equals(bustype)
                promonitorSql = "select * from perf_v_promonitor_appresult where tasktype = 'depttrace' and agencyguid = '"
                        + agencyguid + "' and taskstage = '" + taskstage + "' and depttask = '" + depttask + "' and provincetask = '" + provincetask + "'";
            }
            List<Map<String, Object>> promonitorList = proTraceAppResultDAO.queryForList(promonitorSql);
            String mainguid = (String) promonitorList.get(0).get("guid");
            String analysisSql = "select * from v_perf_t_protraceanalysis where mainguid = '" + mainguid + "'";
            List<Map<String, Object>> analysisList = proTraceAppResultDAO.queryForList(analysisSql);
            if (!analysisList.isEmpty() && analysisList.size() > 0) {
                analysisMap = analysisList.get(0);
                analysisMap.put("treatment_measure", treatmentMeasure);
                analysisMap.put("appresult_details", appresultDetails);
                modList.add(analysisMap);
            } else {
                analysisMap.put("guid", this.getCreateguid());
                analysisMap.put("fiscal_year", SecureUtil.getUserSelectYear());
                analysisMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                analysisMap.put("year", CommonUtil.getYear());
                analysisMap.put("province", SecureUtil.getCurrentUser().getProvince());

                analysisMap.put("treatment_measure", treatmentMeasure);
                analysisMap.put("appresult_details", appresultDetails);
                analysisMap.put("mainguid", mainguid);
                analysisMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                analysisMap.put("create_time", PerfUtil.getServerTimeStamp());
                analysisMap.put("update_time", PerfUtil.getServerTimeStamp());
                analysisMap.put("is_deleted", "2");
                analysisMap.put("agencyguid", agencyguid);
                analysisMap.put("agency_code", agencyguid);
                addList.add(analysisMap);
            }
        }
        if (modList.size() > 0) {
            logger.info("---modList：" + modList.toString());
            proTraceAppResultDAO.updateAllByPK(modList, "guid", "v_perf_t_protraceanalysis");
        }
        if (addList.size() > 0) {
            logger.info("---addList：" + addList.toString());
            proTraceAppResultDAO.saveAll(addList, "v_perf_t_protraceanalysis");
        }
    }

}
