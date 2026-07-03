package gov.mof.fasp2.pmkpi.policyapi;

import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pmkpi/policyapi")
public class PolicyapiController {
    /**
     * 项目绩效目标全量接口
    */
    @ResponseBody
    @GetMapping(value = "/pmgoalinfo/{mof_div_code}/{fiscal_year}",produces = {"application/json"})
    public String getPmgoalinfos(@PathVariable("mof_div_code") String mofdivcode,
                                 @PathVariable("fiscal_year") String fiscalyear,
                                 @RequestParam(value="procodes",required = false) List<String> procodes){
        PolicyapiBO policyapiBO = (PolicyapiBO) PerfServiceFactory.getBean("pmkpi.policyapi.PolicyapiBOTX");
        return policyapiBO.getResult(procodes, mofdivcode, fiscalyear, "pmgoalinfo");
    }
    /**
     * 项目绩效指标全量接口
    */
    @ResponseBody
    @GetMapping(value = "/pmindicator/{mof_div_code}/{fiscal_year}",produces = {"application/json"})
    public String getpmindicators(@PathVariable("mof_div_code") String mofdivcode,
                                  @PathVariable("fiscal_year") String fiscalyear,
                                  @RequestParam(value = "procodes" , required = false) List<String> procodes){
        PolicyapiBO policyapiBO = (PolicyapiBO) PerfServiceFactory.getBean("pmkpi.policyapi.PolicyapiBOTX");
        return policyapiBO.getResult(procodes, mofdivcode, fiscalyear, "pmgoalinfo");
    }
}
