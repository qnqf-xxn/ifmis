package gov.mof.fasp2.pmkpi.evaluation.financial.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.util.FileUtil;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinancialQueryService extends PmkpiService {
    private FinancialQueryBO financialQueryBO;

    public void setFinancialQueryBO(FinancialQueryBO financialQueryBO) {
        this.financialQueryBO = financialQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("finqueryhide", FinancialQueryDAO.PERF_STRING_PROCONFIRM);
        return config;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return financialQueryBO.getTreeData(params);
    }

    /**
     * <p>批量导出评分表附件</p >
     * 可批量导出自评表各末级指标上传的附件，导出格式为项目支出每个项目一个文件夹、部门整体每个部门一个文件夹。
     *
     * @param
     * @author hw
     * @date 2021/12/29 16:26
     */
    public HttpServletResponse batchExp(HashMap config) throws Exception {
        HttpServletRequest request = this.getRequest();
        HttpServletResponse response = this.getResponse();
        InputStream fis = null;
        OutputStream toClient = null;
        try {
            HashMap resultMap = financialQueryBO.batchExp2(config);
            File zipFile = null;
            String tmpDir = null;
            if (resultMap != null && !resultMap.isEmpty()) {
                zipFile = (File) resultMap.get("zipFile");
                tmpDir = (String) resultMap.get("tmpDir");
            }
            fis = new FileInputStream(zipFile);

            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            response.reset();// 清空response
            String zipname = (String) config.get("zipname");
            String filename;
            if (!StringUtils.isEmpty(zipname)) {
                filename = zipname + ".zip";
            } else {
                filename = "附件_" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + ".zip";
            }
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("gb2312"), "iso8859-1"));
            toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            if (!StringUtils.isEmpty(tmpDir)) {
                FileUtil.delFolder(tmpDir);
            }
        } catch (IOException ex) {
            logger.error("---批量导出评分表附件异常：", ex.getMessage());
            ex.printStackTrace();
        } finally {
            if(fis != null){
                fis.close();
            }
            if(toClient != null){
                toClient.close();
            }
        }
        return response;
    }

}
