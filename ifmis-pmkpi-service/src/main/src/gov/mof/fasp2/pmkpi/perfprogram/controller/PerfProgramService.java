package gov.mof.fasp2.pmkpi.perfprogram.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.adjust.report.AdjustReportBO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionBO;
import gov.mof.fasp2.pmkpi.perfprogram.assessment.PerfAssessmentBO;
import gov.mof.fasp2.pmkpi.perfprogram.beforeview.BeforeviewBO;
import gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.FundCalIndexBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.*;
import gov.mof.fasp2.pmkpi.perfprogram.report.TlpProgramBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;

/**
 * @Description:
 * @Revision History:
 * @Revision 15:38 2020/8/29  chongdayong
 */
@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/pmkpi/perfprogram")
public class PerfProgramService {

    private final static Logger logger = Logger.getLogger(PerfProgramService.class);


    /**
     * 绩效事前绩效评估
     */
    @ResponseBody
    @RequestMapping(value = "saveAssessment", produces = {"text/html;charset=utf-8"})
    public String saveAssessment(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("--------saveAssessment 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.debug("--------saveAssessment 开启流程-------tokenid:"+tokenid+"------");
        logger.debug("--------saveAssessment 开启流程-------province:"+user.getProvince()+"------");
        logger.debug("--------saveAssessment 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> assessMap = new HashMap<String, Object>();
            String projguid = request.getParameter("projguid");//项目guid
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String permList = request.getParameter("list");//表格信息
            String busguid = PerfUtil.getSystemSet("PERF_PROASSESSMENTBUSGUID");//审核定义guid，配置表配置
            String midproguid = request.getParameter("midproguid"); //草稿数据
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdmsave = request.getParameter("pdmsave");//项目保存// 21 暂存，其他正常保存
            String prolev = request.getParameter("projtype");//项目级次
            String assessmentInfojson = request.getParameter("assessmentInfojson");
            logger.debug("--------projguid:"+ projguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            logger.debug("--------项目库调用的保存方式---------pdmsave:"+ pdmsave +"======");
            logger.debug("--------assessmentInfojson:"+ assessmentInfojson +"======");
            PerfAssessmentBO perfAssessmentBO = (PerfAssessmentBO) PerfServiceFactory.getBean("pmkpi.perfprogram.assessment.PerfAssessmentBOTX");
            if (!StringUtil.isEmpty(permList) && !"undefined".equals(permList)) {
                //指标信息json转成list
                String perm = String.valueOf(JSON.parse(URLDecoder.decode(permList, "utf-8")));
                perm = perm.substring(perm.indexOf("["),perm.lastIndexOf("]")+1);
                perm = "{tagJson:"+perm+"}";
                List<Map> list = JSON.parseArray(JSON.parseObject(perm).getString("tagJson"), Map.class);
                assessMap.put("datas", list);
            }else{
                assessMap.put("datas", new ArrayList<Map>());
            }

            if (!StringUtil.isEmpty(assessmentInfojson) && !"undefined".equals(assessmentInfojson)) {
                String tabindexstr = URLDecoder.decode(assessmentInfojson, "utf-8");
                Map infoMap = PerfUtil.parseString2Map(tabindexstr);
                assessMap.put("edifinfo", infoMap);
            }else{
                assessMap.put("edifinfo", new HashMap<>());
            }
            String saveAgency = "";
            String procode = "";
            Object procodeobj = "";
            String midsave = "";
            //处理单位，在pdm_proinfo中获取
            Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
            infoMap.put("pro_id", projguid);
            this.saveLog(infoMap, "saveAssessment");
            if ( "1".equals(adjadd)) {
                //获取编辑区单位信息Map
                Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");
                if ("1".equals(prolev) || agencyMap.isEmpty()) {
                    agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                }
                if (!agencyMap.isEmpty()) {
                    saveAgency = (String) agencyMap.get("value");//单位guid
                }
                //pro_code
                procodeobj = infoMap.get("pro_code");//项目code对象

                if(procodeobj instanceof String){ //新增code为string，修改时code为空
                    procode = (String) infoMap.get("pro_code");//项目code
                }
                if (StringUtil.isEmpty(procode) && procodeobj != null){
                    try {
                        Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                        if (map != null && map.size() > 0) {
                            procode = (String) map.get("value");
                        }
                    }catch (Exception e){
                        procode = (String) infoMap.get("pro_code");
                    }
                }
            }else{
                //是否草稿保存，如果草稿保存值为true
                midsave = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("midsave"), String.class);
                //获取编辑区单位信息Map
                Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");
                if ("1".equals(prolev) || agencyMap == null || agencyMap.isEmpty()) {
                    agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                }
                if (agencyMap != null && !agencyMap.isEmpty()) {
                    saveAgency = (String) agencyMap.get("value");//单位guid
                }
                procodeobj = infoMap.get("pro_code");//项目code对象

                if(procodeobj instanceof String){ //新增code为string
                    procode = (String) infoMap.get("pro_code");//项目code
                }
                if (StringUtil.isEmpty(procode) && procodeobj != null){
                    try {
                        Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                        if (map != null && map.size() > 0) {
                            procode = (String) map.get("value");
                        }
                    }catch (Exception e){
                        procode = (String) infoMap.get("pro_code");
                    }
                }
            }
            logger.debug("--------procode:"+ procode );
            logger.debug("--------projguid:"+ projguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            assessMap.put("pro_code", procode);
            assessMap.put("pdmsave",pdmsave); // 21 暂存，其他正常保存
            assessMap.put("adjadd", adjadd);
            assessMap.put("midsave", midsave);
            assessMap.put("busguid", busguid);
            assessMap.put("proguid", projguid);
            assessMap.put("saveAgency", saveAgency);
            assessMap.put("selectbillguid", selectbillguid);
            //为项目code和name为空的数据做处理
            if (!StringUtil.isEmpty(projguid)) {
                config = perfAssessmentBO.saveData(assessMap);
            } else {
                logger.debug("--------projguids为空,不存在绩效数据---------projguid:"+ projguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (AppException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.debug("--------saveAssessment 开启流程完毕-------------");
        return createJSONString(config);
    }

    /**
     * 绩效事前绩效评估报告
     */
    @ResponseBody
    @RequestMapping(value = "saveBeforeview", produces = {"text/html;charset=utf-8"})
    public String saveBeforeview(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("--------saveBeforeview 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.debug("--------saveBeforeview 开启流程-------tokenid:"+tokenid+"------");
        logger.debug("--------saveBeforeview 开启流程-------province:"+user.getProvince()+"------");
        logger.debug("--------saveBeforeview 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> beforeviewMap = new HashMap<String, Object>();
            String proguid = request.getParameter("proguid");//项目guid
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String busguid = "12F8FEC8CC592F54E0630A64A8C0069D";//审核定义guid，配置表配置
            String midproguid = request.getParameter("midproguid"); //草稿数据
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdmsave = request.getParameter("pdmsave");//项目保存// 21 暂存，其他正常保存
            String prolev = request.getParameter("projtype");//项目级次
            String json = request.getParameter("json");
            logger.debug("--------proguid:"+ proguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            logger.debug("--------项目库调用的保存方式---------pdmsave:"+ pdmsave +"======");
            logger.debug("--------json:"+ json +"======");
            BeforeviewBO beforeviewBO = (BeforeviewBO) PerfServiceFactory.getBean("pmkpi.perfprogram.BeforeviewBOTX");
            if (!StringUtil.isEmpty(json) && !"undefined".equals(json)) {
                String tabindexstr = URLDecoder.decode(json, "utf-8");
                Map infoMap = PerfUtil.parseString2Map(tabindexstr);
                beforeviewMap.put("edifinfo", infoMap);
            }else{
                beforeviewMap.put("edifinfo", new HashMap<>());
            }
            String saveAgency = "";
            String procode = "";
            Object procodeobj = "";
            String midsave = "";
            Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
            infoMap.put("pro_id", proguid);
            this.saveLog(infoMap, "saveBeforeview");
            //处理单位，在pdm_proinfo中获取
            if (!"1".equals(adjadd)) {
                //是否草稿保存，如果草稿保存值为true
                midsave = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("midsave"), String.class);
            }
            //获取编辑区单位信息Map
            Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");
            if ("1".equals(prolev) || agencyMap.isEmpty()) {
                agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
            }
            if (!agencyMap.isEmpty()) {
                saveAgency = (String) agencyMap.get("value");//单位guid
            }
            //pro_code
            procodeobj = infoMap.get("pro_code");//项目code对象
            if(procodeobj instanceof String){ //新增code为string，修改时code为空
                procode = (String) infoMap.get("pro_code");//项目code
            }
            if (StringUtil.isEmpty(procode) && procodeobj != null){
                try {
                    Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                    if (map != null && map.size() > 0) {
                        procode = (String) map.get("value");
                    }
                }catch (Exception e){
                    procode = (String) infoMap.get("pro_code");
                }
            }
            logger.debug("--------procode:"+ procode );
            logger.debug("--------proguid:"+ proguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            beforeviewMap.put("pro_code", procode);
            beforeviewMap.put("pdmsave",pdmsave); // 21 暂存，其他正常保存
            beforeviewMap.put("adjadd", adjadd);
            beforeviewMap.put("midsave", midsave);
            beforeviewMap.put("busguid", busguid);
            beforeviewMap.put("proguid", proguid);
            beforeviewMap.put("saveAgency", saveAgency);
            beforeviewMap.put("selectbillguid", selectbillguid);
            //为项目code和name为空的数据做处理
            if (!StringUtil.isEmpty(proguid)) {
                config = beforeviewBO.saveData(beforeviewMap);
            } else {
                logger.debug("--------projguids为空,不存在绩效数据--------proguid:"+ proguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (AppException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.debug("--------saveBeforeview 开启流程完毕-------------");
        return createJSONString(config);
    }

    /**
     * 绩效目标保存(山西)
     */
    @ResponseBody
    @RequestMapping(value = "saveSxGoal", produces = {"text/html;charset=utf-8"})
    public String saveSxGoal(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("--------saveSxGoal 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.debug("--------saveSxGoal 开启流程-------tokenid:"+tokenid+"------");
        logger.debug("--------saveSxGoal 开启流程-------province:"+user.getProvince()+"------");
        logger.debug("--------saveSxGoal 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> indexMap = new HashMap<String, Object>();
            String projguid = request.getParameter("projguid");//项目guid
            String midproguid = request.getParameter("midproguid"); //草稿数据
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdmsave = request.getParameter("pdmsave");//项目保存// 21 暂存，其他正常保存
            String busguid = "FDDCF71C312941CD9D3408ACC958DBAB";//审核定义guid
            String editinfo = request.getParameter("editinfo");//目标信息
            logger.debug("--------projguid:"+ projguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            logger.debug("--------项目库调用的保存方式---------pdmsave:"+ pdmsave +"======");
            logger.debug("--------编辑区信息---------:"+ editinfo +"======");
            gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
            if(!"undefined".equals(editinfo) && editinfo != null) {
                //指标信息json转成list
                String info = String.valueOf(JSON.parse(URLDecoder.decode(editinfo, "utf-8")));
//                logger.error("--------------目标info = " + info);
                Map infoMap = new HashMap();
                if (info != null && !"".equals(info)) {
                    if (info.indexOf("[") != -1 && info.indexOf("[") != -1) {
                        info = info.substring(info.indexOf("["),info.lastIndexOf("]")+1);
                    }
                    info = "{tagJson:"+info+"}";
                    infoMap = JSON.parseObject(JSON.parseObject(info).getString("tagJson"), Map.class);
                }
                indexMap.put("editinfo", infoMap);
            }
            String saveAgency = "";
            String procode = "";
            Object procodeobj = "";
            String pro_name = "";
            String agency_name = "";
            //处理单位，在pdm_proinfo中获取
            if(!"undefined".equals(pdm_proinfo) && pdm_proinfo != null) {
                Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                infoMap.put("pro_id", projguid);
                this.saveLog(infoMap, "saveSxGoal");
                if("1".equals(adjadd) || adjadd=="1"){
                    procodeobj = infoMap.get("pro_code");//项目code对象
                    /*if(procodeobj instanceof String){ //新增code为string，修改时code为空
                        procode = (String) infoMap.get("pro_code");//项目code
                    }*/
                    if (procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    } else {
                        Map<String, Object> proMap = prjIndexBO.getDataMap("v_perf_project_info", " guid='" + selectbillguid + "'");
                        procode = (String) proMap.get("pro_code");//项目code
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                } else {
                    procodeobj = infoMap.get("pro_code");//项目code对象
                    /*if(procodeobj instanceof String){ //新增code为string，修改时code为空
                        procode = (String) infoMap.get("pro_code");//项目code
                    }*/
                    if (procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    } else {
                        Map<String, Object> proMap = prjIndexBO.getDataMap("v_perf_project_info", " guid='" + projguid + "'");
                        procode = (String) proMap.get("pro_code");//项目code
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }
            }
            indexMap.put("busguid", busguid);
            indexMap.put("projguid", projguid);
            indexMap.put("saveAgency", saveAgency);
            indexMap.put("procode", procode);
            indexMap.put("pro_name", pro_name);
            indexMap.put("agency_name", agency_name);
            indexMap.put("pdmsave",pdmsave);
            indexMap.put("adjadd", adjadd);
            //为项目code和name为空的数据做处理
            if(projguid != null && !"".equals(projguid)){
//                config = prjIndexBO.saveData(indexMap);
                logger.debug("--------saveSxData---------projguid:"+ indexMap +"开启流程");
                config = prjIndexBO.saveSxData(indexMap);
            } else {
                logger.debug("--------projguids为空,不存在绩效数据---------projguid:"+ projguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.debug("--------saveGoal 开启流程完毕-------------");
        return createJSONString(config);
    }

    protected String createJSONString(Object obj) {
        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
        String json = jo.toString();
        return json;
    }

    /**
     * 绩效指标树级保存.
     */
    @ResponseBody
    @RequestMapping(value = "saveTreeIndex", produces = {"text/html;charset=utf-8"})
    public String saveTreeIndex(HttpServletRequest request, HttpServletResponse response) {
        logger.info("--------saveTreeIndex 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.info("--------saveTreeIndex 开启流程-------tokenid:"+tokenid+"------");
        logger.info("--------saveTreeIndex 开启流程-------province:"+user.getProvince()+"------");
        logger.info("--------saveTreeIndex 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> indexMap = new HashMap<String, Object>();
            String projguid = request.getParameter("projguid");//项目guid
            String midproguid = request.getParameter("midproguid");//草稿
            String prolev = request.getParameter("projtype");//项目级次
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String pdmsave = request.getParameter("pdmsave");//是否保存
            String showtab = request.getParameter("showtab"); //指标填报的页签：总+年
            String permList = request.getParameter("indexdata");//指标信息
            String busguid = PerfUtil.getSystemSet("PERF_PROINDEXBUSGUID");//审核定义guid，配置表配置
            String issuper = request.getParameter("issuper");//浙江监审标识
            String isfundcal = request.getParameter("isfundcal");//浙江指标与项目测算标识
            String procode = request.getParameter("procode");//项目编码
            String isedittotal = request.getParameter("isedittotal");//
            String isperform = request.getParameter("isperform");//是否特殊绩效
            String projname = URLDecoder.decode(request.getParameter("projname"),"UTF-8");
            logger.info("--------projname:"+ projname );
            logger.info("--------issuper:"+ issuper );
            logger.info("--------isfundcal:"+ isfundcal );
            PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            PerfSupervisionBO perfSupervisionBO = (PerfSupervisionBO) PerfServiceFactory.getBean("pmkpi.perfSupervision.PerfSupervisionBOTX");

            FundCalIndexBO fundCalIndexBO = (FundCalIndexBO) PerfServiceFactory.getBean("pmkpi.fundCalIndex.FundCalIndexBOTX");

            Map data = new HashMap();
            if (!StringUtil.isEmpty(permList) && !"undefined".equals(permList)) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(permList, "utf-8");
//                logger.error("--------------目标info = " + tabindexstr);
                data = PerfUtil.parseString2Map(tabindexstr);
                for (Object str1 : data.keySet()) {
                    String c = (String) data.get(str1);
                    List list = (List) PerfUtil.parseString2List(c);
                    data.put(str1,list);
                }
                logger.info("--------------指标data = " + data.toString());
            }
            String saveAgency = "";
            Object procodeobj = "";
            String midsave = "";
            String pro_name = "";
            String agency_name = "";
            if(!StringUtil.isEmpty(pdm_proinfo)&&!"undefined".equals(pdm_proinfo)) {
                Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                infoMap.put("pro_id", projguid);
                this.saveLog(infoMap, "saveTreeIndex");
                if ( "1".equals(adjadd)) {
                    //pro_code
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string，修改时code为空
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }else{
                    //是否草稿保存，如果草稿保存值为true
                    midsave = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("midsave"), String.class);
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }
            }
            indexMap.put("busguid", busguid);
            indexMap.put("projguid", projguid);
            indexMap.put("saveAgency", saveAgency);
            indexMap.put("procode", procode);
            indexMap.put("pdmsave",pdmsave); // 21 暂存，其他正常保存
            indexMap.put("showtab",showtab);
            indexMap.put("datas",data);
            indexMap.put("isnest","1");
            indexMap.put("adjadd", adjadd);
            indexMap.put("midsave", midsave);
            indexMap.put("selectbillguid", selectbillguid);
            indexMap.put("isedittotal", isedittotal);
            indexMap.put("pro_name", projname);
            indexMap.put("agency_name", agency_name);
            indexMap.put("isperform", isperform);
            logger.info("--------adjadd:"+ adjadd );
            logger.info("--------procode:"+ procode );
            logger.info("--------projguid:"+ projguid );
            logger.info("--------midproguid：" + midproguid);
            logger.info("--------selectbillguid:"+ selectbillguid);
            //为项目code和name为空的数据做处理
            if (!StringUtil.isEmpty(projguid)) {
                config = prjIndexBO.savePrjTreeIndex(indexMap);
                // 处理监审指标强制调整状态
                if(!StringUtil.isEmpty(issuper) && "1".equals(issuper)){
                    perfSupervisionBO.updateIsSuper(procode);
                }
                // 处理绩效指标与项目测算关系
                //if(!StringUtil.isEmpty(isfundcal) && "1".equals(isfundcal)){
                //    logger.info("--------处理绩效指标与项目测算开启---------");
                //    fundCalIndexBO.saveCalIndex(indexMap);
                //    logger.info("--------处理绩效指标与项目测算关闭---------");
                //}
            } else {
                logger.info("--------projguids为空,不存在绩效数据---------projguid:"+ projguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.info("config-----------" + config);
        logger.info("--------saveTreeIndex 开启流程完毕-------------");
        return createJSONString(config);
    }

    /**
     * 细化区域年度绩效
     */
    @ResponseBody
    @RequestMapping(value = "saveTraGoalAndIndex", produces = {"text/html;charset=utf-8"})
    public String saveTraGoalAndIndex(HttpServletRequest request, HttpServletResponse response) {
        logger.info("--------saveTraGoalAndIndex 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.info("--------saveTraGoalAndIndex 开启流程-------tokenid:"+tokenid+"------");
        logger.info("--------saveTraGoalAndIndex 开启流程-------province:"+user.getProvince()+"------");
        logger.info("--------saveTraGoalAndIndex 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> indexMap = new HashMap<>();
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String json = request.getParameter("json");//指标信息
            String procode = request.getParameter("procode");//项目编码
            PrjTraGoalAndIndexBO prjTraGoalAndIndexBO  = (PrjTraGoalAndIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjTraGoalAndIndexBOTX");
            Map<String, Object> data = new HashMap();
            if (!StringUtil.isEmpty(json) && !"undefined".equals(json)) {
                //指标信息json转成Map
                String str = URLDecoder.decode(json, "utf-8");
                data = PerfUtil.parseString2Map(str);
            }
            String saveAgency = "";
            Object procodeobj = "";
            String pro_name = "";
            String agency_name = "";
            logger.info("--------saveTraGoalAndIndex -------procode:"+procode+"------");
            if(!StringUtil.isEmpty(pdm_proinfo)&&!"undefined".equals(pdm_proinfo)) {
                Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                this.saveLog(infoMap, "saveTraGoalAndIndex");
                procodeobj = infoMap.get("pro_code");//项目code对象
                if(procodeobj instanceof String){ //新增code为string
                    procode = (String) infoMap.get("pro_code");//项目code
                }
                if (StringUtil.isEmpty(procode) && procodeobj != null){
                    try {
                        Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                        if (map != null && map.size() > 0) {
                            procode = (String) map.get("value");
                        }
                    }catch (Exception e){
                        procode = (String) infoMap.get("pro_code");
                    }
                }
                //获取项目编辑区信息Map
                Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                    pro_name = (String) pro_nameMap.get("value");
                }
                Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                if (agencyMap != null && !agencyMap.isEmpty()) {
                    saveAgency = (String) agencyMap.get("value");//单位guid
                    String temp_name = (String) agencyMap.get("text");
                    if (!StringUtil.isEmpty(temp_name)){
                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                    }
                }
                if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                    int usertype = CommonUtil.getCurrentUser().getUsertype();
                    logger.info("usertype:--->" + usertype);
                    if (1 == usertype){
                        agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                        if (agencyMap != null && !agencyMap.isEmpty()) {
                            saveAgency = (String) agencyMap.get("value");//单位guid
                            String temp_name = (String) agencyMap.get("text");
                            if (!StringUtil.isEmpty(temp_name)){
                                agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                            }
                        }
                        if (StringUtil.isEmpty(saveAgency)){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                        }
                    } else {
                        saveAgency = CommonUtil.getCurrentUser().getAgency();
                    }
                }
            }
            indexMap.put("saveAgency", saveAgency);
            indexMap.put("procode", procode);
            indexMap.put("datas", data);
            indexMap.put("pro_name", pro_name);
            indexMap.put("agency_name", agency_name);
            logger.info("--------procode:"+ procode );
            //为项目code和name为空的数据做处理
            if (!StringUtil.isEmpty(procode)) {
                config = prjTraGoalAndIndexBO.saveGoalAndIndex(indexMap);
            } else {
                logger.info("--------procode为空,不存在绩效数据---------procode:"+ procode +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.info("--------saveTraGoalAndIndex 开启流程完毕-------------");
        return createJSONString(config);
    }

    /**
     * 绩效目标保存
     */
    @ResponseBody
    @RequestMapping(value = "saveAllGoal", produces = {"text/html;charset=utf-8"})
    public String saveAllGoal(HttpServletRequest request, HttpServletResponse response) {
        logger.info("--------saveAllGoal 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.info("--------saveAllGoal 开启流程-------tokenid:"+tokenid+"------");
        logger.info("--------saveAllGoal 开启流程-------province:"+user.getProvince()+"------");
        logger.info("--------saveAllGoal 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> indexMap = new HashMap<String, Object>();
            String projguid = request.getParameter("projguid");//项目guid
            String midproguid = request.getParameter("midproguid"); //草稿数据
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String isedittotal = request.getParameter("isedittotal");
            String prolev = request.getParameter("projtype"); //1一级项目 2.二级项目
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdmsave = request.getParameter("pdmsave");//项目保存// 21 暂存，其他正常保存
            String busguid = "FDDCF71C312941CD9D3408ACC958DBAB";//审核定义guid
            String goaljson = request.getParameter("goaljson");//目标信息
            String showtab = request.getParameter("showtab");
            String procode = request.getParameter("procode");//项目编码
            String isperform = request.getParameter("isperform");//是否特殊绩效
            String projname = URLDecoder.decode(request.getParameter("projname"),"UTF-8");
            logger.info("--------projname:"+ projname );
            gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
            Map data = new HashMap();
            if (!StringUtil.isEmpty(goaljson) && !"undefined".equals(goaljson)) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(goaljson, "utf-8");
                data = PerfUtil.parseString2Map(tabindexstr);
                logger.info("--------------目标数据data = " + data.toString());
            }
            String saveAgency = "";
            Object procodeobj = "";
            String midsave = "";
            String pro_name = "";
            String agency_name = "";
            //处理单位，在pdm_proinfo中获取
            if(!"undefined".equals(pdm_proinfo) && pdm_proinfo != null) {
                Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                infoMap.put("pro_id", projguid);
                this.saveLog(infoMap, "saveAllGoal");
                if ("1".equals(adjadd)) {
                    //获取编辑区全部信息Map
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                } else {
                    //是否草稿保存，如果草稿保存值为true
                    midsave = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("midsave"), String.class);
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        logger.info("项目code对象：procodeobj="+procodeobj +"--------------- 项目code编码：procode"+procode);
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }
            }
            indexMap.put("busguid", busguid);
            indexMap.put("projguid", projguid);
            indexMap.put("saveAgency", saveAgency);
            indexMap.put("procode", procode);
            indexMap.put("pdmsave",pdmsave);
            indexMap.put("adjadd", adjadd);
            indexMap.put("goaldata", data);
            indexMap.put("showtab", showtab);
            indexMap.put("isedittotal", isedittotal);
            indexMap.put("midsave", midsave);
            indexMap.put("selectbillguid", selectbillguid);
            indexMap.put("pro_name", projname);
            indexMap.put("agency_name", agency_name);
            indexMap.put("isperform", isperform);
            logger.info("--------procode:"+ procode );
            logger.info("--------projguid:"+ projguid );
            logger.info("--------midproguid：" + midproguid);
            logger.info("--------selectbillguid:"+ selectbillguid);
            logger.info("--------项目库调用的保存方式---------pdmsave:"+ pdmsave +"======");
            logger.info("---------封装项目目标基本信息：indexMap="+indexMap);
            //为项目code和name为空的数据做处理
            if(!StringUtil.isEmpty(projguid)){
                config = prjIndexBO.saveGoal(indexMap);
            } else {
                logger.info("--------projguids为空,不存在绩效数据---------projguid:"+ projguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (AppException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.info("--------saveAllGoal 开启流程完毕-------------");
        return createJSONString(config);
    }
    /**
     * 项目绩效目标校验接口
     */
    @ResponseBody
    @RequestMapping(value = "sendPmindicator/{province}/{year}")
    public MicroParamDTO sendPmindicator(@PathVariable("province") String province,
                                         @PathVariable("year") String year,
                                         @RequestParam(value = "checktype") String checktype,
                                         @RequestBody Map dataMap){
        logger.debug("----sendPmindicator-------------项目绩效目标校验开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            Map<String,Object> map = new HashMap<>();
            map.put("key", "checktype");
            map.put("value", checktype);

            logger.debug("---- 校验类型:"+checktype+"-----------dataMap：" + dataMap.toString());
            //是否是转移支付项目
            String istra = dataMap.get("istra") + "";
            //封装项目guid、项目code
            List<Map<String,Object>> idcodes = (List<Map<String, Object>>) dataMap.get("idcodes");
            List<Map<String,Object>> codeList = new ArrayList<>();
            StringBuilder wheresql = new StringBuilder("(");
            if (idcodes != null && idcodes.size() > 0){
                logger.debug("------项目idcodes:-----"+idcodes.toString());
                for (int i = 0; i < idcodes.size(); i++) {
                    Map<String, Object> idcode = idcodes.get(i);
                    Map<String,Object> guidMap = new HashMap<>();
                    String submofdiv = (String) idcode.get("submofdiv");
                    String procode = (String) idcode.get("procode");
                    guidMap.put("guid", idcode.get("proid"));
                    guidMap.put("code", procode);
                    codeList.add(guidMap);
                    if ("1".equals(istra) && !StringUtil.isEmpty(submofdiv)) {
                        String[] strs = submofdiv.split(",");
                        guidMap.put("province", submofdiv.toString());
                        wheresql.append("(pro_code='").append(procode).append("' and ");
                        wheresql.append(pmkpiDAO.createInSql("sub_mof_div_code not", Arrays.asList(strs))).append(") or ");
                    }
                }
                if ("1".equals(istra) && wheresql.length() > 1) {
                    wheresql.delete(wheresql.length() - 3, wheresql.length());
                    wheresql.append(")");
                }
                logger.debug("------codeList：------"+codeList.toString());
                logger.debug("------wheresql：------"+wheresql.toString());
            }else{
                logger.debug("-------idcodes为空,项目不存在----------校验失败");
            }
            if (codeList != null && codeList.size() > 0) {
                //调用审核定义方法
                Map<String, Object> auditMap = null;
                if ("1".equals(istra)) {
                    auditMap = prjIndexBO.auditdefine(codeList, "C4892842174917EDE0535B03A8C02EAC", "perf", map);
                } else {
                    auditMap = prjIndexBO.auditdefine(codeList, "0004F846CE6D4CB8BF106666F0DC0C0C", "perf", map);
                }
                Boolean success =(Boolean) auditMap.get("success");
                if (success){
                    resultMap.put("success",true);
                    logger.debug("---------------校验成功---------------"+success);
                    //如果是转移支付项目，需要清理项目绩效数据
                    if ("1".equals(istra) && wheresql.length() > 1) {
                        wheresql.append(" and yearflag = '0' and t.is_deleted=2 and t.is_backup=2 and sub_mof_div_code is not null ");
                        wheresql.append(PerfUtil.yearProvinceSql("t"));
                        pmkpiDAO.updateIsDeleteDatas(PerfConstant.PMKPI_BACKUP_INDICATOR, wheresql.toString());
                        pmkpiDAO.updateIsDeleteDatas(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql.toString());
                    }

                }
            }else{
                logger.debug("-------resultList为空,项目不存在绩效目标数据----------校验失败");
            }
        }catch (PerfAppException e){
            //审核定义失败
            resultMap = prjIndexBO.getExceptionMes(e);
        }catch (AppException e){
            resultMap.put("error",e.getMessage());
        }
        MicroParamDTO dto = new MicroParamDTO();
        dto.setMap(resultMap);
        logger.error("返回信息："+resultMap);
        return dto;
    }

    /**
     * 部门整体的绩效目标审核定义接口
     */
    @ResponseBody
    @RequestMapping(value = "sendDeptPmindicators/{province}/{year}")
    public MicroParamDTO sendDeptPmindicators(@PathVariable("province") String province,
                                              @PathVariable("year") String year,
                                              @RequestBody List<String> agencylist){
        logger.debug("单位："+agencylist.toString());
        logger.debug("---------------部门整体绩效目标校验开始---------------");    //项目guid
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            //封装项目id
            List<Map<String,Object>> codeList = new ArrayList<>();
            for (String ss : agencylist) {
                Map<String,Object> guidMap = new HashMap<>();
                guidMap.put("guid",ss);
                codeList.add(guidMap);
            }
            if (codeList != null && codeList.size() > 0) {
                //调用审核定义方法
                Map<String, Object> auditMap = prjIndexBO.auditdefine(codeList, "0004F846CE6D4CB8BF107777F0DC0C0C", "perf", null);
                Boolean success =(Boolean) auditMap.get("success");
                if (success){
                    resultMap.put("success",true);
                    logger.debug("---------------校验成功---------------"+success);
                }
            }else{
                logger.debug("-------resultList为空,部门整体不存在绩效目标数据----------校验失败");
            }
        }catch (PerfAppException e){
            //审核定义失败
            resultMap = prjIndexBO.getExceptionMes(e);
        }catch (AppException e){
            resultMap.put("error",e.getMessage());
        }
        MicroParamDTO dto = new MicroParamDTO();
        dto.setMap(resultMap);
        logger.debug("返回信息："+resultMap);
        return dto;
    }

    /**
     * 项目删除同步删除绩效数据
     * 1、储备删除,（以前项目终止is_end=1也会调用此接口，和项目库区分了终止接口调用deltype=9）,但有地区不需要删除往年年度绩效要做自评
     * 2、调整删除 3、调整终审删除 4、取消调整终审，需要还原调整前数据
     * 还有就是项目库取消纳入今年的预算编制的环节删除。
     */
    @ResponseBody
    @RequestMapping(value = "delGoalAndIndex/{province}/{year}")
    public MicroParamDTO delGoalAndIndex(@PathVariable("province") String province,
                                         @PathVariable("year") String year,
                                         @RequestBody Map dataMap){
        //获取项目集合数据 集合中存放参数 proguid（储备、调整前项目guid）  adjproguid 调整项目guid
        List<Map<String, Object>> proList = (List<Map<String, Object>>) dataMap.get("proList");
        //删除类型 1、储备删除 2、调整删除 3、调整终审删除 4、取消调整终审，需要还原调整前数据9、项目终止is_end
        String deltype = (String) dataMap.get("deltype");
        MicroParamDTO dto = new MicroParamDTO();
        logger.info("---------------删除绩效目标、指标开始---------------");    //项目guid
        logger.info("类型deltype:+++++++++++++++++【" + deltype + "】+++++++++++++项目proList+++++++++++++：" + proList.toString());
        Map<String,Object> resultMap = new HashMap<>();
        try{
            PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            resultMap = prjIndexBO.delGoalAndIndex(deltype, proList);
        }catch (Exception e){
            resultMap.put("success", "false");
            resultMap.put("msg", "刪除失败");
            logger.error(e.getMessage(), e);
        }
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }

    /**
     * 预算删除同步删除绩效年度数据
     * @Prolist {procode,procode} --编码.
     */
    @ResponseBody
    @RequestMapping(value = "delYearIndex/{province}/{year}")
    public MicroParamDTO delYearIndex(@PathVariable("province") String province,
                                         @PathVariable("year") String year,
                                      @RequestBody List<String> prolist){
        MicroParamDTO dto = new MicroParamDTO();
        logger.debug("---------------预算系统删除年度绩效目标、指标开始---------------");    //项目guid
        logger.debug("+++++++++++++项目proList+++++++++++++：" + prolist.toString());
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        try{
            if (prolist != null && prolist.size() >0) {
                String time = PerfUtil.getServerTimeStamp();
                //封装项目id
                StringBuffer sql = new StringBuffer(" set t.updatetime='").append(time).append("',t.update_time='").append(time).append("'");
                sql.append(" ,is_deleted=1 ");
                sql.append(" where pro_code in( ");
                for (String tempcode : prolist) {
                    sql.append("'").append(tempcode).append("',");
                }
                sql.deleteCharAt(sql.length() - 1);
                sql.append(")");
                sql.append(" and yearflag='0'");
                sql.append(" and is_deleted = 2 and is_backup = 2 and t.province='" + province+ "' and year = " + year);//修改为删除对应年度区划的物理表数据
                prjIndexDAO.updateDatas("pm_perf_goal_info", sql.toString());
                prjIndexDAO.updateDatas("pm_perf_indicator", sql.toString());
            }
            resultMap.put("success", "true");
            resultMap.put("msg", "年度绩效刪除成功");
            logger.debug("---------------预算系统删除年度绩效目标、指标結束---------------");    //项目guid
        }catch (Exception e){
            resultMap.put("success", "false");
            resultMap.put("msg", "年度绩效刪除失败");
            logger.error(e.getMessage(), e);
        }
        dto.setMap(resultMap);
        logger.debug("返回信息："+resultMap);
        return dto;
    }

    /**
     * 河北一体化预算编制的接口.
     * 用于校验项目的年度绩效目标是否通过.
     */
    @ResponseBody
    @GetMapping(value = "sendHbPerformance/checkperformance",produces = {"application/json;charset=UTF-8"})
    public String sendHbPerformance(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestParam(value = "checktype") String checktype,
            @RequestParam(value = "proList" , required = false) List<String> proList){
        logger.debug("项目主键proguids："+proList.toString()+"---- 校验类型:"+checktype+"-----------");
        logger.debug("----sendHbPerformance-------------河北项目绩效校验开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexBO mergeIndexBO = (MergeIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexBOTX");
        try{
            //封装项目id
            List<Map<String,Object>> guidList = new ArrayList<>();
            for (String ss : proList) {
                Map<String,Object> guidMap = new HashMap<>();
                guidMap.put("guid",ss);
                guidList.add(guidMap);
            }
            if (guidList != null && guidList.size() > 0) {
                logger.debug("--类型：--"+checktype+"--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexBO.checkHBPerfindex(checktype,province,year,guidList);
                resultMap.put("result",true);
                resultMap.put("checklist",checkList);
                resultMap.put("message","成功！");
                logger.debug("---------------校验成功：---------------");
                logger.debug("---------------校验结果：---------------"+checkList.toString());
            }else{
                resultMap.put("result",false);
                resultMap.put("message","guidList为空");
                logger.debug("-------guidList,----------河北项目绩效校验失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        String jsonresult = "";
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
            logger.error("转换JSON流程失败："+resultMap);
        }
        return jsonresult;
    }

    /**
     * 河北一体化预算编制的接口.
     * 用于调整调剂终审绩效覆盖申报数据.
     */
    @ResponseBody
    @GetMapping(value = "auditHbPerformance/endformance",produces = {"application/json;charset=UTF-8"})
    public String auditHbPerformance(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestParam(value = "checktype") String checktype,
            @RequestParam(value = "adjusttype" , required = false) String adjusttype,
            @RequestParam(value = "proList" , required = false) List<String> proList){
        logger.debug("项目主键proguids："+proList.toString()+"---- 类型:"+checktype+"-----------");
        logger.debug("----auditHbPerformance-------------河北项目绩效调剂终审开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexAdjustBO mergeIndexAdjustBO = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
        try{
            //封装项目id
            List<Map<String,Object>> guidList = new ArrayList<>();
            for (String ss : proList) {
                Map<String,Object> guidMap = new HashMap<>();
                guidMap.put("guid",ss);
                guidList.add(guidMap);
            }
            if (guidList != null && guidList.size() > 0) {
                String yearflag = adjusttype!=null ? adjusttype : "0";//1为调整总体绩效,默认为0年度绩效
                logger.debug("--调整类型：--"+yearflag+"--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexAdjustBO.endHBPerformance(adjusttype,province,year,guidList);
//                if(checkList.size()>0){
//                    logger.error("---------------终审结果：---------------"+checkList.toString());
//                    resultMap.put("result",false);
//                    resultMap.put("checklist",checkList);
//                    resultMap.put("message","查询不到项目调整数据");
//                }else{
                    resultMap.put("result",true);
                    resultMap.put("checklist",checkList);
                    resultMap.put("message","成功！");
//                }
                logger.debug("---------------终审成功：---------------");
            }else{
                resultMap.put("result",false);
                resultMap.put("message","guidList为空");
                logger.debug("-------guidList,----------河北项目绩效调剂终审失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        String jsonresult = "";
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
            logger.error("转换JSON流程失败："+resultMap);
        }
        return jsonresult;
    }

    /**
     * 预算调整调剂保存/送审校验接口
     */
    @ResponseBody
    @RequestMapping(value = "checkYearAdjperformance/{province}/{year}",method = RequestMethod.POST)
    public Map checkYearAdjperformance(@PathVariable("province") String province,
                                       @PathVariable("year") String year,
                                       @RequestBody List<String> procodeList){
        logger.debug("项目编码procode："+procodeList.toString()+"---------------");
        logger.debug("----checkYearAdjperformance-------------预算调整调剂保存/送审校验开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexAdjustBO mergeIndexAdjustBO = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
        try{
            //封装项目id
            List<Map<String,Object>> guidList = new ArrayList<>();
            for (String ss : procodeList) {
                Map<String,Object> guidMap = new HashMap<>();
                guidMap.put("guid",ss);
                guidList.add(guidMap);
            }
            if (guidList != null && guidList.size() > 0) {
                logger.debug("--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexAdjustBO.checkYearAdjperformance(province,year,guidList);
                if (checkList == null || checkList.size() == 0) {
                    resultMap.put("result", true);
                    resultMap.put("message","成功！");
                } else {
                    resultMap.put("result", false);
                    resultMap.put("checklist",checkList);
                    resultMap.put("message","失败！");
                }
                logger.debug("---------------校验成功：---------------");
                logger.debug("---------------校验结果：---------------"+checkList.toString());
            }else{
                resultMap.put("result",false);
                resultMap.put("message","guidList为空");
                logger.debug("-------guidList,----------预算调整调剂保存/送审校验失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        return resultMap;
    }

    /**
     * 预算调整调剂终审接口
     */
    @ResponseBody
    @RequestMapping(value = "endAdjperformance/{province}/{year}",method = RequestMethod.POST)
    public Map endAdjperformance(@PathVariable("province") String province,
                                 @PathVariable("year") String year,
                                 @RequestBody List<Map<String, Object> > proList){
        logger.debug("项目编码procode："+proList.toString()+"---------------");
        logger.debug("----endAdjperformance-------------预算调整调剂终审开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexAdjustBO mergeIndexAdjustBO = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
        try{
            if (proList != null && proList.size() > 0) {
                logger.debug("--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexAdjustBO.endAdjperformance(province, year, proList);
                resultMap.put("result",true);
                resultMap.put("checklist",checkList);
                resultMap.put("message","成功！");
                logger.debug("---------------终审成功：---------------");
            } else {
                resultMap.put("result",false);
                resultMap.put("message","guidList为空");
                logger.debug("-------guidList,----------预算调整调剂终审失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        return resultMap;
    }

    /**
     * 预算调整调剂取消终审接口
     */
    @ResponseBody
    @RequestMapping(value = "cancelEndAdjperformance/{province}/{year}",method = RequestMethod.POST)
    public Map cancelEndAdjperformance(@PathVariable("province") String province,
                                       @PathVariable("year") String year,
                                       @RequestBody List<String> procodeList){
        logger.debug("项目编码procode："+procodeList.toString()+"---------------");
        logger.debug("----cancelEndAdjperformance-------------预算调整调剂取消终审开始---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexAdjustBO mergeIndexAdjustBO = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
        try{
            //封装项目id
            if (procodeList != null && procodeList.size() > 0) {
                logger.debug("--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexAdjustBO.cancelEndAdjperformance(province, year, procodeList);
                resultMap.put("result",true);
                resultMap.put("checklist",checkList);
                resultMap.put("message","成功！");
                logger.debug("---------------取消终审成功：---------------");
            } else {
                resultMap.put("result",false);
                resultMap.put("message","procodeList为空");
                logger.debug("-------procodeList,----------预算调整调剂取消终审失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        return resultMap;
    }

    /**
     * 预算调整调剂删除接口
     */
    @ResponseBody
    @RequestMapping(value = "delAdjperformance/{province}/{year}",method = RequestMethod.POST)
    public Map delAdjperformance(@PathVariable("province") String province,
                                       @PathVariable("year") String year,
                                       @RequestBody List<String> procodeList){
        logger.debug("----delAdjperformance-------------预算调整调剂删除开始---------------");
        logger.debug("项目编码procode："+procodeList.toString()+"---------------");
        Map<String,Object> resultMap = new HashMap<>();
        MergeIndexAdjustBO mergeIndexAdjustBO = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
        try{
            //封装项目id
            if (procodeList != null && procodeList.size() > 0) {
                logger.debug("--区划：--"+province+"--年度：--"+year);
                List checkList = mergeIndexAdjustBO.delAdjperformance(province, year, procodeList);
                resultMap.put("result",true);
                resultMap.put("checklist",checkList);
                resultMap.put("message","成功！");
                logger.debug("---------------预算调整调剂删除成功---------------");
            } else {
                resultMap.put("result",false);
                resultMap.put("message","procodeList为空");
                logger.debug("-------procodeList,----------预算调整调剂删除失败");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
        logger.debug("返回信息："+resultMap);
        return resultMap;
    }


    /**
     * 备份数据接口 -- 备份预算一上终审后的绩效数据
    */
    @ResponseBody
    @RequestMapping(value = "copy/copyProjectGoal", method = RequestMethod.POST)
    public Map copyProjectGoal( @RequestBody List<String> AgencyList){
        logger.debug("----copyProjectGoal-------------备份一上终审后绩效数据开始---------------");
        logger.debug("单位集合agencyList：" + AgencyList.toString());
        Map<String, Object> result = new HashMap<>();
        String tempagency = String.join(",", AgencyList);
        Map deptmap = new HashMap();
        StringBuffer deptstr = new StringBuffer();
        String keycode = "";
        for (String tempcode: AgencyList) {
            keycode = tempcode.length() == 3 ? tempcode : tempcode.substring(0, tempcode.length() - 3);
            if (deptmap.containsKey(keycode)){
                continue;
            } else {
                deptmap.put(keycode, "1");
                deptstr.append(",'").append(keycode).append("'");
            }
        }
        String agency = "'" + tempagency.replaceAll(",","','") + "'" + deptstr;
        String wheresql = " t.agencyguid in("+ agency +") ";
        Map<String, Object> tableMap = new HashMap<>();
        tableMap.put("V_PM_PERF_GOAL_INFO", wheresql + " and t.yearflag= '0'" + "&-&1");//项目目标表，逻辑删除
        tableMap.put("V_PM_PERF_INDICATOR", wheresql + " and t.yearflag= '0'" + "&-&1");//项目指标表，逻辑删除
        tableMap.put("V_BGT_PERF_GOAL_INFO", wheresql + "&-&1");//部门目标表，逻辑删除
        tableMap.put("V_BGT_PERF_INDICATOR", wheresql + "&-&1");//部门指标表，逻辑删除
        tableMap.put("V_PERF_T_DEPTTASK", wheresql + "&-&0");//部门任务表，物理删除
        tableMap.put("V_PERF_T_DEPTPERFDECLARE", wheresql + "&-&0");//部门整体主单表，物理删除
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        try {
            for (String tablecode : tableMap.keySet()) {
                String value = (String) tableMap.get(tablecode);
                logger.debug(tablecode + " ：" + value);
                String[] str = value.split("&-&");
                List<Map<String, Object>> datas = prjIndexBO.getDatas(tablecode, str[0], null);
                if (datas.size() > 0) {
                    wheresql = str[0] + PerfUtil.yearProvinceSql("t");
                    //创建项目目标备份表
                    tablecode = tablecode.substring(2);
                    String copygoalTable = tablecode + "_ONE";
                    prjIndexDAO.createTable(copygoalTable, tablecode);
                    if ("1".equals(str[1])) {
                        prjIndexDAO.updateIsDeleteDatas(copygoalTable, wheresql);
                    } else {
                        prjIndexDAO.delDatas(copygoalTable, wheresql);
                    }
                    prjIndexDAO.saveAll(datas, copygoalTable);
                }
            }
            result.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            result.put("success", false);
        }
        logger.debug("----copyProjectGoal-------------备份一上终审后绩效数据结束---------------");
        return  result;
    }



    /**
     * 绩效指标树级保存.
     */
    @ResponseBody
    @RequestMapping(value = "saveGoalAndIndex", produces = {"text/html;charset=utf-8"})
    public String saveGoalAndIndex(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("--------saveGoalAndIndex 开启流程开始-------------");
        String tokenid = request.getParameter("tokenid");
        UserDTO user = SecureUtil.getCurrentUser();
        logger.debug("--------saveGoalAndIndex 开启流程-------tokenid:"+tokenid+"------");
        logger.debug("--------saveGoalAndIndex 开启流程-------province:"+user.getProvince()+"------");
        logger.debug("--------saveGoalAndIndex 开启流程-------year:"+ CommonUtil.getYear()+"------");
        Map config = new HashMap();
        try {
            HashMap<String, Object> indexMap = new HashMap<String, Object>();
            String projguid = request.getParameter("projguid");//项目guid
            String midproguid = request.getParameter("midproguid");//草稿
            String prolev = request.getParameter("projtype");//项目级次
            String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
            String adjadd = request.getParameter("adjadd");//是否调整
            String pdm_proinfo = request.getParameter("pdm_proinfo");//项目基本信息
            String pdmsave = request.getParameter("pdmsave");//是否保存
            String showtab = request.getParameter("showtab"); //指标填报的页签：总+年
            String busguid = PerfUtil.getSystemSet("PERF_PROINDEXBUSGUID");//审核定义guid，配置表配置
            String procode = request.getParameter("procode");//项目编码
            String isedittotal = request.getParameter("isedittotal");
            String totalgoalsjson = request.getParameter("totalgoalsjson");
            String yeargoalsjson = request.getParameter("yeargoalsjson");
            String deltotaljson = request.getParameter("deltotaljson");
            String delyearjson = request.getParameter("delyearjson");
            gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
            List<Map<String, Object>> totalgoals = new ArrayList<>();
            List<Map<String, Object>> yeargoals = new ArrayList<>();
            List<Map<String, Object>> deltotal = new ArrayList<>();
            List<Map<String, Object>> delyear = new ArrayList<>();
            if(!"undefined".equals(totalgoalsjson) && totalgoalsjson != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(totalgoalsjson, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                totalgoals = PerfUtil.parseString2List(tabindexstr);
                logger.debug("--------------长期目标指标data = " + totalgoals.toString());
            }
            if(!"undefined".equals(yeargoalsjson) && yeargoalsjson != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(yeargoalsjson, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                yeargoals = PerfUtil.parseString2List(tabindexstr);
                logger.debug("--------------年度目标指标data = " + yeargoals.toString());
            }
            if(!"undefined".equals(deltotaljson) && deltotaljson != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(deltotaljson, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                deltotal = PerfUtil.parseString2List(tabindexstr);
                logger.debug("--------------删除长期目标指标data = " + deltotal.toString());
            }
            if(!"undefined".equals(delyearjson) && delyearjson != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(delyearjson, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                delyear = PerfUtil.parseString2List(tabindexstr);
                logger.debug("--------------删除年度目标指标data = " + delyear.toString());
            }
            String saveAgency = "";
            Object procodeobj = "";
            String midsave = "";
            String pro_name = "";
            String agency_name = "";
            if(!StringUtil.isEmpty(pdm_proinfo)&&!"undefined".equals(pdm_proinfo)) {
                if ( "1".equals(adjadd)) {
                    //获取编辑区全部信息Map
                    Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                    //pro_code
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string，修改时code为空
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }else{
                    //获取编辑区全部信息Map
                    Map<String, Object> infoMap = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("editform"), Map.class);
                    //是否草稿保存，如果草稿保存值为true
                    midsave = JSON.parseObject(JSON.parseObject(pdm_proinfo).getString("midsave"), String.class);
                    procodeobj = infoMap.get("pro_code");//项目code对象

                    if(procodeobj instanceof String){ //新增code为string
                        procode = (String) infoMap.get("pro_code");//项目code
                    }
                    if (StringUtil.isEmpty(procode) && procodeobj != null){
                        try {
                            Map map = JSONObject.parseObject(procodeobj.toString(), Map.class);
                            if (map != null && map.size() > 0) {
                                procode = (String) map.get("value");
                            }
                        }catch (Exception e){
                            procode = (String) infoMap.get("pro_code");
                        }
                    }
                    //获取项目编辑区信息Map
                    Map<String, Object> pro_nameMap = (Map<String, Object>) infoMap.get("pro_name");
                    if (pro_nameMap != null && !pro_nameMap.isEmpty()) {
                        pro_name = (String) pro_nameMap.get("value");
                    }
                    Map<String, Object> agencyMap = (Map<String, Object>) infoMap.get("agency_code");//获取单位名称
                    if (agencyMap != null && !agencyMap.isEmpty()) {
                        saveAgency = (String) agencyMap.get("value");//单位guid
                        String temp_name = (String) agencyMap.get("text");
                        if (!StringUtil.isEmpty(temp_name)){
                            agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                        }
                    }
                    if (StringUtil.isEmpty(saveAgency)){//修改根据项目库判断逻辑
                        /*1页面有单位，按页面单位存
                        2页面没单位
                        2.1用户的usertype是1财政用户时，agency_code= 管理部门有值取管理部门，管理部门没值取管理处室
                        2.2当用户的类型是2部门用户时，agency_code=用户表的upagencyid。 山西比较特殊，agency_code=用户表的agency;
                        2.3当用户类型是0单位时，agency_code=用户表的agency;*/
                        int usertype = CommonUtil.getCurrentUser().getUsertype();
                        logger.info("usertype:--->" + usertype);
                        if (1 == usertype){
                            agencyMap = (Map<String, Object>) infoMap.get("manage_dept_code");
                            if (agencyMap != null && !agencyMap.isEmpty()) {
                                saveAgency = (String) agencyMap.get("value");//单位guid
                                String temp_name = (String) agencyMap.get("text");
                                if (!StringUtil.isEmpty(temp_name)){
                                    agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                }
                            }
                            if (StringUtil.isEmpty(saveAgency)){
                                agencyMap = (Map<String, Object>) infoMap.get("manage_mof_dep_code");
                                if (agencyMap != null && !agencyMap.isEmpty()) {
                                    saveAgency = (String) agencyMap.get("value");//单位guid
                                    String temp_name = (String) agencyMap.get("text");
                                    if (!StringUtil.isEmpty(temp_name)){
                                        agency_name = temp_name.replaceAll("[0-9]","").replaceAll("-","").trim();
                                    }
                                }
                            }
                        }else if (2 == usertype || PerfUtil.getIsSx()){
                            saveAgency = CommonUtil.getCurrentUser().getUpagencyid();
                        } else {
                            saveAgency = CommonUtil.getCurrentUser().getAgency();
                        }
                    }
                }
            }
            indexMap.put("busguid", busguid);
            indexMap.put("projguid", projguid);
            indexMap.put("proguid", projguid);
            indexMap.put("saveAgency", saveAgency);
            indexMap.put("procode", procode);
            indexMap.put("pro_code", procode);
            indexMap.put("pdmsave",pdmsave); // 21 暂存，其他正常保存
            indexMap.put("showtab",showtab);
            indexMap.put("totalgoals",totalgoals);
            indexMap.put("yeargoals",yeargoals);
            indexMap.put("deltotal",deltotal);
            indexMap.put("delyear",delyear);
            indexMap.put("isnest","1");
            indexMap.put("adjadd", adjadd);
            indexMap.put("midsave", midsave);
            indexMap.put("selectbillguid", selectbillguid);
            indexMap.put("isedittotal", isedittotal);
            indexMap.put("pro_name", pro_name);
            indexMap.put("agency_name", agency_name);
            logger.debug("--------procode:"+ procode );
            logger.debug("--------projguid:"+ projguid );
            logger.debug("--------midproguid：" + midproguid);
            logger.debug("--------selectbillguid:"+ selectbillguid);
            //为项目code和name为空的数据做处理
            if (!StringUtil.isEmpty(projguid)) {
                config = prjIndexBO.saveHbDatas(indexMap);
            } else {
                logger.debug("--------projguids为空,不存在绩效数据---------projguid:"+ projguid +"开启流程失败");
            }
        } catch (PerfAppException e) {
            config = e.getRemap();
            config.put("code",e.getCode());
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("returnval", e.getMessage());
        }
        logger.debug("--------saveGoalAndIndex 开启流程完毕-------------");

        return createJSONString(config);
    }

    /**
     * 华青指标送审校验年度绩效是否存在.
     * @deprecated  广西提出，指标送审前校验项目年度绩效是否录入，
     */
    @ResponseBody
    @RequestMapping(value = "sendbdgcheck/{province}/{year}")
    public MicroParamDTO sendbdgcheck(@PathVariable("province") String province,
                                              @PathVariable("year") String year,
                                              @RequestParam(required = false) String projectkind,
                                              @RequestBody List<Map<String, Object>> proList){
        logger.debug("指标系统项目编码："+proList.toString());
        logger.debug("---------------指标系统送审校验绩效开始---------------");
        logger.debug("------区划：--"+province+"--年度：--"+year);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            //封装项目id
            if (proList != null && proList.size() > 0) {
                List<String> list = new ArrayList<>();
                for (Map<String, Object> proMap : proList) {
                    String pro_code = (String) proMap.get("pro_code");
                    proMap.put("guid", pro_code);
                    proMap.put("province", proMap.get("submofdiv"));
                    list.add(pro_code);
                }
                List<Map<String, Object>> backList = null;
                // 20250912 新增校验模式参数: 1校验申报年度绩效+年中追加终审 其他根据“绩效调整指标（预算调整调剂）”配置的审核定义校验
                String sendbdgchecktype = PerfUtil.getSystemSet("sendbdgchecktype");
                if (!StringUtil.isEmpty(sendbdgchecktype) && "1".equals(sendbdgchecktype)) { // 校验模式为1
                    backList = prjIndexBO.sendbdgcheck(list, year , province);
                    logger.debug("项目信息：" + backList.toString());
                } else if (PerfUtil.getIsGuangXi() && !"39".equals(projectkind)) { // 兼容之前广西的条件
                    backList = prjIndexBO.sendbdgcheck(list, year , province);
                    logger.debug("项目信息：" + backList.toString());
                } else { // 其他情况走审核定义
                    Map<String, Object> params = new HashMap<>();
                    params.put("queryYear", year);
                    params.put("queryProvince", province);
                    Map<String, Object> backMap = prjIndexBO.auditdefine(proList, "2612D26A978E1693E0638516A8C07705", "audit", params);
                    boolean success = (boolean) backMap.get("success");
                    if (!success) {
                        backList = (List<Map<String, Object>>) backMap.get("redata");
                    }
                }
                if (backList != null && backList.size() > 0) {
                    backList.forEach(p ->{
                        String errormsg = (String) p.get("remark");
                        if ((!StringUtil.isEmpty(sendbdgchecktype) && "1".equals(sendbdgchecktype)) || PerfUtil.getIsGuangXi()) {
                            errormsg = errormsg + ":项目年度绩效未填报或未审核通过,无法送审!";
                        }
                        p.put("message", errormsg);
                    });
                    resultMap.put("sucess","false");
                    resultMap.put("msg","");
                    dto.setList(backList);
                } else {
                    resultMap.put("sucess","true");
                    resultMap.put("msg","校验成功!");
                }
            }else{
                resultMap.put("sucess","true");
                resultMap.put("msg", "传递项目编码为空");
                logger.error("-------proList,传送的项目编码为空----------校验失败");
            }
        } catch (PerfAppException e) {
            List<Map<String, Object>> backList = (List<Map<String, Object>>) e.getRemap().get("redata");
            List<Map<String, Object>> list = new ArrayList<>();
            List<Map<String, Object>> errList = new ArrayList<>();
            for (Map<String, Object> map : backList) {
                String alarmlevels = map.get("alarmlevels") + "";
                String errormsg = (String) map.get("remark");
                if ("1".equals(alarmlevels)) {
                    map.put("message", errormsg);
                    list.add(map);
                } else {
                    map.put("message", errormsg);
                    errList.add(map);
                }
            }
            resultMap.put("sucess","false");
            resultMap.put("msg", "");
            resultMap.put("errList", list);
            dto.setList(errList);
        } catch (AppException e){
            resultMap.put("sucess","false");
            resultMap.put("msg", "绩效系统接口报错：" + e.getMessage());
            resultMap.put("error",e.getMessage());
        } catch (Exception e){
            resultMap.put("sucess","false");
            resultMap.put("msg", "绩效系统接口报错：" + e.getMessage());
            resultMap.put("error",e.getMessage());
        }
        dto.setMap(resultMap);
        logger.debug("返回信息：" + resultMap);
        return dto;
    }


    /**
     * 项目库项目信息更改，同步更改绩效相关表字段信息.
     */
    @ResponseBody
    @RequestMapping(value = "proauditcols", method = RequestMethod.POST)
    public MicroParamDTO proauditcols(@RequestParam("province") String province,
                                        @RequestParam("year") String year,
                                        @RequestBody List<Map<String, Object>> proList){
        logger.info("---------------项目库修改项目基本信息开始---------------");
        logger.info("---------------项目修改信息：---------------" + proList);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        TlpProgramBO tlpProgramBO = (TlpProgramBO) PerfServiceFactory.getBean("pmkpi.perfprogram.TlpProgramBOTX");
        try{
            if (proList != null && proList.size() > 0) {
                Map<String, Object> proMap = proList.get(0);
                //是否保存，保存时校验总体提目标和项目guid一致性，1是 其他否
                String issave = proMap.get("issave") + "";
                if ("1".equals(issave)) {
                    logger.info("---------------项目和绩效数据一致性校验---------------");
                    resultMap = tlpProgramBO.checkGoalAndIndexByPro(proMap, province);
                } else {
                    resultMap = tlpProgramBO.upProTableDatas(year, province, proList);
                }
            } else {
                resultMap.put("result_code","0001");
                resultMap.put("reason", "无项目数据");
                logger.info("---------------无项目数据---------------");
            }
            logger.info("---------------项目库修改项目基本信息结束---------------");
        } catch (Exception e) {
            resultMap.put("result_code","0001");
            resultMap.put("reason", "绩效数据修改失败");
            resultMap.put("error",e.getMessage());
        }
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }

    /**
     * 获取特殊绩效指标
     */
    @ResponseBody
    @RequestMapping(value = "getSpecialIndex", produces = {"text/html;charset=utf-8"})
    public String getSpecialIndex(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("--------getSpecialIndex 开始获取指标数据-------------");
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        Map config = new HashMap();
        try {
            Map map = new HashMap();
            String proguid = request.getParameter("proguid");
            String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
            String pdmsave = request.getParameter("pdmsave"); //保存还是暂存区分20 暂存
            String selectbillguid = request.getParameter("selectbillguid"); //调整前的项目guid
            String adjustgoalguid = request.getParameter("adjustgoalguid"); //调整前的目标guid
            String adjadd = request.getParameter("adjadd"); //是否调整
            String tempcode = request.getParameter("tempcode");
            String frametype = request.getParameter("frametype");
            String procode = request.getParameter("procode");
            String goalguid = request.getParameter("goalguid");
            String isperform = request.getParameter("isperform");
            String isZJ = PerfUtil.getSystemSet("isZJ");
            map.put("proguid",proguid);
            map.put("showtab",showtab);
            map.put("pdmsave",pdmsave);
            map.put("selectbillguid",selectbillguid);
            map.put("adjustgoalguid",adjustgoalguid);
            map.put("adjadd",adjadd);
            map.put("tempcode",tempcode);
            map.put("frametype",frametype);
            map.put("goalguid",goalguid);
            map.put("procode",procode);
            map.put("isperform",isperform);
            Map indexMap = new HashMap();
            if("1".equals(isZJ)){
                indexMap = prjIndexBO.findAllIndex(map);
            }
            List<Map<String, Object>> totalList = (List<Map<String, Object>>)indexMap.get("#total");
            config.put("success", true);
            config.put("rtdata", totalList);
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("success", false);
            config.put("rtdata", e.getMessage());
        }
        return createJSONString(config);
    }

    /**
     * 获取特殊绩效目标
     */
    @ResponseBody
    @RequestMapping(value = "getSpecialGoal", produces = {"text/html;charset=utf-8"})
    public String getSpecialGoal(HttpServletRequest request, HttpServletResponse response) {
        gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
        Map config = new HashMap();
        try{
            Map map = new HashMap();


            String projguid = request.getParameter("projguid");
            String showtab = request.getParameter("showtab"); ////页签显示 1总+年2总3年
            String pdmsave = request.getParameter("pdmsave"); //保存还是暂存区分20 暂存
            String selectbillguid = request.getParameter("selectbillguid"); //调整前的guid
            String adjadd = request.getParameter("adjadd"); //是否调整
            String tempcode = request.getParameter("tempcode");
            String procode = request.getParameter("procode");
            String isperform = request.getParameter("isperform");
            String isZJ = PerfUtil.getSystemSet("isZJ");
            map.put("proguid",projguid);
            map.put("showtab",showtab);
            map.put("pdmsave",pdmsave);
            map.put("selectbillguid",selectbillguid);
            map.put("adjadd",adjadd);
            map.put("tempcode",tempcode);
            map.put("procode",procode);
            map.put("isperform",isperform);
            Map allGoal = prjIndexBO.getAllGoal(map);
            Map<String, Object> totalMap = (Map<String, Object>)allGoal.get("#total");
            if(!allGoal.isEmpty()){
                config.put("success", true);
                config.put("rtdata", totalMap);
            }else {
                config.put("success", false);
                config.put("rtdata", "请配置特殊绩效模板！");
            }
        }  catch (Exception e) {
            logger.error(e.getMessage(), e);
            config.put("success", false);
            config.put("rtdata", e.getMessage());
        }
        return createJSONString(config);
    }


    /**
     * 同步各阶段版本号
     */
    @ResponseBody
    @RequestMapping(value = "updateVersion", method = RequestMethod.POST)
    public MicroParamDTO updateVersion(@RequestBody List<Map<String, Object>> datalist,
                                      @RequestParam("province") String province,
                                      @RequestParam("year") String year,
                                      @RequestParam("action") String action,
                                      @RequestParam("type") String type){
        logger.info("---------------项目库同步各阶段版本号开始---------------");
        logger.info("流程操作方向：" + action + "-----类型：" + type + "------区划：--" + province + "--年度：--" + year);
        logger.info("---------------版本同步信息：---------------" + datalist);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            resultMap = prjIndexBO.updateVersion(year, province,action,type, datalist);
            logger.info("---------------项目库同步各阶段版本号结束---------------");
        } catch (AppException e) {
            resultMap.put("result_code","0001");
            resultMap.put("reason", "版本同步修改失败");
            resultMap.put("error",e.getMessage());
        }
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }


    /**
     * 转移支付数据接收.
     * goalList: 获取的是前置库定时任务保存到业务库的cfs_pm_perf_**数据
     * indexList：获取的是前置库定时任务保存到业务库的cfs_pm_perf_**数据
     * type：1项目库调用，2指标调用.
     */
    @ResponseBody
    @RequestMapping(value = "transfer/performance", method = RequestMethod.POST)
    public MicroParamDTO savetransferdata(@RequestBody Map dataMap,
                                       @RequestParam("province") String province,
                                       @RequestParam("year") String year,
                                       @RequestParam("type") Integer type){
        logger.info("---------------转移支付数据接收开始---------------");
        logger.info("-----类型：" + type + "------区划：--" + province + "--年度：--" + year);
        List<Map<String, Object>> goalList = (List<Map<String, Object>>) dataMap.get("goalList");
        List<Map<String, Object>> indexList = (List<Map<String, Object>>) dataMap.get("indexList");
        logger.info("---------------转移支付接收目标数据：---------------" + goalList);
        logger.info("---------------转移支付接收指标数据：---------------" + indexList);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            resultMap = prjIndexBO.savetransferdata(year,province,type,goalList,indexList);
            logger.info("---------------转移支付数据接收结束---------------");
        } catch (AppException e) {
            resultMap.put("sucess","false");
            resultMap.put("msg", "转移支付数据接收失败");
            resultMap.put("error",e.getMessage());
        }
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }

    /**
     * 项目年度绩效相关信息查询接口
     * @deprecated  广西提出，对接oa系统1
     */
    @ResponseBody
    @RequestMapping(value = "queryProperf",produces = {"application/json;charset=UTF-8"})
    public MicroParamDTO queryProperf(@RequestBody Map<String,Object> params) {
        String province= (String) params.get("province");
        String year= (String) params.get("year");
        List procodes = (List) params.get("procodes");
        logger.debug("---------------项目编码："+procodes.toString());
        logger.debug("---------------项目年度绩效相关信息查询开始---------------");
        logger.debug("------区划：--"+province+"--年度：--"+year);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        try{
            if (procodes != null && procodes.size() > 0) {
                List<Map> backList = prjIndexBO.queryProperf(procodes, year , province);
                logger.debug("项目年度绩效信息："+backList.toString());
                if (backList != null && backList.size() > 0) {
                    resultMap.put("result_code","0000");
                    resultMap.put("reason","");
                    dto.setList(backList);
                } else {
                    resultMap.put("result_code","0001");
                    resultMap.put("reason","查询到的项目绩效数据为空");
                }
            }else{
                resultMap.put("result_code","0001");
                resultMap.put("reason","传送的项目编码为空");
                logger.error("-------procodes,传送的项目编码为空----------");
            }
        }catch (Exception e){
            resultMap.put("result_code","0001");
            resultMap.put("reason",e.getMessage());
        }
        dto.setMap(resultMap);
        logger.debug("返回信息："+resultMap);
        return dto;
    }

    private void saveLog(Map data, String type) throws AppException {
        Map<String, Object> saveMap = new HashMap<>();
        String pro_code = "";
        String pro_id = "";
        Map map = null;
        try{
            map = (Map) data.get("pro_code");
            if (map != null && map.size() > 0) {
                pro_code = (String) map.get("value");
            }
        } catch (Exception e){
            pro_code = (String) data.get("pro_code");
        }
        pro_id = (String) data.get("pro_id");
        saveMap.put("pro_code", pro_code);
        saveMap.put("pro_id", pro_id);
        saveMap.put("guid", StringUtil.createUUID());
        saveMap.put("update_time", PerfUtil.getServerTimeStamp());
        saveMap.put("creater", CommonUtil.getCurrentUserID());
        saveMap.put("type", type);
        PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
        pmkpiDAO.save(saveMap, "perf_t_savelog");
        String delsql = "to_number(substr(t.update_time,0,8)) < to_number(to_char(sysdate,'yyyymmdd'))";
        pmkpiDAO.delDatas("perf_t_savelog", delsql);
    }

    /**
     * 保存项目绩效日志接口
     */
    @ResponseBody
    @RequestMapping(value = "saveperflog",produces = {"application/json;charset=UTF-8"})
    public MicroParamDTO saveperflog(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestBody List<Map<String, Object>> prolist){
        logger.debug("--------saveperflog 保存项目绩效日志接口 start-------------");
        logger.debug("--------prolist-------------" + prolist.toString());
        MicroParamDTO microParamDTO = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        //校验参数必填
        if (StringUtil.isEmpty(province)){
            resultMap.put("result",false);
            resultMap.put("message","区划不能为空！");
        } else if (StringUtil.isEmpty(year)){
            resultMap.put("result",false);
            resultMap.put("message","年度不能为空!");
        } else if (prolist == null || prolist.size() == 0){
            resultMap.put("result",false);
            resultMap.put("message","项目信息不能为空!");
        } else {
            try {
                Map<String,Object> params = new HashMap<>();
                PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
                params.put("province", province);
                params.put("year", year);
                params.put("prolist", prolist);
                resultMap = prjIndexBO.saveperflog(params);
            } catch (Exception e) {
                resultMap.put("result", false);
                resultMap.put("message","保存失败");
                logger.error(e.getMessage(), e);
            }
        }
        logger.debug("返回结果值：" + resultMap);
        logger.debug("--------saveperflog 保存项目绩效日志接口 end-------------");
        microParamDTO.setMap(resultMap);
        return microParamDTO;
    }

    /**
     * 获取项目绩效日志接口
     */
    @ResponseBody
    @RequestMapping(value = "getperflog",produces = {"application/json;charset=UTF-8"})
    public MicroParamDTO getperflog(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestParam("logguid") String logguid,
            @RequestParam("pro_id") String pro_id,
            @RequestParam("pro_code") String pro_code) {
        logger.info("--------getperflog 获取项目绩效日志接口 start-------------");
        MicroParamDTO microParamDTO = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        //校验参数必填
        if (StringUtil.isEmpty(province)){
            resultMap.put("result",false);
            resultMap.put("message","区划不能为空！");
        }
        if (StringUtil.isEmpty(year)){
            resultMap.put("result",false);
            resultMap.put("message","年度不能为空!");
        }
        if (StringUtil.isEmpty(logguid)){
            resultMap.put("result",false);
            resultMap.put("message","logguid不能为空!");
        }
        try {
            Map<String,Object> params = new HashMap<>();
            PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            params.put("province", province);
            params.put("year", year);
            params.put("logguid", logguid);
            params.put("pro_id", pro_id);
            params.put("pro_code", pro_code);
            resultMap = prjIndexBO.getperflog(params);
        } catch (Exception e) {
            resultMap.put("result", false);
            resultMap.put("message","保存失败");
            logger.error(e.getMessage(), e);
        }
        logger.info("返回结果值：" + resultMap);
        logger.info("--------getperflog 获取项目绩效日志接口 end-------------");
        microParamDTO.setMap(resultMap);
        return microParamDTO;
    }

    /**
     * 获取页面ui配置数据接口
     */
    @ResponseBody
    @RequestMapping(value = "getperfui",produces = {"application/json;charset=UTF-8"})
    public MicroParamDTO getperfui(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestParam("key") String key) {
        logger.info("--------getperfui 获取页面ui配置数据接口 start-------------");
        MicroParamDTO microParamDTO = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        //校验参数必填
        if (StringUtil.isEmpty(province)){
            resultMap.put("result",false);
            resultMap.put("message","区划不能为空！");
        }
        if (StringUtil.isEmpty(year)){
            resultMap.put("result",false);
            resultMap.put("message","年度不能为空!");
        }
        if (StringUtil.isEmpty(key)){
            resultMap.put("result",false);
            resultMap.put("message","key不能为空!");
        }
        Map<String,Object> params = new HashMap<>();
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        params.put("province", province);
        params.put("year", year);
        params.put("key", key);
        try {
            resultMap = prjIndexBO.getperfuicfg(params);
        } catch (Exception e) {
            resultMap.put("result", false);
            resultMap.put("message","查询失败");
            logger.error(e.getMessage(), e);
        }
        logger.info("返回结果值：" + resultMap);
        logger.info("--------getperfui 获取页面ui配置数据接口 end-------------");
        microParamDTO.setMap(resultMap);
        return microParamDTO;
    }

    /**
     * 项目库终审调用，项目库之前调用接口，接口如下：
     * /pmkpi/perfprogram/proauditcols--储备、调整调用
     * /pmkpi/perfprogram/delGoalAndIndex/{province}/{year}--调整调用
     * 新增宁夏接口调用
     * /pmkpi/perfprogram/addadjust
     * 项目储备终审时，复制整体生成年度绩效
     */
    @ResponseBody
    @RequestMapping(value = "updateAndDel", method = RequestMethod.POST)
    public MicroParamDTO updateAndDel(@RequestParam("province") String province,
                                  @RequestParam("year") String year,
                                  @RequestBody Map<String, Object> dataMap) {
        logger.info("---------------updateAndDel开始---------------");
        logger.info("------区划：--" + province + "--年度：--" + year);
        logger.info("---------------项目库传递信息：---------------" + dataMap);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String, Object> resultMap = new HashMap<>();
        TlpProgramBO tlpProgramBO = (TlpProgramBO) PerfServiceFactory.getBean("pmkpi.perfprogram.TlpProgramBOTX");
        try {
            resultMap = tlpProgramBO.updateAndDel(province, year, dataMap);
            resultMap.put("result", true);
        } catch (AppException e) {
            resultMap.put("result", false);
            resultMap.put("message", "绩效执行失败：" + e.getMessage());
            logger.error(e.getMessage(), e);
        }
        logger.info("---------------updateAndDel结束---------------");
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }

    /**
     * 宁夏生成绩效调整数据
     */
    @ResponseBody
    @RequestMapping(value = "addadjust", method = RequestMethod.POST)
    public MicroParamDTO addadjust(@RequestParam("province") String province,
                                  @RequestParam("year") String year,
                                  @RequestBody Map<String, Object> proMap){
        logger.info("---------------生成绩效调整数据开始---------------");
        logger.info("------区划：--" + province + "--年度：--" + year);
        logger.info("---------------生成绩效调整项目信息：---------------" + proMap);
        MicroParamDTO dto = new MicroParamDTO();
        Map<String,Object> resultMap = new HashMap<>();
        AdjustReportBO adjustReportBO = (AdjustReportBO) PerfServiceFactory.getBean("pmkpi.adjust.report.AdjustReportBOTX");
        try {
            adjustReportBO.saveAdjust(proMap);
            resultMap.put("result", true);
        } catch (AppException e) {
            resultMap.put("result", false);
            resultMap.put("message", "接口addadjust绩效执行失败：" + e.getMessage());
            logger.error(e.getMessage(), e);
        }
        logger.info("---------------生成绩效调整数据结束---------------");
        dto.setMap(resultMap);
        logger.info("返回信息："+resultMap);
        return dto;
    }
}
