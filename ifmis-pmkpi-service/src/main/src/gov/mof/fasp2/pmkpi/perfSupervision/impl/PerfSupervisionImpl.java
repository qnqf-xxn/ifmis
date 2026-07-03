package gov.mof.fasp2.pmkpi.perfSupervision.impl;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionBO;
import gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * <p>预算编制二上部门审核</p >
 *
 * @author zxt
 * @date 2021/8/10 11:30
 */
@RestController
@RequestMapping("/pmkpi/perfSupervision")
public class PerfSupervisionImpl {

    private final static Logger logger = Logger.getLogger(PerfSupervisionImpl.class);

    private PerfSupervisionBO perfSupervisionBO;

    @Resource(name = "pmkpi.perfSupervision.PerfSupervisionBOTX")
    public void setPerfSupervisionBO(PerfSupervisionBO perfSupervisionBO) {
        this.perfSupervisionBO = perfSupervisionBO;
    }

    private PerfSupervisionDAO perfSupervisionDAO;

    @Resource(name = "pmkpi.perfSupervision.PerfSupervisionDAO")
    public void setPerfSupervisionDAO(PerfSupervisionDAO perfSupervisionDAO) {
        this.perfSupervisionDAO = perfSupervisionDAO;
    }

    /**
     * <p>1.预算编制二上部门审核 审核通过，绩效处监审流程开启接口;</p >
     * 如退回到部门审核并再次审核通过时，需重新推送至绩效目标监审界面待办列表中
     *
     * request
     * @author zxt
     * @date 2021/6/7 10:25
     */
    @ResponseBody
    @RequestMapping(value = "/startJsProcess", method = RequestMethod.POST)
    public Map<String, Object> startJsProcess(@RequestParam("province") String province,
                                              @RequestParam("year") String year,
                                              @RequestParam("procode") String procode,
                                              @RequestParam("taskguid") String taskguid) {
        logger.error("--------pmkpi 预算调用监审开启 start-------------");
        HashMap<String, Object> retMap = new HashMap<>();
        retMap.put("result", false);
        retMap.put("reason", "失败！");
        //String proguid = request.getParameter("proguid"); //
        logger.error("--------procode----"+procode+"---------");
        logger.error("--------taskguid----"+taskguid+"---------");

        //当前登录用户
        String proSql = "SELECT * FROM v_perf_project_info WHERE pro_code = '" + procode + "' ";
        List<Map<String, Object>> proList = perfSupervisionDAO.queryForList(proSql); // 查询当前项目
        logger.error("--------proList----"+proList.size()+"---------");

        if (proList != null && proList.size() > 0) {
            Map<String, Object> proMap = proList.get(0);
            String proCatCode = (String) proMap.get("pro_cat_code");
            String proLev = (String) proMap.get("pro_lev");
            //String proguid = (String) proMap.get("pro_id"); //二级项目guid
            String prolevcode = (String) proMap.get("pro_levone_code"); // 一级项目code

            logger.error("--------proCatCode----"+proCatCode+"---------");
            logger.error("--------proLev----"+proLev+"---------");
            //logger.error("--------proguid----"+proguid+"---------");
            logger.error("--------prolevcode----"+prolevcode+"---------");
            try {
                if (!StringUtils.isEmpty(proCatCode) && ("22".equals(proCatCode) || "31".equals(proCatCode)
                        || "32".equals(proCatCode) || "3".equals(proCatCode))) {
                    //------------------------二级项目监审年度指标推送--------------------------
                    int vCount = perfSupervisionDAO.getDataCount("PERF_T_SUPERVISION", " MAINGUID ='" + procode + "' and wfstatus != '011'");
                    if (vCount > 0) {
                        perfSupervisionDAO.delDatas("PERF_T_SUPERVISION", " MAINGUID ='" + procode + "' and wfstatus != '011'");
                    }
                    logger.error("--------原有vCount-二级----"+vCount+"---------");

                    String indicatorSql = "SELECT * FROM v_pm_perf_indicator WHERE pro_code = '" + procode + "' and yearflag = '0' ";
                    List<Map<String, Object>> indicatorList = perfSupervisionDAO.queryForList(indicatorSql); //
                    logger.error("--------现有indicatorList-二级----"+indicatorList.size()+"---------");
                    String workflow = "";
                    if (indicatorList != null && !indicatorList.isEmpty()) {
                        List<Map<String, Object>> saveList = new ArrayList<>();
                        for (Map<String, Object> indicatorLMap : indicatorList) {
                            HashMap<String, Object> map = new HashMap<>();
                            String uuid = StringUtil.createUUID();
                            map.put("guid", uuid);
                            map.put("mainguid", procode);
                            map.put("status", "0");
                            map.put("createtime", PerfUtil.getServerTimeStamp());
                            map.put("updatetime", PerfUtil.getServerTimeStamp());
                            map.put("creater", "admin");
                            //PROVINCE
                            map.put("province", indicatorLMap.get("mof_div_code"));
                            map.put("year", indicatorLMap.get("fiscal_year"));
                            if (!StringUtils.isEmpty(proLev) && ("1".equals(proLev))) {
                                map.put("protype", "promain");
                                //map.put("wfid", "ACB7014749AFD762BBFD99D8304BA3FB");
                            } else if (!StringUtils.isEmpty(proLev) && ("2".equals(proLev))) {
                                map.put("protype", "prodetail");
                                //map.put("wfid", "ACB7014749AFD762BBFD99D8304BA3FC");
                            }
                            map.put("indexguid", indicatorLMap.get("kpi_id"));
                            //map.put("wfstatus", "000");
                            map.put("isadd", indicatorLMap.get("is_add"));
                            map.put("isadj", "0");
                            map.put("taskguid", taskguid);
                            saveList.add(map);
                        }
                        logger.error("--------pmkpi 二级项目监审指标开始推送-------------");
                        workflow = "ACB7014749AFD762BBFD99D8304BA3FC";
                        //perfSupervisionDAO.saveAll(saveList, "PERF_T_SUPERVISION");
                        perfSupervisionBO.workflow("create", workflow, "", "PERF_T_SUPERVISION", saveList);
                        retMap.put("result", true);
                        retMap.put("reason", "成功！");
                        logger.error("--------pmkpi 二级项目监审指标推送完成-------------");

                        logger.error("--------pmkpi 预算调用监审关闭 end-------------");

                    }

                    //------------------------ 一级项目监审年度指标推送--------------------------
                    Map maplev = perfSupervisionDAO.queryForMap("SELECT * FROM v_perf_project_info WHERE pro_code = '" + prolevcode + "' ");
                    if(!maplev.isEmpty()){
                        String prolevguid = (String) maplev.get("pro_id");
                        String prolev1 = (String) maplev.get("pro_lev");

                        logger.error("--------prolevguid----"+prolevguid+"---------");

                        int vCount1 = perfSupervisionDAO.getDataCount("PERF_T_SUPERVISION", " MAINGUID ='" + prolevcode + "' and wfstatus != '011'");
                        if (vCount1 > 0) {
                            perfSupervisionDAO.delDatas("PERF_T_SUPERVISION", " MAINGUID ='" + prolevcode + "' and wfstatus != '011'");
                        }
                        logger.error("--------原有vCount-一级----"+vCount1+"---------");

                        String indicatorSql1 = "SELECT * FROM v_pm_perf_indicator WHERE pro_code = '" + prolevcode + "' and yearflag = '0' ";
                        List<Map<String, Object>> indicatorListlev = perfSupervisionDAO.queryForList(indicatorSql1); //
                        logger.error("--------现有indicatorList-一级----"+indicatorListlev.size()+"---------");

                        if (indicatorListlev != null && !indicatorListlev.isEmpty()) {
                            List<Map<String, Object>> saveList = new ArrayList<>();
                            for (Map<String, Object> indicatorLMap : indicatorListlev) {
                                HashMap<String, Object> map = new HashMap<>();
                                String uuid = StringUtil.createUUID();
                                map.put("guid", uuid);
                                map.put("mainguid", prolevcode);
                                map.put("status", "0");
                                map.put("createtime", PerfUtil.getServerTimeStamp());
                                map.put("updatetime", PerfUtil.getServerTimeStamp());
                                map.put("creater", "admin");
                                //PROVINCE
                                map.put("province", indicatorLMap.get("mof_div_code"));
                                map.put("year", indicatorLMap.get("fiscal_year"));
                                if (!StringUtils.isEmpty(prolev1) && ("1".equals(prolev1))) {
                                    map.put("protype", "promain");
                                    //map.put("wfid", "ACB7014749AFD762BBFD99D8304BA3FB");
                                } else if (!StringUtils.isEmpty(prolev1) && ("2".equals(prolev1))) {
                                    map.put("protype", "prodetail");
                                    //map.put("wfid", "ACB7014749AFD762BBFD99D8304BA3FC");
                                }
                                map.put("indexguid", indicatorLMap.get("kpi_id"));
                                //map.put("wfstatus", "000");
                                map.put("isadd", indicatorLMap.get("is_add"));
                                map.put("isadj", "0");
                                map.put("taskguid", taskguid);
                                saveList.add(map);
                            }
                            workflow = "ACB7014749AFD762BBFD99D8304BA3FB";
                            //perfSupervisionDAO.saveAll(saveList, "PERF_T_SUPERVISION");
                            perfSupervisionBO.workflow("create", workflow, "", "PERF_T_SUPERVISION", saveList);

                            retMap.put("result", true);
                            retMap.put("reason", "成功！");
                            logger.error("--------pmkpi 一级项目监审指标推送完成-------------");
                        }
                    }
                    logger.error("--------pmkpi 预算调用监审关闭 end-------------");
                }
            } catch (AppException e) {
                retMap.put("result", false);
                retMap.put("reason", "失败：" + e.getMessage());
            }
        }
        return retMap;
    }


    /**
     * @description:  监审新增指标意见强制调整校验
     * @param: perfCheckout
     * @return:  Map
     * @author: zhangxutao
     * @date: 2021/8/15 10:57
     */
    @ResponseBody
    @RequestMapping(value = "/perfCheckout", method = RequestMethod.POST)
    public Map<String, Object> perfCheckout(@RequestParam("agencyid") String agencyid) throws AppException {
        logger.error("--------pmkpi 监审校验接口开启 start-------------");
        logger.error("--------agencyid----"+agencyid+"---------");

        HashMap<String, Object> retMap = new HashMap<>();
        //List<Map<String, Object>> rsultList = new ArrayList<>();
        //String agencyid = request.getParameter("agencyid"); // 单位id
        // 监审意见不为空并且为新增指标  isadjoption 1：强制调整 2：建议调整 0：通过
        String sql = "SELECT proname FROM V_PERF_T_SUPERVISIONVIEW WHERE agencyguid = '" + agencyid + "' AND WFSTATUS = '011' " +
                " AND ADJOPTION IS NOT NULL AND isadd = '1'  and isadj = '1' GROUP BY proname";
        List<Map<String, Object>> list = perfSupervisionDAO.queryForList(sql);
        if (list != null && !list.isEmpty()) {
            for (Map<String, Object> map : list) {
                String proname = (String) map.get("proname");
                retMap.put("result", false);
                retMap.put("reason", "”" + proname + "“，该项目存在强制调整绩效指标，请修改后再行操作！");
                logger.error("--------pmkpi--------"+proname+",该项目存在强制调整绩效指标，请修改后再行操作！-----");

                //rsultList.add(retMap);
            }
        } else {
            retMap.put("result", true);
            retMap.put("reason", "该单位下没有项目存在强制调整绩效指标！");
            logger.error("--------pmkpi--------该单位下没有项目存在强制调整绩效指标-----");

            //rsultList.add(retMap);
        }
        logger.error("--------pmkpi 监审校验接口关闭 end-------------");

        return retMap;
    }


}
