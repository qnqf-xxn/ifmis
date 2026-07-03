package gov.mof.fasp2.pmkpi.perfreview.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.perfprogram.controller.PerfProgramService;
import gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pmkpi/perfprogram")
public class PerfReviewController {

    private final static Logger logger = Logger.getLogger(PerfProgramService.class);

    /**
     * 绩效目标评审
     */
    @ResponseBody
    @RequestMapping(value = "perfReview", produces = {"text/html;charset=utf-8"})
    public String perfReview(HttpServletRequest request, HttpServletResponse response){
        logger.error("--------perfReview 绩效目标评审 start-------------");
        Map<String, String> map = new HashMap<String, String>();
        try {
            String datas = request.getParameter("datas");//项目数据
            List<Map<String, Object>> list = null;
            if (!StringUtil.isEmpty(datas) && !"undefined".equals(datas)) {
                //指标信息json转成Map
                String tabindexstr = URLDecoder.decode(datas, "utf-8");
                tabindexstr = tabindexstr.replace("\\","");
                tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
                list = PerfUtil.parseString2List(tabindexstr);
            }
            String bustype = (String) list.get(0).get("bustype");
            String pro_code = (String) list.get(0).get("pro_code");
            if (StringUtil.isEmpty(bustype)) {
                map.put("returnkey", "false");
                map.put("returnval", "字段bustype不能为空，请联系管理员");
                return createJSONString(map);
            }
            if (!"dept".equals(bustype) && StringUtil.isEmpty(pro_code)) {
                map.put("returnkey", "false");
                map.put("returnval", "字段pro_code不能为空，请联系管理员");
                return createJSONString(map);
            }
            logger.error("--------perfReview 绩效目标评审类型bustype -------------" + bustype);
            PerfReviewBO perfReviewBO = (PerfReviewBO) PerfServiceFactory.getBean("pmkpi.perfreview.PerfReviewBOTX");
            String workflow = "";//工作流
            if ("dept".equals(bustype)) {
                workflow = "BC1379AA6FE2BE4AE053480A050AB64C";
            } else if("zyzfprogram".equals(bustype)){//转移支付项目支出
                workflow = "D118978EBDF7E3926E49A0A9E16ED8CD";
            } else {
                workflow = "B9C7D80EC0188933E053B11FA8C0A5D6";
            }

            Map<String,Object> params = new HashMap<String,Object>();//参数
            params.put("workflow", workflow);
            params.put("datas", list);
            params.put("bustype", bustype);
            Map<String, Object> backMap = perfReviewBO.savereviewdatas((HashMap<String, Object>) params);
            Boolean success = (Boolean) backMap.get("success");
            String returnval = "";
            if(success){
                returnval = "保存成功";
            } else {
                returnval = (String) backMap.get("returnval");
            }
            map.put("returnkey", String.valueOf(success));
            map.put("returnval", returnval);
            logger.error("json:"+createJSONString(map).toString());
            logger.error("--------perfReview 绩效目标评审 end-------------");
        } catch (PerfAppException e) {
            map.put("returnkey", "false");
            map.put("returnval",e.getCode());
        }catch (AppException e) {
            logger.error(e.getMessage(), e);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(), e);
        }
        return createJSONString(map);
    }

    protected String createJSONString(Object obj) {
        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
        String json = jo.toString();
        return json;
    }

}
