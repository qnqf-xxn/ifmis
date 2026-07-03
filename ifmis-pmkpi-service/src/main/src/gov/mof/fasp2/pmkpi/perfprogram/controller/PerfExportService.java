package gov.mof.fasp2.pmkpi.perfprogram.controller;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.ui.dto.UIconfigDTO;
import gov.mof.fasp2.datacommon.common.util.CommonUtil;
import gov.mof.fasp2.pmkpi.perfprogram.assessment.PerfAssessmentBO;
import gov.mof.fasp2.pmkpi.perfprogram.beforeview.BeforeviewDAO;
import gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

;

@RestController
public class PerfExportService {
    private final static Logger logger = Logger.getLogger(PerfExportService.class);

    @ApiOperation(value = "查询公司绩效嵌入页签数据",httpMethod = "POST",response = FaspDTO.class)
    @PostMapping(value = "/pmkpi/tab/query/{mof_div_code}/{fiscal_year}",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public FaspDTO  queryPerfDatas(@ApiParam(required = true,value = "绩效页签配置数据",example = "{tabUrl:" +
            "http://x.x.x.x/pmkpi/program/report/progoal.page?projId=B97BD11DB0583BCA7139EC5EDCC852B9&" +
            "authorization=0d2f8085a08c49b5b606d38832dde85c&stagid=B97BD11DB0583BCA7139EC5EDCC852B9&proj" +
            "type=2&tokenid=75401jExIRNTC&authorization=0d2f8085a08c49b5b606d38832dde85c}")
                                       @RequestBody Map<String, Object> kpiTabDatas,
                                       @ApiParam(required = true, value = "财政") @PathVariable(value = "mof_div_code",required = true) String mof_div_code,
                                       @ApiParam(required = true, value = "财年") @PathVariable(value = "fiscal_year",required = true) String fiscal_year) throws Exception {
        String tabUrl = (String) kpiTabDatas.get("tabUrl");
        logger.debug("----------项目导出tabUrl----------" + tabUrl);
        String projId = "";//项目的guid
        String[] split1 = tabUrl.split("\\?");
        String key = split1[0]; //页面的key
        String paramStr = split1[1];//url的参数
        String[] paramArr = paramStr.split("&"); //参数集合
        for(int i = 0 ; i < paramArr.length; i++ ){
            String str = paramArr[i];
            if(str.contains("projId")){
                String[] projIdArr = str.split("=");
                projId = projIdArr[1];
            }
        }
        logger.debug("--------导出开始-------------");
        logger.debug("--------导出开始-------------项目ID"+projId);
        FaspDTO retKpiTabExpDatas = new FaspDTO();
        if(key.contains("/pmkpi/program/report/progoal") || key.contains("/pmkpi/program/report/protabgoal")){
            logger.debug("--------绩效目标导出开始-------------");
            String uikey = "";
            if (key.contains("/pmkpi/program/report/progoal")) {
                uikey = "/pmkpi/program/report/proindex";
            } else {
                uikey = "/pmkpi/program/report/protabgoal";
            }
            PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
            List<UIconfigDTO> editfromlist = prjIndexBO.getEditformData(uikey);
            editfromlist = editfromlist .stream().filter(map-> "1".equals(map.get("isvisiable") + "")).collect(Collectors.toList());
            this.setCols(editfromlist);
            List dataHeadsList = new ArrayList();
            List dataHeadList = new ArrayList();//表格标题
            //查詢中期
            String goalsql = " mainguid='" + projId + "'";
            //查詢年度
            if (!PerfUtil.getProgramIsyear()) {
                goalsql += " and yearflag='1'";
            }
            String tablecode = "(select aa.*,'总体目标' type from pm_perf_goal_info aa where aa.is_backup =2 and aa.is_deleted=2 and aa.yearflag = '1'";
            if (PerfUtil.getProgramIsyear()) {
                tablecode += " union all select aa.*,'年度目标' type from pm_perf_goal_info aa where aa.is_backup =2 and aa.is_deleted=2 and aa.yearflag = '0' " + PerfUtil.yearProvinceSql("aa");
            }
            tablecode += ")";
            List<Map<String, Object>> goallist = prjIndexBO.getDatas(tablecode, goalsql, "order by yearflag desc");
            List dataList = new ArrayList();//表格数据
            //数据列类型
            List dataColsList = new ArrayList();
            List dataColList = new ArrayList();
            for (int i = 0;i< editfromlist.size();i++) {
                Map<String, Object> editform = editfromlist.get(i);
                String name = (String) editform.get("name");
                //表头
                Map<String, Object> head = new HashMap<>();
                head.put("$H" + i + "_colspan", "1");
                head.put("$H" + i + "_rowspan", "1");
                head.put("$H" + i, name);
                dataHeadList.add(head);
                //数据列类型
                Map<String, Object> dataCol = new HashMap<>();
                dataCol.put("datatype", "tree");
                dataCol.put("dataidx", i);
                dataCol.put("fmtCol", 0);
                dataCol.put("fmtRow", 10);
                dataColList.add(dataCol);
            }
            dataHeadsList.add(dataHeadList);
            dataColsList.add(dataColList);
            for(int m = 0;m< goallist.size();m++){
                Map<String, Object> data = new HashMap<>();
                for (int i = 0;i< editfromlist.size();i++){
                    String columncode = (String) editfromlist.get(i).get("colcode");
                    //表格数据
                    data.put("$D"+i, goallist.get(m).get(columncode));
                }
                dataList.add(data);
            }
            retKpiTabExpDatas.put("datas", dataList);//表格数据
            retKpiTabExpDatas.put("dataCols", dataColsList);//数据列类型
            retKpiTabExpDatas.put("headDatas", dataHeadsList);//表头
            logger.debug("--------绩效目标导出结束-------------");
        }
        if(key.contains("/pmkpi/program/report/treeindex")){
            logger.debug("--------绩效指标导出开始-------------");
            String uikey = "/pmkpi/program/report/treeindex";
            gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            List<Map<String, Object>> tablecollist = prjIndexBO.getCols(uikey);
            tablecollist = tablecollist .stream().filter(map-> ("1".equals(map.get("isvisiable") + "") && !"obligate1".equals(map.get("colcode")) || "findex".equals(map.get("colcode"))|| "sindex".equals(map.get("colcode")))).collect(Collectors.toList());
            this.setCols(tablecollist);
            //指标
            List<Map<String, Object>> indexList = prjIndexBO.getExportIndex(projId);
            //表格标题
            List dataHeadsList = new ArrayList();
            List dataHeadList = new ArrayList();
            //数据列类型
            List dataColsList = new ArrayList();
            List dataColList = new ArrayList();
            for (int i = 0;i< tablecollist.size();i++){
                String name = (String) tablecollist.get(i).get("name");
                //表头
                Map<String, Object> head = new HashMap<>();
                head.put("$H"+i+"_colspan", "1");
                head.put("$H"+i+"_rowspan", "1");
                head.put("$H"+i, name);
                dataHeadList.add(head);
                //数据列类型
                Map<String, Object> dataCol = new HashMap<>();
                dataCol.put("datatype", "tree");
                dataCol.put("dataidx", i);
                dataCol.put("fmtCol", 0);
                dataCol.put("fmtRow", 10);
                dataColList.add(dataCol);
            }
            dataHeadsList.add(dataHeadList);
            dataColsList.add(dataColList);
            List dataList = new ArrayList();//表格数据
            for (int m = 0;m< indexList.size();m++){
                Map<String, Object> data = new HashMap<>();
                for (int n = 0;n< tablecollist.size();n++){
                    String columncode = (String) tablecollist.get(n).get("colcode");
                    data.put("$D"+n, indexList.get(m).get(columncode));
                }
                dataList.add(data);

            }
            retKpiTabExpDatas.put("datas", dataList);//表格数据
            retKpiTabExpDatas.put("dataCols", dataColsList);//数据列类型
            retKpiTabExpDatas.put("headDatas", dataHeadsList);//表头
            logger.debug("--------绩效指标导出datas-------------" +dataList);
            logger.debug("--------绩效指标导出headDatas-------------" +dataHeadsList);
            logger.debug("--------绩效指标导出结束-------------");
        }
        if(key.contains("/pmkpi/program/assessment/list")){
            logger.debug("--------事前绩效评估导出开始-------------");
            String uikey = "/pmkpi/program/assessment/list";
            PerfAssessmentBO perfAssessmentBO = (PerfAssessmentBO) PerfServiceFactory.getBean("pmkpi.perfprogram.assessment.PerfAssessmentBOTX");
            List<Map<String, Object>> tablecollist = perfAssessmentBO.getCols(uikey);
            tablecollist = tablecollist .stream().filter(map-> "1".equals(map.get("isvisiable") + "")).collect(Collectors.toList());
            //表格标题
            List dataHeadsList = new ArrayList();
            List dataHeadList = new ArrayList();
            //数据列类型
            List dataColsList = new ArrayList();
            List dataColList = new ArrayList();
            //事前绩效评估
            List<Map<String, Object>> assessmentlist = perfAssessmentBO.getExportDatas(projId);
            for (int i = 0;i< tablecollist.size();i++){
                String name = (String) tablecollist.get(i).get("name");
                //表头
                Map<String, Object> head = new HashMap<>();
                head.put("$H"+i+"_colspan", "1");
                head.put("$H"+i+"_rowspan", "1");
                head.put("$H"+i, name);
                dataHeadList.add(head);
                //数据列类型
                Map<String, Object> dataCol = new HashMap<>();
                dataCol.put("datatype", "tree");
                dataCol.put("dataidx", i);
                dataCol.put("fmtCol", 0);
                dataCol.put("fmtRow", 10);
                dataColList.add(dataCol);
            }
            dataHeadsList.add(dataHeadList);
            dataColsList.add(dataColList);
            List dataList = new ArrayList();//表格数据

            for (int m = 0;m< assessmentlist.size();m++){
                Map<String, Object> data = new HashMap<>();
                for (int n = 0;n< tablecollist.size();n++){
                    String columncode = (String) tablecollist.get(n).get("colcode");
                    //表格数据
                    data.put("$D"+n, assessmentlist.get(m).get(columncode));
                }
                dataList.add(data);
            }
            retKpiTabExpDatas.put("datas", dataList);//表格数据
            retKpiTabExpDatas.put("dataCols", dataColsList);//数据列类型
            retKpiTabExpDatas.put("headDatas", dataHeadsList);//表头
            logger.debug("--------事前评估导出结束-------------");
        }
        return retKpiTabExpDatas;
    }

    /**
     * 添加类型
     * @param list
     */
    private void setCols(List list){
        UIconfigDTO uIconfigDTO = new UIconfigDTO();
        uIconfigDTO.put("colcode", "type");
        uIconfigDTO.put("name", "类型");
        uIconfigDTO.put("ordernum", 0);
        list.add(0, uIconfigDTO);
    }

    /**
     * 项目库复制绩效指标目标接口/调整不挂绩效页签
     * 四种场景应用：1调整新增保存的时候(没有额外参数)2项目终止里面项目重用(is_reused)3结转经常性项目(is_carryover)4项目单位复制(is_copy)
     * 项目库那边传递的value:dto{agency_code,pro_code,agency_name,pro_name}属性。
     * @param dataMap 参数
     * @return
     */
    @ApiOperation(value = "项目库复制绩效指标目标接口", httpMethod = "POST")
    @RequestMapping(value = "/pmkpi/program/copy/goalandindex", method = RequestMethod.POST)
    @ResponseBody
    public Map copyPerformGoal(@RequestBody Map<String, FaspDTO> dataMap){
        Map<String, Object> remp = new HashMap<>();
        List<Map<String, Object>> copyGoal = new ArrayList<>();//复制的总体目标
        List<Map<String, Object>> copyIndex = new ArrayList<>();//复制的总体指标
        List<Map<String, Object>> copyAssessment = new ArrayList<>();//复制事前绩效评估
        List<Map<String, Object>> copyBeforeview = new ArrayList<>();//复制事前绩效评估报告
        Map<String, Object> copyAssessmentopinion = new HashMap<>();//复制事前绩效评估
        String goalTablecode = "pm_perf_goal_info";
        String indexTablecode = "pm_perf_indicator";
        String assessmentTable = "perf_t_assessment";
        String beforeviewTable = BeforeviewDAO.PERF_TABLE_BEFOREVIEW;
        boolean is_carryover = dataMap.containsKey("is_carryover");
        logger.debug("----------项目库结转调用绩效复制接口参数is_carryover是否存在:" + is_carryover);
        logger.debug("---------项目库传递过来的信息："+dataMap.toString());
        String assessmentopinionTable = "perf_t_assessmentopinion";
        for (Map.Entry entry : dataMap.entrySet()) {
            String oldproguid = (String) entry.getKey();//老的项目guid
            if (oldproguid.equals("is_carryover") || oldproguid.equals("is_reused") || oldproguid.equals("is_copy")){
                continue;
            }
            FaspDTO dto = (FaspDTO) entry.getValue();
            String newproguid = dto.getGuid();//新的项目guid
            String agency_code = (String) dto.get("agency_code");//新的单位code
            String pro_code = (String) dto.get("pro_code");//新的项目code
            String agency_name = (String) dto.get("agency_name"); //新项目单位名称
            String pro_name = (String) dto.get("pro_name"); //新项目名称.
            logger.debug("----------老的项目guid:" + oldproguid);
            logger.debug("----------新的项目guid:" + newproguid);
            gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO prjIndexBO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            String wheresql = " t.mainguid='"+oldproguid+"' and t.is_deleted=2 ";
            String newwheresql = " t.mainguid='"+newproguid+"' and t.is_deleted=2 ";
            int assessmentNum = prjIndexBO.getDataCount(assessmentTable, newwheresql);
            if (assessmentNum == 0) {
                List<Map<String, Object>> assessmentList = prjIndexBO.getDatas(assessmentTable, wheresql, null);
                if (assessmentList != null && assessmentList.size() > 0) {
                    for (Map<String, Object> assessmentMap : assessmentList) {
                        String newguid = CommonUtil.createGUID();
                        assessmentMap.put("guid", newguid);
                        assessmentMap.put("mainguid", newproguid);
                        assessmentMap.put("pro_code", pro_code);
                        assessmentMap.put("agencyguid", agency_code);
                        assessmentMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                        assessmentMap.put("createtime", PerfUtil.getServerTimeStamp());
                        assessmentMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        assessmentMap.put("year", CommonUtil.getYear());
                        assessmentMap.put("fiscal_year", CommonUtil.getYear());
                        if (is_carryover){
                            assessmentMap.put("is_last_inst","1");  //是否终审  1：是
                        }
                        copyAssessment.add(assessmentMap);
                    }
                }
            }
            int assessmentopinionNum = prjIndexBO.getDataCount(assessmentopinionTable, newwheresql);
            if (assessmentopinionNum == 0) {
                List<Map<String, Object>> assessmentopinionList = prjIndexBO.getDatas(assessmentopinionTable, wheresql, null);
                if (assessmentopinionList != null && assessmentopinionList.size() > 0) {
                    for (Map<String, Object> assessmentopinionMap : assessmentopinionList) {
                        String newguid = CommonUtil.createGUID();
                        assessmentopinionMap.put("guid", newguid);
                        assessmentopinionMap.put("mainguid", newproguid);
                        assessmentopinionMap.put("pro_code", pro_code);
                        assessmentopinionMap.put("agencyguid", agency_code);
                        assessmentopinionMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                        assessmentopinionMap.put("createtime", PerfUtil.getServerTimeStamp());
                        assessmentopinionMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        assessmentopinionMap.put("year", CommonUtil.getYear());
                        assessmentopinionMap.put("fiscal_year", CommonUtil.getYear());
                        if (is_carryover){
                            assessmentopinionMap.put("is_last_inst","1");  //是否终审  1：是
                        }
                        copyAssessmentopinion.putAll(assessmentopinionMap);
                    }
                }
            }
            int beforeviewNum = prjIndexBO.getDataCount(beforeviewTable, newwheresql);
            if (beforeviewNum == 0) {
                List<Map<String, Object>> beforeviewList = prjIndexBO.getDatas(beforeviewTable, wheresql, null);
                if (beforeviewList != null && beforeviewList.size() > 0) {
                    for (Map map : beforeviewList ) {
                        String newindexguid = CommonUtil.createGUID();
                        map.put("guid", newindexguid);
                        this.setCopyData(map, newproguid, pro_code, agency_code, agency_name, pro_name);
                        copyBeforeview.add(map);
                    }
                }
            }
            wheresql += " and t.yearflag='1' and t.is_backup=2 ";
            newwheresql += " and t.yearflag='1' and t.is_backup =2 ";
            int goalnum = prjIndexBO.getDataCount(goalTablecode, newwheresql);
            HashMap<String,String> goalguidMap = new HashMap<String,String>();
            if (goalnum == 0) {
                List<Map<String, Object>> goalList = prjIndexBO.getDatas(goalTablecode, wheresql, null);
                if (goalList != null && goalList.size() > 0) {
                    for (Map<String, Object> goalMap : goalList) {
                        String newgoalguid = CommonUtil.createGUID();
                        if(PerfUtil.getIS_HUBEI()) {//湖北模式
                            String oldgoalguid = (String) goalMap.get("guid");
                            goalguidMap.put(oldgoalguid, newgoalguid);
                        }
                        goalMap.put("guid", newgoalguid);
                        if (is_carryover){
                            goalMap.put("is_last_inst","1");  //是否终审  1：是
                        }
                        this.setCopyData(goalMap, newproguid, pro_code, agency_code, agency_name, pro_name);
                        copyGoal.add(goalMap);
                    }
                }
            }
            int indexnum = prjIndexBO.getDataCount(indexTablecode, newwheresql);
            if (indexnum == 0) {
                List<Map<String, Object>> indexList = prjIndexBO.getDatas(indexTablecode, wheresql, null);
                if (indexList != null && indexList.size() > 0) {
                    for (Map map : indexList ) {
                        String newindexguid = CommonUtil.createGUID();
                        map.put("guid", newindexguid);
                        if (is_carryover){
                            map.put("is_last_inst","1");  //是否终审  1：是
                        }
                        this.setCopyData(map, newproguid, pro_code, agency_code, agency_name, pro_name);
                        //湖北模式 目标生成新的id后  指标关联的goalguid也要相应改变
                        if(PerfUtil.getIS_HUBEI()){
                            String oldgoalguid = (String) map.get("goalguid");
                            if (oldgoalguid != null && ! oldgoalguid.isEmpty()) {
                                String newGoalguid = goalguidMap.get(oldgoalguid);
                                map.put("goalguid", newGoalguid);
                            }
                        }
                        if (PerfUtil.get_IsJiangXi()){
                            map.put("is_add","2");
                            map.put("islinked",null);
                            map.put("indexcategories",null);
                            map.put("industrycategory",null);
                            map.put("indexcategory",null);
                            map.put("filed",null);
                            map.put("occupation",null);
                        }
                        copyIndex.add(map);
                    }
                }
            }

            //是否处理年度数据
            if (PerfUtil.getProgramIsyear()) {//调整年度:数据根据proguid+pro_code查询
                goalTablecode = "pm_perf_goal_info";
                indexTablecode = "pm_perf_indicator";
                String sql = " and pro_code='" + pro_code + "' and t.yearflag='0' and is_deleted=2 and is_backup =2 " + PerfUtil.yearProvinceSql("t");
                String oldsql = " and pro_code='" + pro_code + "' and t.yearflag='0' and is_deleted=2 and is_backup =2 ";
                //项目库结转调用绩效复制接口参数is_carryover
                if(is_carryover){
                    Integer userSelectYear = SecureUtil.getUserSelectYear() - 1;
                    oldsql += " and t.year='" + userSelectYear + "' and t.province='" + SecureUtil.getUserSelectProvince() + "' ";
                }else{
                    oldsql += PerfUtil.yearProvinceSql("t");
                }
                wheresql = " t.mainguid='" + oldproguid + "'" + oldsql;
                newwheresql = " t.mainguid='" + newproguid + "'" + sql;
                String year = CommonUtil.getYear();
                int yeargoalnum = prjIndexBO.getDataCount(goalTablecode, newwheresql);
                HashMap<String,String> yeargoalidMap = new HashMap<String,String>();
                if (yeargoalnum == 0) {
                    List<Map<String, Object>> goalList = prjIndexBO.getDatas(goalTablecode, wheresql, null);
                    if (goalList != null && goalList.size() > 0) {
                        for (Map<String, Object> goalMap : goalList) {
                            String newgoalguid = CommonUtil.createGUID();
                            if(PerfUtil.getIS_HUBEI()) {//湖北模式
                                String oldgoalguid = (String) goalMap.get("guid");
                                yeargoalidMap.put(oldgoalguid, newgoalguid);
                            }
                            goalMap.put("guid", newgoalguid);
                            goalMap.put("is_adj", 1);//调整是否终审
                            if (is_carryover){
                                goalMap.put("year", year);
                            }
                            this.setCopyData(goalMap, newproguid, pro_code, agency_code, agency_name, pro_name);
                            copyGoal.add(goalMap);
                        }
                    }
                }
                int yearindexnum = prjIndexBO.getDataCount(indexTablecode, newwheresql);
                if (yearindexnum == 0) {
                    List<Map<String, Object>> indexList = prjIndexBO.getDatas(indexTablecode, wheresql, null);
                    if (indexList != null && indexList.size() > 0) {
                        for (Map map : indexList ) {
                            String newguid = CommonUtil.createGUID();
                            map.put("guid", newguid);
                            map.put("is_adj", 1);//调整是否终审
                            if (is_carryover){
                                map.put("year", year);
                            }
                            this.setCopyData(map, newproguid, pro_code, agency_code, agency_name, pro_name);
                            //湖北模式 目标生成新的id后  指标关联的goalguid也要相应改变
                            if(PerfUtil.getIS_HUBEI()){
                                String oldgoalguid = (String) map.get("goalguid");
                                if (oldgoalguid != null && ! oldgoalguid.isEmpty()) {
                                    String newGoalguid = yeargoalidMap.get(oldgoalguid);
                                    map.put("goalguid", newGoalguid);
                                }
                            }
                            if (PerfUtil.get_IsJiangXi()){
                                map.put("is_add","2");
                                map.put("islinked",null);
                                map.put("indexcategories",null);
                                map.put("industrycategory",null);
                                map.put("indexcategory",null);
                                map.put("filed",null);
                                map.put("occupation",null);
                            }
                            copyIndex.add(map);
                        }
                    }
                }
            }
        }
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        try {
            if (copyAssessment.size() > 0) {
                prjIndexDAO.saveAll(copyAssessment, assessmentTable);
            }
            if (!copyAssessmentopinion.isEmpty()) {
                prjIndexDAO.save(copyAssessmentopinion, assessmentopinionTable);
            }
            if (copyGoal.size() > 0) {
                prjIndexDAO.saveAll(copyGoal, goalTablecode);
            }
            if (copyIndex.size() > 0) {
                prjIndexDAO.setIndexDatas(copyIndex, "PM001", false);
                prjIndexDAO.saveAll(copyIndex,indexTablecode);
            }
            if (copyBeforeview.size() > 0) {
                prjIndexDAO.saveAll(copyBeforeview, beforeviewTable);
            }
            remp.put("success", true);
        }  catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("success", false);
        }
        return remp;
    }

    /**
     * 项目调整复制赋值
     * @param data
     * @param mainguid
     * @param pro_code
     * @param agency_code
     * @param  agency_name -- 传递过来的新项目的单位名称
     * @param  pro_name -- 传递过来的新项目名称
     */
    private void setCopyData(Map<String, Object> data, String mainguid, String pro_code, String agency_code,String agency_name,String pro_name) {
        data.put("mainguid", mainguid);
        data.put("pro_code", pro_code);
        data.put("agencyguid", agency_code);
        data.put("is_last_inst",2);//是否终审
        data.put("fiscal_year", CommonUtil.getYear());
        data.put("year", CommonUtil.getYear());
        if (!StringUtil.isEmpty(agency_name)){
            data.put("agency_name",agency_name);
        }
        if (!StringUtil.isEmpty(pro_name)){
            data.put("pro_name",pro_name);
        }
        data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
        PerfServiceFactory.getPmkpiBO().getBasMap(data, "add");
    }

}
