package gov.mof.fasp2.pmkpi.adjust.remind;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustRemindBO  extends PmkpiBO {
    private AdjustRemindDAO adjustRemindDAO;

    public void setAdjustRemindDAO(AdjustRemindDAO adjustRemindDAO) {
        this.adjustRemindDAO = adjustRemindDAO;
    }


    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append(" select * from v_perf_adjustremind t where ");
        String datarule = this.getDataRuleByMenuguid(lefttabtype + adjustRemindDAO.PERF_STRING_ADJUST, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, adjustRemindDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }


    /**
     * 查询左侧树。
     * @param menuId -- 菜单.
     * @return
     * @throws AppException
     */
    public Map getRemindLeftTree(String menuId) throws Exception {
        Map leftconfig = new HashMap();
        List<String> types = new ArrayList<String>();
        types.add("program");
        types.add("dept");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            String datarule = this.getDataRuleByMenuguid(type + adjustRemindDAO.PERF_STRING_ADJUST, "t", "1=1");
            datarule += " and bustype='" + type + "'";
            List<Map<String, Object>> list = adjustRemindDAO.getLeftTree("v_perf_t_adjust", datarule);
            if (list == null) {
                list = new ArrayList<>();
            }
            if (list.size() <= 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("guid","0");
                map.put("code","00");
                map.put("name","全部");
                map.put("superid","0");
                map.put("levelno","1");
                map.put("isleaf","0");
                list.add(map);
                leftconfig.put("datas", list);
            } else {
                if ("program".equals(type)){
                    list = adjustRemindDAO.getLeftTree();
                    leftconfig.put("datas", list);
                } else if ("dept".equals(type)) {
                    leftconfig.put("datas", list);
                }
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

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "v_perf_t_adjust";
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = this.getDataRuleByMenuguid(lefttabtype + adjustRemindDAO.PERF_STRING_ADJUST, "t", "1=1");
        //根据权限查询单位
        return adjustRemindDAO.getLeftTree(tablecode, datarule);
    }
}
