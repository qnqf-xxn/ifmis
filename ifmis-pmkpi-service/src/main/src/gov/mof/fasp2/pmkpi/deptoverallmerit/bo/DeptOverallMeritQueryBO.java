package gov.mof.fasp2.pmkpi.deptoverallmerit.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptoverallmerit.dao.DeptOverallMeritReportDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptOverallMeritQueryBO extends PmkpiBO {
	private DeptOverallMeritReportDAO deptOverallMeritReportDAO;

    public void setDeptOverallMeritReportDAO(DeptOverallMeritReportDAO deptOverallMeritReportDAO) {
        this.deptOverallMeritReportDAO = deptOverallMeritReportDAO;
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
        //String pagetype = (String) params.get("pagetype");
        List<Map<String, Object>> data = null;
//        List queryConfig = (List) params.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) params.get("querySql");
        String menuid = (String)params.get("menuid");
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String viewtabcode = (String)params.get("viewtabcode");
        //String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        //String workflow = (String) params.get("workflow");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        String bustype = (String) params.get("bustype");
        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            deptOverallMeritReportDAO.saveAll(eledatas, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            deptOverallMeritReportDAO.saveAll(treeData, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(viewtabcode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype='").append(bustype).append("'");
        sql.append(" and t.ismain='1'");
        if (wheresql != null && !StringUtils.isEmpty(wheresql)){
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            sql.append(" and (").append(tablesql).append(")");
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append( deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        data = deptOverallMeritReportDAO.queryForList(sql.toString());
        backMap.put("data", data);
        return backMap;
    }
    
    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("name", "查询");
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("datas", this.getLeftTree(menuId, deptOverallMeritReportDAO.getSystemDepttree()));
        return leftconfig;
    }

}
