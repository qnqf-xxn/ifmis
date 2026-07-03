package gov.mof.fasp2.pmkpi.setting.indexlib.gdreport;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class GDIndexBO extends PmkpiBO {

    private GDIndexDAO gdIndexDAO;

    public void setGDIndexDAO(GDIndexDAO gdIndexDAO) {
        this.gdIndexDAO = gdIndexDAO;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String, String> queryParam = new HashMap<String, String>();
        if (queryConfig != null && queryConfig.size() > 0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String saveAgency = (String)sqlmap.get("treeid"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tablecode = (String) sqlmap.get("tablecode");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String elementcode = PerfUtil.getSystemSet("agency_lefttree");
        String sql = "";
        logger.info("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        logger.info("---数据权限：" +menuid +"--"+ datarule);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"2".equals(isleaf) && !"treeroot".equals(saveAgency) ) {
            datarule += " start with superguid='" + saveAgency + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            gdIndexDAO.saveAll(eledatas, gdIndexDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (saveAgency != null && "treeroot".equals(saveAgency)) {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            gdIndexDAO.saveAll(eledatas, gdIndexDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where 1=1");
        if (sql != null && !sql.isEmpty()) {
            returnsql.append(" and ").append(sql);
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            if(!queryParam.isEmpty()) {
                String allColumns = (String) queryParam.get("ALL_COLUMNS");
                if (allColumns != null && !allColumns.isEmpty()) {
                    returnsql.append(" and (").append(wheresql).append(") ");
                } else {
                    returnsql.append(" and ").append(wheresql);
                }
            }
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        /*String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            if(wfsql.contains("WFSTATUS = '000'") && "waitaudit".equals(tabcode)){ // 如果有保存的权限，默认查全部
                returnsql.append(" and ( wfid is null or ").append(wfsql).append(") ");
            } else {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }*/
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid = '").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(gdIndexDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("agency_lefttree");
        logger.info("左侧树要素"+treesource+"####");
        if (StringUtil.isEmpty(treesource)){
            treesource  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        if (treesource != null && !StringUtils.isEmpty(treesource)){
            //根据权限查询单位
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
            List<DicRangeDTO> datas = dss.getRangesByWhereSql(treesource,datarule);
            leftconfig.put("datas", datas);
        }
        return leftconfig;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        try {
            gdIndexDAO.saveAll(deldatas, gdIndexDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + gdIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            gdIndexDAO.update("update V_GD_PERF_INDICATOR t set t.is_deleted = 1,t.is_enabled = 1 where "+delsql+" ");
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 保存指标数据.
     *
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        String treeid = (String) params.get("treeid");
        String indextype = (String) params.get("indextype");
        String pagetype = (String) params.get("pagetype");
        Map<String, Object> data = (Map<String, Object>) params.get("data");
        data.put("updatetime", PerfUtil.getServerTimeStamp());
        data.put("update_time", PerfUtil.getServerTimeStamp());

        if (pagetype != null && "add".equals(pagetype)) {
            Map<String, Object>  agenMap = gdIndexDAO.queryForMap("select * from fasp_T_pubagency where code = '"+treeid+"' ");
            String guid = this.getCreateguid();
            data.put("indicator_id", guid);
            data.put("guid", guid);
            data.put("fiscal_year", CommonUtil.getYear());
            data.put("mof_div_code", SecureUtil.getUserSelectProvince());
            data.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) data.get("mof_div_code")));
            data.put("ind_type_name","项目绩效指标");
            data.put("ind_type_code",2);
            data.put("is_common_ind", 1);
            data.put("parent_id", data.get("sindex"));
            data.put("level_no", 3);
            data.put("is_leaf", 1);
            data.put("is_last_inst", 2);
            data.put("start_date", PerfUtil.getServerTimeStamp());
            data.put("end_date", PerfUtil.getServerTimeStamp());
            data.put("is_enabled", 2);
            data.put("is_deleted", 2);
            data.put("create_time", PerfUtil.getServerTimeStamp());
            data.put("year", CommonUtil.getYear());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("wfid", null);
            data.put("wfstatus", "011");
            data.put("auditor", null);
            data.put("lastupdatetime", null);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("creater", SecureUtil.getCurrentUserID());
            this.getBasMap(data, "add");
            data.put("biz_key", null); // 业务唯一标识
            List<Map<String, Object>> list = new ArrayList<>();
            list.add(data);
            gdIndexDAO.setIndexCode(list);
            data = list.get(0);
            gdIndexDAO.save(data, "V_GD_PERF_INDICATOR");
        } else {
            String timestimps = StringUtil.getSysDBDate();
            data.put("updatetime", timestimps);
            data.put("update_time", timestimps);
            List cols = Arrays.asList(data.keySet().toArray());
            gdIndexDAO.update(cols, data, "V_GD_PERF_INDICATOR");
        }
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");//
        String iswf = (String) params.get("iswf");
        //Map<String, Object> map = this.getByGuid(tablecode, mainguid, iswf);
        //backMap.put("editdata", map);
        backMap.put("flg", "1");
        return backMap;
    }

    /**
     * 编辑查询
     *
     * @param params
     * @return
     */
    public Map<String, Object> getDataByGuid(Map params) {
        String guid = (String) params.get("guid");
        String wheresql = " guid='" + guid + "'";
        List list = gdIndexDAO.getDatas("V_GD_PERF_INDICATOR", wheresql, null);
        Map tempMap = new HashMap();
        if (list.size() > 0) {
            tempMap = (Map) list.get(0);
        }
        return tempMap;
    }







}
