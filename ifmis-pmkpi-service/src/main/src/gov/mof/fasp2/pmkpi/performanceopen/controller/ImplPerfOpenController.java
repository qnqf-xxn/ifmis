package gov.mof.fasp2.pmkpi.performanceopen.controller;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.performanceopen.report.PerfOpenBO;
import gov.mof.fasp2.pmkpi.performanceopen.report.PerfOpenDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;


@Controller
@RequestMapping("/pmkpi/performanceopen")
public class ImplPerfOpenController {
    @Resource(name = "pmkpi.performanceopen.PerfOpenBOTX")
    private PerfOpenBO perfOpenBO;
    @Resource(name = "pmkpi.performanceopen.PerfOpenDAO")
    private PerfOpenDAO perfOpenDAO;

    protected static Logger logger = Logger.getLogger(ImplPerfOpenController.class);

    /**
     * <p>导入绩效公开信息</p >
     *
     * @param
     * @author zxt
     * @date 2023/4/26 14:12
     */
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> fileUpload1(HttpServletRequest request, HttpServletResponse response) throws AppException {
        logger.info("---导入绩效公开信息-start ...");
        Map<String, Object> rs = new HashMap<String, Object>();
        MultipartHttpServletRequest multipartRequest = null;
        if (request instanceof MultipartHttpServletRequest) {
            multipartRequest = (MultipartHttpServletRequest) (request);
            Iterator<String> iter = multipartRequest.getFileNames();
//            String menuid = multipartRequest.getParameter("menuid");   // 菜单
            MultipartFile file = (MultipartFile) multipartRequest.getFile(iter.next()); // 获得文件：
//            String fileName = file.getOriginalFilename();
//            String[] nameSplit = fileName.split("\\.")[0].split("&");
            InputStream fis = null;
            Workbook wookbook = null;
            try {
                // 获取一个绝对地址的流
                fis = file.getInputStream();
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
                rs.put("error", true);
                rs.put("code", "解析文件流异常");
                return rs;
            }
            try {
                wookbook = new HSSFWorkbook(fis);// 得到工作簿 2003版本的excel，用.xls结尾
            } catch (Exception ex) {
                try {
                    fis = file.getInputStream(); // 这里需要重新获取流对象，因为前面的异常导致了流的关闭
                    wookbook = new XSSFWorkbook(fis);// 得到工作簿 2007版本的excel，用.xlsx结尾
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    logger.error(e.getMessage(), e);
                    rs.put("error", true);
                    rs.put("code", "解析工作簿异常");
                    return rs;
                }
            }
            Sheet sheet1 = wookbook.getSheetAt(0); // 获取第一个sheet
            int rows = sheet1.getPhysicalNumberOfRows(); // 忽略表头，从第一行开始
            List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
            for (int j = 1; j < rows; j++) {
                Row row = sheet1.getRow(j);
                String pro_code = "";
                String xmly = "";
                String perfopen = "";
                String isopen = "";
                String openamt = "";
                String openurl = "";
                String openreason = "";
                if (row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    pro_code = row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if (StringUtils.isEmpty(pro_code)) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行项目编码不能为空!");
                        return rs;
                    }
                }
                if (row.getCell(9, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(9, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    xmly = row.getCell(9, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if (StringUtils.isEmpty(xmly)) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行项目来源不能为空!");
                        return rs;
                    }
                }
                if (row.getCell(11, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(11, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    perfopen = row.getCell(11, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if (StringUtils.isEmpty(perfopen)) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行公开类型不能为空!");
                        return rs;
                    } else if(!("年初项目绩效目标".equals(perfopen) || "年中项目绩效目标".equals(perfopen) || "自评项目".equals(perfopen))){
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行公开类型填写错误!");
                        return rs;
                    } else if("年初项目绩效目标".equals(perfopen)){
                        perfopen = "01";
                    } else if("年中项目绩效目标".equals(perfopen)){
                        perfopen = "02";
                    } else if("自评项目".equals(perfopen)){
                        perfopen = "03";
                    }
                }
                if (row.getCell(12, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(12, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    isopen = row.getCell(12, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if (!StringUtils.isEmpty(isopen) && (!("是".equals(isopen) || "否".equals(isopen)))) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行是否公开填写格式为'是'或'否'!");
                        return rs;
                    } else if ("是".equals(isopen)){
                        isopen = "1";
                    } else if ("否".equals(isopen)){
                        isopen = "2";
                    }
                }
                if (row.getCell(13, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(13, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    openamt = row.getCell(13, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if (!StringUtils.isEmpty(openamt) && !openamt.matches("-?[0-9]+.?[0-9]*")) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行公开金额为数字类型!");
                        return rs;
                    }
                }
                if (row.getCell(14, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(14, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    openurl = row.getCell(14, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(15, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(15, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    openreason = row.getCell(15, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                // 判断条件不为空就放入集合
                if(!StringUtils.isEmpty(isopen) || !StringUtils.isEmpty(openamt)
                        || !StringUtils.isEmpty(openurl) || !StringUtils.isEmpty(openreason)){
                    String wheresql = " pro_code = ? and bustype = ? and xmly = ? ";
                    List<Map<String, Object>> list = perfOpenDAO.getDatas(PerfOpenDAO.PERF_VIEW_MANCEOPEN, wheresql, null , new String[]{pro_code, perfopen, xmly});
                    if (list.size() == 1) {
                        Map<String, Object> upmap = null;
                        List<Map<String, Object>> lists = perfOpenDAO.getDatas(PerfOpenDAO.PERF_TABLE_MANCEOPEN, wheresql, null , new String[]{pro_code, perfopen, xmly});
                        if (lists.size() == 1) {
                            upmap = lists.get(0);
                            upmap.put("isopen", isopen);
                            upmap.put("openamt", openamt);
                            upmap.put("openurl", openurl);
                            upmap.put("openreason", openreason);
                            upmap.put("updatetime", PerfUtil.getServerTimeStamp());
                            uplist.add(upmap);
                        } else if (lists.size() == 0) {
                            upmap = list.get(0);
                            upmap.put("guid", StringUtil.createUUID());
                            upmap.put("mainguid", upmap.get("projguid"));
                            upmap.put("agencyguid", upmap.get("agency_code"));
                            upmap.put("isopen", isopen);
                            upmap.put("openamt", openamt);
                            upmap.put("openurl", openurl);
                            upmap.put("openreason", openreason);
                            upmap.put("createtime", PerfUtil.getServerTimeStamp());
                            upmap.put("updatetime", PerfUtil.getServerTimeStamp());
                            upmap.put("creater", SecureUtil.getCurrentUser().getGuid());
                            upmap.put("province", SecureUtil.getUserSelectProvince());
                            upmap.put("year", CommonUtil.getYear());
                            upmap.put("wfid", "9CA7347F12AAA0A8AE02ABEA139D3A99");
                            upmap.put("is_deleted", "2");
                        }
                    } else if (list.size() > 1) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行项目在录入的公开类型内存在多个!");
                        return rs;
                    } else if (list.size() == 0) {
                        rs.put("error", true);
                        rs.put("code", "第" + j + "行项目在录入的公开类型内不存在!");
                        return rs;
                    }
                }

            }
            if(uplist.size() > 0){
                IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
                List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("PERF_T_MANCEOPEN");
                List diccolumn = new ArrayList<String>();
                String curcolumn = "";
                for (DicColumnDTO dicColumnDTO : dicColumnDTOs) {
                    curcolumn = (String) dicColumnDTO.get("dbcolumncode");
                    if ("PROVINCE".equals(curcolumn) || "YEAR".equals(curcolumn) || "PROSELECT".equals(curcolumn)) {
                        continue;
                    }
                    diccolumn.add(curcolumn);
                }
                perfOpenDAO.updateAllByPK(diccolumn, uplist,"guid",PerfOpenDAO.PERF_TABLE_MANCEOPEN);
            }
            if(addlist.size() > 0){
                perfOpenBO.workflow("create", "9CA7347F12AAA0A8AE02ABEA139D3A99", "", PerfOpenDAO.PERF_TABLE_MANCEOPEN, addlist);
            }
        }
        logger.info("---导入绩效公开信息-end ...");
        rs.put("success", true);
        rs.put("code", "完成导入！");
        return rs;

    }

}
