package gov.mof.fasp2.pmkpi.setting.evaluation.proaudit;

import gov.mof.fasp2.publicapi.bussender.dto.ApiResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@FeignClient("ifmis-pdm-service")
public interface PdmInterface {


    /**
     * @Description:调用项目库更新数据接口
     * @param upmap:更新的数据(key:字段名，value:更新值)，表名，区划
     * @param tablecode:表名
     * @param mof_div_code:区划
     * @return MicroParamDTO :result_code:0000(成功)/0001(失败)  reason:失败原因
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/pm/projectinfo/common/up/{mof_div_code}", method = RequestMethod.POST)
    @ResponseBody
    public ApiResultDTO pdmUpdateData(@RequestBody Map upmap,
                                      @RequestParam(value = "tablecode")String tablecode,
                                      @PathVariable("mof_div_code")String mof_div_code);

}
