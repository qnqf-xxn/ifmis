package gov.mof.fasp2.pmkpi.perfQuery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * <p>绩效目标查询（菜单整合）</p >
 *
 * @author hw
 * @date 2021/5/19 17:34
 */
public class PerfQueryBO extends PmkpiBO {

    private PerfQueryDAO perfQueryDAO;

    public void setPerfQueryDAO(PerfQueryDAO perfQueryDAO) {
        this.perfQueryDAO = perfQueryDAO;
    }

    /**
     * 查询左侧树。
     *
     * @param menuId -- 菜单.
     * @return
     * @throws AppException
     */
    public Map getTraceLeftTree(String menuId, String prolev) throws Exception {
        List<String> types = new ArrayList<>();
        types.add("project");
//        types.add("dept");  --去掉部门整体类型
        types.add("firstpro");
        types.add("transpay");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String name = "";
            List<Map<String, Object>> treelist = new ArrayList<>();
            String type = types.get(i);
            Map<String, Object> leftconfig = new HashMap<>();
            Map f1 = new HashMap();
            if ("dept".equals(type)) { // 部门整体
                name = "部门整体";
            } else if ("project".equals(type)) { // 二级项目
                name = "二级项目";
            } else if ("firstpro".equals(type)) { // 一级项目
                name = "一级项目";
            } else if ("transpay".equals(type)) { // 转移支付
                name = "转移支付";
            }
            if(treelist.size() == 0){
                Map<String, Object> map = new HashMap<>();
                map.put("guid","0");
                map.put("code","00");
                map.put("name","全部");
                map.put("superid","#");
                map.put("levelno","1");
                map.put("isleaf","0");
                treelist.add(map);
            }
            leftconfig.put("datas", treelist);
            leftconfig.put("name", name);
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.TRUE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            f1.put("name", name);
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
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String protype = (String) params.get("protype");
        String datarule = this.getDataRuleByMenuguidNull(protype + perfQueryDAO.PERF_T_QUERY, "t", "1=1");
        return perfQueryDAO.getLeftTree(tablecode, datarule);
    }
}
