package gov.mof.fasp2.pmkpi.wfparallel;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WfParallelAuditBO extends PmkpiBO {

    private WfParallelAuditDAO wfParallelAuditDAO;

    public void setWfParallelAuditDAO(WfParallelAuditDAO wfParallelAuditDAO) {
        this.wfParallelAuditDAO = wfParallelAuditDAO;
    }

    /**
     * 查询左侧树。
     * @param menuId -- 菜单.
     * @param modeltype  模块类型
     * @return
     * @throws AppException
     */
    public Map getWfLeftTree(String menuId, String modeltype) {
        Map leftconfig = new HashMap();
        List<String> types = new ArrayList<String>();
        if (modeltype != null && "dept".equals(modeltype)){
            types.add("dept");
        }else {
            types.add("program");
            types.add("dept");
        }
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            //根据权限查询单位
            List<Map<String, Object>> list = new ArrayList<>();
            if (list != null && list.size() <= 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("guid","0");
                map.put("code","00");
                map.put("name","全部");
                map.put("superid","0");
                map.put("levelno","1");
                map.put("isleaf","0");
                list.add(map);
                leftconfig.put("datas", list);
            }
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();
            if("program".equals(type)){
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            }else if ("dept".equals(type)){
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
            }
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
     * 获取左侧树显示数据.
     * @param menuId 菜单.
     * @throws AppException
     * @rturn --
     */
    public List<Map<String, Object>> getDeptLeftTreeData(String menuId)
            throws AppException {
        String sysvalue = wfParallelAuditDAO.getSystemDepttree();
        if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
            //默认查询单位
            sysvalue="PMKPIAGENCYALLPAY";
        }
        String sql = this.getDicDSDataListByWheresql("t", menuId, sysvalue);
        sql += " and t.modeltype='dept' and t.bustype='dept'";
        //根据权限查询
        List<Map<String, Object>> list = wfParallelAuditDAO.getTreeList(sql,"V_PERF_T_BUSWFPARALLEL");
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (1 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if("PMKPIDEPT".equals(sysvalue)){
            wfParallelAuditDAO.saveAll(list, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            wfParallelAuditDAO.saveAll(treesourcedata, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        return wfParallelAuditDAO.getLeftTree();
    }

    /**
     * 查询左侧树数据.
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String modeltype = (String) params.get("modeltype");
        String lefttabtype = (String) params.get("lefttabtype");
        String menuId = (String) params.get("menuid");
        String tablecode = "V_PERF_T_BUSWFPARALLEL";
        List<Map<String, Object>> leftteedata = null;
        if(modeltype != null && "dept".equals(modeltype)){
            leftteedata = this.getDeptLeftTreeData(menuId);
        }else if(modeltype != null && "trace".equals(modeltype)) {
            String datarule = this.getDataRuleByMenuguidNull(lefttabtype+wfParallelAuditDAO.PERF_STRING_TRACE, "t", "1=1");
            //根据权限查询单位
            datarule += " and bustype='" + lefttabtype + "' ";
            List<Map<String, Object>> list = wfParallelAuditDAO.getTreeList(datarule, tablecode);
            wfParallelAuditDAO.saveAll(list, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            leftteedata = wfParallelAuditDAO.getLeftTree();
        }
        return leftteedata;
    }

    /**
     * 表格分页查询.
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuId = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String modeltype = (String) sqlmap.get("modeltype");
        String elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        String tablecode = wfParallelAuditDAO.getTabelByType(lefttabtype, modeltype);
        String column = wfParallelAuditDAO.getseletcols(tablecode);
        StringBuffer returnsql = new StringBuffer("select * from (select ").append(column).append(" p.* from v_PERF_T_BUSWFPARALLEL p inner join ");
        returnsql.append(tablecode).append(" q on p.mainguid = q.guid) t  where 1=1 ");
        String datarule = "";
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if(modeltype != null && "dept".equals(modeltype)){
            returnsql.append(" and t.modeltype='dept' and t.bustype='dept' ");
            datarule = this.getDicDSDataListByWheresql("t", menuId, "PMKPIAGENCYALLPAY");
            if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
                // 数据权限
                datarule += " and isleaf=1 start with superguid='" + saveAgency + "' connect by prior guid = superguid";
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule.replace("t.",""));
                wfParallelAuditDAO.saveAll(eledatas, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            }else {
                List<Map<String, Object>> treeData =  this.getDeptLeftTreeData(menuId);
                wfParallelAuditDAO.saveAll(treeData, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            }
        } else if(modeltype != null && "trace".equals(modeltype)){
            returnsql.append(" and t.modeltype='").append(modeltype).append("' and t.bustype='")
                    .append(lefttabtype).append("'");
            datarule = this.getDataRuleByMenuguidNull(lefttabtype+wfParallelAuditDAO.PERF_STRING_TRACE, "t", null); //数据权限
            datarule = datarule.replace("t.agencyguid","t.guid");
            if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
                datarule += " start with superguid='" + saveAgency + "' connect by prior guid = superguid";
                datarule = " 1= 1" + datarule;
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
                wfParallelAuditDAO.saveAll(eledatas, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            }else {
                datarule = " 1= 1" + datarule;
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
                wfParallelAuditDAO.saveAll(eledatas, wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            }
        }

        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow, "t");
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        if ("1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid='").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select * from ").append(wfParallelAuditDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        return returnsql.toString();
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String remark = (String) params.get("remark");
        String actioncode = (String) params.get("actioncode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, "v_PERF_T_BUSWFPARALLEL", datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
