package gov.mof.fasp2.pmkpi.deptTJformance.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


public class DeptTJPerfQueryBO extends PmkpiBO {

    private DeptTJPerfDAO deptTJPPerfDAO;
    /**
     * 注入dao.
     * @param deptTJPPerfDAO --dao.
     * @throws
     */
    public void setDeptTJPerfDAO(DeptTJPerfDAO deptTJPPerfDAO) {
        this.deptTJPPerfDAO = deptTJPPerfDAO;
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
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("agency"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tablecode = (String) sqlmap.get("tablecode");
        String elementcode = PerfUtil.getSystemSet("dept_letftree");
        logger.info("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"1".equals(isleaf) && !"treeroot".equals(nodeguid)) {
            datarule += " start with superguid='" + nodeguid + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            deptTJPPerfDAO.saveAll(eledatas, deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (nodeguid != null && "treeroot".equals(nodeguid)) {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            deptTJPPerfDAO.saveAll(eledatas, deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where 1=1");
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid = '").append(nodeguid).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY)
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
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (treesource != null && !StringUtils.isEmpty(treesource)){
            leftconfig.put("datas", this.getLeftTree(menuId, treesource));
        }
        return leftconfig;
    }

    /**
     * 天津部门整体导出-分发处室审核进度表
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getExpDatas(HashMap<String, Object> params) throws AppException {
        String key = (String)params.get("key");
        String menuid = (String)params.get("menuid");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
        datarule = " 1= 1 " + datarule;
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = deptTJPPerfDAO.getDatas("perf_v_tjdepttofinexp", datarule, null);
        backMap.put("data", data);
        List<Map<String, Object>> columns= this.getCols(key).stream().filter(m -> (int)m.get("isvisiable")==1).collect(Collectors.toList());
        backMap.put("column", columns);
        return backMap;
    }

}
