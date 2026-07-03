package gov.mof.fasp2.pmkpi.performanceopen.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.performanceopen.report.PerfOpenDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:29
 */
public class PerfOpenAuditBO extends PmkpiBO {

    private PerfOpenAuditDAO perfOpenAuditDAO;
    /**
     * 注入dao.
     * @param perfOpenAuditDAO --dao.
     * @throws
     */
    public void setPerfOpenAuditDAO(PerfOpenAuditDAO perfOpenAuditDAO) {
        this.perfOpenAuditDAO = perfOpenAuditDAO;
    }

    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tablecode = (String) sqlmap.get("tablecode");
        String opencode = (String) sqlmap.get("opencode");
        String agencode = (String) sqlmap.get("agencode");
        String agenisleaf = sqlmap.get("agenisleaf") + ""; //节点是否为末级
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where ");
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(") ");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        if (opencode != null && !opencode.isEmpty() && !"treeroot".equals(opencode)) {
            returnsql.append(" and t.bustype = '").append(opencode).append("'");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(agenisleaf, columncode, agencode, perfOpenAuditDAO.PMKPI_TABLE_T_AGENCY));
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
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTraceLeftTree(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        List<String> types = new ArrayList<String>();
        types.add("perfopen");
        types.add("perfagen");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
            if ("perfopen".equals(type)){
                data = perfOpenAuditDAO.getDatas("v_perf_t_datasource", "elementcode='perfopen'", "order by ordernum");
            } else if ("perfagen".equals(type)) {
                //根据权限查询单位
                String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
                data = perfOpenAuditDAO.getLeftTree(PerfOpenDAO.PERF_TABLE_MANCEOPEN, datarule);
            }
            leftconfig.put("datas", data);
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();

            if ("perfopen".equals(type)){
                leftconfig.put("name", "公开类型");
                f1.put("name", "公开类型");
            } else if ("perfagen".equals(type)){
                leftconfig.put("name", "预算单位");
                f1.put("name", "预算单位");
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
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = PerfOpenDAO.PERF_TABLE_MANCEOPEN;
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 获取审核类型数据源
     * @param wheresql --
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas(String wheresql){
        return perfOpenAuditDAO.getAudittypeDatas(wheresql);
    }

    /**
     * 保存审核意见
     * @param params
     * @return
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        String workflow = (String) params.get("workflow");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String remark = (String) editinfo.get("opinion");
        String actioncode = (String) editinfo.get("ordinarytype");
        String tablecode = PerfOpenDAO.PERF_TABLE_MANCEOPEN;
        //审核定义
        String busguid = (String) params.get("busguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }
}
