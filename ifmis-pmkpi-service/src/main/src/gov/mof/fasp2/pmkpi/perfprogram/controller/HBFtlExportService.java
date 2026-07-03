package gov.mof.fasp2.pmkpi.perfprogram.controller;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.exportexcel.ExcelExportComponet;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.ExpDocDAO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.IExpDocABO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

@RestController
@RequestMapping("/pmkpi/export")
public class HBFtlExportService extends ExcelExportComponet {

    private final static Logger logger = Logger.getLogger(HBFtlExportService.class);

    @Autowired
    FreeMarkerConfigurer freeMarkerConfigurer;

    private Configuration configuration = null;


    /**os
     * 绩效指标保持
     */
    @ResponseBody
    @RequestMapping(value = "hbftl", produces = {"text/html;charset=utf-8"})
    public void hbExportFtl(@RequestParam List guids, @RequestParam("templatecode") String templatecode,
                            @RequestParam("bobeanid") String bobeanid, HttpServletResponse response) throws AppException , IOException{

        Map<String, Object> params = new HashMap<>();
        params.put("guids", guids);
        params.put("templatecode", templatecode);
        params.put("bobeanid", bobeanid);
        logger.debug("--------绩效目标导出templatecode"+templatecode+"--province"+SecureUtil.getUserSelectProvince()+"--year"+SecureUtil.getYear());
        // FW_T_UIEXPDOC表，模板编码
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
        params.put("subdata", subList);
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
                logger.debug("--------模板路径：" + mbPath);
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
        List<Map<String, Object>> datalistMap = getData(params, templateMap);
        String fileName = URLEncoder.encode(expfilename, "UTF-8");
        //HttpServletResponse response = this.getResponse();
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
                        if (null != obj){
                            if (obj instanceof List) {
                                val = PerfUtil.parse2Json(obj);
                                isList = true;
                            } else {
                                val = obj.toString();
                            }
                            if (val.contains("<") || val.contains(">") || val.contains("&") || val.contains("<br>") || val.contains("'") || val.contains("\"") || val.contains("\n")) {
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
                        ZipEntry zipEntry = new ZipEntry(expfilename);
                        zipOutputStream.putNextEntry(zipEntry);
                        zipOutputStream.write(getByteData(t, dataMap));
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
    }
    private byte[] getByteData(Template t, Map<String, Object> dataMap) throws IOException, TemplateException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        OutputStreamWriter osWriter = new OutputStreamWriter(bos, "UTF-8");
        Writer writer = new BufferedWriter(osWriter);
        t.process(dataMap, writer);
        byte[] aaa = bos.toByteArray();
        osWriter.close();
        writer.close();
        bos.close();
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
}
