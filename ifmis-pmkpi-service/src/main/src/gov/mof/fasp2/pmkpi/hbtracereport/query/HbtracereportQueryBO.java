package gov.mof.fasp2.pmkpi.hbtracereport.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HbtracereportQueryBO extends PmkpiBO {

    private HbtracereportQueryDAO hbtracereportQueryDAO;

    public void setHbtracereportQueryDAO(HbtracereportQueryDAO hbtracereportQueryDAO) {
        this.hbtracereportQueryDAO = hbtracereportQueryDAO;
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
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
     *  列表的查询方法.
     * @param sqlmap
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String agency = (String)sqlmap.get("agency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            //数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            hbtracereportQueryDAO.saveAll(eledatas, hbtracereportQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            String sysvalue = PerfUtil.getSystemSet("dept_letftree");
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
            hbtracereportQueryDAO.saveAll(treeData, hbtracereportQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where 1=1");
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            returnsql.append(" and exists(select * from ").append(hbtracereportQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    public List getFileNameList(String mainguid, String filebustype){
        return hbtracereportQueryDAO.getFileNameList(mainguid,filebustype);
    }
}
