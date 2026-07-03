package gov.mof.fasp2.pmkpi.evaluation.financial.word;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinWordBO extends PmkpiBO {
    private FinWordDAO FinWordDAO;

    public void setFinWordDAO(FinWordDAO FinWordDAO) {
        this.FinWordDAO = FinWordDAO;
    }

    /**
     * 整改通知详情
     * @param proname
     * @param proagency
     * @return
     */
    public Map getWordContent(String type,String proname,String proagency) {
        Map result = new HashMap();
        List queryForList = FinWordDAO.queryForList("select name from pmkpi_fasp_t_pubagency where guid = '"+proagency+"'");
        String agencyName = "";
        if(queryForList.size() > 0){
            Map map = (Map) queryForList.get(0);
            agencyName = (String) map.get("name");
        }
        String strc = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">监控结果反馈书</span></p><p><span style=\"text-decoration:underline;\"><span style=\"font-family:仿宋_GB2312\">a1</span></span><span style=\"font-family:仿宋_GB2312\">：</span></p><p style=\"text-indent:43px\"><span style=\"font-family:仿宋_GB2312\">省财政厅对你部门（单位）<span style=\"text-decoration:underline;\">a2</span> 项目实施了三季度重点监控，发现项目存在资金执行率或绩效目标完成程度滞后的情况。现请你部门尽快查明原因，提出整改措施，确保年度目标按期实现。相关整改情况请填写到系统中整改报告书内，并与收到反馈书10个工作日内提交。</span></p><p><br/></p>";
        String strc1 = strc.replace("a1", agencyName);
        String strc2 = strc1.replace("a2", proname);

        result.put("finword", strc2);
        return result;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        String guid = (String) config.get("mainguid");
        String type = (String) config.get("type");
        String backcontent = (String) config.get("backcontent");
        Map<String,Object> backMap = new HashMap<String, Object>();
        if(guid != null && !guid.isEmpty()){
            Map map = null;
            List<Map<String,Object>> datas = FinWordDAO.getDatas("V_PERF_T_FINEVALUATION", "t.guid = '"+guid+"' ","");
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                if("1".equals(type)){
                    map.put("finword", backcontent);
                } else if("2".equals(type)){
                    map.put("finreport", backcontent);
                }
                FinWordDAO.update(map, "V_PERF_T_FINEVALUATION");
            }
            backMap.put("success", true);
        }
        return backMap;
    }

    /**
     * 模板详情
     * @param config
     * @return
     */
    public Map getText(Map config) {
        String type = (String)config.get("type");
        String guid = (String)config.get("mainguid");
        String proguid = (String)config.get("proguid");
        String procode = (String)config.get("procode");
        Map<String,String> map=new HashMap<String, String>();
        String finword = "<p style=\"text-align: center;\"><span style=\"font-family: 方正小标宋简体; font-size: 29px;\">预算绩效评价工作方案</span></p><p style=\"text-align: left;\"><span style=\"font-size: 20px;\">一、评价背景和目的</span></p><p style=\"text-align: left;\"><span style=\"font-size: 16px;\">明确评价的目的、依据和工作目标</span><br/><span style=\"font-size: 20px;\">二、评价重点</span><br/>明确评价方向、主要内容和重点<br/><span style=\"font-size: 20px;\">三、评价方法</span><br/>明确拟采用的主要评价方法以及支撑该方法需要的材料和数据，根据评价对象和绩效目标内容明确指标体系</p><p style=\"text-align: left;\"><span style=\"font-size: 18px;\"><span style=\"font-size: 20px;\">四、评价组织安排</span></span><br/>结合评价方法，明确评价阶段性工作安排、工作要求及具体时间进度安排<br/><span style=\"font-size: 18px;\"><span style=\"font-size: 20px;\">五、评价人员及措施保障</span></span><br/>明确参与评价的相关人员和职责；明确评价工作的保障措施等</p>";
        String finreport = "<p style=\"text-align: left; margin-top: 25px;\"><span style=\"font-family:方正小标宋简体\"><span style=\"font-size: 29px;\">浙江省项目支出绩效评价报告</span></span></p><p style=\"text-align: left; line-height: 2em; margin-top: 25px;\"><span style=\"font-size: 24px;\">&nbsp;&nbsp;&nbsp;&nbsp;项目名称：</span><span style=\"font-size: 24px; text-decoration: none;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;a1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 24px;\"><br/>&nbsp;&nbsp;&nbsp;&nbsp;项目单位：</span><span style=\"font-size: 24px; text-decoration: none;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;a2&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=\"font-size: 24px;\"> &nbsp; &nbsp; &nbsp;<br/>&nbsp;&nbsp;&nbsp;&nbsp;主管部门：&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 24px; text-decoration: none;\">&nbsp; &nbsp;a3&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style=\"font-size: 24px;\"><br/>&nbsp;&nbsp;&nbsp;&nbsp;评价类型：<br/>&nbsp;&nbsp;&nbsp;&nbsp;评价方式：<br/>&nbsp;&nbsp;&nbsp;&nbsp;评价机构：<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp; &nbsp;月&nbsp; &nbsp;日<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;浙江省财政厅（制）</span></p>";
        String sql = "select * from V_PERF_T_FINEVALUATION where guid = '"+guid+"'";
        List list = FinWordDAO.queryForList(sql);
        if(list!=null && list.size()>0){
            map = (Map)list.get(0);
            String word = (String) map.get("finword");
            String report = (String) map.get("finreport");
            if("1".equals(type) && word != null && word != ""){
                finword = (String) map.get("finword");
            }else if("2".equals(type) && report != null && report != ""){
                finreport = (String) map.get("finreport");
            }else if("2".equals(type) && report == null && report != ""){
                List<Map<String,Object>> prolist = FinWordDAO.getDatas("v_perf_t_finevaluation", "t.pro_code = '"+procode+"' ","");
                if(prolist!=null && prolist.size()>0){
                    Map promap = prolist.get(0);
                    String agencyName = "";
                    String finintorgName = "";
                    String projname = (String)promap.get("name");
                    String agencyguid = (String)promap.get("agencyguid");
                    String dept = (String)promap.get("finintorgguid");
                    List queryForList = FinWordDAO.queryForList("select name from pmkpi_fasp_t_pubagency where guid = '"+agencyguid+"'");
                    if(queryForList.size() > 0){
                        Map agencymap = (Map) queryForList.get(0);
                        agencyName = (String) agencymap.get("name");
                    }
                    List finintorgList = FinWordDAO.queryForList("select name from fasp_t_pubdepartment where guid = '"+dept+"'");
                    if(finintorgList.size() > 0){
                        Map deptmap = (Map) finintorgList.get(0);
                        finintorgName = (String) deptmap.get("name");
                    }
                    String str1 = finreport.replace("a2", agencyName);
                    String str2 = str1.replace("a1", projname);
                    String str3 = str2.replace("a3", finintorgName);
                    finreport = str3;
                }
            }
        }
        config.put("finword",finword);
        config.put("finreport",finreport);
        return config;
    }
}
