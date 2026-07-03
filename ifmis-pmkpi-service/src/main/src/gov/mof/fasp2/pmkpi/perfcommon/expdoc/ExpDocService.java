
package gov.mof.fasp2.pmkpi.perfcommon.expdoc;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.exportexcel.ExcelExportComponet;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import java.util.concurrent.TimeUnit;

;

public class ExpDocService extends ExcelExportComponet {

    @Autowired
    FreeMarkerConfigurer freeMarkerConfigurer;

    private Configuration configuration = null;

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    private final static Logger logger = Logger.getLogger(ExpDocService.class);



    /**
     * 创建报告.
     * @param param --
     * @return --
     * @throws PerfAppException --
     */
    @SuppressWarnings({"unchecked" })
    public Map<String, Object> createWord(Map<String, Object> param) throws AppException, Exception {
        boolean rcp = param.get("rcp") == null ? false: (boolean)param.get("rcp") ;
        String templatecode = (String) param.get("templatecode");
        if (rcp) {
            this.getConsole().setProcess(0.1);
            this.getConsole().println("当前进度: 正在获取报告模板");
        }
        logger.info("模板编码：++++"+templatecode);
        // 获取模板信息
        Map<String, Object> templateMap = null;
        ExpDocDAO expDocDAO = (ExpDocDAO) PerfServiceFactory.getBean("pmkpi.perfcommon.expdoc.ExpDocDAO");
        String cacheKey = PmkpiDAO.PMKPI_CACHE_EXPEOC + templatecode;
        String cacheData = PerfUtil.getCacheJSONData(cacheKey);
        List<Map<String, Object>> subList = new ArrayList<>();
        Map<String, Object> expdocMap = null;
        if (cacheData != null) {
            expdocMap = PerfUtil.parseString2Map(cacheData);
            templateMap = (Map<String, Object>) expdocMap.get("maindata");
            subList = (List<Map<String, Object>>) expdocMap.get("subdata");
        } else {
            templateMap = expDocDAO.getExpdoc(templatecode);
            if (!templateMap.isEmpty()) {
                subList = expDocDAO.getSubExpdoc(templateMap.get("guid").toString());
            }
            expdocMap = new HashMap<>();
            expdocMap.put("maindata", templateMap);
            expdocMap.put("subdata", subList);
            PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(expdocMap), false);
        }
        if (templateMap == null || templateMap.isEmpty()) {
            throw new AppException("ERROR", "模板未注册，请联系管理员");
        }
        param.put("subdata", subList);
        // 模板名称
        String zipfilename = (String) templateMap.get("templatename");
        String issinglezip = (String) templateMap.get("iszip");
        String expfilename = ((zipfilename == null || zipfilename.equals("")) ? (String) templateMap.get("expfilename") : zipfilename) + PerfUtil.getServerTimeStamp() + ".zip";
        // 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
        // 这里我们的模板是放在template包下面
        Template t = null;
        try {
            String type = "jar";
            if ("jar".equals(type)) {
                // test.ftl为要装载的模板
                freeMarkerConfigurer.setDefaultEncoding("UTF-8");
                freeMarkerConfigurer.setTemplateLoaderPath("/pmkpi/ftl");
                t = freeMarkerConfigurer.getConfiguration().getTemplate(templatecode+".ftl");
            } else {
                configuration = new Configuration();
                configuration.setDefaultEncoding("UTF-8");
                //模板路径
                String mbPath = this.getClass().getResource("/").getPath().split("WEB-INF")[0] + "pmkpi/ftl";
                logger.error("--------模板路径：" + mbPath);
                File file = new File(mbPath);
                if (!file.exists()) {
                    logger.error("--------找不到模板文件：请重新上传模板或咨询管理员");
                    throw new PerfAppException("0", "找不到模板文件，请重新上传模板或咨询管理员");
                }
                configuration.setDirectoryForTemplateLoading(file); // 模板文件所在路径
                t = configuration.getTemplate(templatecode+".ftl", "UTF-8");
            }
        } catch (AppException e) {
            logger.error("--------找不到模板文件：请重新上传模板或咨询管理员");
            logger.error(e.getMessage(), e);
        }
        // 获取导出数据
        // datalistMap 要填入模板的数据文件
        List<Map<String, Object>> datalistMap = this.getData(param, templateMap);
        String fileName = URLEncoder.encode(expfilename, "UTF-8");
        HttpServletResponse response = this.getResponse();
        response.setContentType("application/x-download");
        response.setHeader("Content-disposition", "attachment;filename=" + fileName);
        OutputStream outputStream = response.getOutputStream();
        ZipOutputStream zipOutputStream = null;
        try {
            if (datalistMap != null && datalistMap.size() > 0) {
                for (Map<String, Object> data : datalistMap) {
                    for (Iterator ite = data.keySet().iterator(); ite.hasNext();) {
                        String key = ite.next().toString();
                        Object obj = data.get(key);
                        String val = "";
                        boolean isList = false;
                        if (null != obj) {
                            if (obj instanceof List) {
                                val = PerfUtil.parse2Json(obj);
                                isList = true;
                            } else {
                                val = obj.toString();
                            }
                            if (val.contains("<") || val.contains(">") || val.contains("&") || val.contains("<br>") || val.contains("'") || val.contains("\"") || val.contains("\r\n")) {
                                val = val.replaceAll("<br>", "");
                                val = val.replaceAll("&", "&amp;");
                                val = val.replaceAll("<", "&lt;");
                                val = val.replaceAll(">", "&gt;");
                                val = val.replaceAll("\r\n", "&#10;");
                                if (isList) {
                                    data.put(key, PerfUtil.parseString2List(val));
                                } else {
                                    val = val.replaceAll("\"","&quot;");
                                    val = val.replaceAll("'","&apos;");
                                    data.put(key, val);
                                }
                            }
                        }
                    }
                }
                if (datalistMap.size() == 1 && issinglezip != null && "0".equals(issinglezip)) {
                    //单个不压缩
                    Map<String, Object> dataMap = datalistMap.get(0);
                    expfilename = (String) dataMap.get("expfilename");
                    fileName = URLEncoder.encode(expfilename, "UTF-8");
                    response.setHeader("Content-disposition", "attachment;filename=" + fileName);
                    outputStream.write(getByteData(t, dataMap));
                } else {
                    //压缩
                    zipOutputStream = new ZipOutputStream(outputStream);
                    zipOutputStream.setEncoding("GBK");
                    for (int i = 0; i < datalistMap.size(); i++) {
                        Map<String, Object> dataMap = datalistMap.get(i);
                        expfilename = (String) dataMap.get("expfilename");
                        String is_expfilenamefolder = PerfUtil.getSystemSet("is_expfilenamefolder");
                        if (StringUtil.isEmpty(is_expfilenamefolder) || "2".equals(is_expfilenamefolder)){
                            expfilename = expfilename.replaceAll("/", "／");
                        }
                        ZipEntry zipEntry = new ZipEntry(expfilename);
                        zipOutputStream.putNextEntry(zipEntry);
                        zipOutputStream.write(getByteData(t, dataMap));
                    }
                    if (rcp) {
                        this.getConsole().setProcess(1f);
                        this.getConsole().println("当前进度: 正在导出文件！");
                        TimeUnit.SECONDS.sleep(1);
                    }
                    zipOutputStream.flush();
                    zipOutputStream.close();
                }
            }
            outputStream.flush();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } catch (TemplateException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
        }
        return null;
    }

    /**
     * 生成报告文件流.
     * @param param --
     * @return --
     * @throws PerfAppException --
     */
    @SuppressWarnings({"unchecked" })
    public Map<String, byte[]> createFile(Map<String, Object> param) throws Exception {
        Map<String, byte[]> resultMap = new HashMap<>();
        String templatecode = (String) param.get("templatecode");
        logger.info("模板编码：++++" + templatecode);

        // 1. 获取模板信息
        Map<String, Object> templateMap = null;
        ExpDocDAO expDocDAO = (ExpDocDAO) PerfServiceFactory.getBean("pmkpi.perfcommon.expdoc.ExpDocDAO");
        String cacheKey = PmkpiDAO.PMKPI_CACHE_EXPEOC + templatecode;
        String cacheData = PerfUtil.getCacheJSONData(cacheKey);
        List<Map<String, Object>> subList = new ArrayList<>();
        Map<String, Object> expdocMap = null;
        if (cacheData != null) {
            expdocMap = PerfUtil.parseString2Map(cacheData);
            templateMap = (Map<String, Object>) expdocMap.get("maindata");
            subList = (List<Map<String, Object>>) expdocMap.get("subdata");
        } else {
            templateMap = expDocDAO.getExpdoc(templatecode);
            if (!templateMap.isEmpty()) {
                subList = expDocDAO.getSubExpdoc(templateMap.get("guid").toString());
            }
            expdocMap = new HashMap<>();
            expdocMap.put("maindata", templateMap);
            expdocMap.put("subdata", subList);
            PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(expdocMap), false);
        }
        if (templateMap == null || templateMap.isEmpty()) {
            throw new AppException("ERROR", "模板未注册，请联系管理员");
        }
        param.put("subdata", subList);
        // 2. 加载 FreeMarker 模板（异常直接抛出，不再吞没）
        Template t = null;
        try {
            String type = "jar"; // 可从配置读取
            if ("jar".equals(type)) {
                freeMarkerConfigurer.setDefaultEncoding("UTF-8");
                freeMarkerConfigurer.setTemplateLoaderPath("/pmkpi/ftl");
                t = freeMarkerConfigurer.getConfiguration().getTemplate(templatecode + ".ftl");
            } else {
                configuration = new Configuration();
                configuration.setDefaultEncoding("UTF-8");
                String mbPath = this.getClass().getResource("/").getPath().split("WEB-INF")[0] + "pmkpi/ftl";
                logger.info("模板路径：" + mbPath);
                File fileDir = new File(mbPath);
                if (!fileDir.exists()) {
                    throw new AppException("0", "找不到模板文件目录，请重新上传模板或咨询管理员");
                }
                configuration.setDirectoryForTemplateLoading(fileDir);
                t = configuration.getTemplate(templatecode + ".ftl", "UTF-8");
            }
        } catch (Exception e) {
            logger.error("模板加载失败", e);
            throw new AppException("ERROR", "模板加载失败: " + e.getMessage());
        }
        // 防御性检查（理论不会触发）
        if (t == null) {
            throw new AppException("ERROR", "模板对象为空，加载失败");
        }
        // 3. 获取导出数据
        List<Map<String, Object>> datalistMap = this.getData(param, templateMap);
        if (datalistMap == null || datalistMap.isEmpty()) {
            logger.warn("无数据可导出，模板编码：" + templatecode);
            return resultMap; // 返回空 Map
        }
        // 4. 数据特殊字符转义
        for (Map<String, Object> data : datalistMap) {
            for (Iterator ite = data.keySet().iterator(); ite.hasNext(); ) {
                String key = ite.next().toString();
                Object obj = data.get(key);
                String val = "";
                boolean isList = false;
                if (null != obj) {
                    if (obj instanceof List) {
                        val = PerfUtil.parse2Json(obj);
                        isList = true;
                    } else {
                        val = obj.toString();
                    }
                    if (val.contains("<") || val.contains(">") || val.contains("&")
                            || val.contains("<br>") || val.contains("'") || val.contains("\"")
                            || val.contains("\r\n")) {
                        val = val.replaceAll("<br>", "");
                        val = val.replaceAll("&", "&amp;");
                        val = val.replaceAll("<", "&lt;");
                        val = val.replaceAll(">", "&gt;");
                        val = val.replaceAll("\r\n", "&#10;");
                        if (isList) {
                            data.put(key, PerfUtil.parseString2List(val));
                        } else {
                            val = val.replaceAll("\"", "&quot;");
                            val = val.replaceAll("'", "&apos;");
                            data.put(key, val);
                        }
                    }
                }
            }
        }
        // 5. 对每条数据生成文件字节数组
        for (Map<String, Object> dataMap : datalistMap) {
            String busguid = (String) dataMap.get("busguid");
            String filename = (String) dataMap.get("expfilename");
            // 若 filename 为空，使用默认值（避免 NullPointerException）
            if (filename == null || filename.isEmpty()) {
                filename = "union_" + System.currentTimeMillis();
                logger.warn("数据中 filename 为空，已自动生成默认值：" + filename);
            }
            try {
                byte[] fileBytes = getByteData(t, dataMap);
                resultMap.put(busguid + "@@" + filename, fileBytes);
                logger.info("生成文件成功，filename={}, 大小={} bytes", busguid, fileBytes.length);
            } catch (Exception e) {
                logger.error("生成文件异常，filename=" + busguid, e);
                throw new AppException("ERROR", "生成文件失败: busguid='" + busguid + "'" + e.getMessage());
            }
        }

        return resultMap;
    }

    private byte[] getByteData(Template t, Map<String, Object> dataMap) throws IOException, TemplateException {
        ByteArrayOutputStream bos = null;
        OutputStreamWriter osWriter = null;
        Writer writer = null;
        byte[] aaa = null;
        try {
            bos = new ByteArrayOutputStream();
            osWriter = new OutputStreamWriter(bos, "UTF-8");
            writer = new BufferedWriter(osWriter);
            t.process(dataMap, writer);
            aaa = bos.toByteArray();
        } catch (Exception e){
            logger.error(e.getMessage());
        } finally {
            if (osWriter != null) {
                osWriter.close();
            }
            if (writer != null) {
                writer.close();
            }
            if (bos != null) {
                bos.close();
            }
        }
        return aaa;
    }
    /**
     * 获取替换模板的业务数据.
     * @param param --
     * @param templateMap --导出模板信息
     * @return --
     * @throws PerfAppException --
     */
    private List<Map<String, Object>> getData(Map<String, Object> param, Map<String, Object> templateMap) throws PerfAppException {
        IExpDocABO busbo = (IExpDocABO) PerfServiceFactory.getBean((String) param.get("bobeanid"));
        if (busbo == null) {
            throw new PerfAppException("0", "导出报告组件业务BO不能为空！");
        }
        return busbo.genExpData(param, templateMap);
    }
    /**
     * @Description:获取服务安装地址（weblogic域根目录）
     * @return - 返回weblogic域根目录
     * @throws
     */
    public static String getServicePath() {
        return new File("").getAbsolutePath().replaceAll("\\\\", "/");
    }

}
