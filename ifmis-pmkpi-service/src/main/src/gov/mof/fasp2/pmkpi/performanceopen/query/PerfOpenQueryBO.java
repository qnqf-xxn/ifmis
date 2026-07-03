package gov.mof.fasp2.pmkpi.performanceopen.query;

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
public class PerfOpenQueryBO extends PmkpiBO {

    private PerfOpenQueryDAO perfOpenQueryDAO;
    /**
     * 注入dao.
     * @param perfOpenQueryDAO --dao.
     * @throws
     */
    public void setPerfOpenQueryDAO(PerfOpenQueryDAO perfOpenQueryDAO) {
        this.perfOpenQueryDAO = perfOpenQueryDAO;
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
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where wfstatus is not null and wfstatus != '000' ");
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
        returnsql.append(this.getLeftTreeWheresql(agenisleaf, columncode, agencode, perfOpenQueryDAO.PMKPI_TABLE_T_AGENCY));
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
            if ("perfopen".equals(type)) {
                data = perfOpenQueryDAO.getDatas("v_perf_t_datasource", "elementcode='perfopen'", "order by ordernum");
            } else if ("perfagen".equals(type)) {
                //根据权限查询单位
                String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
                datarule += " and wfstatus is not null and wfstatus != '000' ";
                data = perfOpenQueryDAO.getLeftTree(PerfOpenDAO.PERF_TABLE_MANCEOPEN, datarule);
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

}
