package gov.mof.fasp2.pmkpi.workevaluate.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateQueryBO extends PmkpiBO {
    private WorkEvaluateQueryDAO workEvaluateQueryDAO;

    public void setWorkEvaluateQueryDAO(WorkEvaluateQueryDAO workEvaluateQueryDAO) {
        this.workEvaluateQueryDAO = workEvaluateQueryDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getDatas(HashMap<String, Object> params) throws AppException {
        String bustype = (String) params.get("bustype");
        String querySql = (String) params.get("querySql");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype = '" + bustype + "' ";
        String isleaf = (String)params.get("isleaf"); //节点是否为末级
        String saveAgency = (String)params.get("saveAgency"); //节点id.
        String columncode = "";
        String tablecode = "";
        if (bustype != null && "dept".equals(bustype)) {
            tablecode = workEvaluateQueryDAO.PMKPI_TABLE_T_AGENCY;
            columncode = "agencyguid";
            String wheresql = this.getLeftTreeWheresql(isleaf, columncode, saveAgency, tablecode);
            if (!"".equals(wheresql) || !StringUtil.isEmpty(wheresql)) {
                datarule += wheresql;
            }
        }
        //存入临时表
        params.put("datarule", datarule);
        params.put("querySql", querySql);
        this.setMap(params);
        return workEvaluateQueryDAO.getDatas(bustype);
    }

    /**
     * 参数与工作流数据guid存储到临时表
     * @throws AppException AppException
     */
    private void setMap(HashMap<String, Object> params) throws AppException {
        Map<String, Object> map = null;
        List<Map<String, Object>> list = new ArrayList<>();
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            map = new HashMap<>();
            String entrykey  = entry.getKey();
            Object entryvalue = entry.getValue();
            if (entrykey != null && entryvalue != null && (entryvalue instanceof String || entryvalue instanceof Integer || entryvalue instanceof Number)) {
                map.put("key", entrykey);
                map.put("value", entryvalue);
                list.add(map);
            }
        }
        workEvaluateQueryDAO.saveAll(list, "PERF_TMP_AUDITDEFINEWHERESQL");
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        HashMap<String, Object> params = (HashMap<String, Object>) sqlmap;
        this.getDatas(params);
        StringBuffer returnsql = new StringBuffer();
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype = '" + bustype + "' ";
        if (bustype != null && "dept".equals(bustype)) {
            return workEvaluateQueryDAO.getLeftTree(workEvaluateQueryDAO.PERF_TABLE_WORKEVALUATE, datarule);
        } else {
            return workEvaluateQueryDAO.getLeftTreeProvince(workEvaluateQueryDAO.PERF_TABLE_WORKEVALUATE, datarule, "province");
        }
    }

    /**
     * 查询任务guid
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTaskguid(HashMap<String, Object> params) throws AppException {
        String tasktype = (String) params.get("tasktype");
        String guid = (String) params.get("guid");
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        String wheresql = " guid = '"+guid+"' and tasktype = '"+ tasktype+"' and province = '"+province+"' and year = '"+year+"'";
        String querysql ="select taskguid from perf_t_worktaskassign t where " + wheresql;
        //workEvaluateQueryDAO.getDatas(tablecode, wheresql, "");
        return workEvaluateQueryDAO.queryForList(querysql);
    }
}
