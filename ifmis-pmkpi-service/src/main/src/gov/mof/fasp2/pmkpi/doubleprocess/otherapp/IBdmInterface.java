package gov.mof.fasp2.pmkpi.doubleprocess.otherapp;

import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;


@FeignClient("ifmis-bdm-service")
public interface IBdmInterface {
    /**
     * @Description:判断项目库是否处在二上阶段
     * @param progremIds 项目ids
     * @return
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/pkmpi/checkprocessbyprogremids")
    @ResponseBody
    public MicroParamDTO checkProgremProcess(@RequestParam("progremIds") String progremIds);

    /**
     * @Description:判断基本支出整体填报是否处在二上阶段
     * @param departmentId 部门id
     * @return
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/pkmpi/checkprocessbydepartmentid")
    @ResponseBody
    public MicroParamDTO checkBaseFundsProcess(@RequestParam("departmentId") String departmentId);


    /**
     * @Description:获取预算流程状态
     * @param dto list:单位信息集合， 包含 agency_code,mof_div_code，fiscal_year，taskflag(可不传，1:一上；2：二上)
     * @return MicroParamDTO boolean:是否成功;str1：失败原因;
     * list:流程信息集合 包含agency_code,mof_div_code，fiscal_year，taskflag(1:一上；2：二上)，wfstatus(工作流状态)
     * @throws Exception
     * @throws
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/bdm/pkmpi/querytaskflow", method = RequestMethod.POST)
    @ResponseBody
    public MicroParamDTO querytaskflow(@RequestBody MicroParamDTO dto);


    /**
     * @Description:根据年度查询tablecode对应表数据总条数
     * @param year 年度
     * @param tablecode 来源表（视图）
     * @return MicroParamDTO.map result datacount message
     * @throws Exception
     */
    @RequestMapping(value = "/bdm/pkmpi/queryBdmOfTabledata")
    @ResponseBody
    public MicroParamDTO queryBdmOfTabledata(@RequestParam("province") String province,@RequestParam("year") String year,@RequestParam("tablecode") String tablecode);

    /**
     * @Description:根据年度和分页查询tablecode对应表数据
     * @param year 年度
     * @param tablecode 来源表（视图）
     * @param pagecount 每页条数
     * @param pagenum 页码
     * @return MicroParamDTO.map result data message
     * @throws Exception
     */
    @RequestMapping(value = "/bdm/pkmpi/getBdmOfTabledata")
    @ResponseBody
    public MicroParamDTO getBdmOfTabledata(@RequestParam("province") String province,@RequestParam("year") String year,@RequestParam("tablecode") String tablecode,@RequestParam("pagecount") String pagecount,@RequestParam("pagenum") String pagenum);
}
