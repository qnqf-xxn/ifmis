package gov.mof.fasp2.pmkpi.hbtracereport.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.PathUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busfw.exportexcel.ExcelExportComponet;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.hbtracereport.query.HbtracereportQueryBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/pmkpi/trace/uploadreport")
public class HBTranceZIPExpdocService extends ExcelExportComponet {

    private final static Logger logger = Logger.getLogger(HBTranceZIPExpdocService.class);

    private static String BUSFUDSRESTBASEPATH_ID = "BUSFUDSRESTBASEPATH";

    String SERVERIP = "severip";

    String HTTPPORT = "httpport";

    String CONTEXTPATH = "contextpath";

    private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_IP = "FUDSSERVERHTTPIP";
    private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_PORT = "FUDSSERVERHTTPPORT";
    private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_CONTEXT = "FUDSSERVERHTTPCONTEXT";

    private HtmlFileUploadService htmlFileUploadService;

    public HtmlFileUploadService getHtmlFileUploadService() {
        if(htmlFileUploadService == null){
            htmlFileUploadService = (HtmlFileUploadService)ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        }
        return htmlFileUploadService;
    }


    @ResponseBody
    @RequestMapping(value = "hbzip", produces = {"text/html;charset=utf-8"})
    public void hbExportTraceZip(@RequestParam("guids") String guids,
                                 HttpServletResponse response) throws AppException, PerfAppException, IOException {
        HbtracereportQueryBO hbtracereportBO  = (HbtracereportQueryBO) PerfServiceFactory.getBean("pmkpi.hbtracereport.hbtracereportqueryBOTX");
        List<String> guidList = Arrays.asList(guids.split(","));
        String filebustype = "hbtracereportupload";
        String zipfilename = "监控报告_"+ PerfUtil.getServerTimeStamp()+".zip";
        response.addHeader("Content-Disposition",
                "attachment; filename=" + new String(zipfilename.getBytes("gbk"), "ISO-8859-1"));
        response.setContentType("application/octet-stream");
        ZipOutputStream zipOutputStream = null;
        OutputStream outputStream = response.getOutputStream();
        zipOutputStream = new ZipOutputStream(outputStream);
        zipOutputStream.setEncoding("GBK");
        String warpath = PathUtil.getWarPath();
        File doc = new File(warpath + "/fudstemp");
        if (!doc.exists()) {
            doc.mkdirs();
        }
        for (String guid : guidList) {
            List<Map<String,Object>> filenamelist = hbtracereportBO.getFileNameList(guid,filebustype);
            if(filenamelist.size()>0) {
                String agencycode = (String) filenamelist.get(0).get("code");
                String agencyname = (String) filenamelist.get(0).get("name");
                String fileurl = "/"+agencycode+"_"+agencyname+"_"+Calendar.getInstance().getTimeInMillis();
                for (Map map : filenamelist) {
                    String filename = (String) map.get("filename");
                    String fileguid = (String) map.get("fileguid");
                    /*File filepath = new File(warpath + "/fudstemp"+fileurl);
                    if (!filepath.exists()) {
                        filepath.mkdirs();
                    }*/
                    try {
                        /*String fudsdownbasepath = GlobalConfig.getConfigData(BUSFUDSRESTBASEPATH_ID, "/fuds");
                        String downloadUrl = getfudsAddress() + fudsdownbasepath + "/file/" + fileguid + "/download?tokenid="
                                + SecureUtil.getKey40();

                        URL url = new URL(downloadUrl);
                        HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
                        httpUrlConn.setDoOutput(true);
                        httpUrlConn.setDoInput(true);
                        httpUrlConn.setUseCaches(false);
                        httpUrlConn.setRequestMethod("GET");
                        httpUrlConn.connect();*/
                        /*this.getResponse().addHeader("Content-Disposition",
                                "attachment; filename=" + new String(filename.getBytes("gbk"), "ISO-8859-1"));
                        this.getResponse().setContentType("application/octet-stream");*/
                        //InputStream inputStream = httpUrlConn.getInputStream();
                        InputStream inputStream = getHtmlFileUploadService().downFileByRest(fileguid,filename);
                        /*String downname = filepath + "/" + fileguid + "_" + filename + "" + Calendar.getInstance().getTimeInMillis();
                        FileOutputStream fos = new FileOutputStream(downname);*/
                        ZipEntry zipEntry = new ZipEntry(fileurl+"/"+filename);
                        zipOutputStream.putNextEntry(zipEntry);
                        int i = 0;
                        byte[] b = new byte[1024];
                        i = inputStream.read(b);
                        while (i > 0) {
                            zipOutputStream.write(b, 0, i);
                            i = inputStream.read(b);
                        }
                        //zipOutputStream.write(b);
                        /*fos.flush();
                        fos.close();*/
                        // 释放资源
                    } catch (Exception e) {
                        throw new AppException(e);
                    }
                }
            }
        }
        zipOutputStream.flush();
        zipOutputStream.close();
    }
}
