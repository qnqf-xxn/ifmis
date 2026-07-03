package gov.mof.fasp2.pmkpi.assessQuery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AssessQueryBO extends PmkpiBO {

    private AssessQueryDAO assessQueryDAO;

    public void setAssessQueryDAO(AssessQueryDAO assessQueryDAO) {
        this.assessQueryDAO = assessQueryDAO;
    }

    /**
     * 查询左侧树。
     *
     * @param menuId -- 菜单.
     * @return
     * @throws AppException
     */
    public Map getTraceLeftTree(String menuId, String prolev) throws Exception {
        List<String> types = new ArrayList<String>();
        types.add("secondpro");
//        types.add("firstpro");
        types.add("transpay");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            Map<String, Object> leftconfig = new HashMap<String, Object>();
            Map f1 = new HashMap();
//            menuId = type + assessQueryDAO.PERF_T_QUERY;
            String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
            if (StringUtil.isEmpty(sysvalue)) {
                sysvalue = "PMKPIAGENCYALLPAY"; //没有配置默认单位
            }
            String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
            //根据权限查询单位
            List<Map<String, Object>> list = assessQueryDAO.getLeftTree("v_perf_project_info", datarule);
            List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> treelist = null;
            Object isleaf = 0;
            for (Map<String, Object> map : list) {
                isleaf = map.get("isleaf");
                if (0 == ((Number) isleaf).intValue()) {
                    treesourcedata.add(map);
                }
            }
            if ("PMKPIAGENCYALLPAY".equals(sysvalue)) {
                treelist = list;
            } else {
                treelist = treesourcedata;
            }
            //查询单位上级，合成左侧树
            if ("firstpro".equals(type)) { // 一级项目
                leftconfig.put("datas", treelist);
                leftconfig.put("name", "一级项目");
                f1.put("name", "一级项目");
            } else if ("secondpro".equals(type)) { // 二级项目
                leftconfig.put("datas", treelist);
                leftconfig.put("name", "二级项目");
                f1.put("name", "二级项目");
            } else if ("transpay".equals(type)) { // 转移支付
                leftconfig.put("datas", treelist);
                leftconfig.put("name", "转移支付");
                f1.put("name", "转移支付");
            }
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.TRUE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            f1.put("ordernum", i);
            f1.put("code", type);
            f1.put("click", "tabChange");
            f1.put("treeinfo", leftconfig);
            tabs[i] = f1;
        }
        Map m = new HashMap();
        m.put("onlydata", Boolean.TRUE);
        m.put("activeTab", 0);
        m.put("dosearch", Boolean.TRUE);
        m.put("tabs", tabs);
        return m;
    }


    /**
     * 查询左侧树数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData1(HashMap<String, Object> params) throws AppException {
        String menuId = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        //根据权限查询单位
        List<Map<String, Object>> list = assessQueryDAO.getLeftTree(tablecode, datarule);
        assessQueryDAO.saveAll(list, assessQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        return assessQueryDAO.getLeftTree();
    }


    /**
     * 获取左侧树数据.
     *
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
        if (StringUtil.isEmpty(sysvalue)) {
            sysvalue = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        //根据权限查询单位
        List<Map<String, Object>> list = assessQueryDAO.getLeftTree("v_perf_project_info", datarule);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> treelist = null;
        Object isleaf = 0;
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (0 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if ("PMKPIAGENCYALLPAY".equals(sysvalue)) {
            treelist = list;
        } else {
            treelist = treesourcedata;
        }
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String menuid = (String) sqlmap.get("menuid");
        StringBuffer s = new StringBuffer();
        String wheresql = this.getDataRuleByMenuguid(menuid, "t", "1=1");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        if ("1".equals(isZJ)){
            sqlmap.put("tablecode","V_PERF_PROJECT_INFOASSESS");//
        }
        s = this.getReportQuerySql(sqlmap);
        String sql = "select t.* from " + s.toString() + " t where 1=1 ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " and " + wheresql;
        }
        return sql;
    }

    /**
     * 查询数据方法
     *
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
        if (pagetype != null && (pagetype.equals("report") || pagetype.equals("audit"))) {
            s = this.getReportQuerySql(params);
            data = assessQueryDAO.getDatas(s.toString(), wheresql, "order by update_time");
        } else {
            String mainguid = (String) params.get("mainguid");
            String tablecode = (String) params.get("tablecode");
            String tablesql = (String) params.get("tablesql");
            String orderby = (String) params.get("orderby");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (tablesql != null && !tablesql.isEmpty()) {
                wheresql += tablesql;
            }
            data = assessQueryDAO.getDatas(tablecode, wheresql, orderby);
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 申报/审核页面查询
     *
     * @param sqlmap --
     * @return --
     * @throws AppException
     */
    public StringBuffer getReportQuerySql(Map sqlmap) throws AppException {
//        List queryConfig = (List) sqlmap.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String orderby = (String) sqlmap.get("orderby");
//        String workflow = (String) sqlmap.get("workflow");
//        String tabcode = (String) sqlmap.get("tabcode");
        String type = (String) sqlmap.get("type");
        String prolev = (String) sqlmap.get("prolev");
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", datarule);
            assessQueryDAO.saveAll(eledatas, assessQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", datarule);
            assessQueryDAO.saveAll(eledatas, assessQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("(select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        if ("1".equals(type)) { // 如果是事前绩效评估查询-V_COL12：1-是；2-否；
            sql.append(" and v_col12 = '1'");
        }
        if (!StringUtils.isEmpty(prolev)) { // 如果级别字段不为空则加入条件查询
            sql.append(" and pro_lev = '" + prolev + "'");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and ").append(tabfilter);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("')");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(assessQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
        return sql;
    }

    public Map<String, Object> getFileMag(HashMap<String, Object> parms) {
        String proguid = (String) parms.get("proguid");
        List<Map<String, Object>> list = assessQueryDAO.getFileMag(proguid);
        Map map = new HashMap();
        if(list.size() > 0){
            Map map1 = list.get(0);
            String fileguid = (String)map1.get("fileguid");
            if(fileguid.isEmpty()){
                map.put("error",true);
                map.put("log","当前项目未上传附件!");
            } else {
                map.put("succes",true);
                map.put("fileguid",map1.get("fileguid"));
            }
        } else {
            map.put("error",true);
            map.put("log","当前项目未上传附件!");
        }
        return map;
    }
}
