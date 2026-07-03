package gov.mof.fasp2.pmkpi.perfprogram.goal;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:23
 */

public class PrjIndexBO extends PmkpiBO {
    /**
     * prjIndexDAO.
     */
    private PrjIndexDAO prjIndexDAO;
    /**
     * 注入dao.
     * @param prjIndexDAO --prjIndexDAO.
     * @throws
     */
    public void setPrjIndexDAO(PrjIndexDAO prjIndexDAO) {
        this.prjIndexDAO = prjIndexDAO;
    }

    /**
     * 获取目标数据
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByGuid(String proguid,String pdmsave){
        logger.debug("--------pdmsave保存标识---------"+ pdmsave);
        String tablecode = "v_pm_perf_goal_info";
        if ("20".equals(pdmsave)){ //项目库暂存草稿
            tablecode = "V_PM_PERF_GOAL_TEMP";
        }
        return prjIndexDAO.getDatas(tablecode, " mainguid='" + proguid + "'", null);
    }

    /**
     * 获取年度目标数据
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByCode(String proguid,String pdmsave){
        logger.debug("--------pdmsave保存标识---------"+ pdmsave);
        String tablecode = "v_pm_perf_goal_info";
        if ("20".equals(pdmsave)){ //项目库暂存草稿
            tablecode = "V_PM_PERF_GOAL_TEMP";
        }
        //查询项目信息
        List<Map<String, Object>> prolist =  prjIndexDAO.getDatas("pm_project_info", " guid='" + proguid + "'", null);
        String pro_code = null;
        if(prolist != null && prolist.size()>0){
            pro_code = prolist.get(0).get("pro_code").toString();
        }
        //年度绩效目标
        return prjIndexDAO.getDatas(tablecode, " pro_code='" + pro_code + "' and yearflag = '0' and is_deleted = 2", null);
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        String showtab = (String) params.get("showtab");
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");//项目名称
        String agency_name = (String) params.get("agency_name"); //一级项目的单位存放名称从前台获取名称
        String pdmsave = (String) params.get("pdmsave"); // 21为暂存,其他为保存
        String isedittotal = (String) params.get("isedittotal");
        String midsave = (String) params.get("midsave"); // 是否草稿页面保存，接口获取
        String adjadd = (String) params.get("adjadd");
        String isnzzj = (String) params.get("isnzzj");//是否年中追加
        String isperform = (String) params.get("isperform"); // 是否特殊绩效
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String tablecode = "pm_perf_goal_info";
        Map<String, Object> goaldata = (Map<String, Object>) params.get("goaldata"); //多页签的数据
        List<Map<String, Object>> addlist = new ArrayList<>(); //新增目标集合
        List<Map<String, Object>> uplist = new ArrayList<>(); //修改目标集合
        List<Map<String, Object>> goallist = new ArrayList<>(); //目标集合
        // 多次保存的情况，特殊绩效每次取最新保存入库，标注：总体or年度
        String flag = "2";
        Map<String, Object> goalMap = null;
        //草稿页面保存并退出/送审，如果存在业务数据，先删除垃圾数据（保存入业务表如果项目库被拦截，绩效没问题绩效数据会入库，产生垃圾数据，删除数据后进行新增）
        if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {
            logger.info("-----------目标草稿删除----------midsave=" + midsave);
            String wheresql = " mainguid='" + proguid + "' and province = '"+CommonUtil.getProvince()+"'";
            prjIndexDAO.updateDatasIsDelete(tablecode, wheresql);
        }
        if (("1".equals(showtab) || "2".equals(showtab)) && (isedittotal == null || !"1".equals(isedittotal))) {
            Map<String, Object> totalmap = (Map<String, Object>) goaldata.get("#total");
            String guid = (String) totalmap.get("guid");
            // 浙江历史项目迁移后的目标指标数据有缺失，默认新增一条
            if(guid == null || guid.length() == 0 || "".equals(guid)){
                guid = this.getCreateguid();
                totalmap.put("guid", guid);
            }
            if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                String newguid =this.getCreateguid();
                totalmap.put("guid",newguid); //只保存草稿时重新生成guid
                totalmap.put("kpi_per_id",newguid);
            }
            totalmap.put("pro_code", procode);
            totalmap.put("pro_name", pro_name);
            totalmap.put("agencyguid", saveAgency);
            totalmap.put("agency_code", saveAgency);
            totalmap.put("mainguid", proguid);
            totalmap.put("yearflag", "1");
            String kpi_target = (String) totalmap.get("kpi_target");
            if(kpi_target == null || kpi_target.isEmpty()){
                totalmap.put("kpi_target", "无目标");
            }
            goalMap = prjIndexDAO.getDataMap(tablecode, "guid='" + guid
                    + "' and is_deleted=2 and is_backup = 2 and province = '"+CommonUtil.getProvince()+"' and sub_mof_div_code is null ");
            if (goalMap.isEmpty() || (pdmsave!= null  && "21".equals(pdmsave))) {
                totalmap.put("mainguid", proguid);
                totalmap.put("agencyguid", saveAgency);
                totalmap.put("agency_code", saveAgency);
                totalmap.put("yearflag","1");
                totalmap.put("pro_code", procode);
                totalmap.put("pro_name", pro_name);
                totalmap.put("agency_name",agency_name);
                if ("1".equals(adjadd)) {//调整
                    totalmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                }
                if ("true".equals(isnzzj)) {//年中追加
                    totalmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
                }
                this.setData(totalmap);
                goalMap = totalmap;
                addlist.add(goalMap);
                flag = "1";
            } else {
                totalmap.put("update_time", PerfUtil.getServerTimeStamp());
                totalmap.put("updatetime", PerfUtil.getServerTimeStamp());
                goalMap.putAll(totalmap);
                uplist.add(goalMap);
            }
            goallist.add(goalMap);
        }
        if ("1".equals(showtab) || "3".equals(showtab)) {
            Map<String, Object> yearmap = (Map<String, Object>) goaldata.get("#year");
            String guid = (String) yearmap.get("guid");
            if(guid == null || guid.length() == 0 || "".equals(guid)){
                guid = this.getCreateguid();
                yearmap.put("guid", guid);
            }
            if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                String newguid =this.getCreateguid();
                yearmap.put("guid",newguid); //只保存草稿时重新生成guid
                yearmap.put("kpi_per_id",newguid);
            }
            yearmap.put("pro_code", procode);
            yearmap.put("pro_name", pro_name);
            yearmap.put("agencyguid", saveAgency);
            yearmap.put("agency_code", saveAgency);
            yearmap.put("mainguid", proguid);
            yearmap.put("yearflag", "0");
            String kpi_target = (String) yearmap.get("kpi_target");
            if(kpi_target == null || kpi_target.isEmpty()){
                yearmap.put("kpi_target", "无目标");
            }
            goalMap = prjIndexDAO.getDataMap(tablecode, "guid='" + guid
                    + "' and is_deleted=2 and is_backup = 2 and province = '"+CommonUtil.getProvince()+ "' and sub_mof_div_code is null ");
            if ("1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
                yearmap.put("is_adj", 1);//是否调整终审，1调整申报 2调整终审，储备阶段为2
            }
            if (goalMap.isEmpty() || ("21".equals(pdmsave))) {
                yearmap.put("mainguid", proguid);
                yearmap.put("agencyguid", saveAgency);
                yearmap.put("agency_code", saveAgency);
                yearmap.put("yearflag","0");
                yearmap.put("pro_code", procode);
                yearmap.put("pro_name", pro_name);
                yearmap.put("agency_name",agency_name);
                if ("1".equals(adjadd)) {//调整
                    yearmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                }
                if ("true".equals(isnzzj)) {//年中追加
                    yearmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
                }
                this.setData(yearmap);
                goalMap = yearmap;
                addlist.add(goalMap);
                flag = "0";
            } else {
                yearmap.put("update_time", PerfUtil.getServerTimeStamp());
                yearmap.put("updatetime", PerfUtil.getServerTimeStamp());
                goalMap.putAll(yearmap);
                uplist.add(goalMap);
            }
            goallist.add(goalMap);
        }
        Map<String, Object> returnMap = this.checkColLength(goallist, PerfConstant.PMKPI_VPM_GOAL_INFO); //字段长度校验-草稿表校验
        if (!"21".equals(pdmsave)) {
            returnMap.putAll(prjIndexDAO.checkTacleColsIsNull(tablecode, goallist)); //非空验证
        }
        logger.info("项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
        if (!returnMap.isEmpty()) {
            return returnMap;
        }
        if (pdmsave != null && "21".equals(pdmsave)) { //暂存
            //删除暂存表
            prjIndexDAO.updateIsDeleteDatas("V_PM_PERF_GOAL_TEMP", " mainguid = '"+proguid+"'"); //删除目标暂存表
            for (Map m : goallist) {
                String newguid =this.getCreateguid();
                m.put("guid",newguid); //只保存草稿时重新生成guid
                m.put("kpi_per_id",newguid);
            }
            prjIndexDAO.saveAll(goallist, "V_PM_PERF_GOAL_TEMP"); //目标暂存表
            Map<String, Object> tempMap = new HashMap<String, Object>();
            tempMap.put("success", true);
            return tempMap;
        }
        if (addlist.size()>0) {
            if("1".equals(isperform) && "1".equals(isZJ)){
                logger.debug("-----删除历史特殊绩效指标：" +procode+ "---"+proguid+"---" +flag);
                String delsql = null;
                if("0".equals(flag)){
                    delsql = "t.pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ";
//                    prjIndexDAO.delDatas(tablecode,"t.pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ");
                } else if("1".equals(flag)){
                    delsql = "t.mainguid = '"+proguid+"' and t.yearflag = '"+flag+"' ";
//                    prjIndexDAO.delDatas(tablecode,"t.mainguid = '"+proguid+"' and t.yearflag = '"+flag+"' ");
                }
                prjIndexDAO.updateDatasIsDelete(tablecode, delsql);
                //prjIndexDAO.updateDatas(tablecode," set t.is_deleted = '1' where pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ");
            }
            logger.debug("-----新增目标数据：" +addlist.toString());
            prjIndexDAO.saveAll(addlist, tablecode); //目标暂存表
        }
        if (uplist.size()>0) {
            logger.debug("-----修改目标数据：" +uplist.toString());
            List<String> cols = new ArrayList<String>(uplist.get(0).keySet());
            cols.remove("province");
            cols.remove("year");
            prjIndexDAO.updateAllByPK(cols, uplist,"guid", tablecode);
        }
        return this.auditdefine(goallist, busguid,"perf", null);
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getAllGoal(Map<String, Object> params) throws AppException {
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            prjIndexDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String pdmsave = (String) params.get("pdmsave"); //保存还是暂存区分20 暂存
        String selectbillguid = (String) params.get("selectbillguid"); //调整前的guid
        String adjadd = (String) params.get("adjadd"); //是否调整
        String tempcode = (String) params.get("tempcode");
        String procode = (String) params.get("procode");
        String isperform = (String)params.get("isperform");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String yearflag = "0";
        String showall = (String) params.get("showall");
        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        logger.debug("-------------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            String dataprovince = (String) params.get("dataprovince");//项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            prjIndexDAO.setYearAndProvince(loginyear,dataprovince);
        }
        if ("1".equals(showtab)){
            tempfilter = new String[]{"1","0"};
        } else if ("2".equals(showtab)){
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        List<Map<String, Object>> goals = null;
        if ((isperform != null) && ("1".equals(isperform)) && ("1".equals(isZJ))) {
            this.logger.debug("---------------获取特殊绩效目标------------");
            goals = this.prjIndexDAO.getSpecialGoal();
        } else if (adjadd != null && "1".equals(adjadd)){
            //调整查询调整的数据
            goals = prjIndexDAO.getGoalsByFilter(proguid, procode, pdmsave, tempfilter, null);
            //调整数据不存在，查询调整前数据
            if(goals.size() == 0 || (!PerfUtil.getProgramIsyear() && showtab.equals("1"))){ //当安徽提出总体+年度一起申报，年度只是个入口，项目复制（单位）不应计算年度，顾修改。
                goals = prjIndexDAO.getGoalsByFilter(selectbillguid, procode, pdmsave, tempfilter, null);
                //调整项目查询不存在数据，重新生成guid，解决项目库嵌套保存不刷新页面
                for (Map<String, Object> map : goals) {
                    String guid = this.getCreateguid();
                    yearflag = (String) map.get("yearflag");
                    params.put("yearflag", yearflag);
                    map.put("guid", guid);
                    map.put("kpi_per_id", guid);
                    map.put("updatetime", PerfUtil.getServerTimeStamp());
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                }
            }
        } else {
            goals = prjIndexDAO.getGoalsByFilter(proguid, procode, pdmsave, tempfilter, null);
        }
        if(goals.size() <= 0 && (tempcode != null && !tempcode.isEmpty())){
            //如果查出来的指标数据为空，则获取模板中的指标数据。
            goals = prjIndexDAO.findGoalByTempCode(proguid,tempcode,tempfilter);
            for (Map map : goals) {
                String guid = this.getCreateguid();
                map.put("guid",guid);
            }
        }
        if (goals != null && goals.size() > 0) {
            for (Map<String, Object> map : goals) {
                yearflag = (String) map.get("yearflag");
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

    /**
     * 初始化目标规范，只适用于新增数据 rowtype = add
     * @param tempMap
     */
    public void setData(Map<String, Object> tempMap){
        this.getBasMap(tempMap,"add");
        tempMap.put("is_last_inst",2);//是否终审
    }

    /**
     * 获取项目名称和单位名称
     * @param params
     */
    public void setProAgencyName(Map<String, Object> params){
        String procode = (String) params.get("procode"); //项目编码
        String proguid = (String) (StringUtil.isEmpty((String) params.get("projguid")) ? params.get("proguid") : params.get("projguid"));
        String pro_name = (String) params.get("pro_name");//项目名称
        String isnzzj = (String) params.get("isnzzj");//是否年中追加
        String adjadd = (String) params.get("adjadd");
        String selectbillguid = (String) params.get("selectbillguid");
        if (StringUtil.isEmpty(procode) || StringUtil.isEmpty(pro_name)) {
            Map<String, Object> proMap = null;
            String wheresql = "";
            if ("true".equals(isnzzj)) {
                wheresql = "t.pro_code = '" + procode + "'";
                proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            } else {
                wheresql = "t.guid = '" + proguid + "'";
                proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, wheresql);
                if ("1".equals(adjadd) && proMap.isEmpty() && !StringUtil.isEmpty(selectbillguid)) {//不存在查询调整前项目
                    wheresql = "guid='" + selectbillguid + "'";
                    proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
                }
            }
            if (!proMap.isEmpty()) {
                procode = (String) proMap.get("pro_code");
                pro_name = (String) proMap.get("pro_name");
                String saveAgency = (String) proMap.get("agency_code");
                String agency_name = (String) proMap.get("agency_name");
                params.put("procode", procode);
                params.put("pro_name", pro_name);
                params.put("agency_name", agency_name);
                params.put("saveAgency", saveAgency);
            }
        }
    }

    public void setGoalData(Map<String, Object> params, Map<String, Object> yearsMap){
        Map<String, Object> map = new HashMap<>();
        String showtab = (String) params.get("showtab");
        String proguid = (String) params.get("proguid");
        String adjadd = (String) params.get("adjadd");
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String yearflag = (String) params.get("yearflag");
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");//项目名称
        //数据不存在，内置中期数据,项目库保存不刷新页面
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (yearflag == null || (yearflag != null && "0".equals(yearflag)))) {
            map.put("guid", this.getCreateguid());
            map.put("mainguid", proguid);
            map.put("agencyguid", saveAgency);
            map.put("agency_code", saveAgency);
            map.put("yearflag","1");
            map.put("pro_code", procode);
            map.put("pro_name", pro_name);
            this.setData(map);
            if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            }
            yearsMap.put("#total", map);
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab)) && (yearflag == null || (yearflag != null && "1".equals(yearflag)))) {
            map = new HashMap<>();
            map.put("guid", this.getCreateguid());
            map.put("mainguid", proguid);
            map.put("agencyguid", saveAgency);
            map.put("agency_code", saveAgency);
            map.put("yearflag","0");
            map.put("pro_code", procode);
            map.put("pro_name", pro_name);
            this.setData(map);
            if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            }
            yearsMap.put("#year", map);
        }
    }

    public List<Map<String, Object>> getGoal(Map<String, Object> params) {
        String pdmsave = (String) params.get("pdmsave");
        String proguid = (String) params.get("proguid");
        ArrayList<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
        logger.debug("--------pdmsave保存标识---------"+ pdmsave);
        String showall = (String) params.get("showall");
        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        logger.debug("-------------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            String dataprovince = (String) params.get("dataprovince");//项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            prjIndexDAO.setYearAndProvince(loginyear,dataprovince);
        }
//        String tablecode = "v_pm_perf_goal_info";
//        if ("20".equals(pdmsave)){ //项目库暂存草稿
//            tablecode = "V_PM_PERF_GOAL_TEMP";
//        }
        //查询项目信息
        List<Map<String, Object>> prolist =  prjIndexDAO.getDatas("pm_project_info", " guid='" + proguid + "'", null);
        String pro_code = null;
        if(prolist != null && prolist.size()>0){
            pro_code = prolist.get(0).get("pro_code").toString();
        }
        //中期绩效目标
        List<Map<String, Object>> zqlist =  prjIndexDAO.getDatas("pm_perf_goal_info", " mainguid='" + proguid
                + "' and nvl(yearflag,'0') = '1' and is_deleted = 2 and is_backup=2 and province = '" + CommonUtil.getProvince() + "'", null);
        //年度绩效目标
        List<Map<String, Object>> ndlist =  prjIndexDAO.getDatas("v_pm_perf_goal_info", " pro_code='" + pro_code + "' and nvl(yearflag,'3') = '0'", null);
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

    public Map saveSxData(HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode");
        String pro_name = (String) params.get("pro_name");
        String agency_name = (String) params.get("agency_name");
        String tablecode = "";
        tablecode = "v_pm_perf_goal_info";
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        //中期绩效目标
        List<Map<String, Object>> zqlist =  prjIndexDAO.getDatas("pm_perf_goal_info", " mainguid='" + proguid
                + "' and nvl(yearflag,'0') = '1' and is_deleted = 2 and is_backup=2 and province='" + CommonUtil.getProvince() +"'", null);
        //年度绩效目标
        List<Map<String, Object>> ndlist =  prjIndexDAO.getDatas("v_pm_perf_goal_info", " pro_code='" + procode + "' and nvl(yearflag,'3') = '0'", null);
        List<Map<String, Object>> goalList = new ArrayList<Map<String, Object>>();
        goalList.addAll(zqlist);
        goalList.addAll(ndlist);
        int i = 0;
        if (goalList != null && goalList.size()>0){
            i = goalList.size();
        }
        if (i > 0) {
            List<Map<String,Object>> uplist = new ArrayList<Map<String,Object>>();
            List<Map<String,Object>> addlist = new ArrayList<Map<String,Object>>();
            //List<Map<String, Object>> goalList = prjIndexDAO.getDatas(tablecode,wheresql,"");
            if (i==1){ //只有一条数据  那就 复制一份数据做保存
                Map<String,Object> map = goalList.get(0);
                String yearflag = String.valueOf(goalList.get(0).get("yearflag"));
                if (!StringUtil.isEmpty(yearflag)){
                    Map<String,Object> map1 = new HashMap<String,Object>();
                    if ("1".equals(yearflag)){//中期
                        map1.putAll(map);
                        map1.put("kpi_target",editinfo.get("kpi_target"));
                        map1.put("yearflag","0");
                    }else if ("0".equals(yearflag)){//年度
                        map1.putAll(map);
                        map1.put("kpi_target",editinfo.get("zqgoal"));
                        map1.put("yearflag","1");
                    }
                    map1.put("guid", this.getCreateguid());
                    map1.put("kpi_per_id", map1.get("guid"));
                    if (map1.get("kpi_target") !=null && !"".equals(map1.get("kpi_target"))) {
                        map1.put("pro_code",procode);
                        map1.put("pro_name",pro_name);
                        map1.put("agencyguid", saveAgency);
                        map1.put("agency_name", agency_name);
                        map1.put("is_last_inst",2);//是否终审
                        map1.put("version",PerfConstant.PMKPI_VERSION_RCDTWH);//版本号
                        map1.put("version_name",PerfConstant.PMKPI_VERSION_NAME_RCDTWH);//版本号说明
                        this.getBasMap(map1, "add");
                        addlist.add(map1);
                    }
                }
            }else if(i==2 && zqlist.size()>0 && ndlist.size()>0){//长期，年度目标都存在 则更新
                for (Map<String,Object> goalmap: goalList){
                    if (goalmap != null && goalmap.size()>0){
                        String yearflag = String.valueOf(goalmap.get("yearflag"));
                        if("0".equals(yearflag)){//年度
                            goalmap.put("kpi_target",editinfo.get("kpi_target"));
                            if (goalmap.get("kpi_target") !=null && !"".equals(goalmap.get("kpi_target"))) {
                                goalmap.put("updatetime", PerfUtil.getServerTimeStamp());
                                goalmap.put("update_time", PerfUtil.getServerTimeStamp());
                                uplist.add(goalmap);
                            }
                        }
                    }
                }

            }else if((zqlist.size()>1 && ndlist.size()==0) || (zqlist.size()==0 && ndlist.size()>1)){
                //数据异常情况：长期目标>1，年度目标不存在 则插入年度目标 或 年度目标>1，长期目标不存在 则插入长期目标
                Map<String,Object> map = goalList.get(0);
                String yearflag = String.valueOf(map.get("yearflag"));
                if (!StringUtil.isEmpty(yearflag)){
                    Map<String,Object> map1 = new HashMap<String,Object>();
                    if ("1".equals(yearflag)){//中期
                        map1.putAll(map);
                        map1.put("kpi_target",editinfo.get("kpi_target"));
                        map1.put("yearflag","0");
                    }else if ("0".equals(yearflag)){//年度
                        map1.putAll(map);
                        map1.put("kpi_target",editinfo.get("zqgoal"));
                        map1.put("yearflag","1");
                    }
                    map1.put("guid", this.getCreateguid());
                    map1.put("kpi_per_id", map1.get("guid"));
                    if (map1.get("kpi_target") !=null && !"".equals(map1.get("kpi_target"))) {
                        map1.put("pro_code",procode);
                        map1.put("pro_name",pro_name);
                        map1.put("agencyguid", saveAgency);
                        map1.put("agency_name", agency_name);
                        map1.put("is_last_inst",2);//是否终审
                        map1.put("version",PerfConstant.PMKPI_VERSION_RCDTWH);//版本号
                        map1.put("version_name",PerfConstant.PMKPI_VERSION_NAME_RCDTWH);//版本号说明
                        this.getBasMap(map1, "add");
                        addlist.add(map1);
                    }
                }
            }
            List<String> cols = new ArrayList<String>(editinfo.keySet());
            if (uplist != null && uplist.size()>0) {
                prjIndexDAO.updateAll(cols, uplist, tablecode);
            }
            prjIndexDAO.saveAll(addlist, tablecode);
        } else {
            //年度绩效数据
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("agencyguid", saveAgency);
            editinfo.put("mainguid", proguid);
            editinfo.put("pro_code", procode);
            editinfo.put("pro_name",pro_name);
            editinfo.put("agency_name", agency_name);
            editinfo.put("is_last_inst",2);//是否终审
            editinfo.put("yearflag","0");
            this.getBasMap(editinfo, "add");
            list.add(editinfo);
            //中期绩效数据
            Map<String,Object> totalMap = new HashMap<String,Object>();
            totalMap.putAll(editinfo);
            totalMap.put("kpi_target",editinfo.get("zqgoal"));
            totalMap.put("yearflag","1");
            totalMap.put("guid", this.getCreateguid());
            this.getBasMap(totalMap, "add");
            if (totalMap.get("kpi_target") !=null && !"".equals(totalMap.get("kpi_target"))) {
                list.add(totalMap);
            }
            logger.debug("--------saveSxData---------list:"+ list);
            prjIndexDAO.saveAll(list, tablecode);
        }
//        }
        return this.auditdefine(list, busguid, "perf", null);
    }

    /**
     * 初始化指标规范，只适用于新增数据 rowtype = add
     * @param tempMap
     * @throws AppException
     */
    public void setIndexMap(Map tempMap) throws AppException {
        this.getBasMap(tempMap,"add");
        tempMap.put("is_last_inst",2);//是否终审
    }

    public Map<String, Object> copyGoal(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        Integer year = Integer.parseInt(CommonUtil.getYear()) -1;
        Map<String, Object> backMap = new HashMap();
        boolean ismultipro = (boolean) params.get("ismultipro");// 是否为多项目
        boolean isconfirm = (boolean) params.get("isconfirm");// 区分是否确认选择了关系，false时需要弹出提示确认，true继续处理
        String multiprosql = null; // 多项目关系的条件sql
        if(ismultipro){ // 多项目关系，查询关系表拼接条件sql
            List<Map<String, Object>> bgtprolastyearlist = prjIndexDAO.getDatas("v_perf_bgtprolastyear", "pro_code = '"+procode+"'",null);
            List<Map<String, Object>> prolastyearlist = prjIndexDAO.getDatas("v_perf_prolastyear", "pro_code = '"+procode+"'",null);
            prolastyearlist.addAll(bgtprolastyearlist);
            if(bgtprolastyearlist.size()==0 && prolastyearlist.size() ==0){
                backMap.put("success",false);
                backMap.put("error","未匹配到该项目上年对照关系,请选择项目进行复制!");
                return backMap;
            }else if(bgtprolastyearlist.size()==0 && prolastyearlist.size()>0 && !isconfirm){
                backMap.put("success",false);
                backMap.put("code",2);
                backMap.put("error","未匹配到该项目上年对照关系,请确认选择的项目进行复制!");
                return backMap;
            }else{
                List<String> procodes = prolastyearlist.stream().map(map -> (String) map.get("last_pro_code")).collect(Collectors.toList());
                multiprosql = prjIndexDAO.createInSql("pro_code", procodes);
            }
        }
        String wheresql = " pro_code = ? and t.yearflag='0' and is_deleted = 2 and is_backup = 2 and t.year = ? and sub_mof_div_code is null ";
        if (PerfUtil.getProgramIsyear()) {
            wheresql += " and nvl(is_adj, 2) = 2";
        }
        Map<String, Object> map; // 上年目标信息
        Map<String, Object> maps = prjIndexDAO.getDataMap(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql, new String[]{procode, CommonUtil.getYear()});
        if(ismultipro){ // 多项目关系，目标值拼到一起
            String multiproquerysql = "select t.* from pm_perf_goal_info t where "+multiprosql+" and t.yearflag = '0' and is_deleted = 2 and is_backup=2 and t.year = ? and sub_mof_div_code is null ";
            if (PerfUtil.getProgramIsyear()) {
                multiproquerysql += " and nvl(is_adj, 2) = 2";
            }
            List<Map<String, Object>> goalslist = prjIndexDAO.queryForList(multiproquerysql, new String[]{String.valueOf(year)});
            if(goalslist.size()>0){// 能查到数据做处理
                List<String> kpiTargets = goalslist.stream().map(goal -> (String) goal.get("kpi_target")).filter(target -> target != null && !target.isEmpty()).collect(Collectors.toList());
                map = goalslist.get(0);
                map.put("kpi_target",String.join(";", kpiTargets));
            }else{
                map = new HashMap<>();
            }
        }else{
            map = prjIndexDAO.getDataMap(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql, new String[]{procode, String.valueOf(year)});
        }
        if (map.isEmpty() || StringUtil.isEmpty((String) map.get("kpi_target"))) {// 如果上年的目标map为空或目标值为空直接返回
            backMap.put("success",false);
            backMap.put("error","该项目上年绩效目标值不存在!");
            return backMap;
        }
        if (!map.isEmpty() && !maps.isEmpty()) {
            maps.put("kpi_target",map.get("kpi_target"));
        } else if (!map.isEmpty()) {
            maps = map;
            String guid = CommonUtil.createGUID();
            maps.put("guid",guid);
            maps.put("kpi_per_id",guid);
            maps.put("fiscal_year",CommonUtil.getYear());
            maps.put("year",CommonUtil.getYear());
        }
        if (!StringUtil.isEmpty((String) maps.get("kpi_target"))) {
            backMap.put("success",true);
            backMap.put("data", maps);
        } else {
            backMap.put("success",false);
            backMap.put("error","该项目上年绩效目标值不存在!");
        }
        return backMap;
    }

    /**
     * 查看切换年度，获取不同年度目标.
     * @param params -- 区划，年度参数
     * @return
     * @throws AppException
     */
    public Map<String, Object> getYearGoal(Map<String, Object> params) throws AppException {
        Map backMap = new HashMap();
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        String procode = (String) params.get("procode");
        String adjadd = (String) params.get("adjadd");
        String proguid = (String) params.get("proguid");
        StringBuffer sql = new StringBuffer(" t.province = '").append(province).append("'");
        sql.append(" and t.year = '").append(year).append("'");
        sql.append(" and t.pro_code = '").append(procode).append("'");
        sql.append(" and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ");
        //项目库不是调整查询是添加是否调整终审条件
        if (!"1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
            sql.append(" and nvl(is_adj, 2) = 2");
        }
        List<Map<String, Object>> list = prjIndexDAO.getDatas(PerfConstant.PMKPI_BACKUP_GOAL_INFO, sql.toString(), null);
        List<Map<String, Object>> datas = new ArrayList<>();
        if (list.size() > 0){
            //项目库阶段填报年度绩效，涉及到调整查询，查寻到数据是多份，进行筛选数据
            if (PerfUtil.getProgramIsyear() && "1".equals(adjadd)) {
                Map<String, Object> proMap = this.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid=?", new String[]{proguid});
                String proyear = (String) proMap.get("year");//查询调整年度
                List<Map<String, Object>> adjList = new ArrayList<>();
                for (Map<String, Object> data : list) {
                    String is_adj = data.get("is_adj") + "";
                    String mainguid = (String) data.get("mainguid");
                    if (!"null".equals(is_adj) && proguid.equals(mainguid)) {
                        adjList.add(data);
                    }
                }
                //调整查看，同年项目发生调整，调整存在年度数据，展示调整数据，过滤调前数据
                if (adjList.size() > 0) {
                    datas = adjList;
                } else if (!year.equals(proyear)){ //调整查看，查看非调整年度数据
                    datas = list;
                }
            } else {
                datas = list;
            }
        }
        if (datas.size() > 0) {
            backMap.put("data",datas.get(0));
        } else {
            backMap.put("data",null);
        }
        return  backMap;
    }

    /**
     * 获取项目年度绩效包含多少年度.
     * @param params -- 参数。
     * @return
     * @throws AppException
     */
    public List getYearOption(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        String province = (String) params.get("province");
        String adjadd = (String) params.get("adjadd");
        StringBuffer sql = new StringBuffer(" select t.year from pm_perf_goal_info t where");
        sql.append(" t.province = '").append(province).append("'");
        sql.append(" and t.pro_code = '").append(procode).append("'");
        sql.append(" and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ");
        //项目库不是调整查询是添加是否调整终审条件
        if (!"1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
            sql.append(" and nvl(is_adj, 2) = 2");
        }
        sql.append(" group by t.year order by year desc");
        List<Map> list = prjIndexDAO.queryForList(sql.toString());
        List elements = new ArrayList();
        list.forEach(e -> {
            Map<String, String> tempMap = new HashMap<>();
            tempMap.put("guid", e.get("year")+"");
            tempMap.put("itemid", e.get("year")+"");
            tempMap.put("code", e.get("year")+"");
            tempMap.put("name", e.get("year")+"");
            tempMap.put("superitemid", "0");
            tempMap.put("levelno", "1");
            tempMap.put("isleaf", "1");
            elements.add(tempMap);
        });
        return elements;
    }

    //-------------------------分界线(以下方法仅供湖北使用)--------------------------------

    /**
     * 查询主表目标数据.(湖北)
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getMainDatas(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String proguid = (String)params.get("proguid");
        String selectbillguid = (String)params.get("selectbillguid");//调整前guid
        String procode = (String)params.get("pro_code");
        String showtab = (String)params.get("showtab");
        String adjadd = (String)params.get("adjadd");
        String pdmsave = (String) params.get("pdmsave"); //保存还是暂存区分20 暂存
        String tempcode = (String) params.get("tempcode");//内置模板编码
        String frametype = (String) params.get("frametype");
        String dataprovince = "";
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String yearflag = "0";
        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        String showall = (String) params.get("showall");
        logger.debug("------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            dataprovince = (String) params.get("dataprovince");//项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            prjIndexDAO.setYearAndProvince(loginyear,dataprovince);
        }
        if ("1".equals(showtab)){
            tempfilter = new String[]{"1","0"};
        } else if ("2".equals(showtab)){
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        List<Map<String, Object>> goals = null;
        HashMap<String,String> oldgoalguidMap = new HashMap<String,String>();
        if (adjadd != null && "1".equals(adjadd)){
            goals = prjIndexDAO.getGoalsByFilter(proguid, procode, pdmsave, tempfilter, dataprovince);
            if(goals.size()<=0){
                goals = prjIndexDAO.getGoalsByFilter(selectbillguid, procode, pdmsave, tempfilter, dataprovince);
                //调整项目查询不存在数据，重新生成guid，解决项目库嵌套保存不刷新页面
                String version = PerfUtil.getServerTimeStamp();
                for (Map<String, Object> map : goals) {
                    String oldgoalguid = String.valueOf(map.get("guid"));
                    String guid = this.getCreateguid();
                    oldgoalguidMap.put(oldgoalguid,guid);
                    yearflag = (String) map.get("yearflag");
                    params.put("yearflag", yearflag);
                    map.put("guid", guid);
                    map.put("kpi_per_id", guid);
                    map.put("version", version);
                    if ("1".equals(yearflag)) {
                        map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                    } else if ("0".equals(yearflag)) {
                        map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                    }
                }
            }
        }else{
            goals = prjIndexDAO.getGoalsByFilter(proguid, procode, pdmsave, tempfilter, dataprovince);
        }
        if(goals.size() <= 0 && (tempcode != null && !tempcode.isEmpty())){
            //如果查出来的目标数据为空，则获取模板中的指标数据。
            goals = prjIndexDAO.findGoalByTempCode(proguid,tempcode,tempfilter);
            for (Map map : goals) {
                String guid = this.getCreateguid();
                map.put("guid",guid);
            }
        }
        //调用通版指标方法 获取指标数据
        gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO indexBO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO) ServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        Map<String, Object> indexsmap = indexBO.findAllIndex(params);
        List<Map<String, Object>> tindexlist = (List<Map<String, Object>>) indexsmap.get("#total");
        List<Map<String, Object>> yindexlist = (List<Map<String, Object>>) indexsmap.get("#year");
        //拼装数据
        String goalguid = "";
        String sindex = null;
        String findex = null;
        String key = "";
        float sweightsum = 0;
        float fweightsum = 0;
        Map<String, Object> sumMap = new HashMap<String, Object>();
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List tgoalindexs = new ArrayList(); //长期目标指标对应.
        List ygoalindexs = new ArrayList(); //年度目标指标对应.
        List tempindex = new ArrayList();
        List<Map<String, Object>> tempdatas = new ArrayList<Map<String, Object>>();//模板
        List<Map<String, Object>> collist = prjIndexDAO.getCol("PM_PERF_INDICATOR");
        if(tindexlist != null && tindexlist.size() > 0) {
            for (Map<String, Object> map : tindexlist) {
                if ("3".equals(String.valueOf(map.get("levelno")))) {
                    goalguid = (String) map.get("goalguid");
                    if (oldgoalguidMap.containsKey(goalguid)) {
                        goalguid = oldgoalguidMap.get(goalguid);
                    }
                    sindex = (String) map.get("sindex");
                    findex = (String) map.get("findex");
                    String weight = map.get("weight") == null ? "0" : map.get("weight") + "";
                    if(sumMap.containsKey(goalguid+ "#" +sindex)){
                        sweightsum = Float.parseFloat(sumMap.get(goalguid+ "#" +sindex).toString());
                        if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                            Float num = Float.parseFloat(weight);
                            sweightsum = sweightsum + num;
                            sweightsum=(float)(Math.round(sweightsum*100))/100;
                            sumMap.put(goalguid+ "#" +sindex,sweightsum);
                        }
                    }else{
                        sumMap.put(goalguid+ "#" +sindex,weight);
                    }
                    if(sumMap.containsKey(goalguid+ "#" +findex)){
                        fweightsum = Float.parseFloat(sumMap.get(goalguid+ "#" +findex).toString());
                        if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                            Float num = Float.parseFloat(weight);
                            fweightsum = fweightsum + num;
                            fweightsum=(float)(Math.round(fweightsum*100))/100;
                            sumMap.put(goalguid+ "#" +findex,fweightsum);
                        }
                    }else{
                        sumMap.put(goalguid+ "#" +findex,weight);
                    }
                    key = goalguid + "#" + sindex;
                    map.put("goalguid", goalguid);
                    map.put("levelno", "3");
                    map.put("isleaf", "1");
                    map.put("_isleaf", "1");
                    map.put("superguid", sindex);
                    map.put("superid", sindex);
                    if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                        map.put("rowtype", "mod");
                    }
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tempindex.add(map);
                    } else {
                        tempindex = new ArrayList();
                        tempindex.add(map);
                        indexMap.put(key, tempindex);
                    }
                } else {
                    tempdatas.add(map);
                }
            }
        }
        if(yindexlist != null && yindexlist.size() > 0) {
            for (Map<String, Object> ymap : yindexlist) {
                if ("3".equals(String.valueOf(ymap.get("levelno")))) {
                    goalguid = (String) ymap.get("goalguid");
                    if (oldgoalguidMap.containsKey(goalguid)) {
                        goalguid = oldgoalguidMap.get(goalguid);
                    }
                    sindex = (String) ymap.get("sindex");
                    findex = (String) ymap.get("findex");
                    String weight = ymap.get("weight") == null ? "0" : ymap.get("weight") + "";
                    if(sumMap.containsKey(goalguid+ "#" +sindex)){
                        sweightsum = Float.parseFloat(sumMap.get(goalguid+ "#" +sindex).toString());
                        if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                            Float num = Float.parseFloat(weight);
                            sweightsum = sweightsum + num;
                            sweightsum=(float)(Math.round(sweightsum*100))/100;
                            sumMap.put(goalguid+ "#" +sindex,sweightsum);
                        }
                    }else{
                        sumMap.put(goalguid+ "#" +sindex,weight);
                    }
                    if(sumMap.containsKey(goalguid+ "#" +findex)){
                        fweightsum = Float.parseFloat(sumMap.get(goalguid+ "#" +findex).toString());
                        if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                            Float num = Float.parseFloat(weight);
                            fweightsum = fweightsum + num;
                            fweightsum=(float)(Math.round(fweightsum*100))/100;
                            sumMap.put(goalguid+ "#" +findex,fweightsum);
                        }
                    }else{
                        sumMap.put(goalguid+ "#" +findex,weight);
                    }
                    key = goalguid + "#" + sindex;
                    ymap.put("goalguid", goalguid);
                    ymap.put("levelno", "3");
                    ymap.put("isleaf", "1");
                    ymap.put("_isleaf", "1");
                    ymap.put("superguid", sindex);
                    ymap.put("superid", sindex);
                    if (ymap.get("rowtype") == null || !"add".equals(ymap.get("rowtype"))) {
                        ymap.put("rowtype", "mod");
                    }
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tempindex.add(ymap);
                    } else {
                        tempindex = new ArrayList();
                        tempindex.add(ymap);
                        indexMap.put(key, tempindex);
                    }
                }
            }
        }

        String flag = "";
        List yeargoals = new ArrayList(); // 年度
        List totalgoals = new ArrayList(); // 长期
        if(goals != null && goals.size() > 0) {
            for (Map<String, Object> map : goals) {
                goalguid = (String) map.get("guid");
                String goalyearflag = (String) map.get("yearflag");
                tgoalindexs = new ArrayList();
                ygoalindexs = new ArrayList();
                List<Map> tempdatalist = new ArrayList();
                JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
                List<Map> jsonlist = jsonArray.toJavaList(Map.class);
                tempdatalist.addAll(jsonlist);
                int sortnum = 0;
                for (Map<String, Object> tepmap : tempdatalist) {
                    for (Map<String, Object> colmap : collist) {
                        String col = (String) colmap.get("columncode");
                        String value = tepmap.get(col) + "";
                        if (value == null || org.springframework.util.StringUtils.isEmpty(value) || "null".equals(value)) {
                            tepmap.put(col, "");
                        }
                    }
                    String levelno = tepmap.get("levelno") + "";


                    if (!org.springframework.util.StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                        sindex = (String) tepmap.get("guid");
                        key = goalguid + "#" + sindex;
                        if (indexMap.containsKey(key)) {
                            tempindex = indexMap.get(key);
                            tepmap.put("_sortid", sortnum);
                            sortnum++;
                            for (int j = 0; j < tempindex.size(); j++) {
                                Map<String, Object> indexmap = (Map<String, Object>) tempindex.get(j);
                                indexmap.put("_sortid", sortnum);
                                sortnum++;
                            }
                            if ("1".equals(goalyearflag)) {
                                tgoalindexs.addAll(tempindex);
                            } else {
                                ygoalindexs.addAll(tempindex);
                            }
                        } else {
                            tepmap.put("_sortid", sortnum);
                            sortnum++;
                        }
                        if(sumMap.containsKey(key)){
                            tepmap.put("weight",sumMap.get(key));
                        }
                    } else {
                        findex = (String) tepmap.get("guid");
                        if(sumMap.containsKey(goalguid + "#" + findex)){
                            tepmap.put("weight",sumMap.get(goalguid + "#" + findex));
                        }
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                    }
                    tepmap.put("goalguid", goalguid);
                    tepmap.put("_isleaf", "1");
                    if ("1".equals(goalyearflag)) {
                        tgoalindexs.add(tepmap);
                    } else {
                        ygoalindexs.add(tepmap);
                    }
                }
                if ("1".equals(goalyearflag)) {
                    map.put("#indexs", tgoalindexs);
                    totalgoals.add(map);
                } else {
                    map.put("#indexs", ygoalindexs);
                    yeargoals.add(map);
                }

                if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                    map.put("rowtype", "mod");
                }
                map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
            }
        }
        backMap.put("yeargoals", yeargoals);
        backMap.put("totalgoals", totalgoals);
        return backMap;
    }



    /**
     * 根据主表记录查询没有记录的查询默认模板数据(湖北)
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getSubData(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String goalguid = (String)params.get("goalguid");
        String proguid = (String)params.get("proguid");
        String frametype = (String) params.get("frametype");
        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        String showall = (String) params.get("showall");
        logger.debug("------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            String dataprovince = (String) params.get("dataprovince");//项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            prjIndexDAO.setYearAndProvince(loginyear,dataprovince);
        }
        List<Map<String, Object>> collist = prjIndexDAO.getCol(PerfConstant.PMKPI_VPM_INDICATOR);
        gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO indexDAO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        List<Map<String, Object>> tempdatas = indexDAO.getTempdatas(proguid,frametype);
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (StringUtil.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("mainguid", proguid);
            map.put("goalguid", goalguid);
            map.put("_isleaf", "1");
            map.put("is_add", "2");
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }


    /**
     * 根据目标查询对应的指标数据
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> getIndexData(HashMap<String,Object> params) throws AppException{
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String pro_code = (String)params.get("pro_code");
        String goalguid = (String)params.get("goalguid");
        String yearflag = (String)params.get("yearflag");
        String wheresql = "";
        //获取模板数据
        List<Map<String, Object>> collist = prjIndexDAO.getCol("PM_PERF_INDICATOR");
        gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO indexDAO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        List<Map<String, Object>> tempdatas = indexDAO.getTempdatas(mainguid,"PM001");
        //指标数据
        List<Map<String, Object>> indexdatas = new ArrayList<Map<String, Object>>();
        if(!StringUtil.isEmpty(yearflag) && "1".equals(yearflag)){
            wheresql = " mainguid = '"+mainguid+"' and goalguid = '"+goalguid+"' and yearflag = '1' and is_deleted = '2'";
            indexdatas = prjIndexDAO.getDatas("PM_PERF_INDICATOR", wheresql, null);
        }else{
            wheresql = " pro_code = '"+pro_code+"' and goalguid = '"+goalguid+"' and yearflag = '0'";
            indexdatas = prjIndexDAO.getDatas("V_PM_PERF_INDICATOR", wheresql, null);
        }
        List<Map<String,Object>> datas = new ArrayList<>();
        //模板数据
        for (Map<String, Object> tempdata : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = tempdata.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    tempdata.put(col, "");
                }
            }
            tempdata.put("mainguid", mainguid);
            tempdata.put("goalguid", goalguid);
            tempdata.put("_isleaf", "1");
            datas.add(tempdata);
        }
        //指标数据
        for (Map<String, Object> indexdata : indexdatas) {
            datas.add(indexdata);
        }
        backMap.put("data",datas);
        return  backMap;
    }

    /**
     * 整体的保存（湖北目标指标整体保存）
     * @param params --前端的参数
     * @return --返回结果
     */
    public Map<String, Object> saveHbDatas(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String proguid = (String)params.get("proguid");
        this.setProAgencyName(params);
        String procode = (String)params.get("pro_code");
        String showtab = (String)params.get("showtab");
        String adjadd = (String)params.get("adjadd");
        String pdmsave = (String) params.get("pdmsave"); //保存还是暂存区分20 暂存
        String saveAgency = (String) params.get("saveAgency");
        String pro_name = (String) params.get("pro_name");//项目名称
        String agency_name = (String) params.get("agency_name");//单位名称
        String isnest = (String) params.get("isnest"); // 嵌套页面跳转过来的
        String isnzzj = (String) params.get("isnzzj");//是否年中追加
        String midsave = (String) params.get("midsave"); // 是否草稿页面保存，接口获取
        String isedittotal = (String) params.get("isedittotal");
        //全部数据
        List<Map<String, Object>> totalgoals = (List<Map<String, Object>>) params.get("totalgoals");
        List<Map<String, Object>> yeargoals = (List<Map<String, Object>>) params.get("yeargoals");
        //删除数据
        List<Map<String, Object>> deltotal = (List<Map<String, Object>>) params.get("deltotal");
        List<Map<String, Object>> delyear = (List<Map<String, Object>>) params.get("delyear");
        //新增和修改的数据
        List<Map<String, Object>> addMainlist = new ArrayList<Map<String, Object>>();//目标表新增
        List<Map<String, Object>> upMainlist = new ArrayList<Map<String, Object>>();//目标表更新
        List<Map<String, Object>> addSublist = new ArrayList<Map<String, Object>>(); //指标表新增
        List<Map<String, Object>> upSublist = new ArrayList<Map<String, Object>>(); //指标表更新
        List<Map<String, Object>> delSublist = new ArrayList<Map<String, Object>>(); //指标表删除
        List<Map<String, Object>> delList = new ArrayList<>();//目标表删除
        List<Map<String, Object>> goallist = new ArrayList<>(); //目标集合
        List<Map<String, Object>> indexlist = new ArrayList<>(); //指标集合
        String levelno = "";
        String indexname = "";
        String rowtype = "";
        String goaltablecode = "pm_perf_goal_info";
        String indextablecode = "pm_perf_indicator";
        if (pdmsave != null && "21".equals(pdmsave)) {
            prjIndexDAO.updateIsDeleteDatas("v_pm_perf_goal_temp", " mainguid = '"+proguid+"'"); //删除目标暂存表
            prjIndexDAO.updateIsDeleteDatas("v_pm_perf_indicator_temp", " mainguid = '"+proguid+"'"); //删除指标暂存表
            goaltablecode = "v_pm_perf_goal_temp";//目标暂存表
            indextablecode = "v_pm_perf_indicator_temp"; //指标暂存表
        }
        //草稿页面保存并退出/送审，如果存在业务数据，先删除垃圾数据（保存入业务表如果项目库被拦截，绩效没问题绩效数据会入库，产生垃圾数据，删除数据后进行新增）
        if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {
            logger.info("-----------湖北目标指标草稿删除----------midsave="+midsave);
            String delsql = " mainguid='" + proguid + "' ";
            prjIndexDAO.updateDatasIsDelete(goaltablecode, delsql);
            prjIndexDAO.updateIndexIsDelete(indextablecode, delsql);
        }
        int i = 0;
        int j = 0;
        int k = 0;
        String wheresql = "";
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (isedittotal == null || !"1".equals(isedittotal))) { // 总+年
            //中期目标删除数据
            if (deltotal != null && deltotal.size() > 0) {
                delList.addAll(deltotal);
            }
            if (totalgoals != null && totalgoals.size() > 0) {
                List<Map<String, Object>> tindexList = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> tindexDelList = new ArrayList<Map<String, Object>>();
                for (Map tgoalMap : totalgoals) {
                    String guid = (String) tgoalMap.get("guid");
                    rowtype = (String) tgoalMap.get("rowtype");
                    // 浙江历史项目迁移后的目标指标数据有缺失，默认新增一条
                    if(guid == null || guid.length() == 0 || "".equals(guid)){
                        guid = this.getCreateguid();
                        tgoalMap.put("guid", guid);
                    }
                    String newgoalid = StringUtil.createUUID();
                    if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                        tgoalMap.put("guid",newgoalid);
                    }
                    if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                        tgoalMap.put("guid",newgoalid); //只保存草稿时重新生成guid
                        tgoalMap.put("kpi_per_id",newgoalid);
                    }
                    String kpi_target = (String) tgoalMap.get("kpi_target");
                    if(kpi_target == null || kpi_target.isEmpty()){
                        tgoalMap.put("kpi_target", "无目标");
                    }
                    wheresql = "guid=? and province=? and is_deleted=2 ";
                    if (!"21".equals(pdmsave)){
                        wheresql += " and is_backup=2 ";
                    }
                    i = prjIndexDAO.getDataCount(goaltablecode, wheresql, new String[]{guid, SecureUtil.getUserSelectProvince()});
                    if (i == 0 || (pdmsave!= null  && "21".equals(pdmsave)) || "add".equals(rowtype) ) {
                        tgoalMap.put("mainguid", proguid);
                        tgoalMap.put("agencyguid", saveAgency);
                        tgoalMap.put("agency_code", saveAgency);
                        tgoalMap.put("yearflag","1");
                        tgoalMap.put("pro_code", procode);
                        tgoalMap.put("pro_name", pro_name);
                        tgoalMap.put("agency_name",agency_name);
                        this.setData(tgoalMap);
                        addMainlist.add(tgoalMap);
                    } else {
                        tgoalMap.put("mainguid", proguid);
                        tgoalMap.put("update_time", PerfUtil.getServerTimeStamp());
                        tgoalMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        upMainlist.add(tgoalMap);
                    }
                    goallist.add(tgoalMap);
                    //处理目标关联指标
                    tindexList = (List<Map<String, Object>>) tgoalMap.get("#indexs");
                    if (tindexList != null && tindexList.size() > 0) {
                        if (PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
                            /**
                             * 校验指标名称不可重复
                             */
                            Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(tindexList);
                            if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                                return nameDupCheckMap;
                            }
                        }
                    }
                    wheresql = " mainguid=? and province=? and yearflag = '1'  and is_deleted = 2 ";
                    if (!"21".equals(pdmsave)){
                        wheresql += " and is_backup=2 ";
                    }
                    k += prjIndexDAO.getDataCount(indextablecode, wheresql, new String[]{proguid, SecureUtil.getUserSelectProvince()});
                    for (Map tindexMap : tindexList) {
                        i++;
                        levelno = PerfUtil.mapGetInt(tindexMap, "levelno") + "";
                        indexname = (String) tindexMap.get("name");
                        rowtype = (String) tindexMap.get("rowtype");
                        if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                            tindexMap.put("guid",StringUtil.createUUID());
                            tindexMap.put("goalguid",newgoalid);
                        }
                        if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                            String newguid = StringUtil.createUUID();
                            tindexMap.put("guid",newguid); //只保存草稿时重新生成guid
                            tindexMap.put("kpi_id",newguid);
                            tindexMap.put("goalguid",newgoalid);
                        }
                        if ("3".equals(levelno) && !StringUtil.isEmpty(indexname)) { //总体指标
                            tindexMap.put("mainguid", proguid);
                            tindexMap.put("pro_code", procode);
                            tindexMap.put("ordernum", i);
                            tindexMap.put("yearflag", "1");
                            tindexMap.put("kpi_val", tindexMap.get("indexval"));
                            tindexMap.put("status", "");
                            tindexMap.put("kpi_content", tindexMap.get("name"));
                            tindexMap.put("kpi_evalstd", "1");
                            if ("add".equals(rowtype)) { //新增
                                tindexMap.put("agency_code", saveAgency);
                                tindexMap.put("agencyguid", saveAgency);
                                tindexMap.put("pro_name", pro_name);
                                tindexMap.put("agency_name", agency_name);
                                this.setIndexMap(tindexMap);
                                if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                                    tindexMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                                }
                                if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                                    tindexMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_RCDTWH+"_年中");
                                }
                                addSublist.add(tindexMap);
                            } else {
                                tindexMap.put("updatetime", PerfUtil.getServerTimeStamp());
                                tindexMap.put("update_time", PerfUtil.getServerTimeStamp());
                                upSublist.add(tindexMap);
                            }
                            indexlist.add(tindexMap); //用于审核定义
                        }
                    }
                    //子表删除数据
                    tindexDelList = (List<Map<String, Object>>) tgoalMap.get("#delindex");
                    if (tindexDelList.size() > 0) {
                        delSublist.addAll(tindexDelList);
                    }
                }
            }
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) { // 年
            //年度目标删除数据
            if (delyear != null && delyear.size() > 0) {
                delList.addAll(delyear);
            }
            if (yeargoals != null && yeargoals.size() > 0) {
                List<Map<String, Object>> yindexList = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> yindexDelList = new ArrayList<Map<String, Object>>();
                for (Map ygoalMap : yeargoals) {
                    String guid = (String) ygoalMap.get("guid");
                    rowtype = (String) ygoalMap.get("rowtype");
                    if(guid == null || guid.length() == 0 || "".equals(guid)){
                        guid = this.getCreateguid();
                        ygoalMap.put("guid", guid);
                    }
                    String newgoalid = StringUtil.createUUID();
                    if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                        ygoalMap.put("guid",newgoalid);
                    }
                    if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                        ygoalMap.put("guid",newgoalid); //只保存草稿时重新生成guid
                        ygoalMap.put("kpi_per_id",newgoalid);
                    }
                    String kpi_target = (String) ygoalMap.get("kpi_target");
                    if(kpi_target == null || kpi_target.isEmpty()){
                        ygoalMap.put("kpi_target", "无目标");
                    }
                    wheresql = "guid=? and is_deleted=2 " + PerfUtil.yearProvinceSql("t");
                    if (!"21".equals(pdmsave)){
                        wheresql += " and is_backup=2 ";
                    }
                    i = prjIndexDAO.getDataCount(goaltablecode, wheresql, new String[]{guid});
                    if (i == 0 || (pdmsave != null && "21".equals(pdmsave)) || "add".equals(rowtype)) {
                        ygoalMap.put("mainguid", proguid);
                        ygoalMap.put("agencyguid", saveAgency);
                        ygoalMap.put("agency_code", saveAgency);
                        ygoalMap.put("yearflag","0");
                        ygoalMap.put("pro_code", procode);
                        ygoalMap.put("pro_name", pro_name);
                        ygoalMap.put("agency_name", agency_name);
                        this.setData(ygoalMap);
                        addMainlist.add(ygoalMap);
                    } else {
                        ygoalMap.put("update_time", PerfUtil.getServerTimeStamp());
                        ygoalMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        upMainlist.add(ygoalMap);
                    }
                    goallist.add(ygoalMap);

                    //处理目标关联指标
                    yindexList = (List<Map<String, Object>>) ygoalMap.get("#indexs");
                    if (yindexList != null && yindexList.size() > 0) {
                        if (PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
                            /**
                             * 校验指标名称不可重复
                             */
                            Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(yindexList);
                            if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                                return nameDupCheckMap;
                            }
                        }
                    }
                    wheresql = " pro_code=? and yearflag = '0'  and is_deleted = 2 " + PerfUtil.yearProvinceSql("t");
                    if (!"21".equals(pdmsave)){
                        wheresql += " and is_backup=2 ";
                    }
                    k += prjIndexDAO.getDataCount(indextablecode, wheresql, new String[]{procode});
                    for (Map yindexMap : yindexList) {
                        j++;
                        levelno = PerfUtil.mapGetInt(yindexMap, "levelno") + "";
                        indexname = (String) yindexMap.get("name");
                        rowtype = (String) yindexMap.get("rowtype");
                        if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                            yindexMap.put("guid",StringUtil.createUUID());
                            yindexMap.put("goalguid",newgoalid);
                        }
                        if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                            String newguid = StringUtil.createUUID();
                            yindexMap.put("guid",newguid); //只保存草稿时重新生成guid
                            yindexMap.put("kpi_id",newguid);
                            yindexMap.put("goalguid",newgoalid);
                        }
                        if ("3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                            yindexMap.put("mainguid", proguid);
                            yindexMap.put("pro_code", procode);
                            yindexMap.put("ordernum", j);
                            yindexMap.put("yearflag", "0");
                            yindexMap.put("kpi_val", yindexMap.get("indexval"));
                            yindexMap.put("status", "");
                            yindexMap.put("kpi_content", yindexMap.get("name"));
                            yindexMap.put("kpi_evalstd", "1");
                            if(yindexMap.get("goalguid") == null){
                                yindexMap.put("goalguid",guid);
                            }
                            if ("add".equals(rowtype)) {
                                yindexMap.put("agency_code", saveAgency);
                                yindexMap.put("agencyguid", saveAgency);
                                yindexMap.put("pro_name", pro_name);
                                yindexMap.put("agency_name", agency_name);
                                this.setIndexMap(yindexMap);
                                if (!StringUtil.isEmpty(adjadd) && addSublist != null &&"1".equals(adjadd)) {//调整
                                    yindexMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                                }
                                if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                                    yindexMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_RCDTWH+"_年中");
                                }
                                addSublist.add(yindexMap);
                            } else {
                                yindexMap.put("updatetime", PerfUtil.getServerTimeStamp());
                                yindexMap.put("update_time", PerfUtil.getServerTimeStamp());
                                upSublist.add(yindexMap);
                            }
                            indexlist.add(yindexMap); //用于审核定义
                        }
                    }
                    //子表删除数据
                    yindexDelList = (List<Map<String, Object>>) ygoalMap.get("#delindex");
                    if (yindexDelList.size() > 0) {
                        delSublist.addAll(yindexDelList);
                    }
                }
            }
        }
        //目标指标长度校验及非空校验
        Map<String, Object> returngoalMapLength = this.checkColLength(goallist, PerfConstant.PMKPI_VPM_GOAL_INFO); //字段长度校验-草稿表校验
        if (returngoalMapLength.size() > 0) {
            logger.error("(目标checkColLength)保存失败项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
            return returngoalMapLength;
        }
        Map<String, Object> returnindexMapLength = this.checkColLength(indexlist, PerfConstant.PMKPI_VPM_INDICATOR);
        if (returnindexMapLength.size() > 0) {
            logger.error("(指标checkColLength)保存失败项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
            return returnindexMapLength;
        }
        prjIndexDAO.setIndexDatas(addSublist,"PM001",false);
        if (addSublist.size() > 0) {
            prjIndexDAO.setIndexCode(addSublist);
        }
        //草稿保存不校验必填
        if (!"21".equals(pdmsave)) {
            Map<String, Object> returnMap = prjIndexDAO.checkTacleColsIsNull(goaltablecode, goallist); //非空验证
            if (returnMap.size() > 0) {
                logger.error("(目标checkTacleColsIsNull)保存失败项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
                return returnMap;
            }
            returnMap = prjIndexDAO.checkTacleColsIsNull(indextablecode, addSublist);
            if (returnMap.size() > 0) {
                logger.debug("(指标checkTacleColsIsNull)保存失败项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
                return returnMap;
            }
        }
        //处理主表删除
        String tempgoalguid = "";
        List<String> delguids = new ArrayList<>();
        for (Map<String, Object> delmap : delList) {
            tempgoalguid = (String) delmap.get("guid");
            delguids.add(tempgoalguid);
        }
        //删除主表与子表
        if (delguids.size() > 0) {
            logger.debug("-----目标删除同步指标数据：" +delguids.toString());
            prjIndexDAO.deleteAllByColumn("guid",delguids,"PM_PERF_GOAL_INFO");
            prjIndexDAO.deleteAllByColumn("goalguid",delguids,"PM_PERF_INDICATOR");
        }

        //主表新增与修改
        if (addMainlist.size()>0) {
            //嵌套时保存后页面不刷新，新增标识符一直存在问题
            if (isnest != null && "1".equals(isnest)) {
                prjIndexDAO.saveAll(addMainlist, prjIndexDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + prjIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                prjIndexDAO.updateDatasIsDelete(goaltablecode, delsql);
            }
            logger.debug("-----新增目标数据：" +addMainlist.toString());
            prjIndexDAO.saveAll(addMainlist, goaltablecode); //目标暂存表
        }
        if (upMainlist.size()>0) {
            logger.debug("-----修改目标数据：" +upMainlist.toString());
            List<String> cols = new ArrayList<String>(upMainlist.get(0).keySet());
            prjIndexDAO.updateAllByPK(this.getTablecol(goaltablecode), upMainlist,"guid", goaltablecode);
        }
        if (k <= 0) { //判断项目是否存在数据，不存在默认全部新增,调整，保存草稿后保存并退出项目guid会变，没办法区分数据是否为新增状态
            for (Map tempMap : indexlist) {
                tempMap.put("agency_code", saveAgency);
                tempMap.put("agencyguid", saveAgency);
                tempMap.put("pro_code", procode);
                tempMap.put("pro_name", pro_name);
                tempMap.put("agency_name", agency_name);
                tempMap.put("prjguid", proguid);
                tempMap.put("mainguid", proguid);
                this.setIndexMap(tempMap);
            }
            prjIndexDAO.setIndexCode(indexlist);
            returnindexMapLength = prjIndexDAO.checkTacleColsIsNull(indextablecode, indexlist);
            if (returnindexMapLength.size() > 0) {
                logger.debug("保存失败项目编码++++++++++++++++" + procode + "+++++++++++项目guid+++++++" + proguid);
                return returnindexMapLength;
            }
            prjIndexDAO.setIndexDatas(indexlist,"PM001",false);
            logger.debug("--------indexList:"+ indexlist);
            prjIndexDAO.saveAll(indexlist, indextablecode);
            return this.auditdefine(indexlist, busguid, "perf", null);
        }
        //子表新增与修改
        prjIndexDAO.setIndexDatas(addSublist,"PM001",false);
        if (addSublist.size()>0) {
            //嵌套时保存后页面不刷新，新增标识符一直存在问题
            if (isnest != null && "1".equals(isnest)) {
                prjIndexDAO.saveAll(addSublist, prjIndexDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + prjIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                prjIndexDAO.updateIndexIsDelete(indextablecode, delsql);
            }
            logger.debug("--------addList:"+ addSublist);
            prjIndexDAO.saveAll(addSublist, indextablecode);
        }
        if (upSublist.size()>0) {
            logger.debug("-----修改指标数据：" +upSublist);
            List<String> cols = new ArrayList<String>(upSublist.get(0).keySet());
            prjIndexDAO.updateAllByPK(this.getTablecol(indextablecode), upSublist,"guid", indextablecode);
        }
        //子表的删除
        if (delSublist.size() > 0){
            List<String> delsubids = new ArrayList<>();
            delSublist.forEach(r->{
                delsubids.add((String) r.get("guid"));
            });
            logger.debug("-----删除指标数据：" +delsubids.toString());
            prjIndexDAO.deleteAllByColumn("guid",delsubids,"PM_PERF_INDICATOR");
        }
        if (pdmsave != null && "21".equals(pdmsave)) { //暂存
            Map<String, Object> tempMap = new HashMap<String, Object>();
            tempMap.put("success", true);
            return tempMap;
        }
        return this.auditdefine(goallist, busguid,"perf", null);
    }

}
