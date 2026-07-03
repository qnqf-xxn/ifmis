package gov.mof.fasp2.pmkpi.perfSupervision.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionBO;
import gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionDAO;
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
@RequestMapping("/pmkpi/supervisionController")
public class ExcleSupervisionController {
    @Resource(name = "pmkpi.perfSupervision.PerfSupervisionBOTX")
    private PerfSupervisionBO perfSupervisionBO;
    @Resource(name = "pmkpi.perfSupervision.PerfSupervisionDAO")
    private PerfSupervisionDAO perfSupervisionDAO;

    protected static Logger logger = Logger.getLogger(ExcleSupervisionController.class);

    /**
     * <p>导入监审结果</p >
     * 根据一二三级加上项目名称确定唯一后 更新监审意见和其它意见
     *
     * @param
     * @author hw
     * @date 2021/6/23 11:12
     */
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> fileUpload1(HttpServletRequest request, HttpServletResponse response) throws AppException {
        logger.info("---导入监审结果-start ...");
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
            List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
            for (int j = 1; j < rows; j++) {
                Row row = sheet1.getRow(j);
                String adjoption = ""; // 监审意见
                String options = ""; // 其它意见
                String proname = ""; // 项目名称
                String kpi_lv1 = ""; // 一级指标
                String kpi_lv2 = ""; // 二级指标
                String kpi_lv3 = ""; // 三级指标
                if (row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    adjoption = row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    options = row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    proname = row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    kpi_lv1 = row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    kpi_lv2 = row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    kpi_lv3 = row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (StringUtils.isEmpty(proname)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行项目名称不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(kpi_lv1)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行一级指标不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(kpi_lv2)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行二级指标不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(kpi_lv3)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行三级指标不能为空!");
                    return rs;
                } else {  // 判断条件不为空就放入集合
                    /**
                     if (!StringUtils.isEmpty(proname) && !StringUtils.isEmpty(kpi_lv1)
                     && !StringUtils.isEmpty(kpi_lv2) && !StringUtils.isEmpty(kpi_lv3))
                     */
                    String sql = "select * from v_Perf_t_Supervisionview where proname = \'" + proname + "\' and lv1_perf_ind_code = \'" + kpi_lv1 + "\' and lv2_perf_ind_code = \'" + kpi_lv2 + "\' and lv3_perf_ind_code = \'" + kpi_lv3 + "\'";
                    List<Map<String, Object>> list = perfSupervisionDAO.queryForList(sql);
                    if (list != null && !list.isEmpty()) {
                        Map<String, Object> qualityMap = list.get(0);
                        qualityMap.put("adjoption", getAdjoption(adjoption));
                        qualityMap.put("options", options);
                        qualityMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        datas.add(qualityMap);
                    }
                }

            }
            if (datas != null && !datas.isEmpty()) {
                perfSupervisionDAO.updateAllByPK(datas, "guid", "PERF_T_SUPERVISION");
            } else {
                logger.info("---导入监审结果-所有数据均不存在，更新失败 ...");
                rs.put("error", true);
                rs.put("code", "导入工作簿异常！");
                return rs;
            }
        }
        logger.info("---导入监审结果-end ...");
        rs.put("success", true);
        rs.put("code", "完成导入！");
        return rs;

    }

    /**
     * <p>获取监审意见代号</p >
     *
     * @param
     * @author hw
     * @date 2021/6/23 11:31
     */
    public String getAdjoption(String adjoption) {
        /**
         * 给监审意见重新赋值
         * case when t.ADJOPTION = '1' then '指标不够完整'
         *     when t.ADJOPTION = '2' then '指标不够细化、量化'
         *     when t.ADJOPTION = '3' then '指标与项目的相关性不够'
         *     when t.ADJOPTION = '4' then '指标与指标值不匹配'
         *     when t.ADJOPTION = '5' then '建议拆分指标'
         *     when t.ADJOPTION = '6' then '一级指标类型错误'
         *     when t.ADJOPTION = '7' then '二级指标类型错误'
         *     when t.ADJOPTION = '8' then '建议增加明确效益指标'
         *     when t.ADJOPTION = '9' then '建议增加明确产出指标'
         *     when t.ADJOPTION = '10' then '建议增加满意度指标'
         *     when t.ADJOPTION = '11' then '其他'
         */
        if ("指标不够完整".equals(adjoption)){
            adjoption = "1";
        } else if ("指标不够细化、量化".equals(adjoption)) {
            adjoption = "2";
        } else if ("指标与项目的相关性不够".equals(adjoption)) {
            adjoption = "3";
        } else if ("指标与指标值不匹配".equals(adjoption)) {
            adjoption = "4";
        } else if ("建议拆分指标".equals(adjoption)) {
            adjoption = "5";
        } else if ("一级指标类型错误".equals(adjoption)) {
            adjoption = "6";
        } else if ("二级指标类型错误".equals(adjoption)) {
            adjoption = "7";
        } else if ("建议增加明确效益指标".equals(adjoption)) {
            adjoption = "8";
        } else if ("建议增加明确产出指标".equals(adjoption)) {
            adjoption = "9";
        } else if ("建议增加满意度指标".equals(adjoption)) {
            adjoption = "10";
        } else if ("".equals(adjoption)) {
            adjoption = "";
        } else {
            adjoption = "11";
        }
        return adjoption;
    }

}
