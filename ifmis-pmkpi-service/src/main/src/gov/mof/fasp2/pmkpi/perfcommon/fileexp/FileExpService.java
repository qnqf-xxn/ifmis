package gov.mof.fasp2.pmkpi.perfcommon.fileexp;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import org.apache.commons.io.IOUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class FileExpService extends PmkpiService {

	private FileExpBO fileExpBO;

    public void setFileExpBO(FileExpBO fileExpBO) {
        this.fileExpBO = fileExpBO;
    }

    /**
     * 批量导出指标和普通附件
     * 可批量导出指标完成情况表各末级指标上传的附件和附件页签上传的附件，导出文件夹格式为：
     * 第一层：[项目编码]单位名称-项目名称 监控附件 或  [部门编码]部门名称 监控附件
     * 第二层：二级指标名称-三级指标名称 ；如有附件页签还上传了附件，则自动生成一层“其他附件”，
     * 第三层：放第二层对应的附件
     * @param config
     * @return
     */
    public HttpServletResponse indexFileExp(HashMap config) throws Exception {
        boolean rcp = config.get("rcp") == null ? false: (boolean)config.get("rcp") ;
        if (rcp) {
            this.getConsole().setProcess(0.1);
            this.getConsole().println("当前进度: 正在获取下载文件");
        }
        HttpServletResponse response = this.getResponse();
        OutputStream outputStream = response.getOutputStream();
        InputStream inputStream = null;
        List<Map<String, Object>> resultList = fileExpBO.indexFileExp(config);
        String zipname = (String) config.get("zipname");
        String fileexptype = (String) config.get("fileexptype");
        String filename = "";
        if (!StringUtils.isEmpty(zipname)) {
            filename = zipname + ".zip";
        } else {
            if(fileexptype!=null && "trace".equals(fileexptype)){
                filename = "监控";
            }else if (fileexptype!=null && "self".equals(fileexptype)){
                filename = "自评";
            }else if (fileexptype!=null && "finevaluation".equals(fileexptype)){
                filename = "财政评价";
            }else if (fileexptype!=null && "deptevaluation".equals(fileexptype)){
                filename = "部门评价";
            }else if (fileexptype!=null && "appraisal".equals(fileexptype)){
                filename = "绩效考核";
            }else if (fileexptype!=null && "problemtaskfeedback".equals(fileexptype)){
                filename = "任务";
            }else if (fileexptype!=null && "deptperfevalTJ_file".equals(fileexptype)){
                filename = "部门绩效评价情况";
            }
            filename += "附件_" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + ".zip";
        }
        try {
            String fileName = URLEncoder.encode(filename, "UTF-8");
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);
            ZipOutputStream zipOutputStream = null;
            //压缩
            zipOutputStream = new ZipOutputStream(outputStream);
            zipOutputStream.setEncoding("GBK");
            for (int i = 0; i < resultList.size(); i++) {
                Map<String, Object> dataMap = resultList.get(i);
                List<Map<String, Object>> expList = (List<Map<String, Object>>) dataMap.get("fileList");
                for (Map<String, Object> expMap : expList) {
                    String name = (String) expMap.get("fileName");
                    inputStream = (InputStream) expMap.get("inputStream");
                    ZipEntry zipEntry = new ZipEntry(name);
                    zipOutputStream.putNextEntry(zipEntry);
                    if (inputStream != null) {
                        // zipOutputStream.write(IOUtils.toByteArray(inputStream));
                        int bytei = 0;
                        byte[] b = new byte[1024];
                        bytei = inputStream.read(b);
                        while (bytei > 0) {
                            zipOutputStream.write(b, 0, bytei);
                            bytei = inputStream.read(b);
                        }
                    }
                }
                if (rcp) {
                    this.getConsole().setProcess(1f);
                    this.getConsole().println("当前进度: 正在导出文件！");
                    TimeUnit.SECONDS.sleep(1);
                }
            }
            zipOutputStream.closeEntry();
            zipOutputStream.flush();
            zipOutputStream.close();
            outputStream.flush();
        } catch (IOException ex) {
            logger.error("---批量导出指标附件异常：", ex.getMessage());
            ex.printStackTrace();
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return response;
    }

}
