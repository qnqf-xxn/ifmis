package gov.mof.fasp2.pmkpi.perfpromod.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProModQyBO extends PmkpiBO {

    private ProModQyDAO proModQyDAO;

    public void setProModQyDAO(ProModQyDAO proModQyDAO) {
        this.proModQyDAO = proModQyDAO;
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
        List<Map<String, Object>> list = proModQyDAO.getTreeList(datarule);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (1 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if (sysvalue != null && "PMKPIAGENCYALLPAY".equals(sysvalue)) {
        	proModQyDAO.saveAll(list, proModQyDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
        	proModQyDAO.saveAll(treesourcedata, proModQyDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //查询单位上级，合成左侧树
        List<Map<String, Object>> treelist = proModQyDAO.getLeftTree();
        leftconfig.put("datas", treelist);
        return leftconfig;
    }


    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
//        List queryConfig = (List) sqlmap.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow");
        String tablesql = (String) sqlmap.get("tablesql");//查询条件
        String orderby = (String) sqlmap.get("orderby");
        String tabcode = (String) sqlmap.get("tabcode");
        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String protablecode = "v_perf_project_info";
        if (prolev != null && "1".equals(prolev)) {
            protablecode = "perf_t_flprogram";
        } else if (prolev != null && "2".equals(prolev)) {
            protablecode = "perf_t_slprogram";
        }
        String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
        String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
        logger.debug("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
            columncode = "agencyguid";
        }
        String datarule = this.getDicDSDataListByWheresql(menuid, "t", null); //数据权限
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (isleaf != null && agency != null && !"1".equals(isleaf) && !"treeroot".equals(agency)) {
            datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            proModQyDAO.saveAll(eledatas, proModQyDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (agency != null && "treeroot".equals(agency)) {
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            proModQyDAO.saveAll(eledatas, proModQyDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select t.* ");
        List<Map<String, Object>> colList = proModQyDAO.getCol(protablecode);
        for (Map<String, Object> map : colList) {
            String col = (String) map.get("columncode");
            if (col != null && !col.isEmpty()) {
                returnsql.append(", p.").append(col).append(" proj").append(col);
            }
        }
        returnsql.append(" from ").append(tablecode).append(" t ");
        returnsql.append("left join ").append(protablecode).append(" p on t.proguid=p.guid ");
        returnsql.append(" where 1=1");
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wfsql = wfsql.replaceAll("WFSTATUS", "t.wfstatus");
            if (tabcode != null && !"alldeals".equals(tabcode)) {
                wfsql = wfsql.replaceAll("wfid", "t.wfid");
            }
            wfsql = wfsql.replaceAll("AUDITOR", "t.auditor");
            wfsql = wfsql.replaceAll("GUID", "t.guid");
            returnsql.append(" and ").append(wfsql);
        }
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.").append(columncode).append("='").append(agency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(proModQyDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.").append(columncode).append(")");
        }
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

}
