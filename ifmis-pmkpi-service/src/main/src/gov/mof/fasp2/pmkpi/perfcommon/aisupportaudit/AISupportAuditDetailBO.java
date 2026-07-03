package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.collections.CollectionUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class AISupportAuditDetailBO extends PmkpiBO {

    private AISupportAuditDAO aISupportAuditDAO;

    public void setAISupportAuditDAO(AISupportAuditDAO aISupportAuditDAO) {
        this.aISupportAuditDAO = aISupportAuditDAO;
    }

    /**
     * 获取项目提示词
     * @param params
     * @return --
     */
    public Map<String, Object> getProPrompt(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        boolean ishubei = PerfUtil.getIS_HUBEI();
        boolean isguangxi = PerfUtil.getIsGuangXi();
        boolean isanhui = PerfUtil.get_ISANHUI();
        String pro_code = (String) params.get("pro_code");
        // AI组装提示词
        Map<String, Object> aipromptmap = new HashMap<>();
        Map<String, Object> proinfo = new HashMap<>();
        if(StringUtils.isNotEmpty(pro_code)){// 查询项目信息并组装提示词
            String wheresql = "t.pro_code = ?";
            Map<String, Object> proMap = aISupportAuditDAO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO,wheresql,new String[]{pro_code});
            if(proMap.isEmpty()){
                backmap.put("success",false);
                backmap.put("error","所选项目未查询到项目信息!");
                return backmap;
            }
            if(!proMap.isEmpty()){
                // 项目信息
                proinfo = proMap;
                aipromptmap.put("项目代码",proMap.get("pro_code"));
                aipromptmap.put("项目名称",proMap.get("pro_name"));
                aipromptmap.put("单位代码",proMap.get("agency_code"));
                aipromptmap.put("单位名称",proMap.get("agency_name"));
                aipromptmap.put("项目内容",proMap.get("pro_desc"));
                aipromptmap.put("预算年度",SecureUtil.getUserSelectYear());
                if(isanhui || isguangxi){// 安徽/广西 是否科研、是否基建
                    aipromptmap.put("是否科研","1".equals(proMap.get("is_scientific")) ? "是" : "否");
                    aipromptmap.put("是否基建","0".equals(proMap.get("captial_cons_pro_type_code")) ? "否" : "是");
                }

                // 预算资金情况
                List<Map<String, Object>>  yearbgtmatlist = aISupportAuditDAO.queryForList("select sum(b.FIN_AUDIT_MONEY) as yearbgtamt from v_bgt_pm_annual b" +
                        " where b.pro_code = '"+pro_code+"' and b.is_deleted = 2 group by mof_div_code, fiscal_year, pro_code");
                if (yearbgtmatlist.size() > 0) {
                    aipromptmap.put("本年度预算资金总额",yearbgtmatlist.get(0).get("yearbgtamt") + "元");
                }

                // 指标计算符号翻译信息
                IDataSetService dss = PerfServiceFactory.getIDataSetService();
                List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
                Map<Object, Object> signsMap = signs.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
                // 绩效目标和指标
                if(!ishubei){ // 非湖北时 默认查询本年和上年的PM表申报目标指标
                    // 本年度绩效目标指标
                    wheresql = "t.pro_code = '"+pro_code+"' and t.yearflag = '0' ";
                    Map<String, Object> goalMap =  aISupportAuditDAO.getDataMap("V_PM_PERF_GOAL_INFO",wheresql);
                    List<Map<String, Object>> indexList = aISupportAuditDAO.getDatas("V_PM_PERF_INDICATOR",wheresql," order by t.findex,t.sindex,t.ordernum");// 本年度绩效指标
                    // 上年度绩效目标指标
                    String lastyearwheresql = "t.province = '"+SecureUtil.getUserSelectProvince()+"' and t.year='" +(SecureUtil.getUserSelectYear()-1)+ "' and t.pro_code = '"+pro_code+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ";
                    Map<String, Object> lastyeargoalMap =  aISupportAuditDAO.getDataMap("PM_PERF_GOAL_INFO",lastyearwheresql);
                    List<Map<String, Object>> lastyearindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",lastyearwheresql," order by t.findex,t.sindex,t.ordernum");// 上年度绩效指标
                    // 总体绩效目标指标
                    String pro_id = (String) proMap.get("pro_id");
                    String totalwheresql = "t.province = '"+SecureUtil.getUserSelectProvince()+"' and t.mainguid = '"+pro_id+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '1' and sub_mof_div_code is null ";
                    Map<String, Object> totalgoalMap =  aISupportAuditDAO.getDataMap("PM_PERF_GOAL_INFO",totalwheresql);
                    List<Map<String, Object>> totalindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",totalwheresql," order by t.findex,t.sindex,t.ordernum");// 上年度绩效指标

                    proinfo.put("indi_count",indexList.size());// 本年度绩效指标总数
                    aipromptmap.put("本年度绩效目标",goalMap.get("kpi_target"));
                    aipromptmap.put("上年度绩效目标",lastyeargoalMap.get("kpi_target"));
                    aipromptmap.put("总体绩效目标",totalgoalMap.get("kpi_target"));
                    aipromptmap.put("本年度绩效指标",packageIndexList(indexList,signsMap));
                    aipromptmap.put("上年度绩效指标",packageIndexList(lastyearindexList,signsMap));
                    aipromptmap.put("总体绩效指标",packageIndexList(totalindexList,signsMap));
                }else{
                    // 湖北目标指标
                    Map<String, Object> hubeiprompt = getProPromptHubei(params,proinfo,signsMap);
                    aipromptmap.putAll(hubeiprompt);
                }
            }
        }
        backmap.put("aiprompt", JSON.toJSONString(aipromptmap));// 提示词信息 给智能体
        backmap.put("proinfo",proinfo);// 项目信息 页面展示
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 获取项目提示词-批量
     * @param params
     * @return --
     */
    public Map<String, Object> getProPromptBatch(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        boolean ishubei = PerfUtil.getIS_HUBEI();
        boolean isanhui = PerfUtil.get_ISANHUI();
        String province = (String) params.get("province");
        int year = (int) params.get("year");
        // 设置年度区划
        aISupportAuditDAO.setYearAndProvince(Integer.toString(year),province);
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        datas.forEach(m -> m.put("guid",m.get("pro_code")));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        // AI组装提示词
        String aiprompt = "";
        List<Map<String, Object>> aipromptList = new ArrayList<>();
        if(datas.size()>0){// 查询项目信息并组装提示词
            String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
            List<Map<String, Object>> proList = aISupportAuditDAO.getDatas(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO,wheresql,"order by pro_code");
            // 本年度绩效目标指标
            String yearwheresql =  wheresql +" and t.yearflag = '0' ";
            List<Map<String, Object>> goalList =  aISupportAuditDAO.getDatas("V_PM_PERF_GOAL_INFO",yearwheresql," order by t.pro_code");
            List<Map<String, Object>> indexList = aISupportAuditDAO.getDatas("V_PM_PERF_INDICATOR",yearwheresql," order by t.pro_code,t.findex,t.sindex,t.ordernum");// 本年度绩效指标
            Map<String, List<Map<String, Object>>> goalGroupMap = goalList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            Map<String, List<Map<String, Object>>> indexGroupMap = indexList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            // 上年度绩效目标指标
            String lastyearwheresql =  wheresql +" and t.province = '"+province+"' and t.year='" +(year-1)+ "' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ";
            List<Map<String, Object>> lastyeargoalList =  aISupportAuditDAO.getDatas("PM_PERF_GOAL_INFO",lastyearwheresql," order by t.pro_code");
            List<Map<String, Object>> lastyearindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",lastyearwheresql," order by t.pro_code,t.findex,t.sindex,t.ordernum");// 上年度绩效指标
            Map<String, List<Map<String, Object>>> lastyearGoalGroupMap = lastyeargoalList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            Map<String, List<Map<String, Object>>> lastyearIndexGroupMap = lastyearindexList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            // 总体绩效目标指标
            String totalwheresql = wheresql +" and t.province = '"+province+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '1' and sub_mof_div_code is null ";
            List<Map<String, Object>> totalgoalList =  aISupportAuditDAO.getDatas("PM_PERF_GOAL_INFO",totalwheresql," order by t.pro_code");
            List<Map<String, Object>> totalindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",totalwheresql," order by t.pro_code,t.findex,t.sindex,t.ordernum");// 上年度绩效指标
            Map<String, List<Map<String, Object>>> totalGoalGroupMap = totalgoalList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            Map<String, List<Map<String, Object>>> totalIndexGroupMap = totalindexList.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));
            // 预算资金情况
            List<Map<String, Object>>  yearbgtmatlist = aISupportAuditDAO.queryForList("select pro_code, sum(t.FIN_AUDIT_MONEY) as yearbgtamt from v_bgt_pm_annual t" +
                    " where "+ wheresql +" and t.is_deleted = 2 group by mof_div_code, fiscal_year, pro_code");
            Map<String, List<Map<String, Object>>> yearBgtGroupMap = yearbgtmatlist.stream().collect(Collectors.groupingBy(item -> (String) item.get("pro_code")));

            if(proList.size()<1){
                backmap.put("success",false);
                backmap.put("error","所选项目未查询到项目信息!");
                return backmap;
            }
            for (Map<String, Object> proMap : proList) {
                String pro_code = (String)proMap.get("pro_code");
                // 项目信息
                Map<String, Object> aipromptmap = new HashMap<>();
                aipromptmap.put("项目代码",proMap.get("pro_code"));
                aipromptmap.put("项目名称",proMap.get("pro_name"));
                aipromptmap.put("单位代码",proMap.get("agency_code"));
                aipromptmap.put("单位名称",proMap.get("agency_name"));
                aipromptmap.put("项目内容",proMap.get("pro_desc"));
                aipromptmap.put("预算年度",SecureUtil.getUserSelectYear());
                if(isanhui){// 安徽 是否科研、是否基建
                    aipromptmap.put("是否科研","1".equals(proMap.get("is_scientific")) ? "是" : "否");
                    aipromptmap.put("是否基建","0".equals(proMap.get("captial_cons_pro_type_code")) ? "否" : "是");
                }
                // 指标计算符号翻译信息
                Map<Object, Object> signsMap = (Map<Object, Object>) params.get("signsMap");
                // 绩效目标和指标
                if(!ishubei){ // 非湖北时 默认查询本年和上年的PM表申报目标指标
                    safeGetFirstGroupValue(goalGroupMap, pro_code, "kpi_target")
                            .ifPresent(val -> aipromptmap.put("本年度绩效目标", val));
                    safeGetFirstGroupValue(lastyearGoalGroupMap, pro_code, "kpi_target")
                            .ifPresent(val -> aipromptmap.put("上年度绩效目标", val));
                    safeGetFirstGroupValue(totalGoalGroupMap, pro_code, "kpi_target")
                            .ifPresent(val -> aipromptmap.put("总体绩效目标", val));
                    safeGetFirstGroupValue(yearBgtGroupMap, pro_code, "yearbgtamt", amt -> amt + "元")
                            .ifPresent(val -> aipromptmap.put("本年度预算资金总额", val));
                    safeProcessGroupList(indexGroupMap, pro_code, list -> packageIndexList(list, signsMap))
                            .ifPresent(val -> aipromptmap.put("本年度绩效指标", val));
                    safeProcessGroupList(lastyearIndexGroupMap, pro_code, list -> packageIndexList(list, signsMap))
                            .ifPresent(val -> aipromptmap.put("上年度绩效指标", val));
                    safeProcessGroupList(totalIndexGroupMap, pro_code, list -> packageIndexList(list, signsMap))
                            .ifPresent(val -> aipromptmap.put("总体绩效指标", val));
                }else{
                    // 湖北目标指标
                }
                Map<String, Object> tmap = new HashMap<>();
                tmap.put("pro_code",pro_code);
                tmap.put("aiprompt", JSON.toJSONString(aipromptmap));
                aipromptList.add(tmap);
            }
            aiprompt = aipromptList.stream()
                    .map(map -> (String) map.get("aiprompt"))
                    .collect(Collectors.joining(","));
        }
        backmap.put("aiprompt", aiprompt);// 提示词信息 给智能体
        backmap.put("aipromptList", aipromptList);
        backmap.put("success",true);
        return backmap;
    }


    /**
     * 翻译处理指标字段提示词
     * @param targetIndexList
     * @param signsMap
     * @return
     */
    public List<Map<String, Object>> packageIndexList(List<Map<String, Object>> targetIndexList, Map<Object, Object> signsMap){
        List<Map<String, Object>> resultList = new ArrayList<>();
        for (int j = 0; j < targetIndexList.size(); j++) {
            Map<String, Object> indexMap = targetIndexList.get(j);
            Map<String, Object> aipromptmapindex = new HashMap<>();
            aipromptmapindex.put("一级绩效指标",indexMap.get("lv1_perf_ind_name"));
            aipromptmapindex.put("二级绩效指标",indexMap.get("lv2_perf_ind_name"));
            aipromptmapindex.put("三级绩效指标",indexMap.get("lv3_perf_ind_name"));
            aipromptmapindex.put("计算符号",signsMap.get(indexMap.get("computesign")));
            aipromptmapindex.put("指标值",indexMap.get("indexval"));
            aipromptmapindex.put("计量单位",indexMap.get("meterunit"));
            resultList.add(aipromptmapindex);
        }
        return resultList;
    }

    /**
     * 湖北提示词
     * @param params
     * @param proinfo 项目信息
     * @param signsMap 计算符号翻译
     * @return
     */
    public Map<String, Object> getProPromptHubei(HashMap<String, Object> params, Map<String, Object> proinfo, Map<Object, Object> signsMap) {
        Map<String, Object> aipromptmap = new HashMap<>();
        List<Map<String, Object>> tempdatas = aISupportAuditDAO.getFrameDatas("PM001");
        Map<Object, Object> frameMap = tempdatas.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        String pro_code = (String) params.get("pro_code");
        // 本年度绩效目标
        String wheresql = "t.pro_code = '"+pro_code+"' and t.yearflag = '0' ";
        List<Map<String, Object>> hbgoalList = aISupportAuditDAO.getDatas("V_PM_PERF_GOAL_INFO",wheresql,"order by goalname");
        wheresql += " and t.goalguid is not null";
        List<Map<String, Object>> indexList = aISupportAuditDAO.getDatas("V_PM_PERF_INDICATOR",wheresql," order by t.findex,t.sindex,t.ordernum");// 本年度绩效指标
        // 上年度绩效目标自评
        String lastyearwheresql = "t.province = '"+SecureUtil.getUserSelectProvince()+"' and t.year='" +(SecureUtil.getUserSelectYear()-1)+ "' and t.pro_code = '"+pro_code+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ";
        List<Map<String, Object>> hblastyeargoalList = aISupportAuditDAO.getDatas("PM_PERF_GOAL_INFO",lastyearwheresql,"order by goalname");// 上年度绩效目标
        lastyearwheresql += " and t.goalguid is not null";
        List<Map<String, Object>> lastyearindexList = aISupportAuditDAO.getDatas("PERF_T_SELFPERFINDEX",lastyearwheresql," order by t.findex,t.sindex,t.ordernum");// 上年度绩效指标
        // 本年度指标总数
        proinfo.put("indi_count",indexList.size());
        // 本年度绩效目标
        List<Map<String, Object>> aipromptmapgoallist = new ArrayList<>();
        for (int i = 0; i < hbgoalList.size(); i++) {
            Map<String, Object> hbgoalMap = hbgoalList.get(i);
            Map<String, Object> aipromptmapgoalmap = new HashMap<>();
            aipromptmapgoalmap.put("目标名称",hbgoalMap.get("kpi_target"));
            String goalguid = (String) hbgoalMap.get("guid");
            List<Map<String, Object>> aipromptindex = new ArrayList<>();
            for (int j = 0; j < indexList.size(); j++) {
                Map<String, Object> indexMap = indexList.get(j);
                String indexgoalguid = (String) indexMap.get("goalguid");
                if(goalguid.equals(indexgoalguid)){
                    Map<String, Object> aipromptmapindex = new HashMap<>();
                    aipromptmapindex.put("一级绩效指标",indexMap.get("lv1_perf_ind_name"));
                    aipromptmapindex.put("二级绩效指标",indexMap.get("lv2_perf_ind_name"));
                    aipromptmapindex.put("三级绩效指标",indexMap.get("lv3_perf_ind_name"));
                    aipromptmapindex.put("计算符号",signsMap.get(indexMap.get("computesign")));
                    aipromptmapindex.put("指标值",indexMap.get("indexval"));
                    aipromptmapindex.put("计量单位",indexMap.get("meterunit"));
                    aipromptindex.add(aipromptmapindex);
                }
            }
            aipromptmapgoalmap.put("绩效指标",aipromptindex);
            aipromptmapgoallist.add(aipromptmapgoalmap);
        }
        aipromptmap.put("本年度绩效目标",aipromptmapgoallist);
        // 上年度绩效目标自评
        List<Map<String, Object>> lastyearaipromptmapgoallist = new ArrayList<>();
        for (int i = 0; i < hblastyeargoalList.size(); i++) {
            Map<String, Object> hbgoalMap = hblastyeargoalList.get(i);
            Map<String, Object> aipromptmapgoalmap = new HashMap<>();
            aipromptmapgoalmap.put("目标名称",hbgoalMap.get("kpi_target"));
            String goalguid = (String) hbgoalMap.get("goalguid");
            List<Map<String, Object>> aipromptindex = new ArrayList<>();
            for (int j = 0; j < lastyearindexList.size(); j++) {
                Map<String, Object> indexMap = lastyearindexList.get(j);
                String indexgoalguid = (String) indexMap.get("goalguid");
                if(goalguid.equals(indexgoalguid)){
                    Map<String, Object> aipromptmapindex = new HashMap<>();
                    aipromptmapindex.put("一级绩效指标",frameMap.get(indexMap.get("findex")));
                    aipromptmapindex.put("二级绩效指标",frameMap.get(indexMap.get("sindex")));
                    aipromptmapindex.put("三级绩效指标",indexMap.get("name"));
                    aipromptmapindex.put("计算符号",signsMap.get(indexMap.get("computesign")));
                    aipromptmapindex.put("指标值",indexMap.get("actualvalue"));
                    aipromptmapindex.put("计量单位",indexMap.get("meterunit"));
                    aipromptindex.add(aipromptmapindex);
                }
            }
            aipromptmapgoalmap.put("绩效指标",aipromptindex);
            lastyearaipromptmapgoallist.add(aipromptmapgoalmap);
        }
        aipromptmap.put("上年度绩效目标",lastyearaipromptmapgoallist);
        return aipromptmap;
    }

    /**
     * 辅助审核结果查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String pro_code = (String) sqlmap.get("pro_code");
        StringBuffer sql = new StringBuffer("select t.* from PERF_V_AISUPPORTAUDIDETAIL t where pro_code ='").append(pro_code).append("'");
        sql.append(" order by ordernum");
        return sql.toString();
    }

    /**
     * 页面审核结束 保存新的实时辅助审核结果
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveNewAISupportAuditDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        Map<String, Object> proinfo = (Map<String, Object>) params.get("proinfo");
        List<Map<String, Object>> aisupportauditresultList = (List<Map<String, Object>>) params.get("datas");
        String timestamps = PerfUtil.getServerTimeStamp();
        String province = SecureUtil.getUserSelectProvince();
        String year = String.valueOf(SecureUtil.getUserSelectYear());
        int i = 1;
        for (Map<String, Object> aisupportauditresultmap : aisupportauditresultList) {
            aisupportauditresultmap.put("guid", this.getCreateguid());
            aisupportauditresultmap.put("province", province);
            aisupportauditresultmap.put("year", year);
            aisupportauditresultmap.put("create_time", timestamps);
            aisupportauditresultmap.put("pro_code",proinfo.get("pro_code"));
            aisupportauditresultmap.put("pro_name",proinfo.get("pro_name"));
            aisupportauditresultmap.put("agency_code",proinfo.get("agency_code"));
            aisupportauditresultmap.put("agency_name",proinfo.get("agency_name"));
            aisupportauditresultmap.put("ordernum",i++);
        }
        if (aisupportauditresultList != null && !aisupportauditresultList.isEmpty()) {
            aISupportAuditDAO.saveAll(aisupportauditresultList, "PERF_T_AISUPPORTAUDIDETAIL");
            // 审核成功后插入更新执行数据
            this.intoAiSupportAuditTask(params);
        }
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 单个项目更新执行任务数据为 已审核
     * @param params
     * @throws AppException
     */
    public void intoAiSupportAuditTask(HashMap<String,Object> params) throws AppException {
        Map<String, Object> proinfo = (Map<String, Object>) params.get("proinfo");
        String pro_code = (String) proinfo.get("pro_code");
        String timestamp = PerfUtil.getServerTimeStamp();
        List<Map<String, Object>> exeList = aISupportAuditDAO.getDatas("V_PERF_T_AISUPPORTAUDITEXE","t.pro_code = ?","order by pro_code",new String[]{pro_code});
        if(exeList.size()>0){
            String updatasql = "update V_PERF_T_AISUPPORTAUDITEXE t set status = '已审核',update_time = '"+timestamp+"' where t.pro_code =" + pro_code;
            aISupportAuditDAO.update(updatasql);
        }else{
            Map waitdatamap = new HashMap();
            waitdatamap.putAll(proinfo);
            waitdatamap.put("guid",StringUtil.createUUID());
            waitdatamap.put("province", CommonUtil.getProvince());
            waitdatamap.put("year", CommonUtil.getYear());
            waitdatamap.put("status", "已审核");
            waitdatamap.put("api_code","PMKPI_AISUPPORTAUDITDETAIL");
            waitdatamap.put("create_time", timestamp);
            waitdatamap.put("update_time", timestamp);
            waitdatamap.put("agencyguid", proinfo.get("agency_code"));
            waitdatamap.put("finintorgguid", proinfo.get("mof_dep_code"));
            aISupportAuditDAO.save(waitdatamap, "PERF_T_AISUPPORTAUDITEXE");
        }
    }

    /**
     * ---------------------------------后台智能辅助审核任务执行start-----------------------------------------
     */

    /**
     * 保存结果到数据库
     * @param aisupportauditresultList
     * @throws AppException
     */
    public void saveResultsToDatabase(List<Map<String, Object>> aisupportauditresultList) throws AppException {
        if (aisupportauditresultList != null && !aisupportauditresultList.isEmpty()) {
            int i = 1;
            for (Map<String, Object> aisupportauditresultmap : aisupportauditresultList) {
                aisupportauditresultmap.put("ordernum",i++);
            }
            aISupportAuditDAO.saveAll(aisupportauditresultList, "PERF_T_AISUPPORTAUDIDETAIL");
        }
    }
    /**
     *
     * @param batchList detail 时，size=1
     * @param url
     * @param apiKey
     * @param timestamps
     * @param resultList
     * @param province
     * @param year
     * @param timeout_ms
     * @param api_code
     * @param proInfoMap
     * @return
     */
    public List<Map<String, Object>> processBatch(List<Map<String, Object>> batchList, String url, String apiKey, String timestamps,
                                                  List<Map<String, Object>> resultList, String province, String year, int timeout_ms, String api_code, Map<String, Object> auditPointMap, Map<String, Object> proInfoMap) {
        List<Map<String, Object>> returnList = new ArrayList<>();
        String pro_code = (String) batchList.get(0).get("pro_code");
        try {
            // 1. 拼接批量的提示词
            StringBuilder batchPrompt = new StringBuilder("请处理以下项目：\n").append(batchList.get(0).get("aiprompt"));
            // 2. 执行流式请求
            logger.info("++++++++++++AI辅助审核开始，项目编码："+ pro_code);
            logger.info("++++++++++++AI辅助审核开始，提示词："+ batchPrompt);
            long start = System.currentTimeMillis();
            AISupportAuditBO.StreamResult sresult = this.executeStreamRequest(url, apiKey, batchPrompt.toString(), "", timeout_ms, api_code);
            // 3. 处理批量结果
            Map<String, Object> batchResult = this.processFinalResult(sresult,auditPointMap);
            List<Map<String, Object>> batchResponseList = (List<Map<String, Object>>) batchResult.get("resultdataslist");
            // 4. 为项目创建结果记录
            for (Map<String, Object> resultmap : batchResponseList) {
                Map<String, Object> aisupportauditresultmap = new HashMap<>();
                // 设置项目结果
                aisupportauditresultmap.putAll(resultmap);
                // 设置默认值
                aisupportauditresultmap.put("guid", this.getCreateguid());
                aisupportauditresultmap.put("province", province);
                aisupportauditresultmap.put("year", year);
                aisupportauditresultmap.put("pro_code", pro_code);
                aisupportauditresultmap.put("create_time", timestamps);
                // 设置项目信息
                Map proinfo = (Map) proInfoMap.get(pro_code);
                aisupportauditresultmap.put("agency_code", proinfo.get("agency_code"));
                aisupportauditresultmap.put("agency_name", proinfo.get("agency_name"));
                aisupportauditresultmap.put("pro_name", proinfo.get("pro_name"));
                // 添加到结果列表（需要同步）
                synchronized (resultList) {
                    resultList.add(aisupportauditresultmap);
                }
                synchronized (returnList) {
                    returnList.add(aisupportauditresultmap);
                }
            }
            logger.info("++++++++++++AI辅助审核：批量处理{}个项目耗时：{}ms", batchList.size(), (System.currentTimeMillis() - start));
        } catch (Exception e) {
            logger.error("++++++++++++AI辅助审核：["+pro_code+"]项目处理失败", e);
        }
        return returnList;
    }

    /**
     * 执行流式ai请求
     * @param url
     * @param apiKey
     * @param prompt
     * @param dialogId
     * @param api_code
     * @return
     * @throws Exception
     */
    public AISupportAuditBO.StreamResult executeStreamRequest(String url, String apiKey, String prompt, String dialogId, int timeout_ms, String api_code) throws Exception {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        Future<AISupportAuditBO.StreamResult> future = executor.submit(() -> {
            HttpURLConnection conn = null;
            AISupportAuditBO.StreamResult result = new AISupportAuditBO.StreamResult();
            StringBuilder buffer = new StringBuilder();
            try {
                // 创建连接
                conn = (HttpURLConnection) new URL(url).openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setRequestProperty("accept", "application/json, text/plain, */*");
                conn.setDoOutput(true);
                conn.setConnectTimeout(5000);
                conn.setReadTimeout(timeout_ms);
                // 发送请求体
                JSONObject requestBody = new JSONObject();
                requestBody.put("api_code", api_code);
                requestBody.put("api_key", apiKey);
                requestBody.put("message", prompt);
                requestBody.put("dialogID", dialogId);
                try (OutputStream os = conn.getOutputStream()) {
                    os.write(requestBody.toString().getBytes(StandardCharsets.UTF_8));
                }
                // 流式读取响应
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(conn.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        buffer.append(line).append("\n");
                        processBuffer(buffer, result);
                    }
                }
            } finally {
                if (conn != null) conn.disconnect();
            }
            return result;
        });
        try {
            return future.get(timeout_ms, TimeUnit.MILLISECONDS);
        } catch (TimeoutException e) {
            future.cancel(true);
            throw new RuntimeException("资源不足，请稍后重试！", e);
        } finally {
            executor.shutdown();
        }
    }

    /**
     * 解析流结果
     * @param buffer
     * @param result
     */
    private static void processBuffer(StringBuilder buffer, AISupportAuditBO.StreamResult result) {
        int position = result.lastPosition;
        String newData = buffer.substring(position);
        result.lastPosition = buffer.length(); // 更新最后读取位置
        String[] lines = newData.split("\n");
        for (String line : lines) {
            if (!line.startsWith("data:")) continue;
            try {
                String jsonStr = line.substring(5)
                        .replace("<think>", "")
                        .trim();
                // 解析JSON
                Map<String, Object> data = JSON.parseObject(jsonStr);
                if (data.get("dialogID") != null) {
                    result.dialogID = (String) data.get("dialogID");
                }
                if (data.get("answer") != null) {
                    String answer = (String)data.get("answer");
                    result.afterThink.append(answer);
                }
            } catch (Exception e) {
                System.err.println("解析失败: " + e.getMessage());
            }
        }
    }

    public static Map<String, Object> processFinalResult(AISupportAuditBO.StreamResult result, Map<String, Object> auditPointMap) {
        Map<String, Object> resultmap =  new HashMap<>();
        // onloadend处理
        String afterThink = result.afterThink.toString();
        // 解析数据
        List<Map<String, Object>> indexData;
        try {
            indexData = extractAndParseJSON(afterThink, auditPointMap);
            System.out.println("解析的返回数据: " + indexData);
            resultmap.put("resultdatas",JSON.toJSONString(indexData));
            resultmap.put("resultdataslist",indexData);
        } catch (Exception e) {
            resultmap.put("resultdatas",null);
            resultmap.put("resultdataslist",null);
        }
        return resultmap;
    }

    /**
     * 解析JSON
     * @param content
     * @return
     * @throws Exception
     */
    private static List<Map<String, Object>> extractAndParseJSON(String content, Map<String, Object> auditPointMap) throws Exception {
        List<Map<String, Object>> parsedIndexArray = new ArrayList<>();
        if (content == null || content.trim().isEmpty()) {
            return parsedIndexArray;
        }
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(content);
        if (rootNode.isArray()) {
            // 如果是数组直接赋值
            parsedIndexArray = objectMapper.convertValue(rootNode, new TypeReference<List<Map<String, Object>>>() {});
        } else if (rootNode.isObject() && !rootNode.isNull()) {
            // 如果是对象取"审核结果"字段
            JsonNode auditResultNode = rootNode.get("审核结果");
            if (auditResultNode != null && auditResultNode.isArray()) {
                parsedIndexArray = objectMapper.convertValue(auditResultNode, new TypeReference<List<Map<String, Object>>>() {});
            }
        }
        List<Map<String, Object>> resultList = new ArrayList<>();
        for (Map<String, Object> item : parsedIndexArray) {
            Map<String, Object> newItem = new HashMap<>();
            for (Map.Entry<String, Object> entry : auditPointMap.entrySet()) {
                newItem.put(entry.getKey(), item.get(entry.getValue()));
            }
            boolean flag = (boolean) auditPointMap.get("nopass_indiArray");
            if(flag){
                Object rawValue = item.get("不通过指标清单");
                if (rawValue instanceof List) {
                    List<?> list = (List<?>) rawValue;
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < list.size(); i++) {
                        if (i > 0) {
                            sb.append(",");
                        }
                        sb.append(list.get(i));
                    }
                    newItem.put("nopass_indi", sb.toString());
                } else {
                    newItem.put("nopass_indi", rawValue);
                }
            }
            for (Map.Entry<String, Object> entry : newItem.entrySet()) {
                Object val = entry.getValue();
                boolean isEmpty =
                        val == null ||
                        (val instanceof String && ((String) val).trim().isEmpty());
                if (isEmpty) {
                    newItem.put(entry.getKey(), "-");
                }
            }
            resultList.add(newItem);
        }
        return resultList;
    }

    /**
     * ---------------------------------后台智能辅助审核任务执行end-----------------------------------------
     */

    /**
     * 通用方法1：取多层Map（Map<String, List<Map<String, Object>>>）中第一个元素的指定Key值
     * @param sourceMap 源Map（比如goalGroupMap、yearBgtGroupMap）
     * @param proCode 项目编码
     * @param key 要取的Key（比如"kpi_target"、"yearbgtamt"）
     * @param converter 可选的值转换器（比如拼接"元"），不需要传null
     * @return 取值成功返回Optional包装的值，失败返回空
     */
    public static Optional<String> safeGetFirstGroupValue(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            String key,
            Function<Object, String> converter) {
        // 全链路前置判空，任何一层为空直接返回空
        if (sourceMap == null || StringUtils.isEmpty(proCode) || StringUtils.isEmpty(key)) {
            return Optional.empty();
        }
        // 取proCode对应的List
        List<Map<String, Object>> groupList = sourceMap.get(proCode);
        if (CollectionUtils.isEmpty(groupList)) {
            return Optional.empty();
        }
        // 取第0个元素
        Map<String, Object> firstGroup = groupList.get(0);
        if (firstGroup == null || !firstGroup.containsKey(key)) {
            return Optional.empty();
        }
        Object value = firstGroup.get(key);
        if (value == null) {
            return Optional.empty();
        }
        // 有转换器就做转换，没有直接返回toString
        String strValue = value.toString();
        return converter == null ? Optional.of(strValue) : Optional.of(converter.apply(value));
    }

    // 重载方法：不需要转换器的时候不用传第四个参数，调用更简洁
    public static Optional<String> safeGetFirstGroupValue(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            String key) {
        return safeGetFirstGroupValue(sourceMap, proCode, key, null);
    }

    /**
     * 通用方法2：取多层Map的整个List，做二次加工（比如调用packageIndexList）
     * @param sourceMap 源Map（比如indexGroupMap、totalIndexGroupMap）
     * @param proCode 项目编码
     * @param processor 二次处理函数，接收List返回处理后的结果
     * @return 处理成功返回Optional包装的结果，失败返回空
     */
    public static <T> Optional<T> safeProcessGroupList(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            Function<List<Map<String, Object>>, T> processor) {
        // 前置判空
        if (sourceMap == null || StringUtils.isEmpty(proCode) || processor == null) {
            return Optional.empty();
        }
        // 取proCode对应的List
        List<Map<String, Object>> groupList = sourceMap.get(proCode);
        if (CollectionUtils.isEmpty(groupList)) {
            return Optional.empty();
        }
        try {
            T result = processor.apply(groupList);
            // 如果二次处理结果是null也返回空，避免put空值
            return Optional.ofNullable(result);
        } catch (Exception e) {
            return Optional.empty();
        }
    }
}
