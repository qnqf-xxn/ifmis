package gov.mof.fasp2.pmkpi.setting.casepage.casemarkedindi;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CasemarkedIndiBO extends PmkpiBO {
    private CasemarkedIndiDAO casemarkedIndiDAO;

    public void setCasemarkedIndiDAO(CasemarkedIndiDAO casemarkedIndiDAO) {
        this.casemarkedIndiDAO = casemarkedIndiDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String type = (String) sqlmap.get("type");
        if("indilist".equals(type)){
            return this.getIndiSql(sqlmap);
        }else if("prolist".equals(type)){
            return this.getProSql(sqlmap);
        }else{
            String tablecode = (String)sqlmap.get("tablecode");
            String wheresql = (String) sqlmap.get("querySql");
            StringBuffer returnsql = new StringBuffer("select * from ").append(tablecode).append(" t ");
            if (wheresql != null && ! wheresql.isEmpty()){
                returnsql.append(" where (").append(wheresql).append(")");
            }
            return returnsql.toString();
        }

    }

    /**
     * 梳理指标统计列表查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getIndiSql(Map sqlmap) throws AppException {
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
            returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, casemarkedIndiDAO.PMKPI_TABLE_T_AGENCY));
        } else {
            if ("treeroot".equals(nodeguid)) {
                returnsql.append(" and exists(select 1 from v_perf_enum en where en.guid=t.casetype and en.elementcode='" + leftsource + "')");
            } else if ("1".equals(isleaf)) {
                returnsql.append(" and casetype='").append(nodeguid).append("'");
            } else if (!"treeroot".equals(nodeguid) && "0".equals(isleaf)) {
                List<Map<String,Object>> list = casemarkedIndiDAO.getCaseType(nodeguid, leftsource);
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

    /**
     * 指标引用情况项目列表查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getProSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tablecode = (String)sqlmap.get("tablecode");
        String menuid = (String)sqlmap.get("menuid");
        String indi_code = (String)sqlmap.get("indi_code");
        String year = (String)sqlmap.get("queryYear");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        //查询项目信息+指标code、name
        StringBuffer returnsql = new StringBuffer("select * from (select t1.*,t1.pro_code||'-'||t1.pro_name as pro_codename,t1.agencyguid||'-'||t1.agency_name as proagency_name,t1.mof_dep_code||'-'||t1.mof_dep_name as profinintorg_name,a.code as indi_code,a.name as indi_name from ")
                .append(tablecode).append(" t1 ");
        returnsql.append(" left join(select pi.* from pm_perf_indicator pi where pi.yearflag ='0' and pi.is_deleted =2 and pi.is_backup =2 and nvl(pi.is_adj, 2) = 2 and pi.year='").append(year);
        returnsql.append("' and pi.code='").append(indi_code).append("') a on t1.pro_code = a.pro_code  and t1.province = a.province )t where t.indi_code is not null ");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        if (wheresql != null && ! wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && ! tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 查询左侧树
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getTreeData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String leftmenuid = (String) params.get("leftmenuid");
        String leftsource = (String) params.get("leftsource");
        String tablecode = (String) params.get("tablecode");
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = "";
        List treeDatas;
        if (CaseReportDAO.CASETYEP_SOURCE.equals(leftsource)) {
            String wheresql = "(select en.*,'' as agencyguid from v_perf_enum en where en.elementcode='" + leftsource + "' order by en.ordernum)";
            treeDatas = casemarkedIndiDAO.getLeftTree(tablecode, datarule, wheresql, "casetype");
            backMap.put("isCasetype", "true");
        } else {
            datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
            datarule += " and bustype='" + lefttabtype + "' ";
            //根据权限查询单位
            treeDatas = casemarkedIndiDAO.getLeftTree(tablecode, datarule);
        }
        backMap.put("treeDatas", treeDatas);
        return backMap;
    }
}
