package gov.mof.fasp2.pmkpi.prorevision.goal;


import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionGoalBO extends PmkpiBO {
    private ProrevisionGoalDAO revisionGoalDAO;

    public void setRevisionGoalDAO(ProrevisionGoalDAO revisionGoalDAO) {
        this.revisionGoalDAO = revisionGoalDAO;
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getAllGoal(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");//项目编码
        String mainguid = (String) params.get("mainguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String[] tempfilter = null;
        List<Map<String, Object>> goals = null;
        String wheresql = " mainguid='" + mainguid + "'";
        goals = revisionGoalDAO.getDataMaps(ProrevisionReportDAO.PERF_T_TABLE_REVISIONGOAL, wheresql);
        if ((goals == null || goals.size() == 0) && (mainguid != null && !"".equals(mainguid))) {
            tempfilter = new String[]{"0"};
            //不存在修订业务数据时，获取总体和年度绩效
            goals = revisionGoalDAO.getGoalsByFilter(proguid, procode, tempfilter);
            for (Map<String, Object> goalMap : goals) {
                goalMap.put("proguid", proguid);
                goalMap.put("mainguid", mainguid);
            }
        }
        if ("1".equals(showtab) || "2".equals(showtab)){
            tempfilter = new String[]{"1"};
            List<Map<String, Object>> totalgoals = revisionGoalDAO.getGoalsByFilter(proguid, procode, tempfilter);
            if (totalgoals.size() > 0) {
                yearsMap.put("#total", totalgoals.get(0));
            }
        }
        if (goals.size() > 0) {
            yearsMap.put("#year", goals.get(0));
        }
        return yearsMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String showtab = (String) params.get("showtab");
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode");
        String pro_name = (String) params.get("pro_name");
        String tablecode = ProrevisionReportDAO.PERF_T_TABLE_REVISIONGOAL;
        Map<String, Object> goaldata = (Map<String, Object>) params.get("goaldata"); //多页签的数据
        List<Map<String, Object>> goallist = new ArrayList<>(); //目标集合
        if ("1".equals(showtab) || "3".equals(showtab)) {
            Map<String, Object> yearmap = (Map<String, Object>) goaldata.get("#year");
            Map<String, Object> goalMap = revisionGoalDAO.getDataMap(tablecode, "mainguid=?", new String[]{mainguid});
            yearmap.put("pro_code", procode);
            yearmap.put("pro_name", pro_name);
            yearmap.put("agencyguid", saveAgency);
            yearmap.put("mainguid", mainguid);
            yearmap.put("proguid", proguid);
            yearmap.put("is_last_inst", 2);
            yearmap.put("yearflag", "0");
            if (goalMap.isEmpty()) {
                yearmap.put("guid", CommonUtil.createGUID());
                yearmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_XDRCDTWH);
                revisionGoalDAO.getBasMap(yearmap, "add");
                revisionGoalDAO.save(yearmap, tablecode);
            } else {
                yearmap.put("update_time", PerfUtil.getServerTimeStamp());
                yearmap.put("updatetime", PerfUtil.getServerTimeStamp());
                goalMap.putAll(yearmap);
                revisionGoalDAO.update(goalMap, tablecode);
            }
            goallist.add(yearmap);
        }
        return this.auditdefine(goallist, busguid,"perf", null);
    }

}
