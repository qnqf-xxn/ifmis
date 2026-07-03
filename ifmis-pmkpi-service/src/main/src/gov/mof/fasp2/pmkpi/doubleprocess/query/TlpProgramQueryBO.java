package gov.mof.fasp2.pmkpi.doubleprocess.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpProgramQueryBO extends PmkpiBO {
	
	private TlpProgramQueryDAO tlpProgramQueryDAO;

	public void setTlpProgramQueryDAO(TlpProgramQueryDAO tlpProgramQueryDAO) {
		this.tlpProgramQueryDAO = tlpProgramQueryDAO;
	}
	
	/**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        //根据权限查询单位
        List<Map<String, Object>> list = tlpProgramQueryDAO.getTreeList(datarule);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (1 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if("PMKPIAGENCYALLPAY".equals(sysvalue)){
        	tlpProgramQueryDAO.saveAll(list, tlpProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
        	tlpProgramQueryDAO.saveAll(treesourcedata, tlpProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //查询单位上级，合成左侧树
        List<Map<String, Object>> treelist = tlpProgramQueryDAO.getLeftTree();
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String menuid = (String) sqlmap.get("menuid");
        StringBuffer s = new StringBuffer();
        String wheresql = this.getDataRuleByMenuguid(menuid, "t", "1=1");
        s = this.getReportQuerySql(sqlmap);
        String sql = "select t.* from " + s.toString() + " t where 1=1 ";
        if (wheresql != null && !"".equals(wheresql)) {
            sql += " and " + wheresql;
        }
        return sql;
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
        String menuid = (String) params.get("menuid");
        StringBuffer s = new StringBuffer();
        String wheresql = this.getDataRuleByMenuguid(menuid, "t", "1=1");
        List<Map<String, Object>> data = null;
        if (pagetype != null && (pagetype.equals("report") || pagetype.equals("audit"))){
            s = this.getReportQuerySql(params);
            data = tlpProgramQueryDAO.getDatas(s.toString(), wheresql, "order by update_time");
        } else {
            String mainguid = (String)params.get("mainguid");
            String tablecode = (String)params.get("tablecode");
            String tablesql = (String)params.get("tablesql");
            String orderby = (String)params.get("orderby");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (!StringUtils.isEmpty(tablesql)) {
                wheresql += tablesql;
            }
            data = tlpProgramQueryDAO.getDatas(tablecode, wheresql, orderby);
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
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            tlpProgramQueryDAO.saveAll(eledatas, tlpProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            tlpProgramQueryDAO.saveAll(eledatas, tlpProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY);
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
            sql.append(" and exists(select * from ").append(tlpProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        if (!StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        return sql;
    }
}
