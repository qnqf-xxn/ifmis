package gov.mof.fasp2.pmkpi.adjust.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustQueryBO extends PmkpiBO {
    private AdjustQueryDAO adjustQueryDAO;

    public void setAdjustQueryDAO(AdjustQueryDAO adjustQueryDAO) {
        this.adjustQueryDAO = adjustQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        StringBuffer returnsql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
        returnsql.append(" where bustype='").append(lefttabtype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (wheresql != null && ! wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && ! tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && ! tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, adjustQueryDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }


    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "v_perf_t_adjust";
        String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + lefttabtype + "' ";
        return adjustQueryDAO.getLeftTree(tablecode, datarule);
    }

}
