package gov.mof.fasp2.pmkpi.setting.casepage.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CaseQueryBO extends PmkpiBO {
    private CaseQueryDAO caseQueryDAO;

    public void setCaseQueryDAO(CaseQueryDAO caseQueryDAO) {
        this.caseQueryDAO = caseQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String isCasetype = (String) sqlmap.get("isCasetype");
        String leftsource = (String) sqlmap.get("leftsource");
        StringBuffer returnsql = new StringBuffer("select * from ").append(tablecode).append(" t ");
        returnsql.append(" where bustype='").append(lefttabtype).append("'");
        if (StringUtil.isEmpty(isCasetype)) {
            String columncode = "agencyguid";
            returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, caseQueryDAO.PMKPI_TABLE_T_AGENCY));
        } else {
            if ("treeroot".equals(nodeguid)) {
                returnsql.append(" and exists(select 1 from v_perf_enum en where en.guid=t.casetype and en.elementcode='" + leftsource + "')");
            } else if ("1".equals(isleaf)) {
                returnsql.append(" and casetype='").append(nodeguid).append("'");
            } else if (!"treeroot".equals(nodeguid) && "0".equals(isleaf)) {
                List<Map<String,Object>> list = caseQueryDAO.getCaseType(nodeguid, leftsource);
                StringBuffer caseguids = new StringBuffer();//调整前guid
                for (Map<String,Object> map : list) {
                    String caseguid = (String) map.get("guid");
                    caseguids.append("'").append(caseguid).append("',");
                }
                caseguids.deleteCharAt(caseguids.length() - 1);
                returnsql.append(" and casetype in(").append(caseguids.toString()).append(")");
            }
        }
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
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && ! wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public Map<String, Object> getTreeData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String leftmenuid = (String) params.get("leftmenuid");
        String leftsource = (String) params.get("leftsource");
        String tablecode = (String) params.get("tablecode");
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = "";
        List treeDatas = null;
        if (CaseReportDAO.CASETYEP_SOURCE.equals(leftsource)) {
            String wheresql = "(select en.*,'' as agencyguid from v_perf_enum en where en.elementcode='" + leftsource + "' order by en.ordernum)";
            treeDatas = caseQueryDAO.getLeftTree(tablecode, datarule, wheresql, "casetype");
            backMap.put("isCasetype", "true");
        } else {
            datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
            datarule += " and bustype='" + lefttabtype + "' ";
            //根据权限查询单位
            treeDatas = caseQueryDAO.getLeftTree(tablecode, datarule);
        }
        backMap.put("treeDatas", treeDatas);
        return backMap;
    }
}
