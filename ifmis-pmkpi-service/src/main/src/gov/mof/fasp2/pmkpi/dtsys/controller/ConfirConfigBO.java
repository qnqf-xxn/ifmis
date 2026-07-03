package gov.mof.fasp2.pmkpi.dtsys.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConfirConfigBO extends PmkpiBO {

    private ConfirConfigDAO confirConfigDAO;

    public void setConfirConfigDAO(ConfirConfigDAO confirConfigDAO) {
        this.confirConfigDAO = confirConfigDAO;
    }

    public Map<String, Object> getProgramTable(){
        Map<String,Object> tableMap = new HashMap<>();
        tableMap.put("PM_PERF_GOAL_INFO", "PERF_DTSYS_PM_GOALINFO");
        tableMap.put("PM_PERF_INDICATOR", "PERF_DTSYS_PM_INDICATOR");
        return tableMap;
    }

    public Map<String, Object> getBgtTable(){
        Map<String,Object> tableMap = new HashMap<>();
        tableMap.put("PM_PERF_GOAL_INFO", "PERF_DTSYS_PM_GOALINFO");
        tableMap.put("PM_PERF_INDICATOR", "PERF_DTSYS_PM_INDICATOR");
        tableMap.put("BGT_PERF_GOAL_INFO", "PERF_DTSYS_BGT_GOALINFO");
        tableMap.put("BGT_PERF_INDICATOR", "PERF_DTSYS_BGT_INDICATOR");
        return tableMap;
    }

    /**
     * 处理获取数据
     * @param dataMap
     * @return
     * @throws AppException
     */
    public Map<String, Object> setDatas(Map<String, Object> dataMap, Map<String, Object> tableMap) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String[] tablecodes = new String[] {"PM_PERF_GOAL_INFO","PM_PERF_INDICATOR",
                "BGT_PERF_GOAL_INFO","BGT_PERF_INDICATOR"};
        String saveTable = "";
        for (String tablecode : tablecodes){
            //根据表明判断是否需要处理
            if (dataMap.containsKey(tablecodes)) {
                String data = (String) dataMap.get(tablecode);
                List datas = PerfUtil.parseString2List(data);
                saveTable = (String) tableMap.get(tablecode);
                if (!StringUtil.isEmpty(saveTable)) {
                    confirConfigDAO.saveAll(datas, saveTable);
                }
            }
        }
        return backMap;
    }

    /**
     * 查询预算编制一上数据
     * @param province
     * @param year
     * @param agencyguid
     * @return
     * @throws AppException
     */
    public Map<String, Object> getBgt1Datas(String province, String year, String agencyguid) {
        Map<String, Object> data = new HashMap<>();
        String tablecode = confirConfigDAO.PMKPI_TABLE_PM_GOAL;
        //项目目标表数据
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_PROJECT_INFO, tablecode, province, year, agencyguid));
        tablecode = confirConfigDAO.PMKPI_TABLE_PM_INDICATOR;
        //项目指标表数据
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_PROJECT_INFO, tablecode, province, year, agencyguid));
        //评审编辑区表
        tablecode = confirConfigDAO.PMKPI_TABLE_AUDITMAIN;
        data.put(tablecode, confirConfigDAO.getAuditOpinion(confirConfigDAO.PMKPI_TABLE_REVIEW, tablecode, province, year, agencyguid));
        //评审主单表
        tablecode = confirConfigDAO.PMKPI_TABLE_AUDITITEMS;
        data.put(tablecode, confirConfigDAO.getAuditOpinion(confirConfigDAO.PMKPI_TABLE_REVIEW, tablecode, province, year, agencyguid));
        return data;
    }

    /**
     * 查询预算编制二上数据
     * @param province
     * @param year
     * @param agencyguid
     * @return
     * @throws AppException
     */
    public Map<String, Object> getBgt2Datas(String province, String year, String agencyguid) {
        Map<String, Object> data = new HashMap<>();
        String tablecode = confirConfigDAO.PMKPI_TABLE_PM_GOAL;
        //项目目标表数据
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_PROJECT_INFO, tablecode, province, year, agencyguid));
        tablecode = confirConfigDAO.PMKPI_TABLE_PM_INDICATOR;
        //项目指标表数据
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_PROJECT_INFO, tablecode, province, year, agencyguid));
        //部门整体目标表数据
        tablecode = confirConfigDAO.PMKPI_TABLE_BGT_GOAL;
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_DEPTPERFDECLARE, tablecode, province, year, agencyguid));
        //部门整体指标表数据
        tablecode = confirConfigDAO.PMKPI_TABLE_BGT_INDICATOR;
        data.put(tablecode, confirConfigDAO.getGoalOrIndexData(confirConfigDAO.PMKPI_TABLE_DEPTPERFDECLARE, tablecode, province, year, agencyguid));
        return data;
    }
}
