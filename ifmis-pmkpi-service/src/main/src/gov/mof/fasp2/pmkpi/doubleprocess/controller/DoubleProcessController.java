package gov.mof.fasp2.pmkpi.doubleprocess.controller;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.doubleprocess.report.TlpDoublepressBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import io.netty.util.internal.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>山西双流程给预算调用接口</p >
 *
 * @author hw
 * @date 2021/5/13 16:39
 */

@Controller
@RequestMapping("/pmkpi/doubleprocess")
public class DoubleProcessController {

    private final static Logger logger = Logger.getLogger(DoubleProcessController.class);

    private TlpDoublepressBO tlpProgramBO;

    @Resource(name = "pmkpi.doubleprocess.TlpProgramBO")
    public void setTlpProgramBO(TlpDoublepressBO tlpProgramBO) {
        this.tlpProgramBO = tlpProgramBO;
    }

    /**
     * <p>退回</p >
     *
     * @param
     * @author hw
     * @date 2021/5/16 15:13
     */
    @RequestMapping(value = "/back", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> back(HttpServletRequest request, HttpServletResponse response) throws AppException, UnsupportedEncodingException {
        logger.info("--------back-------start---");
        HashMap<String, Object> retMap = new HashMap<>();
        retMap.put("result", true);
        retMap.put("reason", "成功！");
        String remark = request.getParameter("remark"); // 审核意见
        String backData = request.getParameter("backData"); // [{"mainguid" : "123456","mof_div_code" :"330000000","fiscal_year": "2021","taskflag": "1","protype":"1"},{...}]
        logger.debug("------remark:" + remark + "--backData:" + backData);
        List<Map<String, Object>> list = new ArrayList<>();
        if (!"undefined".equals(backData) && backData != null) {
            //指标信息json转成Map
            String tabindexstr = URLDecoder.decode(backData, "utf-8");
            tabindexstr = tabindexstr.replace("\\", "");
            if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
            }
            list = PerfUtil.parseString2List(tabindexstr);
        }
        tlpProgramBO.dpBack(remark, list);
        logger.info("--------back--------end---" + retMap);
        return retMap;
    }


    /**
     * <p>2.绩效目标审核推送接口</p >
     *
     * @param
     * @author hw
     * @date 2021/5/17 10:29
     */
/*    @RequestMapping(value = "/bdmgoalinfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> bdmgoalinfo(HttpServletRequest request, HttpServletResponse response) throws AppException, UnsupportedEncodingException {
        logger.info("绩效目标审核推送接口---start---");
        HashMap<String, Object> retMap = new HashMap<>();

        String mof_div_code = request.getParameter("mof_div_code"); // 财政
        String fiscal_year = request.getParameter("fiscal_year"); // 年度
        String datalist = request.getParameter("datalist"); // 数据

        List<Map<String, Object>> list = new ArrayList<>();
            if (!"undefined".equals(datalist) && datalist != null) {
            //指标信息json转成Map
            String tabindexstr = URLDecoder.decode(datalist, "utf-8");
            tabindexstr = tabindexstr.replace("\\", "");
            tabindexstr = tabindexstr.substring(1, tabindexstr.length() - 1);
            list = PerfUtil.parseString2List(tabindexstr);
        }
//        JSONArray jsons = JSONArray.parseArray(datalist);
//        List<JSONObject> datas = JSONObject.parseArray(jsons.toJSONString(), JSONObject.class);
//        for(JSONObject obj :datas){
//            Map<String, Object> params = JSONObject.parseObject(obj.toJSONString(), new TypeReference<Map<String, Object>>(){});
//            list.add(params);
//        }
        Boolean bdmgoalinfo = tlpProgramBO.bdmgoalinfo(list);
        if (bdmgoalinfo) {
            retMap.put("result", true);
            retMap.put("reason", "成功！");
        } else {
            retMap.put("result", false);
            retMap.put("reason", "失败！");
        }
        logger.info("绩效目标审核推送接口---end---");
        return retMap;
    }*/


    /**
     * 通过
     */
    @ResponseBody
    @RequestMapping(value = "/pass", produces = {"text/html;charset=utf-8"})
    public String passDoublePress(@RequestBody Map passmap) {
        logger.debug("--------pass start-------------");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String datas = passmap.get("datas").toString();
            logger.debug("--------datas---------" + datas);
            List<Map<String, Object>> list = new ArrayList<>();
            if(!"undefined".equals(datas) && datas != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(datas, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                logger.debug("--------tabindexstr---------" + tabindexstr);
                list = PerfUtil.parseString2List(tabindexstr);
            }
            if (!list.isEmpty() && !list.stream().filter(m->StringUtil.isNullOrEmpty((String) m.get("pro_code"))).collect(Collectors.toList()).isEmpty()) {
                map.put("result", false);
                map.put("reason", "项目编码不能为空，请检查！");
            } else {
                String bustype = (String) list.get(0).get("bustype");
                String workflow = "";//工作流
                if (bustype != null && "dept".equals(bustype)) {
                    workflow = "BC1379AA6FE2BE4AE053480A050AB64C";
                } else {
                    workflow = "B9C7D80EC0188933E053B11FA8C0A5D6";
                }
                Map<String,Object> params = new HashMap<String,Object>();//参数
                params.put("workflow", workflow);
                params.put("datas", list);
                Map<String, Object> backMap = tlpProgramBO.savereviewdatas((HashMap<String, Object>) params);
                Boolean success = (Boolean) backMap.get("success");
                String returnval = "";
                if(success){
                    returnval = "保存成功";
                } else {
                    returnval = (String) backMap.get("returnval");
                }
                map.put("result", success);
                map.put("reason", returnval);
            }
        } catch (PerfAppException e) {
            map.put("result", false);
            map.put("reason",e.getCode());
        }catch (AppException e) {
            logger.error(e.getMessage(), e);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
        logger.debug("--------pass end-------------" + map);
        return createJSONString(map);
    }

    /**
     * 通过
     */
    @ResponseBody
    @RequestMapping(value = "/backDoublePress", produces = {"text/html;charset=utf-8"})
    public String backDoublePress(@RequestBody Map backmap){
        logger.debug("--------backDoublePress start-------------");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            logger.debug("--------项目库传参---------" + backmap);
            String remark = (String) backmap.get("remark");
            String  datas = (String) backmap.get("backData");
            List<Map<String, Object>> list = new ArrayList<>();
            if(!"undefined".equals(datas) && datas != null) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(datas, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                logger.debug("--------tabindexstr---------" + tabindexstr);
                list = PerfUtil.parseString2List(tabindexstr);
            }
            if (!list.isEmpty() && !list.stream().filter(m->StringUtil.isNullOrEmpty((String) m.get("pro_code"))).collect(Collectors.toList()).isEmpty()) {
                map.put("result", false);
                map.put("reason", "项目编码不能为空，请检查！");
            } else {
                String workflow = "3DC76BC9CDA14F510E6D1B92AA56AAAA";//工作流
                Map<String,Object> params = new HashMap<String,Object>();//参数
                params.put("workflow", workflow);
                params.put("remark", remark);
                params.put("datas", list);
                Map<String, Object> backMap = tlpProgramBO.saveprojdpdatas((HashMap<String, Object>) params);
                Boolean success = (Boolean) backMap.get("success");
                String returnval = "";
                if(success){
                    returnval = "保存成功";
                } else {
                    returnval = (String) backMap.get("returnval");
                }
                map.put("result", success);
                map.put("reason", returnval);
            }
        } catch (PerfAppException e) {
            map.put("result", false);
            map.put("reason",e.getCode());
        }catch (AppException e) {
            logger.error(e.getMessage(), e);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
        logger.debug("--------backDoublePress end-------------" + map);
        return createJSONString(map);
    }

    protected String createJSONString(Object obj) {
        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
        String json = jo.toString();
        return json;
    }


    /**
     * 项目库退回
     * 1.判断评审表有无符合的数据  有则置为无效数据
     * 2.判断预算的后状态是否与绩效双流程表中当前状态一致，一致则将绩效数据置为无效
     */
    @ResponseBody
    @RequestMapping(value = "/bdmgoalinfo", produces = {"text/html;charset=utf-8"})
    public String bdmBack(@RequestBody Map backmap){
        logger.debug("--------bdmgoalinfo start-------------");
        Map<String, Object> backMap = new HashMap<>();
        try {
            String datas = (String) backmap.get("datalist");
            logger.debug("===========datalist===========" + datas);
            List<Map<String, Object>> list = new ArrayList<>();
            if(!"undefined".equals(datas) && datas != null) {
                //退回信息json转成Map
                String tabindexstr = URLDecoder.decode(datas, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                logger.debug("--------tabindexstr---------" + tabindexstr);
                list = PerfUtil.parseString2List(tabindexstr);
            }
            if (!list.isEmpty()) {
                for (int i= 0;i<list.size();i++){
                    Map<String, Object> data = list.get(i);
                    String action = (String) data.get("action");//流程操作方向（1.正向 2.反向）
                    if (!StringUtils.isEmpty(action)){
                        if ("2".equals(action)){//反向(退回 取消送审，取消审核)
                            backMap = tlpProgramBO.bdmBack(data);
                        }else{
                            backMap.put("result", true);
                            backMap.put("reason","成功");
                        }
                    }
                }
            }
        } catch (PerfAppException e) {
            backMap.put("result", false);
            backMap.put("reason",e.getCode());
        }catch (AppException e) {
            logger.error(e.getMessage(), e);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
        logger.debug("--------bdmgoalinfo end-------------" + backMap);
        return createJSONString(backMap);
    }


    /**
     * 预算退回
     * 1.判断评审表有无符合的数据  有则置为无效数据
     * 2.判断预算的后状态是否与绩效双流程表中当前状态一致，一致则将绩效数据置为无效
     */
    //@ResponseBody
    //@RequestMapping(value = "/bdmbackgoalinfo", method = RequestMethod.POST)
    //public String bdmBack(HttpServletRequest request, HttpServletResponse response){
    /*public Map bdmbackgoalinfo(@RequestBody Map backmap){
        logger.debug("--------bdmBack 预算退回 start-------------");
        Map backMap = new HashMap<>();
        backMap.put("result", true);
        backMap.put("reason","成功");
        try {
            List<Map> list = (List<Map>) backmap.get("datalist");
            logger.debug("===========预算退回列表datalist==========="+list);
            if(list!=null && list.size()>0){
                for (int i= 0;i<list.size();i++){
                    Map<String, Object> data = list.get(i);
                    String action = (String) data.get("action");//流程操作方向（1.正向 2.反向）
                    if (!StringUtils.isEmpty(action)){
                        if ("2".equals(action)){//反向(退回 取消送审，取消审核)
                            backMap = tlpProgramBO.bdmBack(data);
                        }else{
                            backMap.put("result", true);
                            backMap.put("reason","成功");
                        }
                    }
                }
            }else{
                logger.debug("===========list为空，预算退回列表数据为空===========");
            }
        } catch (Exception e) {
            backMap.put("result", false);
            backMap.put("reason","失败");
            logger.debug(e.getMessage(), e);
        }

        return backMap;
    }*/

    /**
     * 项目库
     * 判断一批项目，是否审核通过
     */
    @ResponseBody
    @RequestMapping(value = "/checkaudit", produces = {"text/html;charset=utf-8"})
    public String checkAudit(@RequestBody Map checkmap){
        logger.debug("--------checkaudit start-------------");
        Map<String, Object> backMap = new HashMap<>();
        try {
            String datas = (String) checkmap.get("datalist");
            logger.debug("--------datas---------" + datas);
            List<Map<String, Object>> list = new ArrayList<>();
            if(!"undefined".equals(datas) && datas != null) {
                //退回信息json转成Map
                String tabindexstr = URLDecoder.decode(datas, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                if (tabindexstr.startsWith("\"") && tabindexstr.endsWith("\"")){
                    tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                }
                logger.debug("---------tabindexstr--------" + tabindexstr);
                list = PerfUtil.parseString2List(tabindexstr);
            }
            if (!list.isEmpty() && !list.stream().filter(m->StringUtil.isNullOrEmpty((String) m.get("pro_code"))).collect(Collectors.toList()).isEmpty()) {
                backMap.put("result", false);
                backMap.put("reason", "项目编码不能为空，请检查！");
                backMap.put("data",new ArrayList<>());
            } else {
                List dataList = tlpProgramBO.checkAudit(list);
                backMap.put("result", true);
                backMap.put("reason","成功");
                backMap.put("data",dataList) ;
            }
        } catch (PerfAppException e) {
            backMap.put("result", false);
            backMap.put("reason",e.getCode());
            backMap.put("data",new ArrayList<>());
        }catch (AppException e) {
            logger.error(e.getMessage(), e);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
        logger.debug("--------checkaudit end-------------" + backMap);
        return createJSONString(backMap);
    }

}
