package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.goal;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;


public class ApprovalGoalBO extends PmkpiBO {
    /**
     * prjIndexDAO.
     */
    private ApprovalGoalDAO approvalGoalDAO;
    /**
     * 注入dao.
     * @param approvalGoalDAO --approvalGoalDAO.
     * @throws
     */
    public void setApprovalGoalDAO(ApprovalGoalDAO approvalGoalDAO) {
        this.approvalGoalDAO = approvalGoalDAO;
    }


    /**
     * 查询页面编辑区的注册字段
     * @param uikey
     * @return
     */
    public List<Map<String, Object>> getEditfrom(String uikey){
        return  approvalGoalDAO.getEditfrom(uikey);
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getAllGoal(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String selectbillguid = (String) params.get("selectbillguid"); //调整前的guid
        String adjadd = (String) params.get("adjadd"); //是否调整
        String tempcode = (String) params.get("tempcode");
        String procode = (String) params.get("procode");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String yearflag = "0";
        if ("1".equals(showtab)){
            tempfilter = new String[]{"1","0"};
        } else if ("2".equals(showtab)){
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        List<Map<String, Object>> goals = null;
        if(adjadd != null && "1".equals(adjadd)){
            goals = approvalGoalDAO.getGoalsByFilter(proguid, procode, tempfilter);
            if(goals.size()<=0){
                goals = approvalGoalDAO.getGoalsByFilter(selectbillguid, procode, tempfilter);
                //调整项目查询不存在数据，重新生成guid，解决项目库嵌套保存不刷新页面
                String version = PerfUtil.getServerTimeStamp();
                for (Map<String, Object> map : goals) {
                    String guid = this.getCreateguid();
                    yearflag = (String) map.get("yearflag");
                    params.put("yearflag", yearflag);
                    map.put("guid", guid);
                    map.put("kpi_per_id", guid);
                    map.put("version", version);
                    if ("1".equals(yearflag)) {
                        map.put("version_name", "项目总体绩效目标调整_"+version);
                    } else if ("0".equals(yearflag)) {
                        map.put("version_name", "项目年度绩效目标调整_"+version);
                    }
                }
            }
        }else{
            goals = approvalGoalDAO.getGoalsByFilter(proguid, procode, tempfilter);
        }
        if(goals.size() <= 0 && (tempcode != null && !tempcode.isEmpty())){
            //如果查出来的指标数据为空，则获取模板中的指标数据。
            goals = approvalGoalDAO.findGoalByTempCode(proguid,tempcode,tempfilter);
            for (Map map : goals) {
                String guid = this.getCreateguid();
                map.put("guid",guid);
            }
        }
        if (goals != null && goals.size() > 0) {
            for (Map<String, Object> map : goals) {
                yearflag = (String) map.get("yearflag");
                this.setData(map);
                params.put("yearflag", yearflag);
                if (yearflag != null && !"0".equals(yearflag)) {
                    yearsMap.put("#total", map);
                } else {
                    yearsMap.put("#year", map);
                }
            }
            //不存在年度目标数据
            if (yearsMap.size() == 1 && "1".equals(showtab)) {
                setGoalData(params, yearsMap);
            }
        } else {
            setGoalData(params, yearsMap);
        }
        return yearsMap;
    }

    public void setData(Map<String, Object> params){
        params.put("creater", SecureUtil.getCurrentUserID());
        params.put("province", SecureUtil.getUserSelectProvince());
        params.put("year", CommonUtil.getYear());
        params.put("createtime", PerfUtil.getServerTimeStamp());
        params.put("kpi_per_id", params.get("guid"));
        params.put("create_time", PerfUtil.getServerTimeStamp());
        params.put("mof_div_code", SecureUtil.getUserSelectProvince());
        this.getBasMap(params, "add");
    }

    public void setGoalData(Map<String, Object> params, Map<String, Object> yearsMap){
        Map<String, Object> map = new HashMap<>();
        String showtab = (String) params.get("showtab");
        String proguid = (String) params.get("proguid");
        String adjadd = (String) params.get("adjadd");
        String saveAgency = (String) params.get("saveAgency");
        String yearflag = (String) params.get("yearflag");
        String version = PerfUtil.getServerTimeStamp();
        //数据不存在，内置中期数据,项目库保存不刷新页面
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (yearflag == null || (yearflag != null && "0".equals(yearflag)))) {
            map.put("mainguid", proguid);
            if ("1".equals(adjadd)) {//调整
                map.put("version", version);
                map.put("version_name", "项目总体绩效目标调整_"+version);
            } else {
                map.put("version_name", "项目总体绩效目标录入");
                map.put("version", version);
            }
            map.put("guid", this.getCreateguid());
            map.put("agencyguid", saveAgency);
            map.put("mainguid", proguid);
            map.put("agency_code", saveAgency);
            map.put("yearflag","1");
            this.setData(map);
            yearsMap.put("#total", map);
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab)) && (yearflag == null || (yearflag != null && "1".equals(yearflag)))) {
            map = new HashMap<>();
            if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                map.put("version", version);
                map.put("version_name", "项目年度绩效目标调整_"+version);
            } else {
                map.put("version_name", "项目年度绩效目标录入");
                map.put("version", version);
            }
            map.put("mainguid", proguid);
            map.put("guid", this.getCreateguid());
            map.put("agencyguid", saveAgency);
            map.put("agency_code", saveAgency);
            map.put("yearflag","0");
            map.put("guid", this.getCreateguid());
            this.setData(map);
            yearsMap.put("#year", map);
        }
    }

    public List<Map<String, Object>> getGoal(String proguid) {
        ArrayList<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
        //查询项目信息
        List<Map<String, Object>> prolist =  approvalGoalDAO.getDatas("pm_project_info", " guid='" + proguid + "'", null);
        String pro_code = null;
        if(prolist != null && prolist.size()>0){
            pro_code = prolist.get(0).get("pro_code").toString();
        }
        //中期绩效目标
        List<Map<String, Object>> zqlist =  approvalGoalDAO.getDatas("pm_perf_goal_info", " mainguid='" + proguid
                + "' and nvl(yearflag,'0') = '1' and is_deleted=2 and is_backup=2 and province='" + CommonUtil.getProvince() + "'", null);
        //年度绩效目标
        List<Map<String, Object>> ndlist =  approvalGoalDAO.getDatas("v_pm_perf_goal_info", " pro_code='" + pro_code + "' and nvl(yearflag,'3') = '0'", null);
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list.addAll(zqlist);
        list.addAll(ndlist);
        Map<String, Object> resultMap = new HashMap<>();
        if (list != null && list.size()>0){
            resultMap.putAll(list.get(0));
            resultMap.put("kpi_target","");
            resultMap.put("zqgoal","");
            for (int i = 0;i<list.size();i++){
                Map<String, Object> map = list.get(i);
                String yearflag = String.valueOf(map.get("yearflag"));
                if (!StringUtil.isEmpty(yearflag)){
                    String kpi_target = String.valueOf(map.get("kpi_target"));
                    if ("0".equals(yearflag)) {
                        resultMap.put("kpi_target", kpi_target);
                    }else if("1".equals(yearflag)){
                        resultMap.put("zqgoal", kpi_target);
                    }
                }
            }
            resultList.add(resultMap);
        }
        return resultList;

    }
}