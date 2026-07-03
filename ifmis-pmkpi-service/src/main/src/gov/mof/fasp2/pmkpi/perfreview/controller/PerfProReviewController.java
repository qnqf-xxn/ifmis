package gov.mof.fasp2.pmkpi.perfreview.controller;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pmkpi/projectinfo")
public class PerfProReviewController {
    private final static Logger logger = Logger.getLogger(PerfProReviewController.class);

    /**
     * 项目库绩效目标评审
     * @param proinfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/send/{mof_div_code}/{fiscal_year}", method = RequestMethod.POST, produces = {"text/html;charset=utf-8"})
    public String sendProInfotoPmkpi(@RequestBody List<FaspDTO> proinfo) throws AppException {
        logger.error("--------sendProInfotoPmkpi 项目库绩效目标评审 start-------------");
        Map<String, String> map = new HashMap<String, String>();
        Boolean success = false;
        String tip = "";
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> m = new HashMap<>();
        if (proinfo != null && proinfo.size()>0){
            for (FaspDTO dto : proinfo) {
                String mainguid = (String) dto.get("guid");
                String saveAgency = (String) dto.get("agency_code");
                m.put("mainguid", mainguid);
                m.put("saveAgency", saveAgency);
                list.add(m);
            }
            PerfReviewBO perfReviewBO = (PerfReviewBO) PerfServiceFactory.getBean("pmkpi.perfreview.PerfReviewBOTX");
            String workflow = "B9C7D80EC0188933E053B11FA8C0A5D6";
            Map<String,Object> params = new HashMap<String,Object>();//参数
            params.put("workflow", workflow);
            params.put("datas", list);
            Map<String, Object> backMap = perfReviewBO.savereviewdatas((HashMap<String, Object>) params);
            success = (Boolean) backMap.get("success");
            tip = (String) backMap.get("returnval");
        }
        String returnval = "";
        if(success){
            map.put("result_code", "0000");
            returnval = tip;
        } else {
            map.put("result_code", "0001");
            returnval = tip;
        }
        map.put("reason", returnval);
        logger.error("--------sendProInfotoPmkpi 项目库绩效目标评审 end-------------");
        return createJSONString(map);
    }

    protected String createJSONString(Object obj) {
        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
        String json = jo.toString();
        return json;
    }
}
