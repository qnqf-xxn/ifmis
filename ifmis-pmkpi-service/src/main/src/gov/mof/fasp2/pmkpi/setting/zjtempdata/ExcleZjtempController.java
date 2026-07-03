package gov.mof.fasp2.pmkpi.setting.zjtempdata;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
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
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;


@Controller
@RequestMapping("/pmkpi/setting/exclezjtempcontroller")
public class ExcleZjtempController {
    @Resource(name = "pmkpi.setting.zjdataset.ZjTempDataBOTX")
    private ZjTempDataBO zjTempDataBO;
    @Resource(name = "pmkpi.setting.zjdataset.ZjTempDataDAO")
    private ZjTempDataDAO zjTempDataDAO;

    protected static Logger logger = Logger.getLogger(ExcleZjtempController.class);

    /**
     * <p>导入码表项目</p >
     *
     * @param
     * @author
     * @date 2021/9/10 11:12
     */
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> fileUpload1(HttpServletRequest request, HttpServletResponse response) throws AppException {
        logger.info("---导入项目码表结果-start ...");
        String ishubei = request.getParameter("is_hubei"); //判断是否是湖北参数
        String isZJ = PerfUtil.getSystemSet("isZJ");
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
            NumberFormat f =new DecimalFormat("00000");
            String guid = "";
            String name = "";//项目名称
            String agencyguid = "";
            String status  = "1";
            String version = "2";//导入数据
            String superid = "";
            String code = "";
            String levelno = "";
            String isleaf = "";
            String remark = "导入项目";
            String createtime = PerfUtil.getServerTimeStamp();
            String updatetime = createtime;
            String creater = SecureUtil.getCurrentUser().getGuid();
            String province = CommonUtil.getProvince();
            String year = CommonUtil.getYear();
            String proelement = "01"; //项目类型 01 项目支出 02 转移支付
            HashMap<String,String> one = new HashMap<>(); //存放一级项目
            for (int j = 1; j < rows; j++) {
                Row row = sheet1.getRow(j);
                guid = zjTempDataBO.getCreateguid();
                //获取单位或部门
                if (row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    agencyguid = row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                //获取项目
                if (row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    name = row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                //获取级次
                if (row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                    row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    levelno = row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    if ("1".equals(levelno) && !"1".equals(isZJ)){
                        one.put(agencyguid+"&"+name, guid);
                    }
                }
                if ("1".equals(isZJ)){
                    //获取项目编码
                    if (row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                        row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                        code = row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                        if ("1".equals(levelno)){
                            one.put(agencyguid+"&"+code, guid);
                        }
                    }
                    //获取父级项目编码
                    if (row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                        row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                        superid = row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                        if("1".equals(levelno)){
                            superid = "01";
                        }
                    }
                    //获取备注
                    if (row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                        row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                        remark = row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    }
                }else {
                    //获取父级项目
                    if (row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                        row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                        superid = row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    }
                    //获取备注
                    if (row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
                        row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                        remark = row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                    }
                }

                if ("1".equals(ishubei) && row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null){
                    row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
                    proelement = row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
                }
                if (StringUtils.isEmpty(name)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行项目名称不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(levelno)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行级次不能为空!");
                    return rs;
                }else if ("1".equals(isZJ) && StringUtils.isEmpty(code)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行项目编码不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(superid) && !"1".equals(levelno)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行父级项目不能为空!");
                    return rs;
                } else if (StringUtils.isEmpty(agencyguid)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行单位编码不能为空!");
                    return rs;
                } else if ("1".equals(ishubei) && StringUtils.isEmpty(proelement)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行项目类型不能为空!");
                    return rs;
                }else if("1".equals(ishubei) && !"01".equals(proelement) && !"02".equals(proelement)) {
                    rs.put("error", true);
                    rs.put("code", "第" + j + "行项目类型值错误,01:项目支出，02:转移支付!");
                    return rs;
                } else {  // 判断条件不为空就放入集合
                    Map<String, Object> qualityMap = new HashMap<String,Object>();
                    qualityMap.put("guid",guid);
                    qualityMap.put("year",year);
                    qualityMap.put("province",province);
                    qualityMap.put("createtime",createtime);
                    qualityMap.put("updatetime",updatetime);
                    qualityMap.put("creater",creater);
                    qualityMap.put("levelno",levelno);
                    qualityMap.put("name",name);
                    qualityMap.put("code",code);
                    qualityMap.put("superid",superid);
                    qualityMap.put("agencyguid",agencyguid);
                    qualityMap.put("dept",agencyguid.substring(0,3));
                    qualityMap.put("remark",remark);
                    qualityMap.put("status",status);
                    qualityMap.put("version",version);
                    qualityMap.put("proelement",proelement);
                    datas.add(qualityMap);
                }
            }
            //获取导入的项目编码
            Map<String,String> procodeMap = new HashMap<>();//存放项目编码.key:agency vulue: maxcode
            String key = "";
            int i = 1;
            int tempint = 0;
            String curcode = "";
            for (Map<String, Object> map : datas) {
                ++i;
                agencyguid = (String) map.get("agencyguid");
                levelno = (String) map.get("levelno");
                superid = (String) map.get("superid");
                proelement = (String) map.get("proelement");
                key = agencyguid+"&"+superid;
                //校验一二级关系
                if (!"1".equals(levelno) && !one.containsKey(key)){
                    rs.put("error", true);
                    rs.put("code", "第" + i + "行父级项目不存在!");
                    return rs;
                }
                if ("1".equals(levelno)){
                    if("1".equals(isZJ)){
                        map.put("superid", "01");
                        map.put("isleaf", "0");
                    }else {
                        map.put("superid", proelement);
                        map.put("isleaf", "0");
                    }
                } else {
                    map.put("isleaf", "1");
                    map.put("superid", one.get(key));
                }
                if (procodeMap.containsKey(agencyguid)){
                    tempint = Integer.parseInt(String.valueOf(procodeMap.get(agencyguid)));
                    tempint++;
                    curcode = String.format("%05d", tempint);
                    map.put("code", province+agencyguid+curcode);
                    map.put("ordernum", tempint);
                    procodeMap.put(agencyguid, curcode);
                } else {
                    curcode = zjTempDataDAO.getMaxCode(agencyguid);
                    if(!"1".equals(isZJ)){
                        map.put("code", province+agencyguid+curcode);
                        procodeMap.put(agencyguid, curcode);
                    }
                    map.put("ordernum", curcode.replaceFirst("^0*",""));

                }
            }
            if (datas != null && !datas.isEmpty()) {
                try {
                    zjTempDataDAO.saveAll(datas,"v_perf_t_indexcomfunc"); //追加不删除,页面删除
                }catch (AppException e){
                    logger.info("-----导入码表项目保存数据失败");
                    logger.info(e.getMessage());
                }
            } else {
                logger.info("---导入码表项目失败-");
                rs.put("error", true);
                rs.put("code", "导入工作簿异常！");
                return rs;
            }
        }
        logger.info("---导入码表项目-end ...");
        rs.put("success", true);
        rs.put("code", "完成导入！");
        return rs;
    }

}
