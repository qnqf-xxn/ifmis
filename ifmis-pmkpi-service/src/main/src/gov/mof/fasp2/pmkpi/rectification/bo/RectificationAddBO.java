package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddDAO;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationAddBO extends PmkpiBO {
    private RectificationAddDAO rectificationAddDAO;

    public void setRectificationAddDAO(RectificationAddDAO rectificationAddDAO) {
        this.rectificationAddDAO = rectificationAddDAO;
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getProjInfo(Map params) {
        String tablecode = (String) params.get("tablecode");
        String pro_code = (String) params.get("pro_code");
        String proguid = (String) params.get("proguid");
        String bustype = (String) params.get("bustype");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            PerfServiceFactory.getPmkpiDAO().setYearAndProvince(queryYear, queryProvince);
        }
        StringBuffer sql = new StringBuffer();
        if(PerfUtil.getIsHbei() || (bustype != null && "3".equals(bustype))){
            sql.append("guid = '").append(proguid).append("'");
        }else{
            sql.append("pro_code = '").append(pro_code).append("'");
        }
        return rectificationAddDAO.getDataMap(tablecode, sql.toString());
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getFinevaluation(String projguid) {
        StringBuffer sql = new StringBuffer();
        sql.append("guid = '").append(projguid).append("'");
        return rectificationAddDAO.getDataMap("v_perf_project_info", sql.toString());
    }

    /**
     * 整改通知详情
     * @return
     */
    public Map getRecityContent(Map params) {
        String taskstage = (String) params.get("taskstage");
        String proname = (String) params.get("proname");
        String agencyguid = (String) params.get("agencyguid");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            PerfServiceFactory.getPmkpiDAO().setYearAndProvince(queryYear, queryProvince);
        }
        Map result = new HashMap();
        List queryForList = rectificationAddDAO.queryForList("select name from pmkpi_fasp_t_pubagency where guid = '"+agencyguid+"'");
        String agencyName = "";
        if(queryForList.size() > 0){
            Map map = (Map) queryForList.get(0);
            agencyName = (String) map.get("name");
        }
        String isre = PerfUtil.getSystemSet("is_region");
        logger.debug("----整改通知详情----proname---["+proname+"]--proagency---["+agencyguid+"]----taskstage---["+taskstage+"]-");
        logger.debug("----整改通知详情----is_region---["+isre+"]---------");
        String strc = "";
        if("1".equals(isre)){
            strc = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">监控结果反馈书</span></p><p><span style=\"text-decoration:underline;\"><span style=\"font-family:仿宋_GB2312\">a1</span></span><span style=\"font-family:仿宋_GB2312\">：</span></p><p style=\"text-indent:43px\"><span style=\"font-family:仿宋_GB2312\">省财政厅对你部门（单位）<span style=\"text-decoration:underline;\">a2</span> 项目实施了a3重点监控，发现项目存在资金执行率或绩效目标完成程度滞后的情况。现请你部门（单位）尽快查明原因，提出整改措施，确保年度目标按期实现。相关整改情况请填写到系统中整改报告书内，并于收到反馈书10个工作日内提交。</span></p><p><br/></p>";
        } else if("2".equals(isre)){
            strc = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">监控结果反馈书</span></p><p><span style=\"text-decoration:underline;\"><span style=\"font-family:仿宋_GB2312\">a1</span></span><span style=\"font-family:仿宋_GB2312\">：</span></p><p style=\"text-indent:43px\"><span style=\"font-family:仿宋_GB2312\">市财政局对你部门（单位）<span style=\"text-decoration:underline;\">a2</span> 项目实施了a3重点监控，发现项目存在资金执行率或绩效目标完成程度滞后的情况。现请你部门（单位）尽快查明原因，提出整改措施，确保年度目标按期实现。相关整改情况请填写到系统中整改报告书内，并于收到反馈书10个工作日内提交。</span></p><p><br/></p>";
        } else {
            strc = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">监控结果反馈书</span></p><p><span style=\"text-decoration:underline;\"><span style=\"font-family:仿宋_GB2312\">a1</span></span><span style=\"font-family:仿宋_GB2312\">：</span></p><p style=\"text-indent:43px\"><span style=\"font-family:仿宋_GB2312\">区（县）财政局对你部门（单位）<span style=\"text-decoration:underline;\">a2</span> 项目实施了a3重点监控，发现项目存在资金执行率或绩效目标完成程度滞后的情况。现请你部门（单位）尽快查明原因，提出整改措施，确保年度目标按期实现。相关整改情况请填写到系统中整改报告书内，并于收到反馈书10个工作日内提交。</span></p><p><br/></p>";
        }
        String strc1 = strc.replace("a1", agencyName);
        String strc2 = strc1.replace("a2", proname);
        String strc3 = "";
        int value = 0;
        if(taskstage != null && !taskstage.isEmpty()){
            value = Integer.valueOf(taskstage).intValue();
        }
        logger.debug("----整改通知详情----strc1---["+strc1+"]---------");
        logger.debug("----整改通知详情----strc2---["+strc2+"]---------");
        logger.debug("----整改通知详情----value---["+value+"]---------");

        if(value <= 3){
            strc3 = strc2.replace("a3", "一季度");
        }else if(value > 3 && value <= 6){
            strc3 = strc2.replace("a3", "二季度");
        }if(value > 6 && value <= 9){
            strc3 = strc2.replace("a3", "三季度");
        }if(value > 9 && value <= 12){
            strc3 = strc2.replace("a3", "四季度");
        }
        logger.debug("----整改通知详情----strc3---["+strc3+"]---------");
        result.put("rectifycontent", strc3);
        return result;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        String projguid = (String) config.get("projguid");
        String bustype = (String) config.get("bustype");
        String type = (String)config.get("type");
        String workflow = (String) config.get("workflow");
        String rectifycontent = (String) config.get("rectifycontent");
        UserDTO user = SecureUtil.getCurrentUser();
        //获取项目信息
        Map projinfo = new HashMap();
        Map projMap = new HashMap();
        if (type != null && "FINEVALUATION".equals(type)){//财政重点评价
            projMap = getFinevaluation(projguid);
        }else if(type != null && "RANDOMCOMMENT".equals(type)){
            //projinfo = getProjInfo(projcode);
        }
        // 新增
        List<String> guidList=new ArrayList<String>();
        Map<String,Object> Sqlparam=new HashMap<String, Object>();
        String guidNew= StringUtil.createUUID();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        if (projinfo != null || projinfo.size()>0 || projMap != null || projMap.size()>0){
            Sqlparam.put("guid", guidNew);
            Sqlparam.put("state", "0");
            Sqlparam.put("createuid", user.getGuid());
            Sqlparam.put("createuname", user.getName());
            Sqlparam.put("createtime", StringUtil.getDateBySimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
            Sqlparam.put("delstatus", "0");
            Sqlparam.put("province", user.getProvince());
            Sqlparam.put("year", CommonUtil.getYear());
            Sqlparam.put("proguid", projguid);
            Sqlparam.put("rectifycontent", rectifycontent);
            Sqlparam.put("creater", user.getName());
            //财政重点评价(组织评价机构)
            Sqlparam.put("evalmeach", ("FINEVALUATION").equals(type)? projMap.get("evalmeach"):null);
//            Sqlparam.put("rectifytitle", rectifytitle);
//            Sqlparam.put("rectifycontent", taskcontent);
//            Sqlparam.put("orgid", orgid);
            Sqlparam.put("projname", ("RANDOMCOMMENT").equals(type)? projinfo.get("proname"):projMap.get("projname"));
            if (type != null && ("RANDOMCOMMENT").equals(type)){
                Sqlparam.put("projcode", projinfo.get("procode"));
            }
            Sqlparam.put("agencyguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("agencyguid"):projMap.get("agencyguid"));
            Sqlparam.put("finintorgguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("finintorgguid"):projMap.get("finintorgguid"));
            Sqlparam.put("manage_mof_dep_code", ("RANDOMCOMMENT").equals(type)? projinfo.get("manage_mof_dep_code"):projMap.get("manage_mof_dep_code"));
            Sqlparam.put("bustype", bustype);
            Sqlparam.put("type", type);
            Sqlparam.put("status", "1");
            //isfinal=1(已终审) isfinal = 2(未终审)
            Sqlparam.put("isfinal", "2");
            //保存数据
            rectificationAddDAO.save(Sqlparam, "PERF_T_RECTIFY");
            guidList.add(guidNew);
            l.add(Sqlparam);
//            this.workflow("create","D1BCFBC977C77FA061E449DADBE6F773", "", "PERF_T_RECTIFY", l);
            PerfServiceFactory.getIWorkflowService().createProcess(workflow, guidList);
        }
        return config;
    }

    /**
     * 反馈信息详情
     * @param config
     * @return
     */
    public Map getText(Map config) {
        String guid = (String)config.get("mainguid");
        String projguid = (String)config.get("projguid");
        Map<String,String> result=new HashMap<String, String>();
        String str = "";
        String agencyName = "";
        String finintorgName = "";
        if (guid != null && !guid.isEmpty()) {
            String sql ="select t.rectifycontent,t.rectifytitle,t.feedbackcontent,t.projname,t.agencyguid,t.finintorgguid,t.type from  PERF_T_RECTIFY t where guid='"+guid+"' ";
            List list = rectificationAddDAO.queryForList(sql);
            if(list!=null && list.size()>0){
                result = (Map)list.get(0);
            }
            if (result == null || result.size() <= 0){
                result = getFinevaluation(projguid);
            }
            List queryForList = rectificationAddDAO.queryForList("select name from pmkpi_fasp_t_pubagency where guid = '"+result.get("agencyguid")+"'");
            if(queryForList.size() > 0){
                Map map = (Map) queryForList.get(0);
                agencyName = (String) map.get("name");
            }
            List finintorgList = rectificationAddDAO.queryForList("select name from fasp_t_pubdepartment where guid = '"+result.get("finintorgguid")+"'");
            if(finintorgList.size() > 0){
                Map map = (Map) finintorgList.get(0);
                finintorgName = (String) map.get("name");
            }
            if(result.get("rectifycontent") == null || result.get("rectifycontent").isEmpty()){
                str = "<p style=\"text-align: center;\"><span style=\"font-size: 29px; font-family: 方正小标宋简体;\">省级部门绩效评价结果反馈书</span></p><table align=\"center\"><tbody><tr class=\"firstRow\" style=\"height: 40px;\"><td width=\"111\" style=\"border-color: windowtext; padding: 0px 7px;\"><p style=\"line-height: 17px;\"><span style=\"font-family: 仿宋_GB2312;\">评价项目</span></p></td><td width=\"499\" colspan=\"3\" style=\"border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0px 7px; word-break: break-all;\">a1</td></tr><tr style=\"height: 40px;\"><td width=\"111\" style=\"border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0px 7px;\"><p style=\"line-height: 17px;\"><span style=\"font-family: 仿宋_GB2312;\">评价组织机构</span></p></td><td width=\"171\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px; word-break: break-all;\">a2</td><td width=\"112\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><p style=\"text-align: center; line-height: 17px;\"><span style=\"font-family: 仿宋_GB2312;\">项目主管部门</span></p></td><td width=\"216\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px; word-break: break-all;\">a3</td></tr><tr style=\"height: 40px;\"><td width=\"111\" style=\"border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0px 7px;\"><p style=\"line-height: 17px;\"><span style=\"font-family: 仿宋_GB2312;\">评价机构</span></p></td><td width=\"171\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px; word-break: break-all;\"><br/></td><td width=\"112\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><p style=\"text-align: center; line-height: 17px;\"><span style=\"font-family: 仿宋_GB2312;\">评价时间</span></p></td><td width=\"216\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><br/></td></tr><tr style=\"break-inside: avoid; height: 85px;\"><td width=\"111\" style=\"border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0px 7px;\"><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">主要</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">绩效</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">情况</span></p></td><td width=\"499\" colspan=\"3\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><br/></td></tr><tr style=\"break-inside: avoid; height: 177px;\"><td width=\"111\" style=\"border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0px 7px;\"><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">主要</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">问题</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">与</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">建议</span></p></td><td width=\"499\" colspan=\"3\" valign=\"top\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><br/></td></tr><tr style=\"break-inside: avoid; height: 281px;\"><td width=\"111\" style=\"border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0px 7px;\"><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">评价</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">组织</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">机构</span></p><p style=\"text-align: center;\"><span style=\"font-family: 仿宋_GB2312;\">意见</span></p></td><td width=\"499\" colspan=\"3\" style=\"border-top: none; border-left: none; border-bottom-color: windowtext; border-right-color: windowtext; padding: 0px 7px;\"><p style=\"text-indent: 31px;\"><span style=\"font-family: 仿宋_GB2312;\">被评价单位（部门）要针对存在的问题及评价提出的相关建议，积极改进、完善，并将整改落实材料和整改报告书于XXXX年XX月XX日前反馈省财政厅。</span></p><p><span style=\"font-family: 仿宋_GB2312;\">&nbsp;</span></p><p style=\"text-align: right;\"><span style=\"font-family: 仿宋_GB2312;\">XXXX</span><span style=\"font-family: 仿宋_GB2312;\">年XX月XX日</span></p></td></tr></tbody></table><p>&nbsp;</p><p><br/></p><p><br/></p><p><br/></p>";
                String str1 = str.replace("a2", agencyName);
                String str2 = str1.replace("a1", result.get("projname") != null ? result.get("projname") : "");
                String str3 = str2.replace("a3", finintorgName);
                str = str3;
          } else {
                str = result.get("rectifycontent");
            }
        }
        config.put("rectifycontent", str);
        return config;
    }
}
