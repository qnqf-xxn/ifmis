package gov.mof.fasp2.pmkpi.deif;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

/**
 * @ClassName: DeifselectproService
 */

public class DeifselectproService extends PmkpiService {

    private DeifselectproBO deifselectproBO;

    public void setDeifselectproBO(DeifselectproBO deifselectproBO) {
        this.deifselectproBO = deifselectproBO;
    }


    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 导出json
     * @param config
     * @return
     * @throws Exception
     */
    public HttpServletResponse exportJsonData(HashMap config) throws Exception {
        HttpServletResponse response = this.getResponse();
        OutputStream outputStream = response.getOutputStream();
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ByteArrayInputStream byteArrayInputStream = null;
        InputStream inputStream = null;
        Reader jsonStreamReader = null;
        try {
            //获取导出配置
            Map<String, Map<String, Object>> expTabsInfo = deifselectproBO.getDeifselectproBO(config);
            config.put("expTabsInfo",expTabsInfo);
            //处理文件名和Header
            String expfilename = config.get("expfilename") + PerfUtil.getServerTimeStamp() + ".json";
            String fileName = URLEncoder.encode(expfilename, "UTF-8");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);
            File josinfile = deifselectproBO.expJsonDatas(expTabsInfo);
            if (josinfile.exists() && josinfile.length() != 0) {
                //文件转byte缓存，用于存储结果和导出文件
                inputStream = new FileInputStream(josinfile);
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    byteArrayOutputStream.write(buffer, 0, bytesRead);
                }
                byte[] byteArray = byteArrayOutputStream.toByteArray();
                byteArrayInputStream = new ByteArrayInputStream(byteArray);
                String charsetName = deifselectproBO.getJsonReadCharset();
                jsonStreamReader = new InputStreamReader(byteArrayInputStream, charsetName);
                //初始化并保存JsonResultDto
                deifselectproBO.saveJsonResult(initJsonResultDto(config),jsonStreamReader);
                byteArrayInputStream.reset();
                //写入文件导出
                String content = IOUtils.toString(byteArrayInputStream, charsetName);
                outputStream.write(content.getBytes(charsetName));
                outputStream.flush();
            }
        } catch (IOException ex) {
            logger.error("---导出异常：", ex.getMessage());
            ex.printStackTrace();
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
            if (jsonStreamReader != null) {
                jsonStreamReader.close();
            }
            if (byteArrayOutputStream != null) {
                byteArrayOutputStream.close();
            }
            if (byteArrayInputStream != null) {
                byteArrayInputStream.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return response;
    }

    /**
     * 初始化jsonResultDto
     * @param config
     * @return
     * @throws Exception
     */
    public FaspDTO initJsonResultDto (HashMap config) throws Exception {
        FaspDTO jsonResultDto = new FaspDTO();
        String bustype = (String) config.get("bustype");
        String appId = "pmkpi";
        String nowTime = CommonUtil.getTimeStamp();
        String batchNo = appId + nowTime;
        jsonResultDto.loadSysGuid();
        jsonResultDto.put("deifbatchno", batchNo);
        jsonResultDto.put("appid", appId);
        jsonResultDto.put("dd", config.get("dd"));
        jsonResultDto.put("bustype", bustype);
        jsonResultDto.put("createtype", 2); //1接口 2.页面导入
        jsonResultDto.put("createdate", nowTime.substring(0, 8));
        jsonResultDto.put("createtime", nowTime);
        jsonResultDto.put("usercode", CommonUtil.getCurrentUser().getCode());
        jsonResultDto.put("agency_code", "");
        jsonResultDto.put("status", "1"); //1成功，2数据校验失败，3审核定义失败
        Map<String, Map<String, Object>> expTabsInfo = (Map<String, Map<String, Object>>) config.get("expTabsInfo");
        Set<String> jsonTables = expTabsInfo.keySet();
        jsonResultDto.put("tables", StringUtils.join(jsonTables, ","));
        Set<String> jsonTableNames = new LinkedHashSet<>();
        for (String jsonTable : jsonTables) {
            jsonTableNames.add(deifselectproBO.getRegDicTableName(jsonTable));
        }
        jsonResultDto.put("tables_name", StringUtils.join(jsonTableNames, ","));
        return jsonResultDto;
    }

}
