package gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.datacommon.common.util.CommonUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.audit.ProTraceAuditBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.io.InputStream;
import java.util.*;
import java.util.stream.IntStream;

public class ProTraceThirdAuditBO extends PmkpiBO {
    private ProTraceThirdAuditDAO proTraceThirdAuditDAO;

    public void setProTraceThirdAuditDAO(ProTraceThirdAuditDAO proTraceThirdAuditDAO) {
        this.proTraceThirdAuditDAO = proTraceThirdAuditDAO;
    }

    private HtmlFileUploadService htmlFileUploadService;

    public HtmlFileUploadService getHtmlFileUploadService() {
        if(htmlFileUploadService == null){
            htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        }
        return htmlFileUploadService;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
//        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
//        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String tasktype= (String) sqlmap.get("tasktype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where t.tasktype='").append(tasktype).append("'");
        if (PerfUtil.getIsGuangXi()) {
            returnsql.append(" and t.audittype='2' ");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceThirdAuditDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        if (PerfUtil.getIsHbei()) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String tasktype = (String) params.get("tasktype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        if (PerfUtil.getIsGuangXi()) {
            datarule += " and t.audittype='2' ";
        }
        return proTraceThirdAuditDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        String bustype = (String) params.get("bustype");
        String type = (String) params.get("type");//会否成果上传页面
        this.workflow(actioncode, workflow, remark, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, datas);
        ProTraceAuditBO proTraceAuditBO = (ProTraceAuditBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.audit.ProTraceAuditBOTX");
        proTraceAuditBO.updateTracePayTabelDatas(datas, actioncode, bustype);
        if ("third".equals(type) && "back".equals(actioncode)) {
            List<String> cols = new ArrayList<>();
            cols.add("audittype");
            for (Map<String, Object> map: datas) {
                map.put("audittype", "1");
            }
            proTraceThirdAuditDAO.updateAll(cols, datas, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE);
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 查询绩效云评价指标数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        String wheresql = " mainguid='" + mainguid + "' ";
        List<Map<String, Object>> datas = proTraceThirdAuditDAO.getDatas(tablecode, wheresql, "order by ind_code1,ind_code2");
        backMap.put("data", datas);
        return backMap;
    }

    /**
     * 2.2.查询重点绩效监控项目成果
     * 3.2.查询财政重点评价项目成果
     * @param params
     * @throws Exception
     */
    public Map<String, Object> getProTraceEvalResult(HashMap<String, Object> params) throws Exception {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String evalType = (String) params.get("evalType");
        String pro_code = "";
        for(Map<String, Object> map : datas){
            pro_code += map.get("pro_code") + ",";
        }
        pro_code = pro_code.substring(0,pro_code.length() - 1);
        String url = "http://121.36.109.18:8085/api/kpi/dataQuery/getProjEvalResult";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/json; charset=UTF-8"));
        headers.add("Accept", MediaType.APPLICATION_JSON.toString());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("mofDivCode", CommonUtil.getProvince());
        jsonObject.put("year",CommonUtil.getYear());
        jsonObject.put("projCode",pro_code);
//        jsonObject.put("mofDivCode", "150000000");
//        jsonObject.put("year","2026");
//        jsonObject.put("projCode","152500254083210000001");
        jsonObject.put("evalType",evalType);
        HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        logger.info("==============调用绩效云-查询项目成果接口开始: {}===========", formEntity.toString());
        String json = restTemplate.postForObject(url,formEntity, String.class);
        // String json = "{\"error\":false,\"errorMsg\":null,\"exception\":null,\"result\":[{\"eval_report_list\":[{\"attachs\":[{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=e8c9cc0ac5024b73ad1b51c674e0c422\",\"data_id\":\"YMXp7npPrh4jmS3sKTQYnQcdJi4TdaSp\",\"file_name\":\"PJBG-2026051156958-废弃采坑地质环境治理项目绩效评价报告-全文电子版(征求意见稿).docx\",\"file_type\":\"docx\",\"file_id\":\"e8c9cc0ac5024b73ad1b51c674e0c422\"},{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=f46d573dad4743e3b8a98731775de75d\",\"data_id\":\"YMXp7npPrh4jmS3sKTQYnQcdJi4TdaSp\",\"file_name\":\"PJBG-2026051156958-废弃采坑地质环境治理项目绩效评价报告-全文电子版(定稿).docx\",\"file_type\":\"docx\",\"file_id\":\"f46d573dad4743e3b8a98731775de75d\"}],\"agency_name\":\"中华中南绩效管理咨询有限责任公司\",\"create_time\":\"2026-05-11 11:00:56\",\"year\":\"2026\",\"report_id\":\"YMXp7npPrh4jmS3sKTQYnQcdJi4TdaSp\",\"wtf_name\":\"省财政厅\",\"report_name\":\"废弃采坑地质环境治理项目绩效评价报告\",\"report_code\":\"PJBG-2026051156958\"},{\"attachs\":[{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=42df9d3cf23842ff9ba41f0655af6b71\",\"data_id\":\"XnB3CFddYWNZRfASwwzjJxZZKd5WDsj6\",\"file_name\":\"PJBG-2026051163606-安全生产绩效评价报告-全文电子版(定稿).docx\",\"file_type\":\"docx\",\"file_id\":\"42df9d3cf23842ff9ba41f0655af6b71\"},{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=a1ab44eba9b6420bafa385cc1c2403fa\",\"data_id\":\"XnB3CFddYWNZRfASwwzjJxZZKd5WDsj6\",\"file_name\":\"PJBG-2026051163606-安全生产绩效评价报告-全文电子版(征求意见稿).docx\",\"file_type\":\"docx\",\"file_id\":\"a1ab44eba9b6420bafa385cc1c2403fa\"}],\"agency_name\":\"中华中南绩效管理咨询有限责任公司\",\"create_time\":\"2026-05-11 11:02:24\",\"year\":\"2026\",\"report_id\":\"XnB3CFddYWNZRfASwwzjJxZZKd5WDsj6\",\"wtf_name\":\"省财政厅\",\"report_name\":\"安全生产绩效评价报告\",\"report_code\":\"PJBG-2026051163606\"},{\"attachs\":[{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=4a113965e644449db20626ad65af575b\",\"data_id\":\"wzC6JF2T5zZCGDiWQd6ZTdXHe57sfwXk\",\"file_name\":\"PJBG-2026050677628-上年度未实施完毕项目尾款及质保金绩效评价报告-全文电子版(定稿).docx\",\"file_type\":\"docx\",\"file_id\":\"4a113965e644449db20626ad65af575b\"},{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=813367efc99b4f9d946b7da061c7d095\",\"data_id\":\"wzC6JF2T5zZCGDiWQd6ZTdXHe57sfwXk\",\"file_name\":\"PJBG-2026050677628-上年度未实施完毕项目尾款及质保金绩效评价报告-全文电子版(征求意见稿).docx\",\"file_type\":\"docx\",\"file_id\":\"813367efc99b4f9d946b7da061c7d095\"}],\"agency_name\":\"中华中南绩效管理咨询有限责任公司\",\"create_time\":\"2026-05-06 15:40:25\",\"year\":\"2026\",\"report_id\":\"wzC6JF2T5zZCGDiWQd6ZTdXHe57sfwXk\",\"wtf_name\":\"省财政厅\",\"report_name\":\"上年度未实施完毕项目尾款及质保金绩效评价报告\",\"report_code\":\"PJBG-2026050677628\"}],\"indicator_list\":[{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898944\",\"ind_name3\":\"110001-检查频次\",\"ind_code3\":\"110001\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":50,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查的频次情况\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898945\",\"ind_name3\":\"110002-完成检查报告数量\",\"ind_code3\":\"110002\",\"kpi_evalstd\":\"少一个扣除2分\",\"ind_name1\":\"产出指标\",\"kpi_score\":30,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查形成的报告（总结）个数\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747107676160\",\"ind_name3\":\"110003-相关会议调研次数\",\"ind_code3\":\"110003\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":20,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映纪检监察相关会议调研情况\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898944\",\"ind_name3\":\"110001-检查频次\",\"ind_code3\":\"110001\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":50,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查的频次\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898945\",\"ind_name3\":\"110002-完成检查报告数量\",\"ind_code3\":\"110002\",\"kpi_evalstd\":\"每缺少一份报告，扣除2分\",\"ind_name1\":\"产出指标\",\"kpi_score\":36,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查形成的报告（总结）个数\"},{\"ind_code2\":\"21\",\"ind_code1\":\"2\",\"ind_id\":\"wMWniBkmNY57KyhyFMndpD28Z7ezZsHc\",\"ind_name3\":\"经济效益\",\"ind_code3\":\"221212\",\"kpi_evalstd\":\"测试\",\"ind_name1\":\"效益指标\",\"kpi_score\":14,\"ind_name2\":\"经济效益指标\",\"kpi_content\":\"测试\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898944\",\"ind_name3\":\"110001-检查频次\",\"ind_code3\":\"110001\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":50,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查的频次情况\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898945\",\"ind_name3\":\"110002-完成检查报告数量\",\"ind_code3\":\"110002\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":30,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查形成的报告（总结）个数\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747107676160\",\"ind_name3\":\"110003-相关会议调研次数\",\"ind_code3\":\"110003\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":20,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映纪检监察相关会议调研情况\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898944\",\"ind_name3\":\"110001-检查频次\",\"ind_code3\":\"110001\",\"kpi_evalstd\":null,\"ind_name1\":\"产出指标\",\"kpi_score\":50,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查的频次情况\"},{\"ind_code2\":\"11\",\"ind_code1\":\"1\",\"ind_id\":\"1288649747090898945\",\"ind_name3\":\"110002-完成检查报告数量\",\"ind_code3\":\"110002\",\"kpi_evalstd\":\"每缺少一份报告，扣除2分\",\"ind_name1\":\"产出指标\",\"kpi_score\":36,\"ind_name2\":\"数量指标\",\"kpi_content\":\"反映监督检查形成的报告（总结）个数\"},{\"ind_code2\":\"21\",\"ind_code1\":\"2\",\"ind_id\":\"wMWniBkmNY57KyhyFMndpD28Z7ezZsHc\",\"ind_name3\":\"经济效益\",\"ind_code3\":\"221212\",\"kpi_evalstd\":\"测试\",\"ind_name1\":\"效益指标\",\"kpi_score\":14,\"ind_name2\":\"经济效益指标\",\"kpi_content\":\"测试\"}],\"year\":\"2026\",\"proj_name\":\"废弃采坑地质环境治理项目\",\"proj_code\":\"152500254083210000001\",\"plan_list\":[{\"attachs\":[{\"file_url\":\"http://121.36.109.18:8085/api/kpi/officeEdit/downloadKpiFile?fileId=1c2514916122468099c0c1d18db18bf2\",\"data_id\":\"BZ2cQZXrxm33tnEbhNTfESzapkfpCtad\",\"file_name\":\"SSFA-2026050966803-第三方机构如何注册实施方案电子版(征求意见稿).docx\",\"file_type\":\"docx\",\"file_id\":\"1c2514916122468099c0c1d18db18bf2\"}],\"agency_name\":\"中华中南绩效管理咨询有限责任公司\",\"create_time\":\"2026-05-09 09:47:16\",\"year\":\"2026\",\"plan_code\":\"SSFA-2026050966803\",\"wtf_name\":\"省财政厅\",\"plan_id\":\"BZ2cQZXrxm33tnEbhNTfESzapkfpCtad\",\"plan_name\":\"安全生产绩效评价实施方案\"}],\"proj_id\":\"509567F31AB970AFE063020012AC1F2B\"}],\"code\":200,\"success\":true}";
        if (CommonUtil.isEmpty(json)) {
            backMap.put("success",false);
            backMap.put("error","远程接口调用失败，请联系管理员");
            return backMap;
        }
        logger.info("==============调用绩效云-查询项目成果接口返回: {}===========", json);
        Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
        logger.info("==============调用绩效云-查询项目成果接口解析: {}===========", jsonMap.toString());
        if ((Boolean) jsonMap.get("error")){
            String message = (String) jsonMap.get("errorMsg");
            backMap.put("success",false);
            backMap.put("error",message);
            return backMap;
        }
        // 遍历绩效云接口数据
        List<Map<String, Object>> result = (List<Map<String, Object>>) jsonMap.get("result");
        for (Map<String, Object> map : result){
            // 快速匹配绩效云和绩效监控数据pro_code
            String projCode = (String) map.get("proj_code");
            OptionalInt indexOpt = IntStream.range(0, datas.size())
                    .filter(i -> {
                        Map<String, Object> map1 = datas.get(i);
                        // 防止 NullPointerException 和类型转换异常
                        return map1.containsKey("pro_code") &&
                                projCode.equals(map1.get("pro_code"));
                    })
                    .findFirst();
            Map<String, Object> proMap = datas.get(indexOpt.getAsInt());
            // 附件数据
            List<Map<String, Object>> proFileList = new ArrayList<>();
            List<String> delFileguids = new ArrayList<String>();
            boolean b1 = false;
            boolean b2 = false;

            // 绩效云-实施方案
            List<Map<String, Object>> planList  = (List<Map<String, Object>>) map.get("plan_list");
            processAttachmentList(planList, proMap, proFileList, delFileguids, "实施方案", evalType, b1);
            if(b1){
                backMap.put("success",false);
                backMap.put("error","文件上传失败！");
                return backMap;
            }
            // 绩效云-评价报告
            List<Map<String, Object>>  evalReportList  = (List<Map<String, Object>>) map.get("eval_report_list");
            processAttachmentList(evalReportList, proMap, proFileList, delFileguids, "评价报告", evalType, b2);
            if(b2){
                backMap.put("success",false);
                backMap.put("error","文件上传失败！");
                return backMap;
            }
            if(!delFileguids.isEmpty() && delFileguids.size() > 0){
                String guids = "";
                for(String guid : delFileguids){
                    guids += "'" + guid + "',";
                }
                guids = guids.substring(0,guids.length() - 1);
                proTraceThirdAuditDAO.delDatas("PERF_FILE"," t.guid in ("+guids+")");
                // proTraceThirdAuditDAO.deleteAllByColumn("guid", delFileguids, "PERF_FILE");
            }
            if(!proFileList.isEmpty() && proFileList.size() > 0){
                proTraceThirdAuditDAO.saveAll(proFileList,"PERF_FILE");
            }
            // 绩效云-绩效评价指标
            List<Map<String, Object>>  indicatorList  = (List<Map<String, Object>>) map.get("indicator_list");
            indicatorList.forEach(indimap -> {
                indimap.put("pro_code",proMap.get("pro_code"));
                indimap.put("mainguid",proMap.get("guid"));
                indimap.put("year", proMap.get("year"));
                indimap.put("province", proMap.get("province"));
            });
            proTraceThirdAuditDAO.delDatas("PERF_T_JXY_INDICATOR","t.pro_code = '"+proMap.get("pro_code")+"' ");
            proTraceThirdAuditDAO.saveAll(indicatorList,"PERF_T_JXY_INDICATOR");
        }
        backMap.put("success",true);
        return backMap;
    }

    /**
     * 处理附件列表
     *
     * @param sourceList      数据列表（plan_list 或 eval_report_list）
     * @param proMap          项目主数据映射
     * @param proFileList     待保存的文件列表容器
     * @param delFileguids    待删除的文件ID列表容器
     * @param businessType    业务类型标识（用于日志区分，可选）
     */
    private void processAttachmentList(List<Map<String, Object>> sourceList,
                                       Map<String, Object> proMap,
                                       List<Map<String, Object>> proFileList,
                                       List<String> delFileguids,
                                       String businessType,
                                       String evalType,
                                       boolean b) throws Exception {
        if (sourceList == null || sourceList.isEmpty()) {
            b = false;
            return;
        }
        for (Map<String, Object> itemMap : sourceList) {
            List<Map<String, Object>> attachsList = (List<Map<String, Object>>) itemMap.get("attachs");
            if (attachsList == null || attachsList.isEmpty()) {
                continue;
            }
            for (Map<String, Object> attachsMap : attachsList) {
                String fileUrl = (String) attachsMap.get("file_url");
                String fileId = (String) attachsMap.get("file_id");
                String fileName = (String) attachsMap.get("file_name");

                // 参数校验，避免空指针
                if (fileId == null || fileName == null) {
                    continue;
                }
                // 附件先删后插

                // 1. 根据绩效云附件ID获取附件服务保存返回的附件ID
                List<Map<String, Object>> datas = proTraceThirdAuditDAO.getDatas("PERF_FILE", "T.GUID = '"+fileId+"' ", "");
                if (!datas.isEmpty() && datas.size() > 0){
                    Map<String, Object> map = datas.get(0);
                    // 2. 删除旧文件记录
                    boolean isDeleted = getHtmlFileUploadService().deleteFile((String) map.get("fileguid"));
                    if (isDeleted) {
                        delFileguids.add(fileId);
                    }
                }
                // 3. 上传新文件并获取返回信息
                String fileguid = uploadFile(fileUrl, fileName);
                logger.info("==============附件服务保存返回信息({}): {}===={}===========", businessType, fileName, fileguid);
                // 4. 构建新的文件记录对象
                if (!fileguid.isEmpty() && fileguid != null) {
                    Map<String, Object> proFilemap = new HashMap<>();
                    proFilemap.put("guid",fileId); // 绩效云数据主键
                    proFilemap.put("billguid",proMap.get("guid"));   // 业务数据项目主键
                    proFilemap.put("fileguid",fileguid);  // 保存接口返回的附件ID
                    proFilemap.put("filename",fileName);
                    proFilemap.put("province",proMap.get("province"));
                    proFilemap.put("year",proMap.get("year"));
                    proFilemap.put("creatername","管理员-绩效云");
                    if (evalType.equals("01")){
                        proFilemap.put("filetype","PPP6P63P38P90CC3E053B11FA8C0BCC1"); // 监控-附件材料
                    } else {
                        proFilemap.put("filetype","4PP6P63P38P90CC3E053B11FA8C0BCC1"); // 财政评价-其他材料
                    }
                    proFilemap.put("update_time",PerfUtil.getServerTimeStamp());
                    proFilemap.put("create_time",PerfUtil.getServerTimeStamp());
                    proFileList.add(proFilemap);
                } else {
                    logger.warn("上传文件后返回结果为空, fileName: {}", fileName);
                    b = false;
                    return;
                }
            }
        }
    }

    /**
     * 从第三方服务获取文件流
     * @param fileUrl    附件下载地址
     * @param filename   附件名称
     */
    public String uploadFile(String fileUrl, String filename) {
        String result = null;
        RestTemplate restTemplate = new RestTemplate();
        // 从第三方服务获取文件流
        ResponseEntity<Resource> downloadResponseEntity = restTemplate.exchange(
                fileUrl,
                HttpMethod.GET,
                null,
                Resource.class // 直接使用 Resource.class，不需要 ParameterizedTypeReference
        );
        // 文件流保存至附件服务
        if (downloadResponseEntity.getStatusCode().is2xxSuccessful() && downloadResponseEntity.getBody() != null) {
            Resource resource = downloadResponseEntity.getBody();
            try (InputStream inputStream = resource.getInputStream()) {
                logger.info("==============从绩效云服务获取文件流成功: {}===========", filename);
                result = getHtmlFileUploadService().saveToFuds(inputStream, filename);
            } catch (Exception e) {
                logger.error("==============处理文件流失败: {}===========", e.getMessage(), e);
                e.printStackTrace();
            }
        } else {
            logger.warn("==============从绩效云服务获取文件流失败，状态码: {}===========", downloadResponseEntity.getStatusCode());
        }
        logger.info("==============uploadFile返回结果: {}===========", result);
        return result;
    }
}
