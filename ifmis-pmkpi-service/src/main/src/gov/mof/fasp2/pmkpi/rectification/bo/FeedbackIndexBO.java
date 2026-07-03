package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.FeedbackIndexDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedbackIndexBO extends PmkpiBO {
    private FeedbackIndexDAO feedbackIndexDAO;

    public void setFeedbackIndexDAO(FeedbackIndexDAO feedbackIndexDAO) {
        this.feedbackIndexDAO = feedbackIndexDAO;
    }

    /**
     * 根据左侧页签和数据反查左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = RectificationAddProjDAO.PERF_T_RECTIFY;
        String leftmenuid = (String) params.get("leftmenuid");
        String bustype = (String) params.get("bustype");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + bustype + "' ";
        return feedbackIndexDAO.getLeftTree(tablecode,datarule);
    }

    /**
     * 送审
     * @param config
     * @return
     * @throws AppException
     */
    public Map send(HashMap config) throws AppException {
        String workflow = (String) config.get("workflow");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        this.workflow("audit",workflow, "", RectificationAddProjDAO.PERF_T_RECTIFY, datas);
        return config;
    }

    /**
     * 取消审核
     * @param config
     * @return
     * @throws AppException
     */
    public Map cancel(HashMap config) throws AppException {
        String workflow = (String) config.get("workflow");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        this.workflow("cancelaudit",workflow, "", RectificationAddProjDAO.PERF_T_RECTIFY, datas);
        return config;
    }


    /**
     * 反馈信息详情
     * @param config
     * @return
     */
    public Map getText(Map config) {
        String guid = (String)config.get("mainguid");
        Map<String,String> result=new HashMap<String, String>();
        String sql ="select t.rectifycontent,t.rectifytitle,t.feedbackcontent,t.projname,t.agencyguid from  PERF_T_RECTIFY t where guid='"+guid+"' ";
        result=feedbackIndexDAO.queryForMap(sql);
        List queryForList = feedbackIndexDAO.queryForList("select name from pmkpi_fasp_t_pubagency where guid = '"+result.get("agencyguid")+"'");
        String agencyName = "";
        if(queryForList.size() > 0){
            Map map = (Map) queryForList.get(0);
            agencyName = (String) map.get("name");
        }
        String strc = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">监控结果反馈书</span></p><p><span style=\"text-decoration:underline;\"><span style=\"font-family:仿宋_GB2312\">a1</span></span><span style=\"font-family:仿宋_GB2312\">：</span></p><p style=\"text-indent:43px\"><span style=\"font-family:仿宋_GB2312\">省财政厅对你部门（单位）<span style=\"text-decoration:underline;\">a2</span> 项目实施了三季度重点监控，发现项目存在资金执行率或绩效目标完成程度滞后的情况。现请你部门尽快查明原因，提出整改措施，确保年度目标按期实现。相关整改情况请填写到系统中整改报告书内，并与收到反馈书10个工作日内提交。</span></p><p><br/></p>";
        String strc1 = strc.replace("a1", agencyName);
        String strc2 = strc1.replace("a2", result.get("projname"));
        String str = "";
        if(result.get("feedbackcontent") == null || result.get("feedbackcontent").isEmpty()){
            str = "<p style=\"text-align: center;\"><span style=\"font-family: 宋体, SimSun; font-size: 36px;\">省级部门绩效监控整改报告书</span></p><p><br/></p><table align=\"center\" id = \"contable\"><tbody><tr style=\";height:26px\" class=\"firstRow\"><td width=\"127\" colspan=\"2\" style=\"border: 1px solid windowtext; padding: 0px 7px;\"><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">项目单位</span></p></td><td width=\"132\" style=\"border-top: 1px solid windowtext; border-right: 1px solid windowtext; border-bottom: 1px solid windowtext; border-image: initial; border-left: none; padding: 0px 7px; word-break: break-all;\">a1</td><td width=\"168\" style=\"border-top: 1px solid windowtext; border-right: 1px solid windowtext; border-bottom: 1px solid windowtext; border-image: initial; border-left: none; padding: 0px 7px;\"><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">项目名称</span></p></td><td width=\"168\" style=\"border-top: 1px solid windowtext; border-right: 1px solid windowtext; border-bottom: 1px solid windowtext; border-image: initial; border-left: none; padding: 0px 7px; word-break: break-all;\">a2</td></tr><tr style=\";height:26px\"><td width=\"127\" colspan=\"2\" style=\"border-right: 1px solid windowtext; border-bottom: 1px solid windowtext; border-left: 1px solid windowtext; border-image: initial; border-top: none; padding: 0px 7px;\"><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">联系人</span></p></td><td width=\"132\" style=\"border-top: none; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px; word-break: break-all;\">a3</td><td width=\"168\" style=\"border-top: none; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px; word-break: break-all;\"><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">联系电话（手机）</span></p></td><td width=\"168\" style=\"border-top: none; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px; word-break: break-all;\">a4</td></tr><tr style=\";page-break-inside:avoid;height:664px\"><td width=\"52\" style=\"border-right: 1px solid windowtext; border-bottom: 1px solid windowtext; border-left: 1px solid windowtext; border-image: initial; border-top: none; padding: 0px 7px;\"><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">整</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">改</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">情</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">&nbsp;</span></p><p style=\"text-align:center\"><span style=\"font-family: 宋体, SimSun; font-size: 18px;\">况</span></p></td><td width=\"543\" colspan=\"4\" valign=\"top\" style=\"border-top: none; border-left: none; border-bottom: 1px solid windowtext; border-right: 1px solid windowtext; padding: 0px 7px; word-break: break-all;\" class=\"conclass\">a5</td></tr></tbody></table><p><br/></p>";
            String str1 = str.replace("a1", agencyName);
            String str2 = str1.replace("a2", result.get("projname") != null ? result.get("projname") : "");
            String str3 = str2.replace("a3", result.get("leadername") != null ? result.get("leadername") : "");
            String str4 = str3.replace("a4", result.get("leaderphone") != null ? result.get("leaderphone") : "");
            String str5 = str4.replace("a5", result.get("feedbackcontent") != null ? result.get("feedbackcontent") : "");
            str = str5;
        } else {
            str = result.get("feedbackcontent");
        }
        config.put("rectifycontent", strc2);
        config.put("rectifytitle", result.get("rectifytitle"));
        config.put("feedbackcontent", str);
        return config;
    }

    /**
     * 表格查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(feedbackIndexDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //页面类型
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String bustype = (String) sqlmap.get("bustype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String type = (String) sqlmap.get("type");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String isSx = PerfUtil.getSystemSet("isSX");
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype=").append(bustype);
        sql.append(" and ").append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        //山西模式 项目支出   业务处下达到部门，部门下达到单位
        if (!StringUtil.isEmpty(isSx) && "1".equals(isSx) && "1".equals(bustype)) {
            sql.append(" and nvl(t.SXSTATE,0) = 1");
        }
        /*if (type != null && !type.isEmpty()){
            sql.append(" and t.type ='").append(type).append("'");
        }*/
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        //循环过滤条件
        String wfsql = " ";
        String[] str = null;
        if (workflow != null && !workflow.isEmpty()) {
            workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
            str = workflow.split(",");
            for (int i = 0; i < str.length; i++) {
                int index = str[i].indexOf("'");
                str[i] = str[i].substring(index + 1, str[i].length() - 1);
                wfsql += this.getWfSql(tabcode, str[i]);
                if (i < str.length - 1) {
                    wfsql += " or ";
                }
            }
            if (wfsql != null && !wfsql.isEmpty()) {
                sql.append("  and (").append(wfsql).append(")");
            }
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, feedbackIndexDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }


    public List<Map<String,Object>> getDataByGuid(HashMap<String,Object> params) {
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("projguid");
        String pro_code = (String) params.get("procode");
        String bustype = (String) params.get("bustype");
        String rectype = (String) params.get("rectype");
        String taskguid = (String) params.get("taskguid");
        StringBuffer sql = new StringBuffer();
        if (PerfUtil.getIsHbei() || "3".equals(bustype)){
            sql.append(" proguid = '").append(guid).append("' ");
        }else{
            sql.append(" pro_code = '").append(pro_code).append("' ");
        }
        if ("绩效监控".equals(rectype)){
            sql.append(" and taskguid ='").append(taskguid).append("'");
        }
        sql.append(" and rectype ='").append(rectype).append("' and wfstatus <> '011' order by createtime");
        return this.getDatas(tablecode, sql.toString(), null);
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }

}
