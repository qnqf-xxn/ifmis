package gov.mof.fasp2.pmkpi.setting.taskset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaskSetBO extends PmkpiBO {
    private TaskSetDAO taskSetDAO;

    public void setTaskSetDAO(TaskSetDAO taskSetDAO) {
        this.taskSetDAO = taskSetDAO;
    }

    /**
     * @Description: 指标树.
     * @return Map<String, Object>
     * @throws AppException 异常信息
     */
    @SuppressWarnings("rawtypes")
    public Map<String, Object> getLeftTree() throws AppException {
        List<Map<String, Object>> eledatas = PerfUtil.getSourceData("PMKPIPERFTASK", null);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "绩效任务");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", eledatas);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        String pagetype = (String) params.get("pagetype");
        Map<String, Object> data = (Map<String, Object>) params.get("data");
        this.getBasMap(data, "add");
        if (pagetype != null && "add".equals(pagetype)) {
            data.put("guid",this.getCreateguid());
            data.put("status", 1);
            taskSetDAO.save(data, taskSetDAO.PMKPI_TABLE_T_TAKSSET);
        } else {
            taskSetDAO.update(data, taskSetDAO.PMKPI_TABLE_T_TAKSSET);
        }
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        String treeid = (String) params.get("treeid");
        String bustype = (String) params.get("bustype");
        String querySql = (String) params.get("querySql");
        String isleaf = params.get("isleaf") + "";
        String wheresql = "";
        if (bustype != null &&  treeid != null) {
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql = " tasktype='" + treeid + "'";
            } else {
                wheresql = " bustype='" + treeid + "'";
            }
        } else {
            wheresql = " 1=1 ";
        }
        if (querySql != null && !querySql.isEmpty()) {
            wheresql += " and " + querySql;
        }
        return taskSetDAO.getDatas(taskSetDAO.PMKPI_TABLE_T_TAKSSET, wheresql, " order by update_time");
    }

    /**
     * 编辑查询
     * @param params
     * @return
     */
    public Map<String, Object> getDataByGuid(Map params) {
        String guid = (String) params.get("guid");
        String wheresql = " guid='" + guid + "'";
        return taskSetDAO.getDatas(taskSetDAO.PMKPI_TABLE_T_TAKSSET, wheresql, " order by update_time").get(0);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        try {
            taskSetDAO.saveAll(deldatas, taskSetDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + taskSetDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            taskSetDAO.delDatas(taskSetDAO.PMKPI_TABLE_T_TAKSSET, delsql);
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 校验任务是否可删除
     * @param parms --
     * @return
     */
    public int checkdel(HashMap<String, Object> parms) {
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        try {
            taskSetDAO.saveAll(deldatas, taskSetDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + taskSetDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.taskguid)";
            return taskSetDAO.getDataCount("v_perf_t_promonitor", delsql);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return 0;
    }
}
