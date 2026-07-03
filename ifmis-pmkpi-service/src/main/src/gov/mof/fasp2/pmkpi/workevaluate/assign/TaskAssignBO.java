package gov.mof.fasp2.pmkpi.workevaluate.assign;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaskAssignBO extends PmkpiBO {

    private TaskAssignDAO taskAssignDAO;

    public void setTaskAssignDAO(TaskAssignDAO taskAssignDAO) {
        this.taskAssignDAO = taskAssignDAO;
    }

    /**
     * 查询数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("guid");
        String bustype = (String) params.get("bustype");
        String tabfilter = (String) params.get("tabfilter");
        StringBuffer wheresql = new StringBuffer();
        if(tablecode != null && !"V_PERF_T_WORKTASKASSIGN".equals(tablecode) && !"PERF_T_WORKTASKASSIGN".equals(tablecode)){//未下达
            if(bustype != null && "dept".equals(bustype)){
                wheresql.append(" not exists(select 1 from (select * from V_PERF_T_WORKTASKASSIGN m WHERE m.busTYPE= '");
                wheresql.append(bustype).append("' ) a where a.agencyguid = t.guid )");
            }else {
                wheresql.append(" not exists(select 1 from (select * from V_PERF_T_WORKTASKASSIGN m WHERE m.busTYPE= '");
                wheresql.append(bustype).append("' ) a where a.subprovince = t.guid )");
            }
            String menuid =  bustype + taskAssignDAO.PERF_WORKTASK_ASSIGN;
            String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
            if (bustype != null && "subprovince".equals(bustype)) {
                datarule = datarule.replace("t.agencyguid", "t.guid");
                datarule = datarule.replace("t.province", "t.guid");
            }
            wheresql.append(datarule);
        }else {//已下达
            String columncode = "";
            String table = "";
            wheresql.append(" t.taskguid = '").append(guid).append("'");
            if(bustype != null && "dept".equals(bustype)){
                columncode = "t.agencyguid";
                table = taskAssignDAO.PMKPI_TABLE_T_AGENCY;
            } else {
                columncode = "t.province";
                table = "V_ELE_VD08001";
            }
            wheresql.append(" and exists(select 1 from ").append(table).append(" a where a.guid=").append(columncode).append(")");
        }
        if(tabfilter != null && !tabfilter.isEmpty()){
            wheresql.append(" and ").append(tabfilter);
        }
        List<Map<String, Object>> list = taskAssignDAO.getDatas(tablecode, wheresql.toString(), " order by code");
        backMap.put("data", list);
        return backMap;
    }

    /**
     * 下达任务.
     * @param params --
     * @return --
     */
    public void assignTask(HashMap<String,Object> params) throws AppException {
        String guid = (String) params.get("guid");
        String bustype = (String) params.get("bustype");
        String tasktype = (String) params.get("tasktype");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map map : datas) {
            String assignguid = (String) map.get("guid");
            map.put("guid", CommonUtil.createGUID());
            map.put("taskguid", guid);
            map.put("bustype", bustype);
            map.put("tasktype", tasktype);
            map.put("status", 1);
            map.put("is_deleted", 2);
            if (bustype != null && "subprovince".equals(bustype)) {
                map.put("wfid", "1");
                map.put("wfstatus", "00");
            }
            map.put("creater", SecureUtil.getCurrentUserID());
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("update_time", PerfUtil.getServerTimeStamp());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", SecureUtil.getUserSelectYear());
            if("dept".equals(bustype)){
                map.put("agencyguid", assignguid);
            }else{
                map.put("subprovince", assignguid);
            }
        }
        taskAssignDAO.saveAll(datas, taskAssignDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = " exists(select 1 from "+taskAssignDAO.PMKPI_TABLE_TMP_AGENCY + " a where t.guid = a.guid)";
        taskAssignDAO.delDatas("V_PERF_T_WORKTASKASSIGN", wheresql);
        taskAssignDAO.saveAll(datas, "V_PERF_T_WORKTASKASSIGN");
    }

    /**
     * 取消下达任务.
     * @param params --
     * @return --
     */
    public void unassignTask(HashMap<String,Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        taskAssignDAO.saveAll(datas, taskAssignDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = " exists(select 1 from "+taskAssignDAO.PMKPI_TABLE_TMP_AGENCY + " a where t.guid = a.guid)";
        taskAssignDAO.delDatas("V_PERF_T_WORKTASKASSIGN", wheresql);
        wheresql = " exists(select 1 from "+taskAssignDAO.PMKPI_TABLE_TMP_AGENCY + " a where t.mainguid = a.guid)";
        taskAssignDAO.delDatas("v_perf_t_deptscore", wheresql);
    }
}
