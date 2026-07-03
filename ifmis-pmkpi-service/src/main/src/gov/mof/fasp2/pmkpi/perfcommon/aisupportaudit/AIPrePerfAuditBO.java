package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
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
import org.apache.commons.compress.utils.IOUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
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
import java.util.*;
import java.util.concurrent.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class AIPrePerfAuditBO extends PmkpiBO {

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
        String pro_id;
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
                pro_id = (String) proMap.get("pro_id");
                aipromptmap.put("项目ID",proMap.get("pro_id"));
                aipromptmap.put("项目代码",proMap.get("pro_code"));
                aipromptmap.put("项目名称",proMap.get("pro_name"));
                aipromptmap.put("单位代码",proMap.get("agency_code"));
                aipromptmap.put("单位名称",proMap.get("agency_name"));
                aipromptmap.put("预算年度",SecureUtil.getUserSelectYear());
                // 指标计算符号翻译信息
                IDataSetService dss = PerfServiceFactory.getIDataSetService();
                List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
                Map<Object, Object> signsMap = signs.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
                // 绩效目标和指标
                if(!ishubei){ // 非湖北时 默认查询本年和上年的PM表申报目标指标
                    // 总体绩效目标指标
                    String totalwheresql = "t.province = '"+SecureUtil.getUserSelectProvince()+"' and t.mainguid = '"+pro_id+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '1' and sub_mof_div_code is null ";
                    List<Map<String, Object>> totalindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",totalwheresql," order by t.findex,t.sindex,t.ordernum");// 上年度绩效指标
                    aipromptmap.put("target",AIStreamUtil.packageIndexList(totalindexList,signsMap));
                }else{
                }
                // 报告文件
                params.put("pro_id",pro_id);
                Map<Object, Object> reportTxtMap = this.uploadProfiletoAITranTxt(params);
                aipromptmap.put("report", reportTxtMap.get(pro_id));
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
        String province = (String) params.get("province");
        int year = (int) params.get("year");
        // 设置年度区划
        aISupportAuditDAO.setYearAndProvince(Integer.toString(year),province);
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        // 上传事前评估绩效报告附件并返回文本内容
        Map<String, Object> reportTxtMap = datas.stream()
                .filter(item -> item.containsKey("pro_id") && item.get("pro_id") != null && item.containsKey("report") && item.get("report") != null)
                .collect(Collectors.toMap(item -> (String) item.get("pro_id"),item -> item.get("report"), (v1, v2) -> v1));
        datas.forEach(m -> m.put("guid",m.get("pro_id")));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        // AI组装提示词
        String aiprompt = "";
        List<Map<String, Object>> aipromptList = new ArrayList<>();
        if(datas.size()>0){// 查询项目信息并组装提示词
            String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_id)";
            List<Map<String, Object>> proList = aISupportAuditDAO.getDatas(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO,wheresql,"order by pro_id");
            // 总体绩效目标指标
            String totalwheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid ) and t.province = '"+province+"' and t.is_deleted = 2 and is_backup =2 and t.yearflag = '1' and sub_mof_div_code is null ";
            List<Map<String, Object>> totalindexList = aISupportAuditDAO.getDatas("PM_PERF_INDICATOR",totalwheresql," order by t.mainguid,t.findex,t.sindex,t.ordernum");// 上年度绩效指标
            Map<String, List<Map<String, Object>>> totalIndexGroupMap = totalindexList.stream().collect(Collectors.groupingBy(item -> (String) item.get("mainguid")));
            if(proList.size()<1){
                backmap.put("success",false);
                backmap.put("error","所选项目未查询到项目信息!");
                return backmap;
            }
            for (Map<String, Object> proMap : proList) {
                String pro_id = (String)proMap.get("pro_id");
                String pro_code = (String)proMap.get("pro_code");
                // 项目信息
                Map<String, Object> aipromptmap = new HashMap<>();
                aipromptmap.put("项目ID",proMap.get("pro_id"));
                aipromptmap.put("项目代码",proMap.get("pro_code"));
                aipromptmap.put("项目名称",proMap.get("pro_name"));
                aipromptmap.put("单位代码",proMap.get("agency_code"));
                aipromptmap.put("单位名称",proMap.get("agency_name"));
                aipromptmap.put("预算年度",SecureUtil.getUserSelectYear());
                // 指标计算符号翻译信息
                Map<Object, Object> signsMap = (Map<Object, Object>) params.get("signsMap");
                // 绩效目标和指标
                if(!ishubei){ // 非湖北时
                    AIStreamUtil.safeProcessGroupList(totalIndexGroupMap, pro_id, list -> AIStreamUtil.packageIndexList(list, signsMap))
                            .ifPresent(val -> aipromptmap.put("target", val));
                }else{
                    // 湖北目标指标
                }
                // 事前评估报告文本内容
                aipromptmap.put("report",reportTxtMap.get(pro_id));
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
     *
     * @param params
     * @return
     * @throws AppException
     */
    Map<Object, Object> uploadProfiletoAITranTxt(HashMap<String, Object> params) throws AppException {
        Map<Object, Object> reportTxtMap = new HashMap<>();
        String aitaskparams = PerfUtil.getSystemSet("aitaskparams");
        logger.info("-----------AI后台任务,系统参数："+aitaskparams);
        Map<String, Object> aitaskparamsmap = PerfUtil.parseString2Map(aitaskparams);
        int singletimeoutms = Integer.parseInt((String) aitaskparamsmap.get("singletimeoutms"));
        String llmurl = (String) aitaskparamsmap.get("llmurl");
        String province = (String) params.get("province");
        String tokenid = (String) params.get("tokenid");
        String qstream_url = llmurl + "?tokenid="+tokenid;
        if(PerfUtil.get_ISYANSHI()){
            qstream_url = llmurl + "?user_code=admin&province="+province;
        }
        String upload_url = qstream_url.replace("rendQStream","uploadFile");
        String wf_url = qstream_url.replace("rendQStream","run");
        HtmlFileUploadService htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        String spro_id = (String) params.get("pro_id");
        List<Map<String, Object>> datas = new ArrayList<>();
        String filter = (String) params.get("filter");
        filter = "'DE9176','DE9177'";// 92smx1
        if(!StringUtil.isNullOrEmpty(spro_id)){
            Map<String, Object> newData = new HashMap<>();
            newData.put("guid",spro_id);
            datas.add(newData);
        }else{
            datas = (List<Map<String, Object>>) params.get("datas");
            datas.forEach(m -> {
                String pro_id = (String) m.get("pro_id");
                if(StringUtil.isNullOrEmpty(pro_id)){
                    pro_id = (String) m.get("guid");
                }
                m.put("guid",pro_id);
            });
            // 去重
            datas = datas.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                    Comparator.comparing(x -> (String)x.get("guid")))), ArrayList::new));
        }
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
            // step1 上传附件获得file_id
            for (Map map : fileInfoList) {
//                String fileguid = "611689E575B91B82F8A5E12D4DBF6B72";
                String fileguid = (String) map.get("fileguid");
                String originalFileName = htmlFileUploadService.getFileinfoByRest(fileguid).get("fileName").toString();
                map.put("filename",originalFileName);
                InputStream inputStream = htmlFileUploadService.downFileByRest(fileguid, originalFileName, null);
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
                ResponseEntity<String> response = restTemplate.exchange(upload_url, HttpMethod.POST, requestEntity, String.class);
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

            // step2 通过每个file_id解析报告文件
            for (Map map : fileInfoList) {
                String fileid = (String) map.get("file_id");
                String fileTxt = AIStreamUtil.processFileTxt(fileid,singletimeoutms,qstream_url, "", "PMKPI_AIPERFEVALTXT");
                map.put("file_txt",fileTxt);
            }

            // step3 根据pro_id 分组聚合报告内容
            Map<String, List<Map<String, Object>>> groupedByProId = fileInfoList.stream()
                    .collect(Collectors.groupingBy(
                            item -> (String) item.get("pro_id"),
                            LinkedHashMap::new,
                            Collectors.toList()
                    ));
            for (Map.Entry<String, List<Map<String, Object>>> entry : groupedByProId.entrySet()) {
                String proId = entry.getKey();
                List<Map<String, Object>> projectFiles = entry.getValue();
                StringBuilder reportContent = new StringBuilder();
                // 拼接该项目的所有附件报告
                for (int i = 0; i < projectFiles.size(); i++) {
                    Map<String, Object> fileInfo = projectFiles.get(i);
                    String fileName = (String) fileInfo.get("filename");
                    String fileTxt = (String) fileInfo.get("file_txt");
                    String fileGuid = (String) fileInfo.get("fileguid");
                    if (StringUtil.isNullOrEmpty(fileName)) {
                        fileName = "未知文件_" + fileGuid;
                    }
                    if (StringUtil.isNullOrEmpty(fileTxt)) {
                        fileTxt = " [无解析内容]";
                    }
                    reportContent.append("报告").append(i + 1).append(":").append(fileName).append(fileTxt);
                    if (i < projectFiles.size() - 1) {
                        reportContent.append(System.lineSeparator());
                    }
                }
                logger.info("项目[{}]聚合完成，共{}份附件，报告文本总长度：{}", proId, projectFiles.size(), reportContent.length());
                reportTxtMap.put(proId, reportContent.toString());
            }

        } catch (Exception e) {
            logger.error("上传的项目事前绩效评估附件失败", e);
        }
        return reportTxtMap;
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
        StringBuffer sql = new StringBuffer("select t.* from PERF_V_AIPREPERFAUDIT t where pro_code ='").append(pro_code).append("'");
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
        Map<String, Object> auditresultMap = (Map<String, Object>) params.get("datas");
        String timestamps = PerfUtil.getServerTimeStamp();
        String province = SecureUtil.getUserSelectProvince();
        String year = String.valueOf(SecureUtil.getUserSelectYear());
        if(!auditresultMap.isEmpty()){
            auditresultMap.put("guid", this.getCreateguid());
            auditresultMap.put("province", province);
            auditresultMap.put("year", year);
            auditresultMap.put("create_time", timestamps);
            auditresultMap.put("pro_code",proinfo.get("pro_code"));
            auditresultMap.put("pro_name",proinfo.get("pro_name"));
            auditresultMap.put("agency_code",proinfo.get("agency_code"));
            auditresultMap.put("agency_name",proinfo.get("agency_name"));
            aISupportAuditDAO.save(auditresultMap, "PERF_T_AIPREPERFAUDIT");
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
            waitdatamap.put("api_code","PMKPI_AIPREPERFAUDIT");
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
            aISupportAuditDAO.saveAll(aisupportauditresultList, "PERF_T_AIPREPERFAUDIT");
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
            StringBuilder batchPrompt = new StringBuilder().append(batchList.get(0).get("aiprompt"));
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
            indexData = extractAndParseJSON(afterThink,auditPointMap);
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
        List<Map<String, Object>> resultList = new ArrayList<>();
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(content);
        if (rootNode.isArray()) {
            // 如果是数组直接赋值
            parsedIndexArray = objectMapper.convertValue(rootNode, new TypeReference<List<Map<String, Object>>>() {});
        } else if (rootNode.isObject() && !rootNode.isNull()) {
            // 如果是对象
            Map<String, Object> parsedMap =  objectMapper.convertValue(rootNode, new TypeReference<Map<String, Object>>() {});
            parsedMap.put("conclusion",parsedMap.get("conclusion"));
            parsedMap.put("reportproblem",parsedMap.get("reportProblem"));
            parsedMap.put("indicator",parsedMap.get("indicator"));
            resultList.add(parsedMap);
        }
        for (Map<String, Object> item : parsedIndexArray) {
            Map<String, Object> newItem = new HashMap<>();
            newItem.put("conclusion", item.get("conclusion"));
            newItem.put("reportproblem", item.get("reportProblem"));
            newItem.put("indicator", item.get("indicator"));
            resultList.add(newItem);
        }
        return resultList;
    }

    /**
     * 查询审核结果
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getAuditData(HashMap<String, Object> params) throws AppException{
        Map<String, Object> backMap = new HashMap<String, Object>();
        String pro_code = (String) params.get("pro_code");
        Map<String, Object>  data = aISupportAuditDAO.getDataMap("PERF_V_AIPREPERFAUDIT", " t.pro_code = ? ",new String[]{pro_code});
        backMap.put("data", data);
        return backMap;
    }
}
