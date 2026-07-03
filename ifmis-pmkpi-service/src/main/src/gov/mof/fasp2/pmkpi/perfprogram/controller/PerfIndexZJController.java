package gov.mof.fasp2.pmkpi.perfprogram.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

;

/**
 * @description: TODO
 * @author: zhangxutao
 * @date: 2021/8/24 11:47
 * @version 1.0
 */
@RestController
@RequestMapping("/pmkpi/perfindexzj")
public class PerfIndexZJController {

//    private final static Logger logger = Logger.getLogger(PerfProgramService.class);
//
//    private PrjIndexDAO prjIndexDAO;
//
//    public void setPrjIndexDAO(PrjIndexDAO prjIndexDAO) {
//        this.prjIndexDAO = prjIndexDAO;
//    }
//
//    @ResponseBody
//    @RequestMapping(value = "/saveIndex", method = RequestMethod.POST)
//    public Map<String, Object> saveIndex(@RequestParam("agencyid") String agencyid) throws AppException {
//        logger.debug("--------pmkpi 新增指标入库开启 start-------------");
//        logger.debug("--------agencyid------"+agencyid+"-------");
//
//        Map<String, Object> retMap = new HashMap<>();
//        List<Map<String, Object>> addList = new ArrayList<>();
//        try{
//            String sql = "select * from v_perf_project_info where agency_code = '" + agencyid + "' ";
//            List<Map<String, Object>> list = prjIndexDAO.queryForList(sql);
//            //查询指标库最大排序数
//            List<Map<String, Object>> list1 = prjIndexDAO.queryForList("select max(ordernum) from bas_perf_indicator as ordernum ");
//            int a = 0;
//            int maxOrdernum = 0;
//            if (list != null && !list.isEmpty()) {
//                maxOrdernum = (int) list1.get(0).get("ordernum");
//            }
//            if (list != null && !list.isEmpty()) {
//                // 存放一级项目code
//                LinkedHashSet<String> mainCodeList = new LinkedHashSet<String>();
//                // 处理二级项目年度且新增指标
//                for (Map<String, Object> map : list) {
//                    String procode = (String) map.get("pro_code");
//                    String prolevcode = (String) map.get("pro_levone_code");
//                    mainCodeList.add(prolevcode);
//                    //查询二级项目年度且新增指标
//                    String sqlind = "select * from v_pm_perf_indicator where pro_code = "+procode+" and yearflag = '0' and is_add = '1' ";
//                    List<Map<String, Object>> listind = prjIndexDAO.queryForList(sqlind);
//                    logger.debug("--------"+procode+"-二级新增指标数量------"+listind.size()+"-------");
//
//                    for (Map<String, Object> mapind : listind){
//                        maxOrdernum = maxOrdernum + a++;
//                        HashMap<String, Object> addMap = new HashMap<>();
//                        addMap.put("guid", CommonUtil.createGUID());
//                        addMap.put("computesign",mapind.get("computesign")); //计算符号
//                        addMap.put("createtime",mapind.get("createtime"));    //创建时间
//                        addMap.put("updatetime",mapind.get("updatetime"));    //更新时间
//                        addMap.put("status","1");// 数据状态
//                        addMap.put("year",mapind.get("year"));//年度
//                        addMap.put("province",mapind.get("province"));//区划
//                        addMap.put("framesystem","PM001"); // 项目类型
//                        addMap.put("ordernum",maxOrdernum);//排序
//                        addMap.put("meterunit",mapind.get("meterunit"));  // 单位
//                        addMap.put("weight",mapind.get("weight"));    //权重
//                        addMap.put("ind_id",mapind.get("kpi_id"));    //指标ID
//                        addMap.put("perf_ind_code",mapind.get("code")); //指标code
//                        addMap.put("perf_ind_name",mapind.get("name")); //指标名称
//                        addMap.put("is_common_ind","1");//
//                        addMap.put("value_desc",mapind.get("kpi_remark"));//
//                        addMap.put("agency_code",mapind.get("agency_code"));//单位编码
//                        addMap.put("agencyguid",mapind.get("agency_code"));//单位code
//                        addMap.put("kpi_val",mapind.get("kpi_val"));//指标值
//                        addMap.put("mof_div_code",mapind.get("mof_div_code")); //区划
//                        addMap.put("fiscal_year",mapind.get("fiscal_year"));   //年度
//                        addMap.put("start_date",mapind.get("createtime"));//
//                        addMap.put("end_date",mapind.get("createtime"));//
//                        addMap.put("parent_id",mapind.get("superid"));//
//                        addMap.put("level_no","2");//
//                        addMap.put("is_leaf","1");//
//                        addMap.put("is_enabled","1");//
//                        addMap.put("update_time",mapind.get("updatetime"));//
//                        addMap.put("is_deleted","2");//
//                        addMap.put("create_time",mapind.get("createtime"));//
//                        addMap.put("findex",mapind.get("kpi_lv1")); //一级
//                        addMap.put("sindex",mapind.get("kpi_lv2"));    //二级
//                        addMap.put("name",mapind.get("name"));//指标名称
//                        addMap.put("industrycategory",procode); // 行业类别
//                        addMap.put("indexcategories",prolevcode);                  // 行业大类
//                        addMap.put("indexcategory","0");//指标类别
//                        addMap.put("wfstatus","011");//
//                        addMap.put("lastupdatetime",mapind.get("updatetime")); //流程最后更新时间
//                        addList.add(addMap);
//                    }
//                    // 如果入库流程退回重新审，项目已入库指标删除，取最新重新入库
//                    if(listind.size() > 0){
//                        String delsqlind = " code in (select code from v_pm_perf_indicator where  pro_code = "+procode+" and yearflag = '0' and is_add = '1')";
//                        prjIndexDAO.deltab("v_bas_perf_indicator",delsqlind);
//                    }
//                }
//                // 处理一级项目年度且新增指标
//                if (mainCodeList != null && !mainCodeList.isEmpty()) {
//                    Iterator i = mainCodeList.iterator();
//                    while (i.hasNext()){
//                        String prolevcode = (String) i.next();
//                        //查询一级项目且新增指标
//                        String sqlind = "select * from v_pm_perf_indicator where pro_code = "+prolevcode+" and yearflag = '0' and is_add = '1' ";
//                        List<Map<String, Object>> listind = prjIndexDAO.queryForList(sqlind);
//                        logger.debug("--------"+prolevcode+"-一级新增指标数量------"+listind.size()+"-------");
//
//                        for (Map<String, Object> mapind : listind){
//                            maxOrdernum = maxOrdernum + a++;
//                            HashMap<String, Object> addMap = new HashMap<>();
//                            addMap.put("guid", CommonUtil.createGUID());
//                            addMap.put("computesign",mapind.get("computesign")); //计算符号
//                            addMap.put("createtime",mapind.get("createtime"));    //创建时间
//                            addMap.put("updatetime",mapind.get("updatetime"));    //更新时间
//                            addMap.put("status","1");// 数据状态
//                            addMap.put("year",mapind.get("year"));//年度
//                            addMap.put("province",mapind.get("province"));//区划
//                            addMap.put("framesystem","PM001"); // 项目类型
//                            addMap.put("ordernum",maxOrdernum);//排序
//                            addMap.put("meterunit",mapind.get("meterunit"));  // 单位
//                            addMap.put("weight",mapind.get("weight"));    //权重
//                            addMap.put("ind_id",mapind.get("kpi_id"));    //指标ID
//                            addMap.put("perf_ind_code",mapind.get("code")); //指标code
//                            addMap.put("perf_ind_name",mapind.get("name")); //指标名称
//                            addMap.put("is_common_ind","1");//
//                            addMap.put("value_desc",mapind.get("kpi_remark"));//
//                            addMap.put("agency_code",mapind.get("agency_code"));//单位编码
//                            addMap.put("agencyguid",mapind.get("agency_code"));//单位code
//                            addMap.put("kpi_val",mapind.get("kpi_val"));//指标值
//                            addMap.put("mof_div_code",mapind.get("mof_div_code")); //区划
//                            addMap.put("fiscal_year",mapind.get("fiscal_year"));   //年度
//                            addMap.put("start_date",mapind.get("createtime"));//
//                            addMap.put("end_date",mapind.get("createtime"));//
//                            addMap.put("parent_id",mapind.get("superid"));//
//                            addMap.put("level_no","2");//
//                            addMap.put("is_leaf","1");//
//                            addMap.put("is_enabled","1");//
//                            addMap.put("update_time",mapind.get("updatetime"));//
//                            addMap.put("is_deleted","2");//
//                            addMap.put("create_time",mapind.get("createtime"));//
//                            addMap.put("findex",mapind.get("kpi_lv1")); //一级
//                            addMap.put("sindex",mapind.get("kpi_lv2"));    //二级
//                            addMap.put("name",mapind.get("name"));//指标名称
//                            addMap.put("industrycategory",prolevcode); // 行业类别
//                            addMap.put("indexcategories",prolevcode);                  // 行业大类
//                            addMap.put("indexcategory","0");//指标类别
//                            addMap.put("wfstatus","011");//
//                            addMap.put("lastupdatetime",mapind.get("updatetime")); //流程最后更新时间
//                            addList.add(addMap);
//                        }
//                        // 如果入库流程退回重新审，项目已入库指标删除，取最新重新入库
//                        if(listind.size() > 0){
//                            String delsqlind = " code in (select code from v_pm_perf_indicator where  pro_code = "+prolevcode+" and yearflag = '0' and is_add = '1')";
//                            prjIndexDAO.deltab("v_bas_perf_indicator",delsqlind);
//                        }
//                    }
//
//                }
//                if (addList != null && !addList.isEmpty()) {
//                    prjIndexDAO.saveAll(addList,"bas_perf_indicator");
//                    retMap.put("result", true);
//                    retMap.put("reason","指标已入库");
//                }
//
//            }
//        } catch (PerfAppException e) {
//            retMap = e.getRemap();
//            retMap.put("result", false);
//            retMap.put("reason",e.getCode());
//        }  catch (Exception e) {
//            logger.error(e.getMessage(), e);
//            retMap.put("result", false);
//            retMap.put("reason", e.getMessage());
//        }
//        logger.debug("--------pmkpi 新增指标入库关闭 end-------------");
//        return retMap;
//        }
//    /**
//     * 绩效目标评审,重点项目标识
//     */
//    @ResponseBody
//    @RequestMapping(value = "zjperfSignReview", produces = {"text/html;charset=utf-8"})
//    public Map<String, Object> perfSignReview(HttpServletRequest request, HttpServletResponse response){
//        logger.debug("--------perfSignReview 标记项目绩效目标评审 start-------------");
//        Map<String, Object> map = new HashMap<String, Object>();
//        try {
//            String datas = request.getParameter("datas");//项目数据
//            String bustype = request.getParameter("bustype");//项目类型，是收支项目还是部门整体项目
//            List<Map<String, Object>> list = null;
//            if (!StringUtil.isEmpty(datas) && !"undefined".equals(datas)) {
//                //指标信息json转成Map
//                String tabindexstr = URLDecoder.decode(datas, "utf-8");
//                tabindexstr = tabindexstr.replace("\\","");
//                tabindexstr = tabindexstr.substring(1, tabindexstr.length()-1);
//                list = PerfUtil.parseString2List(tabindexstr);
//            }
//            PerfReviewBO perfReviewBO = (PerfReviewBO) PerfServiceFactory.getBean("pmkpi.perfreview.PerfReviewBOTX");
//
//            String workflow = "";//工作流
//            if ("dept".equals(bustype)) {
//                workflow = "BC1379AA6FE2BE4AE053480A050AB64C";
//            } else {
//                //查询已经在评审列表的数据，如果存在，则去掉
//                List<String> alreadyList  = perfReviewBO.getAlreadReview("program");
//                list.removeIf(i -> alreadyList.contains(i.get("pro_code")));
//                //查询所有已标记的项目pro_code
//                List<String> signList  = perfReviewBO.getSinglist();
//                //去掉所有不存在重点标目编码的项目
//                list.removeIf(i -> !signList.contains(i.get("pro_code")));
//                workflow = "B9C7D80EC0188933E053B11FA8C0A5D6";
//            }
//            Map<String,Object> params = new HashMap<String,Object>();//参数
//            params.put("workflow", workflow);
//            params.put("datas", list);
//            Map<String, Object> backMap = perfReviewBO.savereviewdatas((HashMap<String, Object>) params);
//            Boolean success = (Boolean) backMap.get("success");
//            String returnval = "";
//            if(success){
//                returnval = "保存成功";
//            } else {
//                returnval = (String) backMap.get("returnval");
//            }
//            map.put("returnkey", String.valueOf(success));
//            map.put("returnval", returnval);
//            logger.debug("json:"+createJSONString(map).toString());
//            logger.debug("--------perfSignReview 标记项目绩效目标评审 end-------------");
//        } catch (PerfAppException e) {
//            map.put("returnkey", "false");
//            map.put("returnval",e.getCode());
//        }catch (Exception e) {
//            logger.error(e.getMessage(), e);
//        }
//        return map;
//    }
//    protected String createJSONString(Object obj) {
//        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
//        String json = jo.toString();
//        return json;
//    }
}
