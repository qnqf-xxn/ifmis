package gov.mof.fasp2.pmkpi.deptracetask.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptracetask.dao.DeptraceTaskQueryDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptraceTaskQueryBO extends PmkpiBO {

    private DeptraceTaskQueryDAO deptraceTaskQueryDAO;

    public void setDeptraceTaskQueryDAO(DeptraceTaskQueryDAO deptraceTaskQueryDAO) {
        this.deptraceTaskQueryDAO = deptraceTaskQueryDAO;
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        String sysvalue = deptraceTaskQueryDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String pagetype = (String) params.get("pagetype");
        StringBuffer s = new StringBuffer();
        String wheresql = "";
        List<Map<String, Object>> data = null;
        if (pagetype != null && (pagetype.equals("report") || pagetype.equals("audit"))){
            s = this.getReportQuerySql(params);
            data = deptraceTaskQueryDAO.getDatas(s.toString(), wheresql, null);
        } else {
            String mainguid = (String)params.get("mainguid");
            String tablecode = (String)params.get("tablecode");
            String tablesql = (String)params.get("tablesql");
            String orderby = (String)params.get("orderby");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (!StringUtils.isEmpty(tablesql)) {
                wheresql += tablesql;
            }
            data = deptraceTaskQueryDAO.getDatas(tablecode, wheresql, orderby);
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 申报/审核页面查询
     * @param sqlmap --
     * @return --
     * @throws AppException
     */
    public StringBuffer getReportQuerySql(Map sqlmap) throws AppException {
//        List queryConfig = (List) sqlmap.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String orderby = (String) sqlmap.get("orderby");
        //String workflow = (String) sqlmap.get("workflow");
        //String tabcode = (String) sqlmap.get("tabcode");
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule);
            deptraceTaskQueryDAO.saveAll(eledatas, deptraceTaskQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
        	String sysvalue = deptraceTaskQueryDAO.getSystemDepttree();
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
            deptraceTaskQueryDAO.saveAll(treeData, deptraceTaskQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("(select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        if (!StringUtils.isEmpty(wheresql)){
            sql.append(" and ").append(wheresql);
        }
        if (!StringUtils.isEmpty(tablesql)){
            sql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("')");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptraceTaskQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        if (!StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        return sql;
    }
}
