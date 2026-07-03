package gov.mof.fasp2.pmkpi.workevaluate.task;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateTaskBO extends PmkpiBO {

    private WorkEvaluateTaskDAO workEvaluateTaskDAO;

    public void setWorkEvaluateTaskDAO(WorkEvaluateTaskDAO workEvaluateTaskDAO) {
        this.workEvaluateTaskDAO = workEvaluateTaskDAO;
    }

    public String getVodSql (Map sqlmap){
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tablecode = (String)sqlmap.get("tablecode");
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" where ").append(wheresql);
        }
        returnsql.append(" order by update_time");
        return  returnsql.toString();
    }

    /**
     * 查询编辑区数据
     * @param params 参数
     * @return
     */
    public Map<String, Object> queryeditdata(HashMap<String, Object> params) {
        Map<String, Object> returnmap = new HashMap<>();
        String guid = (String) params.get("guid");
        String tablecode = (String) params.get("tablecode");
        String taskyear = (String) params.get("taskyear");
        String taskprovince = (String) params.get("taskprovince");
        String wheresql = " t.guid = '"+guid+"'";
        if (!StringUtil.isEmpty(taskyear)){
            wheresql += " and year = '"+taskyear+"'";
        }
        if (!StringUtil.isEmpty(taskprovince)){
            wheresql += " and province = '"+taskprovince+"'";
        }
        List<Map<String, Object>> list = workEvaluateTaskDAO.getDatas(tablecode, wheresql, null);
        returnmap.put("data", list);
        return returnmap;
    }

    /**
     * 保存任务
     * @param params
     * @return
     */
    public void saveTask (HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String guid = (String) datas.get("guid");
        String bustype = (String) params.get("bustype");
        String viewtype = (String) params.get("viewtype");
        if(viewtype != null && "add".equals(viewtype)){
            //datas.put("guid", CommonUtil.createGUID());
            datas.put("bustype", bustype);
            datas.put("fiscal_year", SecureUtil.getUserSelectYear());
            datas.put("mof_div_code", SecureUtil.getUserSelectProvince());
            datas.put("province", SecureUtil.getUserSelectProvince());
            datas.put("year", SecureUtil.getUserSelectYear());
            datas.put("status", 1);
            datas.put("is_deleted", 2);
            datas.put("creater", SecureUtil.getCurrentUserID());
            datas.put("create_time", PerfUtil.getServerTimeStamp());
            datas.put("update_time", PerfUtil.getServerTimeStamp());
            datas.put("agencyguid", SecureUtil.getCurrentUser().getUpagencyid());
            datas.put("agency_code", SecureUtil.getCurrentUser().getUpagencyid());
        }else {
            datas.put("fiscal_year", SecureUtil.getUserSelectYear());
            datas.put("mof_div_code", SecureUtil.getUserSelectProvince());
            datas.put("province", SecureUtil.getUserSelectProvince());
            datas.put("year", SecureUtil.getUserSelectYear());
            datas.put("status", 1);
            datas.put("is_deleted", 2);
            datas.put("bustype", bustype);
            datas.put("update_time", PerfUtil.getServerTimeStamp());
        }
        String wheresql = "  t.guid = '" + guid + "'";
        workEvaluateTaskDAO.delDatas(tablecode, wheresql);
        workEvaluateTaskDAO.save(datas, tablecode);
    }

    /**
     * 删除任务
     * @param params
     * @return
     */
    public Map<String, Object> delTask (HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        workEvaluateTaskDAO.saveAll(datas, workEvaluateTaskDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = " exists(select 1 from "+workEvaluateTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid = t.taskguid)";
        List<Map<String, Object>> taskList = workEvaluateTaskDAO.getDatas("V_PERF_T_WORKTASKASSIGN", wheresql, null);
        if(taskList.size()>0){
            backMap.put("success", false);
            throw new PerfAppException("提示", "删除的任务存在下达的数据！！！", backMap);
        }else {
            wheresql = " exists(select 1 from "+workEvaluateTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid = t.guid)";
            workEvaluateTaskDAO.delDatas(tablecode, wheresql);
            backMap.put("success", true);
        }
        return backMap;
    }
}
