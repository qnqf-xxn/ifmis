package gov.mof.fasp2.pmkpi.setting.indexauth.controller;

import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.indexauth.IndexAuthBO;
import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/pmkpi/indexauth")
public class PerfIndexAuthService {

    private final static Logger logger = Logger.getLogger(PerfIndexAuthService.class);

    /**
     * 指标库授权数据保存接口
     */
    @ResponseBody
    @RequestMapping(value = "saveIndexAuth",produces = {"application/json;charset=UTF-8"})
    public String saveIndexAuth(
            @RequestParam("authtype") String authtype,
            @RequestBody Map<String, Object> dataMap){
        logger.info("--------saveIndexAuth 指标库授权同步 start-------------");
        Map<String,Object> resultMap = new HashMap<>();
        try {
//            String authtype = (String) dataMap.get("authtype");
            List<Map<String,Object>> datalist = (List<Map<String, Object>>) dataMap.get("datalist");
            logger.info("--------saveIndexAuth 指标库授权同步 authtype :"+authtype+"-------------");
            logger.info("--------saveIndexAuth 指标库授权同步 datalist.size :"+datalist.size()+"-------------");
            IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
            indexAuthBO.saveIndexAuth(authtype,datalist);
            resultMap.put("returnkey", true);
            logger.info("--------saveIndexAuth 指标库授权同步 end-------------");
        } catch (PerfAppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getCode());
        } catch (AppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getMessage());
            logger.error(e.getMessage(), e);
        }
        String jsonresult = "";
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("returnkey",false);
            resultMap.put("returnval",e.getMessage());
            logger.error("转换JSON流程失败："+resultMap);
        }
        return jsonresult;
    }


    /**
     * 获取授权指标库指标（分页）接口
     */
    @ResponseBody
    @RequestMapping(value = "getAuthIndexByPage",produces = {"application/json;charset=UTF-8"})
    public String getAuthIndexByPage(@RequestBody Map<String, Object> dataMap){
        logger.info("--------getAuthIndexByPage 获取授权指标库指标 start-------------");
        Map<String,Object> resultMap = new HashMap<>();
        try {
            String authtype = (String) dataMap.get("authtype");
            String authcode = (String) dataMap.get("authcode");
            String selectnode = (String) dataMap.get("selectnode");
            String year = (String) dataMap.get("year");
            logger.info("--------getAuthIndexByPage 获取授权指标库指标 authtype :"+authtype+"，authcode :"+authcode+"，year :"+year+"-------------");
            IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
            Map<String,Object> data = indexAuthBO.getAuthIndexByPage(dataMap);
            resultMap.put("returnkey", true);
            resultMap.put("returnval", data);
            logger.info("--------getAuthIndexByPage 获取授权指标库指标 end-------------");
        } catch (PerfAppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getCode());
        } catch (AppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getMessage());
            logger.error(e.getMessage(), e);
        }
        String jsonresult = "";
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("returnkey",false);
            resultMap.put("returnval",e.getMessage());
            logger.error("转换JSON流程失败："+resultMap);
        }
        return jsonresult;
    }


    /**
     * 获取授权指标库左侧树类型接口
     */
    @ResponseBody
    @RequestMapping(value = "getAuthLefttree",produces = {"application/json;charset=UTF-8"})
    public String getAuthLefttree(@RequestBody Map<String, Object> dataMap){
        logger.info("--------getAuthLefttree 获取授权指标库左侧树类型 start-------------");
        Map<String,Object> resultMap = new HashMap<>();
        try {
            String authtype = (String) dataMap.get("authtype");
            String authcode = (String) dataMap.get("authcode");
            String year = (String) dataMap.get("year");
            logger.info("--------getAuthLefttree 获取授权指标库左侧树类型 authtype :"+authtype+"，authcode :"+authcode+"，year :"+year+"-------------");
            IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
            Map<String,Object> data= indexAuthBO.getAuthLefttree(dataMap);
            resultMap.put("returnkey", true);
            resultMap.put("returnval", data);
            logger.info("--------getAuthLefttree 获取授权指标库左侧树类型 end-------------");
        } catch (PerfAppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getCode());
        } catch (AppException e) {
            resultMap.put("returnkey", false);
            resultMap.put("returnval",e.getMessage());
            logger.error(e.getMessage(), e);
        }
        String jsonresult = "";
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("returnkey",false);
            resultMap.put("returnval",e.getMessage());
            logger.error("转换JSON流程失败："+resultMap);
        }
        return jsonresult;
    }


    /**
     * 绩效指标对外接口.
     * 湖北债券系统要基础数据指标模板.
     */
    @ResponseBody
    @GetMapping(value = "getBasIndicator",produces = {"application/json;charset=UTF-8"})
    public String sendHbPerformance(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestParam(value = "type") String type,
            @RequestParam("agency_code") String agency_code){
        logger.error("type："+type+"---- 获取数据类型:"+type+"-----------");
        logger.error("----区划:--"+province+"-------年度------"+year);
        //注入年度区划参数

        Map<String,Object> resultMap = new HashMap<>();
        IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
        //校验
        if (StringUtil.isEmpty(province)){
            resultMap.put("result",false);
            resultMap.put("message","区划参数不能为空!");
        }
        if (StringUtil.isEmpty(year)){
            resultMap.put("result",false);
            resultMap.put("message","年度参数不能为空!");
        }
        if (StringUtil.isEmpty(type)){
            resultMap.put("result",false);
            resultMap.put("message","取数类型参数不能为空!");
        }
        try{
            //封装项目id
            List<Map<String,Object>> indexList = new ArrayList<>();
            if ("hq_frame_pm".equals(type)){
                indexList = indexAuthBO.getFrame(province,year);
                resultMap.put("result",true);
                resultMap.put("data",indexList);
                resultMap.put("message","成功！");
            } else if ("hq_fincal_pm_indicator".equals(type)){
                indexList = indexAuthBO.getFincalIndicator(province,year);
                resultMap.put("result",true);
                resultMap.put("data",indexList);
                resultMap.put("message","成功！");
            } else if ("hq_dept_pm_indicator".equals(type)){
                if (StringUtil.isEmpty(agency_code)){
                    resultMap.put("result",false);
                    resultMap.put("message","单位编码不能为空!");
                } else {
                    indexList = indexAuthBO.getDepIndicator(province,year,agency_code);
                    resultMap.put("result",true);
                    resultMap.put("data",indexList);
                    resultMap.put("message","成功！");
                }
            } else if ("hq_fincal_gdpm_indicator".equals(type)) {
                indexList = indexAuthBO.getFincalGDIndicator(province,year);
                resultMap.put("result",true);
                resultMap.put("data",indexList);
                resultMap.put("message","成功！");
            } else if ("hq_dept_gdpm_indicator".equals(type)) {
                if (StringUtil.isEmpty(agency_code)){
                    resultMap.put("result",false);
                    resultMap.put("message","单位编码不能为空!");
                } else {
                    indexList = indexAuthBO.getDepGDIndicator(province,year,agency_code);
                    resultMap.put("result",true);
                    resultMap.put("data",indexList);
                    resultMap.put("message","成功！");
                }
            } else {
                resultMap.put("result",false);
                resultMap.put("message","取数类型参数不存在，请检查!");
            }
        }catch (AppException e){
            resultMap.put("result",false);
            resultMap.put("message",e.getMessage());
        }
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
     * 接收债务项目绩效接口
     */
    @ResponseBody
    @RequestMapping(value = "savegoalindex",produces = {"application/json;charset=UTF-8"})
    public String savegoalindex(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestBody Map<String, Object> perfmap) throws AppException {
        logger.info("--------savegoalindex 接收项目绩效接口 start-------------");
        String jsonresult = "";
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
        if (!resultMap.isEmpty()) {
            return PerfUtil.parse2Json(resultMap);
        }
        try {
            IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
            perfmap.put("province", province);
            perfmap.put("year", year);
            CaseInsensitiveMap caseInsensitiveMap = new CaseInsensitiveMap(perfmap);
            resultMap = indexAuthBO.savegoalindex(caseInsensitiveMap);
            logger.info("--------savegoalindex 接收项目绩效接口 end-------------");
        } catch (PerfAppException e) {
            resultMap.put("result", false);
            resultMap.put("message","保存失败");
        } catch (AppException e) {
            resultMap.put("result", false);
            resultMap.put("message","保存失败");
            logger.error(e.getMessage(), e);
        }
        try {
            jsonresult = PerfUtil.parse2Json(resultMap);
        } catch (AppException e) {
            resultMap.put("result", false);
            resultMap.put("message","保存失败");
            logger.error("转换JSON流程失败："+resultMap);
        }
        logger.info("返回结果值：" + jsonresult);
        return jsonresult;
    }

    /**
     * 查询绩效数据接口
     */
    @ResponseBody
    @RequestMapping(value = "getGoaAndIindex",produces = {"application/json;charset=UTF-8"})
    public MicroParamDTO getGoaAndIindex(
            @RequestParam("province") String province,
            @RequestParam("year") String year,
            @RequestBody Map<String, Object> perfmap) throws AppException {
        logger.info("--------getGoaAndIindex 获取绩效数据接口 start-------------");
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
        if (!resultMap.isEmpty()) {
            microParamDTO.setMap(resultMap);
            return microParamDTO;
        }
        try {
            if (!perfmap.isEmpty()) {
                perfmap.put("province", province);
                perfmap.put("year", year);
                logger.info("--------perfmap-------------" + perfmap);
                IndexAuthBO indexAuthBO = (IndexAuthBO) PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
                resultMap = indexAuthBO.getGoaAndIindex(perfmap);
            }
            logger.info("--------getGoaAndIindex 获取绩效数据接口 end-------------");
        } catch (PerfAppException e) {
            resultMap.put("result", false);
            resultMap.put("message","查询失败");
        } catch (AppException e) {
            resultMap.put("result", false);
            resultMap.put("message","查询失败");
            logger.error(e.getMessage(), e);
        }
        microParamDTO.setMap(resultMap);
        return microParamDTO;
    }
}
