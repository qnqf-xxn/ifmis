package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

public class AISupportAuditExeBO extends PmkpiBO {

    private AISupportAuditDAO aISupportAuditDAO;

    public void setAISupportAuditDAO(AISupportAuditDAO aISupportAuditDAO) {
        this.aISupportAuditDAO = aISupportAuditDAO;
    }

    @Value("${ifmis.fasp2.gateway.address:127.0.0.1}")
    private String pathurl;

    /**
     * 获取左侧树数据
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "V_PERF_PROJECT_YEAR";//默认查全部
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        List<Map<String, Object>> treelist = aISupportAuditDAO.getLeftTree(tablecode,datarule);
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    /**
     * 辅助审核列表查询
     * @param params
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map params) throws AppException {
        // 待审核、审核中、已审核、审核失败
        String tablecode = params.get("tablecode")!=null ? (String)params.get("tablecode") : "V_PERF_T_AISUPPORTAUDITWAITING";
        String api_code = (String)params.get("api_code");
        String tablesql = (String)params.get("tablesql");
        String wheresql = (String)params.get("querySql");
        String menuid = (String) params.get("menuid");
        String tabcode = (String) params.get("tabcode");
        String tabfilter = (String) params.get("tabfilter");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        StringBuffer wfsql = new StringBuffer();
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(aISupportAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        String province = SecureUtil.getUserSelectProvince();
        if(!StringUtil.isNullOrEmpty(tabcode) && "wait".equals(tabcode)){
            tablecode = "V_PERF_T_AISUPPORTAUDITWAITING";
            wfsql.append(" not exists(select 1 from V_PERF_T_AISUPPORTAUDITEXE a where t.pro_code = a.pro_code and a.api_code= '").append(api_code).append("' ) ");
        }else if(!StringUtil.isNullOrEmpty(tabcode) && "auditing".equals(tabcode)){
            tablecode = "V_PERF_T_AISUPPORTAUDITEXE";
            wfsql.append(" status = '审核中' and api_code = '").append(api_code).append("' ");
        }else if(!StringUtil.isNullOrEmpty(tabcode) && "done".equals(tabcode)){
            tablecode = "V_PERF_T_AISUPPORTAUDITEXE";
            wfsql.append(" status = '已审核' and api_code = '").append(api_code).append("' ");
        }else if(!StringUtil.isNullOrEmpty(tabcode) && "fail".equals(tabcode)){
            tablecode = "V_PERF_T_AISUPPORTAUDITEXE";
            wfsql.append(" status = '审核失败' and api_code = '").append(api_code).append("' ");
        }
        StringBuffer sql = new StringBuffer("select t.* from ");
        sql.append(tablecode);
        sql.append(" t where t.province='").append(province).append("'");
        if (wfsql.length() > 0) {
            sql.append(" and ( ").append(wfsql).append(" )");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        sql.append(datarule);
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, aISupportAuditDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 批量AI辅助审核
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> batchAudit(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        String apicode = (String) params.get("apicode");
        if(StringUtils.isEmpty(apicode)){
            backmap.put("success",false);
            return backmap;
        }
        this.intoAiSupportAuditTask(params);
        String year = CommonUtil.getYear();
        String province = CommonUtil.getProvince();
        String tokenid = SecureUtil.getKey40();
        int yearInt = SecureUtil.getUserSelectYear();
        params.put("year",year);
        params.put("province",province);
        params.put("tokenid",tokenid);
        params.put("yearInt",yearInt);
        // 指标计算符号翻译信息
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        Map<Object, Object> signsMap = signs.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        params.put("signsMap",signsMap);
        List<Map<String, Object>> taskList = (List<Map<String, Object>>) params.get("waitingTaskList");
        if("PMKPI_AIPREPERFAUDIT".equals(apicode)){
            //提前解析报告文件
            AIPrePerfAuditBO aIPrePerfAuditBO =(AIPrePerfAuditBO)PerfServiceFactory.getBean("pmkpi.aisupportaudit.AIPrePerfAuditBOTX");
            Map<Object, Object> reportTxtMap = aIPrePerfAuditBO.uploadProfiletoAITranTxt(params);
            taskList.forEach(m -> m.put("report",reportTxtMap.get(m.get("pro_id"))));
        }
        ThreadPoolTaskExecutor taskExecutor = (ThreadPoolTaskExecutor) ServiceFactory.getBean("asyncServiceExecutor");
        taskExecutor.execute(() -> {
            try {
                this.startAiSupportAuditTask(params);
            } catch (Throwable e) {
                // 异步多线程审核时单独try catch处理异常，其他报错时要更新整个任务失败
                this.updateAiSupportAuditTaskStatus(taskList,"审核失败",apicode);
                logger.error("异步审核任务执行失败，参数：{}", params, e);
                e.printStackTrace();
            }
        });
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 清空AI辅助审核结果
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> clearAudit(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        String apicode = (String) params.get("apicode");
        if(StringUtils.isEmpty(apicode)){
            backmap.put("success",false);
            return backmap;
        }
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        datas.forEach(m -> m.put("guid", m.get("pro_code")));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)"+ PerfUtil.yearProvinceSql("t");
        aISupportAuditDAO.delDatas("PERF_T_AISUPPORTAUDITEXE",wheresql + " and t.api_code = '"+apicode+"' ");
        if("PMKPI_AISUPPORTAUDIT".equals(apicode)){
            aISupportAuditDAO.delDatas("PERF_T_AISUPPORTAUDIRESULT",wheresql);
        } else if("PMKPI_AISUPPORTAUDITDETAIL".equals(apicode)){
            aISupportAuditDAO.delDatas("PERF_T_AISUPPORTAUDIDETAIL",wheresql);
        } else if("PMKPI_AIPREPERFAUDIT".equals(apicode)){
            aISupportAuditDAO.delDatas("PERF_T_AIPREPERFAUDIT",wheresql);
        }
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 删除失败任务
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> clearError(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        String apicode = (String) params.get("apicode");
        if(StringUtils.isEmpty(apicode)){
            backmap.put("success",false);
            return backmap;
        }
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        datas.forEach(m -> m.put("guid", m.get("pro_code")));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        String wheresql = " (t.status = '审核失败' or t.status = '审核中' ) and t.api_code = '"+apicode+"' and exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)"+ PerfUtil.yearProvinceSql("t");
        aISupportAuditDAO.delDatas("PERF_T_AISUPPORTAUDITEXE",wheresql);
        backmap.put("success",true);
        return backmap;
    }

    /**
     * 插入AI辅助审核待审任务
     * @param params
     * @throws AppException
     */
    public void intoAiSupportAuditTask(HashMap<String,Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String apicode = (String) params.get("apicode");
        datas.forEach(m -> m.put("guid", m.get("pro_code")));
        aISupportAuditDAO.saveAll(datas, aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        String wheresql = " exists(select 1 from " + aISupportAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
        List<Map<String, Object>> addList = new ArrayList<>();
        List<Map<String, Object>> updateList = new ArrayList<>();
        List<String> updateprocodeList = new ArrayList<>();
        List<Map<String, Object>> exeList = aISupportAuditDAO.getDatas("V_PERF_T_AISUPPORTAUDITEXE"," t.api_code = '"+apicode +"' and "+wheresql,"order by pro_code");
        List<Map<String, Object>> proList = aISupportAuditDAO.getDatas(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO,wheresql,"order by pro_code");
        Map<String, Map<String, Object>> exeCodeToMap = new HashMap<>(exeList.size());
        for (Map<String, Object> exeMap : exeList) {
            String proCode = (String) exeMap.get("pro_code");
            if (proCode != null) {
                exeCodeToMap.put(proCode, exeMap);
            }
        }
        for (Map<String, Object> proMap : proList) {
            String proCode = (String) proMap.get("pro_code");
            if (proCode != null && exeCodeToMap.containsKey(proCode)) {
                updateList.add(exeCodeToMap.get(proCode));
                updateprocodeList.add(proCode);
            } else {
                addList.add(proMap);
            }
        }
        String timestamp = PerfUtil.getServerTimeStamp();
        List<Map<String, Object>> waitdatalist = new ArrayList<>();
        for (Map<String, Object> data : addList) {
            String pro_code = (String) data.get("pro_code");
            if(!StringUtil.isNullOrEmpty(pro_code)){
                Map waitdatamap = new HashMap();
                waitdatamap.putAll(data);
                waitdatamap.put("guid",StringUtil.createUUID());
                waitdatamap.put("api_code",apicode);
                waitdatamap.put("year", CommonUtil.getYear());
                waitdatamap.put("province", CommonUtil.getProvince());
                waitdatamap.put("create_time", timestamp);
                waitdatamap.put("update_time", timestamp);
                waitdatamap.put("agencyguid", waitdatamap.get("agency_code"));
                waitdatamap.put("finintorgguid", waitdatamap.get("mof_dep_code"));
                waitdatamap.put("status", "审核中");
                waitdatalist.add(waitdatamap);
            }
        }
        if(waitdatalist.size()>0){
            aISupportAuditDAO.saveAll(waitdatalist, "PERF_T_AISUPPORTAUDITEXE");
            params.put("waitingTaskList",waitdatalist);
        }
        if(updateList.size()>0){
            String usql = aISupportAuditDAO.createInSql("pro_code", updateprocodeList);
            String updatasql = "update V_PERF_T_AISUPPORTAUDITEXE t set status = '审核中',update_time = '"+timestamp+"' where " + usql;
            aISupportAuditDAO.update(updatasql);
            params.put("waitingTaskList",updateList);
        }
    }

    /**
     * 开始执行AI辅助审核待审任务
     * @param params
     * @throws AppException
     */
    public void startAiSupportAuditTask(HashMap<String,Object> params) throws AppException {
        //列表模式 浙江/湖北： PMKPI_AISUPPORTAUDIT ，单个项目 安徽： PMKPI_AISUPPORTAUDITDETAIL
        //浙江事前绩效： PMKPI_AIPREPERFAUDIT
        String apicode = (String) params.get("apicode");
        if(StringUtils.isNotEmpty(apicode) && "PMKPI_AISUPPORTAUDIT".equals(apicode)){
            params.put("targettablecode","PERF_T_AISUPPORTAUDIRESULT");
        } else if(StringUtils.isNotEmpty(apicode) && "PMKPI_AISUPPORTAUDITDETAIL".equals(apicode)){
            params.put("targettablecode","PERF_T_AISUPPORTAUDIDETAIL");
        } else if(StringUtils.isNotEmpty(apicode) && "PMKPI_AIPREPERFAUDIT".equals(apicode)){
            params.put("targettablecode","PERF_T_AIPREPERFAUDIT");
        }
        this.doAISupportAuditTaskBatch(params);
    }

    /**
     * 更新AI辅助审核待审任务状态
     * @param aisupportauditresultList 完成结果list 包含pro_code即可
     */
    public void updateAiSupportAuditTaskStatus(List<Map<String, Object>> aisupportauditresultList,String status,String apicode) {
        String timestamp = PerfUtil.getServerTimeStamp();
        List<String> procodeList = new ArrayList<>();
        if(aisupportauditresultList.size()>0){
            aisupportauditresultList = aisupportauditresultList.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                    Comparator.comparing(x -> (String)x.get("guid")))), ArrayList::new));
            aisupportauditresultList.forEach(m -> {
                procodeList.add((String) m.get("pro_code"));
            });
            String wheresql = aISupportAuditDAO.createInSql("pro_code", procodeList) + " and t.api_code = '"+apicode+"' ";
            String updatasql = "update V_PERF_T_AISUPPORTAUDITEXE t set status = '"+status+"',update_time = '"+timestamp+"' where "+wheresql;
            aISupportAuditDAO.update(updatasql);
        }
    }

    /**
     * 批量开始AI审核任务
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> doAISupportAuditTaskBatch(Map<String,Object> params) throws AppException {
        AISupportAuditBO aISupportAuditBO =(AISupportAuditBO)PerfServiceFactory.getBean("pmkpi.aisupportaudit.AISupportAuditBOTX");
        AISupportAuditDetailBO aISupportAuditDetailBO =(AISupportAuditDetailBO)PerfServiceFactory.getBean("pmkpi.aisupportaudit.AISupportAuditDetailBOTX");
        AIPrePerfAuditBO aIPrePerfAuditBO =(AIPrePerfAuditBO)PerfServiceFactory.getBean("pmkpi.aisupportaudit.AIPrePerfAuditBOTX");
        Map<String, Object> result =  new HashMap<>();
        result.put("success",false);
        String aitaskparams = PerfUtil.getSystemSet("aitaskparams");
        logger.info("-----------AI后台任务,系统参数："+aitaskparams);
        Map<String, Object> aitaskparamsmap = PerfUtil.parseString2Map(aitaskparams);
        int batchSize = Integer.parseInt((String) aitaskparamsmap.get("batchSize"));
        int threadcount = Integer.parseInt((String) aitaskparamsmap.get("threadcount"));
        int timeoutmis = Integer.parseInt((String) aitaskparamsmap.get("timeoutmis"));
        int singletimeoutms = Integer.parseInt((String) aitaskparamsmap.get("singletimeoutms"));
        String llmurl = (String) aitaskparamsmap.get("llmurl");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        String tokenid = (String) params.get("tokenid");
        String api_code = (String) params.get("apicode");
        int yearInt = (int) params.get("yearInt");
        Map<Object, Object> signsMap = (Map<Object, Object>) params.get("signsMap");
        if("PMKPI_AISUPPORTAUDITDETAIL".equals(api_code) || "PMKPI_AIPREPERFAUDIT".equals(api_code)){
            batchSize = 1;
        }
        // 查询待处理任务
        List<Map<String, Object>> taskList = (List<Map<String, Object>>) params.get("waitingTaskList");
        logger.info("++++++++++++获取AI辅助审核任务待处理数量"+ taskList.size());
        if(taskList != null && !taskList.isEmpty()){
            // 查询审核列表ui配置获取审核要点翻译名称用于结果解析
            Map<String, Object> auditPointMap = new HashMap<>();
            if("PMKPI_AISUPPORTAUDITDETAIL".equals(api_code)){
                String key = PerfUtil.getIsGuangXi()? "/pmkpi/common/aisupportauditdetail/gx" : "/pmkpi/common/aisupportauditdetail";
                List<Map<String, Object>> cols = this.getCols(key);
                auditPointMap = cols.stream()
                        .collect(Collectors.toMap(col -> ((String) col.get("colcode")).toLowerCase(), col -> col.get("name"),                            // value映射：直接取name
                                (oldVal, newVal) -> newVal));
                if(PerfUtil.get_ISANHUI()){
                    auditPointMap.put("nopass_indiArray",true);
                }else{
                    auditPointMap.put("nopass_indiArray",false);
                }
            }else if("PMKPI_AISUPPORTAUDIT".equals(api_code) && PerfUtil.getIsZJ()){
                List<Map<String, Object>> cols = this.getCols("/pmkpi/common/aisupportaudit");
                auditPointMap = cols.stream().filter(col -> ((String) col.get("colcode")).toUpperCase().startsWith("AUDITPOINT"))
                        .collect(Collectors.toMap(col -> ((String) col.get("colcode")).toLowerCase(),col -> col.get("name"),
                                (oldVal, newVal) -> newVal));
            }
            Map<String, Object> proInfoMap = new HashMap<>();
            for (Map<String, Object> proMap : taskList) {
                String procode = (String) proMap.get("pro_code");
                proInfoMap.put(procode,proMap);
            }
            String url = llmurl + "?tokenid="+tokenid;
            if(PerfUtil.get_ISYANSHI()){
                url = llmurl + "?user_code=admin&province="+province;
            }
            HashMap<String, Object> param = new HashMap<>();
            param.put("datas",taskList);
            param.put("year",yearInt);
            param.put("province",province);
            param.put("signsMap",signsMap);
            param.put("tokenid",tokenid);
            // 获取组装提示词
            Map<String, Object> backmap = new HashMap<>();
            if(StringUtils.isNotEmpty(api_code) && "PMKPI_AISUPPORTAUDIT".equals(api_code)){
                backmap = aISupportAuditBO.getProPrompt(param);
            } else if(StringUtils.isNotEmpty(api_code) && "PMKPI_AISUPPORTAUDITDETAIL".equals(api_code)){
                backmap = aISupportAuditDetailBO.getProPromptBatch(param);
            } else if(StringUtils.isNotEmpty(api_code) && "PMKPI_AIPREPERFAUDIT".equals(api_code)){
                backmap = aIPrePerfAuditBO.getProPromptBatch(param);
            }
            // 提示词信息aipromptList 每个项目一条
            List<Map<String, Object>> aipromptList = (List<Map<String, Object>>) backmap.get("aipromptList");
            if(aipromptList != null && !aipromptList.isEmpty()){
                logger.info("++++++++++++获取AI辅助审核待处理的项目数量"+ aipromptList.size());
                String apiKey = "";
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
                    Map<String, Object> finalAuditPointMap = auditPointMap;
                    Future<Boolean> future = executor.submit(() -> {
                        try {
                            if("PMKPI_AISUPPORTAUDIT".equals(api_code)){
                                List<Map<String, Object>> batchResults = aISupportAuditBO.processBatch(batchList, finalUrl, apiKey, timestamps, aisupportauditresultList, province, year, singletimeoutms, api_code, finalAuditPointMap);
                                // 批次成功后直接入库
                                if (batchResults != null && !batchResults.isEmpty()) {
                                    aISupportAuditBO.saveResultsToDatabase(batchResults);
                                    this.updateAiSupportAuditTaskStatus(batchResults,"已审核",api_code);
                                    logger.info("批次 " + batchIndex + " 处理并入库成功，共 " + batchResults.size() + " 条记录");
                                }
                            }else if("PMKPI_AISUPPORTAUDITDETAIL".equals(api_code)){
                                List<Map<String, Object>> batchResults = aISupportAuditDetailBO.processBatch(batchList, finalUrl, apiKey, timestamps, aisupportauditresultList, province, year, singletimeoutms, api_code, finalAuditPointMap, proInfoMap);
                                // 批次成功后直接入库
                                if (batchResults != null && !batchResults.isEmpty()) {
                                    aISupportAuditDetailBO.saveResultsToDatabase(batchResults);
                                    this.updateAiSupportAuditTaskStatus(batchResults,"已审核",api_code);
                                    logger.info("批次 " + batchIndex + " 处理并入库成功，共 " + batchResults.size() + " 条记录");
                                }
                            }else if("PMKPI_AIPREPERFAUDIT".equals(api_code)){
                                List<Map<String, Object>> batchResults = aIPrePerfAuditBO.processBatch(batchList, finalUrl, apiKey, timestamps, aisupportauditresultList, province, year, singletimeoutms, api_code, finalAuditPointMap, proInfoMap);
                                // 批次成功后直接入库
                                if (batchResults != null && !batchResults.isEmpty()) {
                                    aIPrePerfAuditBO.saveResultsToDatabase(batchResults);
                                    this.updateAiSupportAuditTaskStatus(batchResults,"已审核",api_code);
                                    logger.info("批次 " + batchIndex + " 处理并入库成功，共 " + batchResults.size() + " 条记录");
                                }
                            }
                            return true;
                        } catch (Exception e) {
                            logger.error( "批次 " + batchIndex + " 处理失败", e);
                            // 更新该批次结果为 审核失败
                            this.updateAiSupportAuditTaskStatus(batchList,"审核失败",api_code);
                            return false;
                        }
                    });
                    futures.add(future);
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
            }
            result.put("success",true);
        }
        return result;
    }
}
