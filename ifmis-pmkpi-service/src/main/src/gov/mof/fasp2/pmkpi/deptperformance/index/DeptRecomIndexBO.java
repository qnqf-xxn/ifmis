package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptRecomIndexBO extends PmkpiBO {
    private DeptIndexDAO deptIndexDAO;

    public void setDeptIndexDAO(DeptIndexDAO deptIndexDAO) {
        this.deptIndexDAO = deptIndexDAO;
    }

    /**
     * 指标推荐.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     *
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String saveAgency = (String) sqlmap.get("saveAgency");
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String isleaf = sqlmap.get("isleaf") + "";
        String levelno = sqlmap.get("levelno") + "";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select * from v_bas_perf_indicator").append(" t ");
        returnsql.append(" where t.wfstatus = '011' and t.framesystem ='DEPT' ");
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and (").append(tabfilter).append(")");
        }
        if (nodeguid != null && !nodeguid.isEmpty()) {
            if ("1".equals(isleaf)) {
                returnsql.append(" and agencyguid = '").append(nodeguid).append("'");
            } else if ("0".equals(isleaf)) {
                returnsql.append(" and (");
                for (int i = Integer.parseInt(levelno); i<saveAgency.length()/3; i++) {
                    returnsql.append("agencyguid = '").append(saveAgency.substring(0, 3 * (i))).append("' or ");
                }
                returnsql.append("agencyguid = '").append(saveAgency).append("'");
                returnsql.append(" )");
            }
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
    public Map<String, Object> getTreeData(String menuId,String saveAgency) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("dosearch", Boolean.TRUE);
        String sql = " guid = '" + saveAgency + "'";
        leftconfig.put("datas", deptIndexDAO.getLeftTree(PmkpiDAO.PMKPI_TABLE_T_AGENCY, sql));
        return leftconfig;
    }

}
