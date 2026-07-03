package gov.mof.fasp2.pmkpi.perfself.pushdatacommun;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.ExpDocService;
import gov.mof.fasp2.pmkpi.perfutil.PerfHttpUtils;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PushDataCommunBO extends PmkpiBO {

    private PushDataCommunDAO pushDataCommunDAO;

    public void setPushDataCommunDAO(PushDataCommunDAO pushDataCommunDAO) {
        this.pushDataCommunDAO = pushDataCommunDAO;
    }

    /**
     * <p>左侧树-菜单信息</p >
     *
     * @param
     * @author hw
     * @date 2021/7/17 16:06
     */
    public Map<String, Object> getTreeInfo(Map<String, Object> params) {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", new ArrayList<>());
        return leftconfig;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String menuid = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        datarule += PerfUtil.yearProvinceSql("t");
        return pushDataCommunDAO.getLeftTree(tablecode, datarule);
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = sqlmap.get("isleaf") + "";
        String querySql = (String) sqlmap.get("querySql");
        String agency = (String) sqlmap.get("agency");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        StringBuffer sql = new StringBuffer();
        sql.append("select * from ").append(tablecode).append(" t where ");
        sql.append(datarule);
        if (!StringUtil.isEmpty(tabfilter)) {
            sql.append(" and ").append(tabfilter);
        }
        if (!StringUtil.isEmpty(querySql)) {
            sql.append(" and ").append(querySql);
        }
        sql.append(PerfUtil.yearProvinceSql("t"));
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, pushDataCommunDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 推送数据到数据交互中心
     * @param params
     * @return
     */
    public Map<String, Object> add(HashMap<String, Object> params) throws Exception {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        return this.createSXDataCommunicationFile(datas);
    }

    /**
     * 获取山西数据交互中心token
     * @return
     */
    public String getSXDataCommunicationToken() throws AppException, IOException {
        String secret = "sxcz2022";
        // 1. 获取 Token（POST 表单）
        String tokenUrl = PerfUtil.getDatacommunicationBase_IP() + "/common/v2/service/oauth2/token";
        Map<String, String> tokenParams = new HashMap<>();
        tokenParams.put("appid", pushDataCommunDAO.DATACOMMUNICATION_APPID);
        tokenParams.put("secret", secret);
        String tokenResp = PerfHttpUtils.doGetForm(tokenUrl, tokenParams);
        Map<String, Object> tokenMap = PerfUtil.parseString2Map(tokenResp);
        String code = tokenMap.get("code") + "";
        if (!"200".equals(code)) {
            throw new AppException("ERROR", "获取数据交互中心token失败，请联系管理员！：" + tokenMap);
        }
        Map<String, Object> data = (Map<String, Object>) tokenMap.get("data");
        String token = (String) data.get("access_token");
        if (StringUtil.isNullOrEmpty(token)) {
            throw new AppException("ERROR", "获取到的数据交互中心token为空，请联系管理员！");
        }
        logger.info("Token获取成功:" + token);
        return token;
    }

    /**
     * 山西生成自评报告，上传到文件到数据交互中心，并新增数据到数据交互中心
     * @return
     * @throws Exception
     */
    public Map<String, Object> createSXDataCommunicationFile(List<Map<String, Object>> datas) throws Exception {
        List<String> guids = new ArrayList<>();
        List<String> procodeList = new ArrayList<>();
        Map<String, Object> dataMap = new HashMap<>();
        datas.forEach(map -> {
            String guid = (String) map.get("guid");
            String pro_code = (String) map.get("pro_code");
            guids.add(guid);
            procodeList.add(pro_code);
            dataMap.put(guid, map);
        });
        String token = this.getSXDataCommunicationToken();
//        String token = "";
        Map<String, Object> resultMap = new HashMap<>();
        // 3. 生成文件内容（多个 byte[]）
        ExpDocService expDocService = PerfServiceFactory.getExtDocService();
        Map<String, Object> params = new HashMap<>();
        params.put("templatecode", "sxproselfevalxls");
        params.put("bobeanid", "pmkpi.perfcommon.expdoc.ExpDocBOTX");
        params.put("guids", guids);
        Map<String, byte[]> expMap = expDocService.createFile(params);
        // 4. 逐个上传文件
        String uploadUrl = PerfUtil.getDatacommunicationBase_IP() + "/mof/v2/service/file/" + pushDataCommunDAO.DATACOMMUNICATION_APPID + "/upload";
        // 额外的表单字段（除了文件之外，需要作为请求参数传递）
        Map<String, String> extraFields = new HashMap<>();
        extraFields.put("token", token);
        extraFields.put("syscode", "020");
        List<Map<String, Object>> saveList = new ArrayList<>();
        // 获取系统临时目录并创建自定义子目录
        String baseTemp = System.getProperty("java.io.tmpdir");
        File tempDir = new File(baseTemp, "pmkpi_uploads");
        if (!tempDir.exists()) {
            boolean created = tempDir.mkdirs();
            if (!created) {
                throw new IOException("无法创建临时目录: " + tempDir.getAbsolutePath());
            }
        }
        File tempFile = null;
        for (String key : expMap.keySet()) {
            String[] keys = key.split("@@");
            String busguid = keys[0];
            String filename = keys[1];
            byte[] fileBytes = expMap.get(key);
            if (fileBytes == null || fileBytes.length == 0) {
                logger.warn("文件 {} 内容为空，跳过", filename);
                continue;
            }
            if (!StringUtil.isEmpty(filename)) {
                filename = filename.replaceAll(".xls", "");
            }
            try {
                // 创建临时文件（指定前缀/后缀）
                tempFile = File.createTempFile(filename, ".xls", tempDir); // 需要动态后缀或来自文件名
                // 或者使用 Files.write
                Files.write(tempFile.toPath(), fileBytes);
                // 调用上传
                String uploadResp = PerfHttpUtils.doPostMultipart(uploadUrl, tempFile, filename + ".xls", "file1", extraFields);
//                String uploadResp = "{\"code\":\"200\", \"data\":\"123\"}";
                Map<String, Object> uploadResult = PerfUtil.parseString2Map(uploadResp);
                String uploadCode = uploadResult.get("code") + "";
                if ("200".equals(uploadCode)) {
                    Map<String, Object> selfMap = (Map<String, Object>) dataMap.get(busguid);
                    Map<String, Object> saveMap = new HashMap<>();
                    saveMap.put("guid", StringUtil.createUUID());
                    saveMap.put("file_id", uploadResult.get("data"));
                    saveMap.put("mof_div_code", selfMap.get("province"));
                    saveMap.put("fiscal_year", selfMap.get("year"));
                    saveMap.put("pro_code", selfMap.get("pro_code"));
                    saveMap.put("create_time", PerfUtil.getServerTimeStamp());
                    saveMap.put("update_time", PerfUtil.getServerTimeStamp());
                    saveMap.put("is_deleted", 2);
                    saveList.add(saveMap);
                    logger.info("文件 {} 上传成功", filename);
                    // 可选：更新数据库状态（将对应记录标记为已推送）
                } else {
                    resultMap.put("success", false);
                    logger.error("文件 {} 上传失败，响应：{}", filename, uploadResult);
                }
            } catch (Exception e) {
                resultMap.put("success", false);
                logger.error("文件 {} 上传异常", filename, e.getMessage());
            } finally {
                // ★★★ 确保临时文件被立即删除 ★★★
                if (tempFile != null && tempFile.exists()) {
                    boolean deleted = tempFile.delete();
                    if (!deleted) {
                        // 若立即删除失败，退而求其次，JVM 退出时删除（慎用，但作为兜底）
                        logger.warn("临时文件 {} 删除失败，将由 JVM 退出时清理", tempFile.getAbsolutePath());
                        tempFile.deleteOnExit();
                    } else {
                        logger.debug("临时文件 {} 已成功删除", tempFile.getAbsolutePath());
                    }
                }
            }
        }
        //保存，并调用新增接口，先确保新增成功，成功后，调用保存
        if (!saveList.isEmpty()) {
            String addurl = PerfUtil.getDatacommunicationBase_IP() + PerfUtil.getDatacommunicationBase_URL();
            Map<String, String> urlParams = new HashMap<>();
            urlParams.put("token", token);
            Map<String, Object> addParams = new HashMap<>();
            addParams.put("body", saveList);
            String addResp = PerfHttpUtils.doPostForm(addurl, addParams, urlParams);
//            String addResp = "{\"code\":\"200\", \"data\":\"123\"}";
            Map<String, Object> addMap = PerfUtil.parseString2Map(addResp);
            if ("200".equals(addMap.get("code") + "")) {
                pushDataCommunDAO.saveAll(saveList, "perf_t_datacommunication");
                resultMap.put("success", true);
            } else {
                resultMap.put("success", false);
            }
        }
        return resultMap;
    }

    /**
     * 山西删除上传到数据交互中心数据，并删除上传到数据交互中心的附件
     * @param datas
     * @return
     * @throws Exception
     */
    public Map<String, Object> delSXDataCommunicationFile(List<Map<String, Object>> datas) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        if (datas.isEmpty()) {
            resultMap.put("success", true);
            return resultMap;
        }
        List<String> procodeList = new ArrayList<>();
        datas.forEach(map -> {
            procodeList.add((String) map.get("pro_code"));
        });
        String tablecode = "V_PERF_T_DATACOMMUNICATION";
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(this.createInSql("pro_code", procodeList));
        List<Map<String, Object>> dataCommunicationList = this.getDatas(tablecode, wheresql.toString(), null);
        if (dataCommunicationList.isEmpty()) {
            resultMap.put("success", true);
            logger.info("没有需要删除的项目附件");
            return resultMap;
        }
        String[] guids = new String[dataCommunicationList.size()];
        List<String> fileids = new ArrayList<>();
        for (int i=0; i < dataCommunicationList.size(); i++) {
            guids[i] = (String) dataCommunicationList.get(i).get("guid");
            fileids.add((String) dataCommunicationList.get(i).get("file_id"));
        }
        Map<String, Object> delMap = new HashMap<>();
        delMap.put("guid", guids);
        //获取token
        String token = this.getSXDataCommunicationToken();
//        String token = "";
        //删除数据7
        String delUrl = PerfUtil.getDatacommunicationBase_IP() + PerfUtil.getDatacommunicationBase_URL();
        Map<String, String> extraFields = new HashMap<>();
        extraFields.put("token", token);
        extraFields.put("where", URLEncoder.encode(PerfUtil.parse2Json(delMap), StandardCharsets.UTF_8.name()));
        String delResult = PerfHttpUtils.doDelete(delUrl, extraFields);
//        String delResult = "{\"code\":\"200\"}";
        Map<String, Object> delResultMap = PerfUtil.parseString2Map(delResult);
        //删除数据成功后，删除附件
        if ("200".equals(delResultMap.get("code") + "") && !fileids.isEmpty()) {
            //删除中间表数据
            pushDataCommunDAO.updateIsDeleteDatas(tablecode, wheresql.toString());

//            //通过交流，不调用逐个删除文件
//            String delFileUrl = PerfUtil.getDatacommunicationBase_IP() + "/mof/v2/service/file/" + pushDataCommunDAO.DATACOMMUNICATION_APPID + "/delete";
//            // 额外的表单字段（需要作为请求参数传递）
//            Map<String, String> delFields = new HashMap<>();
//            for (String fileid : fileids) {
//                delFields.put("token", token);
//                delFields.put("fileid", fileid);
//                String delFileResult = PerfHttpUtils.doPostForm(delFileUrl,null, delFields);
//                Map<String, Object> delFileResultMap = PerfUtil.parseObj2Map(delFileResult);
//                if (!"200".equals(delFileResultMap.get("code") + "")) {
//                    logger.error("文件 {} 删除失败，响应:", fileid, delFileResultMap);
//                }
//            }
            resultMap.put("success", true);
        } else {
            logger.error("数据 {} 删除失败，响应：", guids, delResultMap);
            throw new AppException("Error", "数据交互中心附件删除失败，请联系管理员！");
        }
        return resultMap;
    }
}
