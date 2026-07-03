package gov.mof.fasp2.pmkpi.doubleprocess.otherapp;

import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@FeignClient("ifmis-pdm-service")
public interface IPdmInterface {


    /**
     * @Description:获取项目库流程状态
     * @param dto list:单位信息集合， 包含 包含 proguid, mof_div_code，fiscal_year
     * @return MicroParamDTO boolean:是否成功;str1：失败原因;
     * list:流程信息集合 proguid,mof_div_code，fiscal_year，wfstatus(工作流状态)
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/pm/pkmpi/queryprobgtflow", method = RequestMethod.POST)
    @ResponseBody
    public MicroParamDTO querytaskflow(@RequestBody MicroParamDTO dto);

    /**
     * @Description:获取项目库超出资金额度的项目id
     * @param paramMap list:单位信息集合， 包含 包含 proguid, mof_div_code，fiscal_year
     * @return MicroParamDTO boolean:是否成功;str1：失败原因;
     * list:流程信息集合 proguid,mof_div_code，fiscal_year，wfstatus(工作流状态)
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/pm/pkmpi/queryproveramt", method = RequestMethod.POST)
    @ResponseBody
    public Map queryproveramt(@RequestBody Map paramMap);

}
