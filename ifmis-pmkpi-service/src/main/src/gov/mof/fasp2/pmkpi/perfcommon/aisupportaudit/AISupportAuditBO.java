package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfcommon.smssend.SmsService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class AISupportAuditBO extends PmkpiBO {

    private AISupportAuditDAO aISupportAuditDAO;

    public void setAISupportAuditDAO(AISupportAuditDAO aISupportAuditDAO) {
        this.aISupportAuditDAO = aISupportAuditDAO;
    }

    @Value("${ifmis.fasp2.gateway.address:127.0.0.1}")
    private String pathurl;

    /**
     * 获取项目提示词
     * @param params
     * @return --
     */
    public Map<String, Object> getProPrompt(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        boolean ishubei = PerfUtil.getIS_HUBEI();
        boolean iszhejiang = PerfUtil.getIsZJ();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        datas.forEach(m -> {
            String pro_code = (String) m.get("pro_code");
            if(StringUtil.isNullOrEmpty(pro_code)){
                pro_code = (String) m.get("code");
            }
            m.put("guid",pro_code);
        });
        // 去重，监审一个项目会有多条
        datas = datas.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                Comparator.comparing(x -> (String)x.get("guid")))), ArrayList::new));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        // AI组装提示词
        String aiprompt = "";
        List<Map<String, Object>> aipromptList = new ArrayList<>();
        if(datas.size()>0){// 查询项目信息并组装提示词
            String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
            List<Map<String, Object>> proList = aISupportAuditDAO.getDatas(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO,wheresql,"order by pro_code");
            if(proList.size()<1){
                backmap.put("success",false);
                backmap.put("error","所选项目未查询到项目信息!");
                return backmap;
            }
            List<Map<String, Object>> goalList = new ArrayList<>();
            if(!ishubei){// 非湖北，目标单独查询获取
                goalList = aISupportAuditDAO.getDatas("V_PM_PERF_GOAL_INFO",wheresql,null);
            }
            List<Map<String, Object>> last2yearevalindexList = new ArrayList<>();
            if(iszhejiang){// 浙江，需要多传输前年自评指标
                last2yearevalindexList = aISupportAuditDAO.getDatas("V_PM_PERF_EVALINDEXAGGLAST",wheresql,null);
            }
            String indiaggview = ishubei ? "V_PM_PERF_INDICATORAGGHB" : "V_PM_PERF_INDICATORAGG";
            String indiaggviewlast = ishubei ? "V_PM_PERF_INDICATORAGGLASTHB" : "V_PM_PERF_INDICATORAGGLAST";
            List<Map<String, Object>> indexList = aISupportAuditDAO.getDatas(indiaggview,wheresql,null);// 本年度绩效指标
            List<Map<String, Object>> lastyearindexList = aISupportAuditDAO.getDatas(indiaggviewlast,wheresql,null);// 上年度绩效指标
            List<Map<String, Object>> bgtamtList = aISupportAuditDAO.getDatas("V_PM_PERF_BGTAMTNOWANDLAST",wheresql,null);// 前年上年和本年度资金
            for (Map<String, Object> proMap : proList) {
                String proaiprompt = "{";
                proaiprompt += "项目编码："+proMap.get("pro_code")+"，";
                proaiprompt += "项目名称："+proMap.get("pro_name")+"，";
                proaiprompt += "单位编码："+proMap.get("agency_code")+"，";
                if(!StringUtil.isNullOrEmpty(proMap.get("agency_name"))){
                    proaiprompt += "单位名称："+proMap.get("agency_name")+"，";
                }
                if(!StringUtil.isNullOrEmpty(proMap.get("pro_bases"))){
                    proaiprompt += "立项依据："+proMap.get("pro_bases")+"，";
                }
                if(!StringUtil.isNullOrEmpty(proMap.get("pro_desc"))){
                    proaiprompt += "项目内容："+proMap.get("pro_desc")+"，";
                }
                if(!StringUtil.isNullOrEmpty(proMap.get("pro_term"))){
                    proaiprompt += "项目期限："+proMap.get("pro_term")+"年，";
                }
                if(!StringUtil.isNullOrEmpty(proMap.get("v_col7"))){
                    proaiprompt += "测算依据及说明："+proMap.get("v_col7")+"，";
                }
                proaiprompt += "预算年度："+SecureUtil.getUserSelectYear()+"，";
                String pro_code = (String) proMap.get("pro_code");
                if(!ishubei){
                    for (int i = 0; i < goalList.size(); i++) {
                        Map<String, Object> goal = goalList.get(i);
                        String procode = (String) goal.get("pro_code");
                        if(pro_code.equals(procode)){
                            proaiprompt += "年度绩效目标："+goal.get("kpi_target")+"，";
                        }
                    }
                }
                for (int i = 0; i < indexList.size(); i++) {
                    Map<String, Object> index = indexList.get(i);
                    String procode = (String) index.get("pro_code");
                    if(pro_code.equals(procode)){
                        proaiprompt += "本年度绩效指标："+index.get("perfindex")+"，";
                    }
                }
                for (int i = 0; i < lastyearindexList.size(); i++) {
                    Map<String, Object> index = lastyearindexList.get(i);
                    String procode = (String) index.get("pro_code");
                    if(pro_code.equals(procode)){
                        if(ishubei){
                            proaiprompt += "上年绩效自评指标："+index.get("perfindex")+"，";
                        }else{
                            proaiprompt += "上年度绩效指标："+index.get("perfindex")+"，";
                        }
                    }
                }
                if(iszhejiang){
                    for (int i = 0; i < last2yearevalindexList.size(); i++) {
                        Map<String, Object> index = last2yearevalindexList.get(i);
                        String procode = (String) index.get("pro_code");
                        if(pro_code.equals(procode)){
                            proaiprompt += "前年绩效自评指标："+index.get("perfindex")+"，";
                        }
                    }
                }
                for (int i = 0; i < bgtamtList.size(); i++) {
                    Map<String, Object> bgtamt = bgtamtList.get(i);
                    String procode = (String) bgtamt.get("pro_code");
                    if(pro_code.equals(procode)){
                        proaiprompt += "预算资金情况："+bgtamt.get("perfbgtamt")+"，";
                    }
                }
                proaiprompt += "}";
                proaiprompt = proaiprompt.replaceAll("\\n", "").replaceAll("\\s*", "");
                Map<String, Object> aipromptmap = new HashMap<>();
                aipromptmap.put("pro_code",proMap.get("pro_code"));
                aipromptmap.put("aiprompt",proaiprompt);
                aipromptList.add(aipromptmap);
            }
            aiprompt = aipromptList.stream()
                    .map(map -> (String) map.get("aiprompt"))
                    .collect(Collectors.joining(","));
        }
        backmap.put("aiprompt", aiprompt);
        backmap.put("aipromptList", aipromptList);
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 获取任务数据
     * @return --
     */
    public Map<String, Object> getTaskDatas() throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> taskList = aISupportAuditDAO.getDatas("PERF_T_AISUPPORTAUDITTASK"," status is null" + PerfUtil.yearProvinceSql("t"),null);
        if(taskList.size()>0){
            backmap.put("timeout_ms",taskList.get(0).get("singletimeoutms") !=null ? ((BigDecimal) taskList.get(0).get("singletimeoutms")).intValue() : 300000);
        }else{
            backmap.put("timeout_ms",300000);
        }
        return backmap;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String querySql = (String) sqlmap.get("querySql"); //查询区封装的参数
        StringBuffer sql = new StringBuffer("select t.* from V_PERF_T_AISUPPORTAUDIRESULT t");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) sqlmap.get("datas");
        if(datas.size() > 0){
            datas.forEach(m -> {
                String pro_code = (String) m.get("pro_code");
                if(StringUtil.isNullOrEmpty(pro_code)){
                    pro_code = (String) m.get("code");
                }
                m.put("guid",pro_code);
            });
            // 去重，监审一个项目会有多条
            datas = datas.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                    Comparator.comparing(x -> (String)x.get("guid")))), ArrayList::new));
            aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
            sql.append(" where ").append(wheresql);
            if (!StringUtil.isEmpty(querySql)) {
                sql.append(" and (").append(querySql).append(")");
            }
        }else{
            if (!StringUtil.isEmpty(querySql)) {
                sql.append(" where (").append(querySql).append(")");
            }
        }
        sql.append(" order by pro_code");
        return sql.toString();
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
    public StreamResult executeStreamRequest(String url, String apiKey, String prompt, String dialogId, int timeout_ms, String api_code) throws Exception {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        Future<StreamResult> future = executor.submit(() -> {
            HttpURLConnection conn = null;
            StreamResult result = new StreamResult();
            StringBuilder buffer = new StringBuilder();
            try {
                // 创建连接
                conn = (HttpURLConnection) new URL(url).openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setRequestProperty("accept", "application/json, text/plain, */*");
//                conn.setRequestProperty("tokenid", tokenid);
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
    private static void processBuffer(StringBuilder buffer, StreamResult result) {
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
                    if (answer.contains("nothinkflag")) {
                        result.beforeThink.append("模型无思考过程");
                        result.afterThink.append(answer.replace("nothinkflag", ""));
                    }else {
                        if (answer.contains("</think>")) {
                            result.beforeThink.append(answer);
                            result.isAfterThink = true;
                        } else if (result.isAfterThink) {
                            result.afterThink.append(answer);
                        } else {
                            result.beforeThink.append(answer);
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("解析失败: " + e.getMessage());
            }
        }
    }

    /**
     * 解析完成结果
     * @param result
     * @return
     */
    public static Map<String, Object> processFinalResult(StreamResult result, Map<String, Object> auditPointMap) {
        Map<String, Object> resultmap =  new HashMap<>();
        // onloadend处理
        String beforeThink = result.beforeThink.toString();
        String afterThink = result.afterThink.toString();
        // 解析数据（extractAndParseJSON）
        List<Map<String, Object>> indexData;
        try {
            indexData = extractAndParseJSON(afterThink, auditPointMap);
            System.out.println("解析的返回数据: " + indexData);
            resultmap.put("thinkingprocess",beforeThink);
            resultmap.put("resultdatas",JSON.toJSONString(indexData));
            resultmap.put("resultdataslist",indexData);
        } catch (Exception e) {
            resultmap.put("thinkingprocess",e.getMessage());
            resultmap.put("resultdatas",null);
            resultmap.put("resultdataslist",null);
        }
        return resultmap;
    }

    // 辅助类和简化方法
    public static class StreamResult {
        StringBuilder beforeThink = new StringBuilder();
        StringBuilder afterThink = new StringBuilder();
        String dialogID;
        boolean isAfterThink;
        int lastPosition;
    }

    /**
     * 解析JSON
     * @param content
     * @return
     * @throws Exception
     */
    private static List<Map<String, Object>> extractAndParseJSON(String content, Map<String, Object> auditPointMap) throws Exception {
        // 实际实现应包含JSON提取和解析逻辑
        Pattern pattern = Pattern.compile("```jsonstart\\s*([\\s\\S]*?)\\s*```jsonend");
        Matcher matcher = pattern.matcher(content);
        if (!matcher.find()) {
            throw new Exception("未找到JSON内容");
        }
        String jsonString = matcher.group(1).trim();
        List<Map<String, Object>> resultList = new ArrayList<>();
        List<Map> parsedList = JSON.parseArray(jsonString, Map.class);
        for (Map<String, Object> item : parsedList) {
            Map<String, Object> newItem = new HashMap<>();
            newItem.put("agency_code", item.get("单位编码"));
            newItem.put("agency_name", item.get("单位名称"));
            newItem.put("pro_code", item.get("项目编码"));
            newItem.put("pro_name", item.get("项目名称"));
            for (Map.Entry<String, Object> entry : auditPointMap.entrySet()) {
                newItem.put(entry.getKey(), item.get(entry.getValue()));
            }
//            newItem.put("auditpoint1", item.get(auditPointMap.get("auditpoint1")));
//            newItem.put("auditpoint2", item.get(auditPointMap.get("auditpoint2")));
//            newItem.put("auditpoint3", item.get(auditPointMap.get("auditpoint3")));
//            newItem.put("auditpoint4", item.get(auditPointMap.get("auditpoint4")));
//            newItem.put("auditpoint5", item.get(auditPointMap.get("auditpoint5")));
            resultList.add(newItem);
        }
        return resultList;
    }

    /**
     * 执行后台AI辅助审核任务
     * AI APT_CODE: PMKPI_AISUPPORTAUDIT
     * @param province     区划
     * @param year         年度
     * @return
     */
    public Map<String, Object> doAISupportAuditTaskBatch(String province,String year,Map<String, Object> waitingTaskparam) throws AppException {
        Map<String, Object> result =  new HashMap<>();
        result.put("success",false);
        int batchSize; // 每批处理的项目数量
        int threadcount; // 并行的线程数量
        int timeoutmis; // 超时等待时间-分钟
        int timeout_ms; // 超时等待时间毫秒单次访问
        String api_code; // AI访问api_code
        String url; // AI访问url
        // 设置年度区划
        aISupportAuditDAO.setYearAndProvince(year,province);
        // 查询待处理任务
        List<Map<String, Object>> taskList;
        if(waitingTaskparam!=null && !waitingTaskparam.isEmpty()){
            taskList = (List<Map<String, Object>>) waitingTaskparam.get("waitingTaskList");
        }else{
            taskList = aISupportAuditDAO.getDatas("PERF_T_AISUPPORTAUDITTASK"," province ='" + province + "' and year ='" + year + "' ",null);
        }
        logger.info("++++++++++++获取AI辅助审核任务待处理数量"+ taskList.size());
        if(taskList != null && !taskList.isEmpty()){
            List<Map<String, Object>> returnList = new ArrayList<>();
            for (Map<String, Object> task: taskList) {
                String tablecode = (String) task.get("tablecode");
                String wheresql = (String) task.get("wheresql");
                List<Map<String, Object>> resultList = aISupportAuditDAO.getDatas(tablecode,wheresql,"order by pro_code");
                returnList.addAll(resultList);
            }
            // 获取登录用户
            String defusercode = SecureUtil.getCurrentUser().getCode();
            String config = taskList.get(0).get("config") !=null ? (String) taskList.get(0).get("config") : "";
            if(!StringUtil.isNullOrEmpty(config)){
                Map<String, Object> configmap = PerfUtil.parseString2Map(config);
                defusercode = (String) configmap.get("defuser");
                if(!StringUtil.isNullOrEmpty(defusercode)){
                    logger.info("++++++++++++AI辅助审核任务配置登录用户:"+ defusercode + ";" );
                }
            }
            String llmurl ="/ifmisLLM/chat/1.0.0.0/rendQStream";
            if(PerfUtil.getIS_HUBEI()){
                defusercode = "admin";
                llmurl ="/hbifmisLLM/chat/1.0.0.0/rendQStream";
            }
            batchSize = taskList.get(0).get("batchSize") !=null ? ((BigDecimal) taskList.get(0).get("batchSize")).intValue() : 5;
            threadcount = taskList.get(0).get("threadcount") !=null ? ((BigDecimal) taskList.get(0).get("threadcount")).intValue() : 2;
            timeoutmis = taskList.get(0).get("timeoutmis") !=null ? ((BigDecimal) taskList.get(0).get("timeoutmis")).intValue() : 60;
            timeout_ms = taskList.get(0).get("singletimeoutms") !=null ? ((BigDecimal) taskList.get(0).get("singletimeoutms")).intValue() : 300000;
            url = (taskList.get(0).get("url") !=null ? (String) taskList.get(0).get("url") : ("http://" + pathurl + llmurl)) + "?user_code="+defusercode+"&province="+province+"&year="+year;
            api_code = taskList.get(0).get("api_code") !=null ? (String) taskList.get(0).get("api_code") : "PMKPI_AISUPPORTAUDIT";
            HashMap<String, Object> params = new HashMap<>();
            params.put("datas",returnList);
            Map<String, Object> backmap;
            // 查询审核列表ui配置获取审核要点翻译名称用于结果解析
            Map<String, Object> auditPointMap = new HashMap<>();
            List<Map<String, Object>> cols = this.getCols("/pmkpi/common/aisupportaudit");
            for (Map<String, Object> col : cols) {
                String colcode = (String) col.get("colcode");
                if(colcode.toUpperCase().startsWith("AUDITPOINT")){
                    auditPointMap.put(colcode.toLowerCase(),col.get("name"));
                }
            }
            // 获取组装提示词
            backmap = this.getProPrompt(params);
            // 提示词信息aipromptList 每个项目一条
            List<Map<String, Object>> aipromptList = (List<Map<String, Object>>) backmap.get("aipromptList");
            if(aipromptList != null && !aipromptList.isEmpty()){
                logger.info("++++++++++++获取AI辅助审核待处理的项目数量"+ aipromptList.size());
                String apiKey = "app-pVrTP59ykjwDpDRYvwq73Ngy";
                String timestamps = PerfUtil.getServerTimeStamp();
                List<Map<String, Object>> aisupportauditresultList = new ArrayList<>();
                // 使用线程池并行处理批次
                ExecutorService executor = Executors.newFixedThreadPool(threadcount);
                List<Future<Boolean>> futures = new ArrayList<>();
                // 分批处理项目
                for (int i = 0; i < aipromptList.size(); i += batchSize) {
                    int end = Math.min(i + batchSize, aipromptList.size());
                    List<Map<String, Object>> batchList = aipromptList.subList(i, end);
                    // 提交批处理任务到线程池
                    String finalUrl = url;
                    int batchIndex = i / batchSize;
                    Future<Boolean> future = executor.submit(() -> {
                        try {
                            List<Map<String, Object>> batchResults = processBatch(batchList, finalUrl, apiKey, timestamps, aisupportauditresultList, province, year, timeout_ms, api_code, auditPointMap);
                            // 批次成功后直接入库
                            if (batchResults != null && !batchResults.isEmpty()) {
                                saveResultsToDatabase(batchResults);
                                logger.info("批次 " + batchIndex + " 处理并入库成功，共 " + batchResults.size() + " 条记录");
                            }
                            return true;
                        } catch (Exception e) {
                            logger.error( "批次 " + batchIndex + " 处理失败", e);
                            return false;
                        }
                    });
                    futures.add(future);
//                    executor.submit(() -> processBatch(batchList, finalUrl, apiKey, timestamps, aisupportauditresultList, province, year, timeout_ms, api_code));
                }
                // 关闭线程池并等待所有任务完成
                executor.shutdown();
                try {
                    if (!executor.awaitTermination(timeoutmis, TimeUnit.MINUTES)) {
                        executor.shutdownNow();
                        logger.error("AI请求处理超时，强制终止");
                    }
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    logger.error("批处理被中断", e);
                }
//                // 保存所有结果到数据库
//                if (!aisupportauditresultList.isEmpty()) {
//                    saveResultsToDatabase(aisupportauditresultList);
//                }
            }
            result.put("success",true);
            if((boolean)result.get("success")){
                // 最后更新任务完成
                taskList.forEach(m -> {m.put("status","success");});
                aISupportAuditDAO.updateAll(taskList,"PERF_T_AISUPPORTAUDITTASK");
            }
        }
        return result;
    }

    public List<Map<String, Object>> processBatch(List<Map<String, Object>> batchList, String url, String apiKey, String timestamps,
                                                   List<Map<String, Object>> resultList, String province, String year, int timeout_ms, String api_code, Map<String, Object> auditPointMap) {
        List<Map<String, Object>> returnList = new ArrayList<>();
        try {
            // 1. 拼接批量的提示词
            StringBuilder batchPrompt = new StringBuilder("请处理以下项目（每个项目用<|project|>分隔）：\n");
            List<String> projectCodes = new ArrayList<>();
            Map<String, Object> aipromptsmap = new HashMap<>();
            for (Map<String, Object> aiprompt : batchList) {
                String pro_code = (String) aiprompt.get("pro_code");
                String prompt = (String) aiprompt.get("aiprompt");
                batchPrompt.append("<|project|>")
                        .append(pro_code)
                        .append("\n")
                        .append(prompt)
                        .append("\n");
                projectCodes.add(pro_code);
                aipromptsmap.put(pro_code,prompt);
            }
            // 2. 执行流式请求
            logger.info("++++++++++++AI辅助审核开始，项目编码："+ projectCodes);
            long start = System.currentTimeMillis();
            StreamResult sresult = this.executeStreamRequest(url, apiKey, batchPrompt.toString(), "", timeout_ms, api_code);
            // 3. 处理批量结果
            Map<String, Object> batchResult = processFinalResult(sresult, auditPointMap);
            String thinkingprocess = (String) batchResult.get("thinkingprocess");
            List<Map<String, Object>> batchResponseList = (List<Map<String, Object>>) batchResult.get("resultdataslist");
            // 4. 分割批量响应为单个项目结果
            Map<String, Map<String, String>> parsedResults = parseBatchResponse(batchResponseList, projectCodes);
            // 5. 为每个项目创建结果记录
            for (Map<String, Object> aiprompt : batchList) {
                String pro_code = (String) aiprompt.get("pro_code");
                Map<String, String> projectResult = parsedResults.getOrDefault(pro_code, new HashMap<>());
                Map<String, Object> aisupportauditresultmap = new HashMap<>();
                aisupportauditresultmap.put("guid", this.getCreateguid());
                aisupportauditresultmap.put("province", province);
                aisupportauditresultmap.put("year", year);
                aisupportauditresultmap.put("pro_code", pro_code);
                aisupportauditresultmap.put("prompt", aipromptsmap.getOrDefault(pro_code, new HashMap<>()));
                aisupportauditresultmap.put("timestamps", timestamps);
                aisupportauditresultmap.put("thinkingprocess", thinkingprocess);//每一批次处理的思考过程是一起的
                // 设置项目结果
                if (projectResult.containsKey("data")) {
                    aisupportauditresultmap.put("resultdatas", projectResult.get("data"));
                    aisupportauditresultmap.put("status", "success");
                } else {
                    aisupportauditresultmap.put("resultdatas", null);
                    aisupportauditresultmap.put("status", "failure");
                }
                // 添加到结果列表（需要同步）
                synchronized (resultList) {
                    resultList.add(aisupportauditresultmap);
                }
                synchronized (returnList) {
                    returnList.add(aisupportauditresultmap);
                }
            }
            logger.info("++++++++++++批量处理{}个项目耗时：{}ms", batchList.size(), (System.currentTimeMillis() - start));
        } catch (Exception e) {
            logger.error("批处理失败", e);
            // 为批次中的所有项目创建错误记录
            for (Map<String, Object> aiprompt : batchList) {
                Map<String, Object> aisupportauditresultmap = new HashMap<>();
                aisupportauditresultmap.put("guid", this.getCreateguid());
                aisupportauditresultmap.put("province", province);
                aisupportauditresultmap.put("year", year);
                aisupportauditresultmap.put("pro_code", aiprompt.get("pro_code"));
                aisupportauditresultmap.put("prompt", aiprompt.get("aiprompt"));
                aisupportauditresultmap.put("timestamps", timestamps);
                aisupportauditresultmap.put("thinkingprocess", "批处理失败: " + e.getMessage());
                aisupportauditresultmap.put("resultdatas", null);
                aisupportauditresultmap.put("status", "failure");
                synchronized (resultList) {
                    resultList.add(aisupportauditresultmap);
                }
                synchronized (returnList) {
                    returnList.add(aisupportauditresultmap);
                }
            }
        }
        return returnList;
    }

    /**
     * 解析批量响应为单个项目结果
     * @param batchResponseList
     * @param projectCodes
     * @return
     */
    public Map<String, Map<String, String>> parseBatchResponse(List<Map<String, Object>> batchResponseList, List<String> projectCodes) {
        Map<String, Map<String, String>> results = new HashMap<>();
        if (batchResponseList == null || batchResponseList.isEmpty()) {
            return results;
        }
        for (int i = 0; i < batchResponseList.size(); i++) {
            for (int j = 0; j < projectCodes.size(); j++) {
                String pro_code = projectCodes.get(j);
                Map<String, Object> batchResponseMap = batchResponseList.get(i);
                String resprocode = (String) batchResponseMap.get("pro_code");
                if(pro_code.equals(resprocode)){
                    Map<String, String> projectResult = new HashMap<>();
                    projectResult.put("data", JSON.toJSONString(batchResponseMap));
                    results.put(pro_code, projectResult);
                }
            }
        }
        return results;
    }

    /**
     * 保存结果到数据库
     * @param aisupportauditresultList
     */
    public void saveResultsToDatabase(List<Map<String, Object>> aisupportauditresultList) {
        String sql = "INSERT INTO PERF_T_AISUPPORTAUDIRESULT " +
                "(GUID, PROVINCE, YEAR, PRO_CODE, TIMESTAMPS, STATUS, PROMPT, THINKINGPROCESS, RESULTDATAS, AGENCY_CODE, AGENCY_NAME, PRO_NAME, AUDITPOINT1, AUDITPOINT2, AUDITPOINT3, AUDITPOINT4, AUDITPOINT5) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        LobHandler lobHandler = new DefaultLobHandler();
        LobCreator lobCreator = lobHandler.getLobCreator();
        aISupportAuditDAO.getJdbcTemplate().batchUpdate(sql, new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                Map<String, Object> item = aisupportauditresultList.get(i);
                ps.setString(1, (String) item.get("guid"));
                ps.setString(2, (String) item.get("province"));
                ps.setString(3, (String) item.get("year"));
                ps.setString(4, (String) item.get("pro_code"));
                ps.setString(5, (String) item.get("timestamps"));
                ps.setString(6, (String) item.get("status"));
                // 使用LobCreator处理大字段
                lobCreator.setClobAsString(ps, 7, (String) item.get("prompt"));
                lobCreator.setClobAsString(ps, 8, (String) item.get("thinkingprocess"));
                String resultdatas = (String) item.get("resultdatas");
                lobCreator.setClobAsString(ps, 9, resultdatas);
                Map<String, Object> resultdatamap = (Map<String, Object>) JSONObject.parse(resultdatas);
                if(resultdatamap == null){
                    ps.setString(10, item.get("agency_code")!=null ? (String) item.get("agency_code") : "");
                    ps.setString(11, item.get("agency_name")!=null ? (String) item.get("agency_name") : "");
                    ps.setString(12, item.get("pro_name")!=null ? (String) item.get("pro_name") : "");
                    ps.setString(13, item.get("auditpoint1")!=null ? (String) item.get("auditpoint1") : "");
                    ps.setString(14, item.get("auditpoint2")!=null ? (String) item.get("auditpoint2") : "");
                    ps.setString(15, item.get("auditpoint3")!=null ? (String) item.get("auditpoint3") : "");
                    ps.setString(16, item.get("auditpoint4")!=null ? (String) item.get("auditpoint4") : "");
                    ps.setString(17, item.get("auditpoint5")!=null ? (String) item.get("auditpoint5") : "");
                }else{
                    ps.setString(10, resultdatamap.get("agency_code")!=null ? (String) resultdatamap.get("agency_code") : "");
                    ps.setString(11, resultdatamap.get("agency_name")!=null ? (String) resultdatamap.get("agency_name") : "");
                    ps.setString(12, resultdatamap.get("pro_name")!=null ? (String) resultdatamap.get("pro_name") : "");
                    ps.setString(13, resultdatamap.get("auditpoint1")!=null ? (String) resultdatamap.get("auditpoint1") : "");
                    ps.setString(14, resultdatamap.get("auditpoint2")!=null ? (String) resultdatamap.get("auditpoint2") : "");
                    ps.setString(15, resultdatamap.get("auditpoint3")!=null ? (String) resultdatamap.get("auditpoint3") : "");
                    ps.setString(16, resultdatamap.get("auditpoint4")!=null ? (String) resultdatamap.get("auditpoint4") : "");
                    ps.setString(17, resultdatamap.get("auditpoint5")!=null ? (String) resultdatamap.get("auditpoint5") : "");
                }
            }
            @Override
            public int getBatchSize() {
                return aisupportauditresultList.size();
            }
        });
    }

    /**
     * 保存新的实时辅助审核结果
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveNewAISupportAuditDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        String thinkingprocess = (String) params.get("thinkingprocess");
        List<Map<String, Object>> aipromptList = (List<Map<String, Object>>) params.get("aipromptList");
        Map<String, Object> aipromptMap = aipromptList.stream().filter(item -> item.get("pro_code") != null)
                .collect(Collectors.toMap(
                        item -> (String) item.get("pro_code"),
                        item -> item.get("aiprompt")
                ));
        List<Map<String, Object>> aisupportauditresultList = (List<Map<String, Object>>) params.get("datas");
        String timestamps = PerfUtil.getServerTimeStamp();
        String province = SecureUtil.getUserSelectProvince();
        String year = String.valueOf(SecureUtil.getUserSelectYear());
        for (Map<String, Object> aisupportauditresultmap : aisupportauditresultList) {
            String pro_code = (String)aisupportauditresultmap.get("pro_code");
            aisupportauditresultmap.put("guid", this.getCreateguid());
            aisupportauditresultmap.put("province", province);
            aisupportauditresultmap.put("year", year);
            aisupportauditresultmap.put("prompt", aipromptMap.get(pro_code));
            aisupportauditresultmap.put("timestamps", timestamps);
            aisupportauditresultmap.put("thinkingprocess", thinkingprocess);
            aisupportauditresultmap.put("resultdatas", null);
            aisupportauditresultmap.put("status", "success");
        }
        if (aisupportauditresultList != null && !aisupportauditresultList.isEmpty()) {
            saveResultsToDatabase(aisupportauditresultList);
        }
        backmap.put("success",true);
        return backmap;
    }


    public List<String> uploadProfiletoAI(HashMap<String, Object> params) throws AppException {
        HtmlFileUploadService htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String filter = (String) params.get("filter");
        String url = (String) params.get("url");
        filter = "'DE9176','DE9177'";// 92smx1
        datas.forEach(m -> {
            String pro_id = (String) m.get("pro_id");
            if(StringUtil.isNullOrEmpty(pro_id)){
                pro_id = (String) m.get("guid");
            }
            m.put("guid","3CFB9E1D6C9E7796206F643E1DD06313");
//            m.put("guid",pro_id);
        });
        // 去重
        datas = datas.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                Comparator.comparing(x -> (String)x.get("guid")))), ArrayList::new));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        StringBuffer sql = new StringBuffer();
        sql.append("select t1.proguid as pro_id,t2.name as name, t.filecontent as fileguid,t.filename from pm_filecontents t ")
                .append("left join v_pm_attachment t1 on t1.guid = t.attachguid ")
                .append("left join v_pm_t_dicattachtype t2 on t2.guid = t1.attachtype ")
                .append("where exists (select 1 from PERF_TMP_GUIDS a where t1.proguid = a.guid) ")
                .append(" and t2.guid in(").append(filter).append(")");
        List<Map<String, Object>> fileInfoList = aISupportAuditDAO.queryForList(sql.toString());
        RestTemplate restTemplate = new RestTemplate();
        if (fileInfoList == null || fileInfoList.isEmpty()) {
            logger.warn("项目事前绩效评估附件为空");
        }
        logger.info("准备上传的项目事前绩效评估附件数量：{}", fileInfoList.size());
        List<String> fileidlist = new ArrayList<>();
        try {
            for (Map map : fileInfoList) {
                String fileguid = "C0E50288D10455195CF4E3D230D0CF44";
//                String fileguid = (String) map.get("fileguid");
                String originalFileName = htmlFileUploadService.getFileinfoByRest(fileguid).get("fileName").toString();
                map.put("filename",originalFileName);
                InputStream inputStream = htmlFileUploadService.downFileByRest(fileguid, null, false);
                byte[] fileBytes = IOUtils.toByteArray(inputStream);
                inputStream.close();
                if (originalFileName == null) {
                    originalFileName = "file_" + fileguid;
                }
                String finalOriginalFileName = originalFileName;
                ByteArrayResource resource = new ByteArrayResource(fileBytes) {
                    @Override
                    public String getFilename() {
                        return finalOriginalFileName;
                    }
                };
                // 构建请求
                MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
                body.add("file", resource);
                body.add("api_key", "app-pVrTP59ykjwDpDRYvwq73Ngy");
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.MULTIPART_FORM_DATA);
                HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
                // 发送请求
                url = "http://192.168.100.222:8001/ifmisLLM/chat/1.0.0.0/uploadFile?user_code=admin";
                ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
                String json = response.getBody();
                Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
                String code = (String)jsonMap.get("code");
                if("500".equals(code)){
                    String message = (String) jsonMap.get("message");
                    throw new AppException(message);
                }else if (jsonMap.get("data") != null){
                    Map data = (Map) jsonMap.get("data");
                    String fileid = (String) data.get("file_id");
                    map.put("file_id",fileid);
                    logger.info("==============上传的项目事前绩效评估附件：【"+map+"】===========");
                    fileidlist.add(fileid);
                }
            }
        } catch (Exception e) {
            logger.error("上传的项目事前绩效评估附件失败", e);
        }
        return fileidlist;
    }
}
