package gov.mof.fasp2.pmkpi.perfcommon.impexp;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportDataDTO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.server.SecureXmlParser;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.appexception.DataSetAppException;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class ImpExpABO extends PmkpiBO implements IImpExpABO {
    private String PERF_TABLE_SUBTABLECOLS = "v_perf_t_impexpsub";

    private String PERF_TABLE_IMPTEMP = "v_perf_t_imptemp";

    /**
     * 处理上传文件
     */
    private Integer sucessCount;

    public Integer getSucessCount() {
        return sucessCount;
    }

    public void setSucessCount(int sucessCount) {
        this.sucessCount = sucessCount;
    }

    // 文件
    File file = null;

    public void setFile(File file) {
        this.file = file;
    }
    // 文件流
    InputStream inputStream;

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    @Override
    public List imp(File file, Map paras) throws Exception {
        String impexpcode = (String) paras.get("impexpcode");
        String beanid = (String) paras.get("beanid");
        if (impexpcode == null || impexpcode.isEmpty()) {
            throw new AppException("ERROR", "请进行模板配置");
        }
        if (beanid == null || beanid.isEmpty()) {
            throw new AppException("ERROR", "beanid不能为空");
        }
        IImpExpABO busImpExpABO = (IImpExpABO) ServiceFactory.getBean(beanid);
        paras.put("tablecols", busImpExpABO.beforeExpImpCols(paras));
        // 获取导入列信息
        List colList = genDataTableconfig(paras);
        //表名
        List<ImportDataDTO> resultList = new ArrayList<ImportDataDTO>();
        // 文件解析
        setFile(file);
        //将数据读取出来放到文件流中
        setInputStream(this.getInputStream(file));
        resultList = this.doParse(colList);
        // 数据翻译
        resultList = analyData(resultList, colList);
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        try {
            // 数据校验导入，回调方法
            if (resultList != null && resultList.size() > 0) {
                List<Map<String, Object>> impCols = (List<Map<String, Object>>) paras.get("uitablecolsconfig");
                StringBuffer error = null;
                ImportErrorDTO dto = null;
                String fileguid = "";
                List<Map<String, Object>> errorlist = new ArrayList<>();
                if (FileUploadService.fileguids.get() != null) {//框架导入功能
                    fileguid = FileUploadService.fileguids.get();
                } else {//绩效导入功能
                    fileguid = ImpExpAComponet.FILE_GUIDS.get();
                }
                for (ImportDataDTO impData : resultList) {
                    Integer linenum = (Integer) impData.get("linenum");
                    error = new StringBuffer();
                    for (Map<String, Object> col : impCols) {
                        //字段是否必填
                        if ("1".equals(col.get("redden"))) {
                            String value = (String) impData.get(col.get("columncode"));
                            String colname = (String) col.get("name");
                            if (StringUtil.isNullOrEmpty(value)) {
                                error.append(colname).append("不能为空。");
                            }
                        }
                    }
                    if (!StringUtil.isEmpty(error.toString())) {
                        dto = new ImportErrorDTO(fileguid, linenum, error.toString());
                        errordao.saveErrorMsg(dto);
                        errorlist.add(dto);
                    }
                }
                if (errorlist.size() > 0) {
                    throw new AppException("ANA-ERROR", "导入数据错误");
                }
                if (beanid != null) {
                    resultList = busImpExpABO.impData(resultList, paras);
                }
            }
        } catch (AppException e1) {
            e1.printStackTrace();
            Throwable cause = e1;
            while (cause.getCause() != null) {
                cause = cause.getCause();
            }
            String error = cause.getMessage();
            if (error != null && error.length() > 1000) {
                error = error.substring(0, 1000);
            }
            throw new AppException(e1.getCode(), cause.getMessage());
        } catch (Exception e) {
            throw e;
        } finally {
            if (errordao.haveUnsavedErrorMsg()) {
                errordao.saveUnsavedErrorMsg();
            }
        }
        return resultList;
    }

    @Override
    public List impreport(File file, Map paras) throws Exception {
        String impexpcode = (String) paras.get("impexpcode");
        String beanid = (String) paras.get("beanid");
        //是否存在列配置
        String iscol = (String) paras.get("iscol");
        //查询配置表信息
        List colList = null;
        if (impexpcode == null || impexpcode.isEmpty()) {
            throw new AppException("ERROR", "请进行模板配置");
        }
        if (beanid == null || beanid.isEmpty()) {
            throw new AppException("ERROR", "beanid不能为空");
        }
        // 文件解析
        setFile(file);
        //将数据读取出来放到文件流中
        setInputStream(this.getInputStream(file));
        //解析xml导入报告
        List list = readXml();
        IImpExpABO busImpExpABO = (IImpExpABO) ServiceFactory.getBean(beanid);
        // 数据校验导入，回调方法
        List<ImportDataDTO> resultList = new ArrayList<>();
        if (iscol != null && !iscol.isEmpty()) {
            // 获取导入列信息
            colList = genDataTableconfig(paras);
            if (colList == null || colList.size() <= 0) {
                throw new AppException("ERROR", "请配置导入列");
            }
            resultList = this.setImpData(list, paras);
        } else {
            colList = genDataReportconfig(paras);
            if (colList == null || colList.size() <= 0) {
                throw new AppException("ERROR", "请配置导入模板");
            }
            // 获得本行中单元格中的数据
            for (Object obj: list) {
                Map<Integer, Object> datas = (Map<Integer, Object>) obj;
                for (Integer key : datas.keySet()) {
                    List<String> dataList = (List<String>) datas.get(key);
                    for (int i = 0; i < dataList.size(); i++) {
                        String str = dataList.get(i);
                        if (!StringUtil.isEmpty(str) && str.indexOf("http://www.w3.org/TR/REC-html40") != -1) {
                            str = str.replaceAll("http://www.w3.org/TR/REC-html40", "");
                            dataList.remove(i);
                            dataList.add(i, str);
                        }
                    }
                }
            }
            resultList = list;
        }
        if (resultList.size() > 0) {
            if (iscol != null && !iscol.isEmpty()) {
                paras.put("list", list);
                // 数据翻译
                analyData(resultList, colList);
            }
            FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
            try {
                resultList = busImpExpABO.impData(resultList, paras);
            } catch (AppException e1) {
                e1.printStackTrace();
                Throwable cause = e1;
                while (cause.getCause() != null) {
                    cause = cause.getCause();
                }
                String error = cause.getMessage();
                if (error != null && error.length() > 1000) {
                    error = error.substring(0, 1000);
                }
                throw new AppException(e1.getCode(), cause.getMessage());
            } catch (Exception e) {
                throw e;
            } finally {
                if (errordao.haveUnsavedErrorMsg()) {
                    errordao.saveUnsavedErrorMsg();
                }
            }
        }
        return resultList;
    }

    @Override
    public List impData(List datas, Map paras) throws AppException {
        return null;
    }

    @Override
    public List parseFile(Map paras, String filename, InputStream is) throws AppException {
        IImpExpABO busImpExpABO = (IImpExpABO) paras.get("busImpExpABO");
        busImpExpABO.beforeParseFile(paras, filename, is);
        List datalist = new ArrayList();
        Map m = null;
        List uitablecolsconfig = genDataTableconfig(paras);
        // 找到要翻译的字段
        List columncodes = new ArrayList();
        List elementcodes = new ArrayList();

        String elementcode = null;
        String columncode = null;
        Map columncodemap = new HashMap();
        String head = null;
        int headmaxlength = 1;
        int n = 0;
        for (int i = 0; i < uitablecolsconfig.size(); i++) {
            m = (Map) uitablecolsconfig.get(i);
            elementcode = (String) m.get("elementcode");
            columncode = (String) m.get("columncode");
            if (elementcode != null) {
                columncodes.add(columncode);
                elementcodes.add(elementcode);
                columncodemap.put(columncode, columncode);
            }
            head = (String) m.get("head");
            if (head != null) {
                n = head.split(",").length + 1;
                if (n > headmaxlength) {
                    headmaxlength = n;
                }
            }
        }
        paras.put("columncodes", columncodes);
        paras.put("elementcodes", elementcodes);

        boolean istrans = false;
        // 解析Excel
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(is);
            HSSFSheet sheet = workbook.getSheetAt(0);
            HSSFCell cell = null;
            Object value = null;
            PerfDTO dto = null;
            for (int i = headmaxlength; i < sheet.getLastRowNum() + 1; i++) {// getLastRowNum，获取最后一行的行标
                HSSFRow row = sheet.getRow(i);
                if (row == null) {
                    break;
                } else {
                    dto = new PerfDTO();
                    datalist.add(dto);
                    for (int j = 0; j < uitablecolsconfig.size(); j++) {// getLastCellNum，是获取最后一个不为空的列是第几个
                        m = (Map) uitablecolsconfig.get(j);
                        cell = row.getCell(j);
                        columncode = (String) m.get("columncode");
                        if (columncodemap.containsKey(columncode)) {
                            istrans = true;
                        } else {
                            istrans = false;
                        }
                        if (busImpExpABO.isBusGetCellValue()) {
                            value = busImpExpABO.getCellValue(paras, m, cell, columncode, istrans);
                        } else {
                            value = this.getCellValue(paras, m, cell, columncode, istrans);
                        }
                        dto.put(columncode, value);
                    }
                }
            }

        } catch (IOException e) {
            throw new AppException(e);
        }
        return datalist;
    }

    private List genDataTableconfig(Map paras) throws AppException {
        String impexpcode = (String) paras.get("impexpcode");
        if (impexpcode == null || impexpcode.isEmpty()) {
            return null;
        }
        String wheresql = " mainguid = '" + impexpcode + "'";
        List list = this.getDatas(PERF_TABLE_SUBTABLECOLS, wheresql, " order by ordernum");
        List tablecols = (List) paras.get("tablecols");
        if (tablecols != null && tablecols.size() > 0) {
            list.addAll(tablecols);
        }
        paras.put("uitablecolsconfig", list);
        return list;
    }

    private List genDataReportconfig(Map paras) throws AppException {
        String impexpcode = (String) paras.get("impexpcode");
        if (impexpcode == null || impexpcode.isEmpty()) {
            return null;
        }
        String wheresql = " temptype = '" + impexpcode + "'";
        List list = this.getDatas(PERF_TABLE_IMPTEMP, wheresql, " order by num");
        paras.put("reporttablecolsconfig", list);
        return list;
    }


    @Override
    public List beforeParseFile(Map paras, String filename, InputStream is) throws AppException {
        return null;
    }

    @Override
    public Object getCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans)
            throws AppException {
        Object value = null;
        if (cell == null) {
            value = "";
        } else if (cell.getCellType() == CellType.BOOLEAN) {
            value = cell.getBooleanCellValue();
        } else if (cell.getCellType() == CellType.NUMERIC) {
            if(HSSFDateUtil.isCellDateFormatted(cell)){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                value = sdf.format(cell.getDateCellValue());
            }else{
                cell.setCellType(CellType.STRING);
                value = new BigDecimal(cell.getStringCellValue());
            }
        } else {
            value = cell.getStringCellValue();
        }
        String coltype = ""+colconfig.get("type");
        if(value instanceof String){
            if("amt".equals(coltype)||"n".equals(coltype)||"f".equals(coltype)||"i".equals(coltype)||"p".equals(coltype)){
                String sv = (String)value;
                value = sv.trim().replaceAll(",", "");
            }
        }
        return value;
    }

    @Override
    public List busImpDatas(Map paras, String filename, List<? extends Map> datalist) throws AppException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Map busImpConfirmDatasSave(Map paras, ArrayList datalist) throws AppException {
        String busbo = (String) paras.get("busbo");
        if (busbo == null) {
            throw new AppException("0", "导入组件业务BO不能为空！");
        }
        IImpExpABO busImpExpABO = (IImpExpABO) ServiceFactory.getBean(busbo);
        return busImpExpABO.busImpConfirmDatasSave(paras, datalist);
    }

    @Override
    public boolean isBusGetCellValue() {
        return false;
    }

    public int genExpHead(List uitablecolsconfig, HSSFWorkbook workbook, HSSFSheet sheet) {
        List cols = new ArrayList();
        Map m = null;
        for (int i = 0; i < uitablecolsconfig.size(); i++) {
            m = new HashMap();
            m.putAll((Map) uitablecolsconfig.get(i));
            cols.add(m);
        }
        boolean ismorehead = false;
        int maxmoreheadrow = 0;// 多表头最大层数
        Map colmap = null;
        Object colwidth = null;
        String head = null;
        String[] heads = null;
        for (int i = 0, l = cols.size(); i < l; i++) {
            colmap = (Map) cols.get(i);
            colwidth = colmap.get("colwidth");
            if (colwidth == null || "0".equals("" + colwidth)) {
                colmap.put("colwidth", 100);
            }
            head = (String) colmap.get("head");
            if (head != null) {
                ismorehead = true;// 多表头
                heads = head.split(",");
                colmap.put("headobj", heads);
                if (heads.length > maxmoreheadrow) {
                    maxmoreheadrow = heads.length;
                }
            }
        }
        Map tm = null;
        List cols2 = new ArrayList();
        List cols1 = null;
        List cols0 = null;
        int colspan = 0;
        int rowspan = 0;
        if (ismorehead) {// 形成多表头二维数组

            for(int j=0;j<cols.size();j++){
                colmap = (Map) cols.get(j);
                heads = (String[]) colmap.get("headobj");
                if(heads!=null&&heads.length<maxmoreheadrow){
                    List<String> newheadobj = new ArrayList<String>();
                    for(int i1=0;i1<heads.length;i1++){
                        newheadobj.add(heads[i1]);
                    }
                    for(int i1=0;i1<maxmoreheadrow-heads.length;i1++){
                        newheadobj.add((String)colmap.get("name"));
                    }
                    heads = (String[])newheadobj.toArray(heads);
                    colmap.put("headobj", heads);
                }
            }

            for (int i = 0; i <= maxmoreheadrow; i++) {
                cols1 = new ArrayList();
                if (i == 0) {
                    cols0 = cols1;
                } else {
                    cols2.add(cols1);
                }
                for (int j = 0; j < cols.size(); j++) {
                    colmap = (Map) cols.get(j);
                    if (colmap.get("headobj") != null && i != 0) {
                        heads = (String[]) colmap.get("headobj");
                        if (heads.length >= i) {
                            tm = new HashMap();
                            tm.put("colspan", 1);
                            tm.put("rowspan", 1);
                            tm.put("rowlevelno", maxmoreheadrow-(heads.length-(i-1)));
                            tm.put("colwidth", colmap.get("colwidth"));
                            tm.put("name", heads[i - 1]);
                            tm.put("isdraw", false);
                            tm.put("iscol", false);
                            cols1.add(tm);
                        } else {
                            tm = new HashMap();
                            tm.put("colspan", 1);
                            tm.put("rowspan", 1);
                            tm.put("rowlevelno", maxmoreheadrow-(heads.length-(heads.length-1)));
                            tm.put("colwidth", colmap.get("colwidth"));
                            tm.put("name", heads[heads.length - 1]);
                            tm.put("isdraw", false);
                            tm.put("iscol", false);
                            cols1.add(tm);
                        }
                    } else {
                        tm = new HashMap();
                        tm.put("colspan", 1);
                        tm.put("rowspan", 1);
                        tm.put("colwidth", colmap.get("colwidth"));
                        tm.put("name", colmap.get("name"));
                        tm.put("rowlevelno", 0);
                        tm.put("isdraw", false);
                        tm.put("iscol", true);
                        cols1.add(tm);
                    }
                }
            }
            cols2.add(cols0);
            // 根据名称判断 合并
            List col1 = null;
            Map colmap1 = null;
            for (int i = 0; i < cols2.size(); i++) {
                col1 = (List) cols2.get(i);
                for (int j = 0; j < col1.size(); j++) {
                    colmap = (Map) col1.get(j);
                    if (colmap.get("isset") != null) {// 设置过了
                        continue;
                    }
                    // 列合并
                    colmap.put("isset", true);
                    colmap.put("isdraw", true);
                    int coln=0;
                    for (int k = j + 1; k < col1.size(); k++) {
                        colmap1 = (Map) col1.get(k);
                        if (("" + colmap1.get("name")).equals(""+colmap.get("name"))&&("" + colmap1.get("rowlevelno")).equals(""+colmap.get("rowlevelno"))) {
                            colspan = Integer.parseInt(("" + colmap.get("colspan")));
                            colspan++;
                            colmap.put("colspan", colspan);
                            colmap1.put("isset", true);
                            coln++;
                        } else {
                            break;
                        }
                    }
                    // 行合并
                    for (int k = i + 1; k < cols2.size(); k++) {
                        colmap1 = (Map) ((List) cols2.get(k)).get(j);
                        colmap = (Map) col1.get(j);
                        if (("" + colmap1.get("name")).equals(colmap.get("name"))) {
                            rowspan = Integer.parseInt(("" + colmap.get("rowspan")));
                            rowspan++;
                            colmap.put("rowspan", rowspan);
                            colmap1.put("isset", true);
                            colmap.put("iscol", colmap1.get("iscol"));
                            if(coln>0){
                                for(int c=1;c<=coln;c++){
                                    Map colmap2 = (Map) ((List) cols2.get(k)).get(j+c);
                                    colmap2.put("isset", true);
                                }
                            }
                        } else {
                            break;
                        }
                    }
                }
            }
        } else {// 非多表头
            cols1 = new ArrayList();
            cols2.add(cols1);
            for (int i = 0; i < cols.size(); i++) {
                colmap = (Map) cols.get(i);
                tm = new HashMap();
                tm.put("colspan", 1);
                tm.put("rowspan", 1);
                tm.put("colwidth", colmap.get("colwidth"));
                tm.put("name", colmap.get("name"));
                tm.put("isdraw", true);
                tm.put("iscol", true);
                cols1.add(tm);
            }
        }

        HSSFRow row = null;
        HSSFCell cell = null;
        Object colwidthobj = null;

        // 1. 获取基础样式（只作为模板，不直接使用）
        HSSFCellStyle baseStyle = getCellStyleHead(workbook);

        // 2. 创建红色字体样式
        HSSFCellStyle redStyle = workbook.createCellStyle();
        redStyle.cloneStyleFrom(baseStyle);          // 复制基础样式的所有属性
        HSSFFont redFont = workbook.createFont();
        redFont.setBold(true);
        redFont.setColor(IndexedColors.RED.getIndex());
        redStyle.setFont(redFont);
        redStyle.setWrapText(true);  // 开启自动换行

        // 3. 创建黑色字体样式
        HSSFCellStyle blackStyle = workbook.createCellStyle();
        blackStyle.cloneStyleFrom(baseStyle);
        HSSFFont blackFont = workbook.createFont();
        blackFont.setBold(true);
        blackFont.setColor(IndexedColors.BLACK.getIndex());
        blackStyle.setFont(blackFont);
        blackStyle.setWrapText(true);  // 开启自动换行

        // 4. 在循环中直接选用样式
        for (int i = 0; i < maxmoreheadrow + 1; i++) {
            row = sheet.createRow(i);
            for (int j = 0; j < cols.size(); j++) {
                Map col = (Map) cols.get(j);
                cell = row.createCell(j);
                if ("1".equals(col.get("redden"))) {
                    cell.setCellStyle(redStyle);
                } else {
                    cell.setCellStyle(blackStyle);
                }
            }
        }

        int colwidthint = 0;
        for (int j = 0; j < cols.size(); j++) {
            m = (Map) cols.get(j);
            colwidthobj = m.get("colwidth");
            colwidthint = Integer.parseInt("" + colwidthobj);
            sheet.setColumnWidth(j, (int) (256 * colwidthint / 6.8));
        }
        for (int i = 0; i < cols2.size(); i++) {
            row = sheet.getRow(i);
            cols1 = (List) cols2.get(i);
            for (int j = 0, l = cols1.size(); j < l; j++) {
                colmap = (Map) cols1.get(j);
                if (colmap.get("isdraw") == null || "false".equals("" + colmap.get("isdraw"))) {
                    continue;
                }
                cell = row.getCell(j);
                colspan = Integer.parseInt("" + colmap.get("colspan"));
                rowspan = Integer.parseInt("" + colmap.get("rowspan"));
                cell.setCellValue("" + colmap.get("name"));
                if (colspan != 1 || rowspan != 1) {
                    CellRangeAddress cra = new CellRangeAddress(i, i + rowspan - 1, j, j + colspan - 1); // 起始行, 终止行,
                                                                                                         // 起始列, 终止列
                    sheet.addMergedRegion(cra);
                }
            }
        }
        // 导出空模版
        // 将下拉框数据放到新的sheet里，然后excle通过新的sheet数据加载下拉框数据
        Sheet hidden = workbook.createSheet("hidden");
        IDataSetService dataSetService = (IDataSetService) ServiceFactory.getBean("bus.dic.dataset.service");
        for (int i = 0; i < uitablecolsconfig.size(); i++) {
            //将此列设置为字符串类型
            setColumnTypeString(workbook,sheet,i);
            Map<String, Object> importcolDTO = (Map<String, Object>) uitablecolsconfig.get(i);
            String csid = (String) importcolDTO.get("csid");
            if (!StringUtil.isNullOrEmpty(csid)) {
                // 检查是否配置导入模版是否需要生成结果集下拉框
//                if (!StringUtil.isNullOrEmpty(importcolDTO.get("importds"))) {
                    try {
                        List<DicRangeDTO> dicRangeDtos = null;
                        // 是否通过cfg方式获取结果集
                        if (StringUtil.isNullOrEmpty(importcolDTO.get("importdscfg"))) {
                            dicRangeDtos = dataSetService.getRangesByDsGuid(csid);
                        } else {
                            DataSetDTO dataSetDto = dataSetService.getDataSetByGuid(csid);
                            dicRangeDtos = dataSetService.getAllRangesByWhereSql(dataSetDto.getElementcode(),
                                    importcolDTO.get("importdscfg").toString());
                        }
                        // 创建单元格对象
                        Cell xcell = null;
                        // 遍历我们上面的数组，将数据取出来放到新sheet的单元格中
                        for (int u = 0; u < dicRangeDtos.size(); u++) {
                            String dicData = dicRangeDtos.get(u).getCode() + "-" + dicRangeDtos.get(u).getName();
                            // 取出数组中的每个元素
                            String name = dicData;
                            // 根据i创建相应的列对象（说明我们将会把每个元素单独放一列）
                            Row xrow = null;
                            if (hidden.getRow(u) == null) {
                                xrow = hidden.createRow(u);
                            } else {
                                xrow = hidden.getRow(u);
                            }
                            // 创建每一行中的第一个单元格
                            xcell = xrow.createCell(i);
                            // 然后将数组中的元素赋值给这个单元格
                            xcell.setCellValue(name);
                        }
                        // 创建名称，可被其他单元格引用
                        Name namedCell = workbook.createName();
                        namedCell.setNameName("hidden" + i);
                        // 设置名称引用的公式
                        // 比如productNameArray.length为10 也就是 选取行为A列为1 到 行为A列为10 的数据（也就取到了10个单元格的数据）
                        // 比如"hidden!$A$1:$B$10"也就是 选取行为A列为1 到 行为B列为10 的数据 （也就是选取到了20个单元格的数据）
                        namedCell.setRefersToFormula("hidden!$" + intToAlphabet(i) + "$1:$" + intToAlphabet(i) + "$"
                                + (dicRangeDtos.size() + 1));
//						namedCell.setRefersToFormula("hidden!$"+i+"$1:$"+i+"$" + (dicRangeDtos.size()));
                        // 加载数据,将名称为hidden的sheet中的数据转换为List形式
                        DVConstraint constraint = DVConstraint.createFormulaListConstraint("hidden" + i);

                        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
                        CellRangeAddressList regions = new CellRangeAddressList(1, 65500, i, i);
                        // 将设置下拉选的位置和数据的对应关系 绑定到一起
                        DataValidation dataValidation = new HSSFDataValidation(regions, constraint);

                        // 将第二个sheet设置为隐藏
                        workbook.setSheetHidden(1, true);
                        // 将数据赋给下拉列表
                        sheet.addValidationData(dataValidation);
                    } catch (DataSetAppException e) {
                        logger.error("获取csid=" + csid + "的数据集出错报错");
                        logger.error(e.getMessage(), e);
                    } catch (AppException e) {
                        logger.error("获取csid=" + csid + "的数据集出错报错");
                        logger.error(e.getMessage(), e);
                    }
//                }
            }
        }
        return maxmoreheadrow + 1;
    }

    @Override
    public void beforeExpImpModel(Map paras, HttpServletRequest request, HttpServletResponse response)
            throws AppException {
        // TODO Auto-generated method stub
    }

    @Override
    public List beforeExpImpCols(Map paras) throws AppException {
        return null;
    }

    /**
     * 处理xml导入数据
     * @param list
     * @param paras
     * @return
     * @throws AppException
     */
    public List setImpData(List list, Map paras) throws AppException {
        if (list.size() <= 0) {
            return null;
        }
        List cols = (List) paras.get("uitablecolsconfig");
        //计算有几行表头
        int heads = this.getTableHeadNum(cols);
        List<ImportDataDTO> result = new ArrayList<ImportDataDTO>();
        Map datas = (Map) list.get(0);
        // 逐行读取数据
        for (int rowIndex = (heads+1); rowIndex <= datas.size(); rowIndex++) {
            // 获得行对象
            int number = 0;//计数器
            List<String> data = (List<String>) datas.get(rowIndex);
            if (data != null && data.size() > 0) {
                // 获得本行中单元格的个数
                int columnCount = data.size();
                String[] lineArray = new String[cols.size()];
                // 获得本行中单元格中的数据
                for (int columnindex = 0; columnindex < columnCount; columnindex++) {
                    String str = data.get(columnindex);
                    if (!StringUtil.isEmpty(str)) {
                        str = str.replace("http://www.w3.org/TR/REC-html40", "");
                    }
                    // 获得指定单元格中的数据
                    if ("@@@".equals(str)){
                        str = null;
                    }
                    lineArray[columnindex] = str;
                }
                for(int i = 0;i < lineArray.length;i++){
                    if(lineArray[i]==null){
                        number = number+1;
                    }
                }
                //空行跳过
                if(number==lineArray.length){
                    continue;
                }
                //把每列数据对应到相应的导入列上
                ImportDataDTO maprow = this.getRowData(lineArray, cols, rowIndex - heads);
                result.add(maprow);
            }
        }
        return result;
    }

    @Override
    public boolean expImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {
        String beanid = (String) paras.get("beanid");
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("导出数据");
        IImpExpABO busImpExpABO = null;
        if (beanid != null) {
            busImpExpABO = (IImpExpABO) ServiceFactory.getBean(beanid);
            if (busImpExpABO.expImpModel(paras, request, response)) {
                return true;
            }
            busImpExpABO.beforeExpImpModel(paras, request, response);
            paras.put("tablecols", busImpExpABO.beforeExpImpCols(paras));
        }
        List uitablecolsconfig = genDataTableconfig(paras);

        if (busImpExpABO != null) {
            paras.put("uitablecolsconfig", uitablecolsconfig);
            List datalist = busImpExpABO.busExpDatas(paras);
            if (datalist != null && datalist.size() > 0) {
                List columncodes = new ArrayList();
                List elementcodes = new ArrayList();
                Map columncodemap = new HashMap();
                int headnum = 1;
                for (int i = 0; i < uitablecolsconfig.size(); i++) {
                    Map m = (Map) uitablecolsconfig.get(i);
                    String elementcode = (String) m.get("csid");
                    String columncode = (String) m.get("columncode");
                    String importdscfg = (String) m.get("importdscfg");
                    if (elementcode != null) {
                        columncodes.add(columncode);
                        elementcodes.add(elementcode);
                        List<Map<String, Object>> sourceList = PerfUtil.getSourceData(elementcode, importdscfg);
                        Map map = new HashMap();
                        sourceList.forEach(source->{
                            map.put(source.get("guid"), source);
                        });
                        columncodemap.put(columncode, map);
                    }
                    String head = (String) m.get("head");
                    if (!StringUtil.isNullOrEmpty(head)) {
                        int len = head.split(",").length + 1;
                        if (headnum < len) {
                            headnum = len;
                        }
                    }
                }
                paras.put("columncodes", columncodes);
                paras.put("elementcodes", elementcodes);
                if (datalist != null && datalist.size() != 0) {
                    HSSFRow row;
                    HSSFCell cell;
                    Map trandata = null;
                    Map col = null;
                    Map cellstylemap = this.getCellStyleMap(workbook);
                    boolean istrans = true;
                    Map rowdata = null;
                    for (int i = 0; i < datalist.size(); i++) {
                        rowdata = (Map)datalist.get(i);
                        rowdata.put("_linenumber", (i+1));
                        row = sheet.createRow(headnum + i);
                        for (int j = 0; j < uitablecolsconfig.size(); j++) {
                            col = (Map) uitablecolsconfig.get(j);
                            String columncode = (String) col.get("columncode");
                            trandata = new HashMap();
                            if (columncodemap.containsKey(columncode)) {
                                istrans = true;
                                trandata.put(columncode, columncodemap.get(columncode));
                            } else {
                                istrans = false;
                            }
                            cell = row.createCell(j);
                            if(!busImpExpABO.setCellValue(paras, col, cell, columncode, istrans,rowdata, trandata, cellstylemap)){
                                this.setCellValue(paras, col, cell, columncode, istrans,rowdata, trandata, cellstylemap);
                            }
                        }
                    }
                }
            }
        }
        this.genExpHead(uitablecolsconfig, workbook, sheet);
        String expfilename = (String) paras.get("expfilename");
        if (expfilename == null) {
            expfilename = "导出模板" + PerfUtil.getServerTimeStamp() + ".xls";
        } else {
            expfilename = expfilename.replace("@sysdate@", PerfUtil.getServerTimeStamp());
        }
        OutputStream out = null;
        try {
            String fileName = URLEncoder.encode(expfilename, "UTF-8");
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);
            out = response.getOutputStream();
            workbook.write(out);
        } catch (IOException e) {
            throw new AppException(e);
        } finally {
            try {
                if (out != null) {
                    out.flush();
                    out.close();
                }
                if(workbook != null){
                    workbook.close();
                }
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            }

        }

        return false;
    }

    public HSSFCellStyle getCellStyleHead(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyleHead = getCellStyle_text(workbook);
        cellStyleHead.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        cellStyleHead.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        cellStyleHead.setAlignment(HorizontalAlignment.CENTER);// 左右居中
        cellStyleHead.setVerticalAlignment(VerticalAlignment.CENTER);// 上下居中
        return cellStyleHead;
    }

    @Override
    public List busExpDatas(Map paras) throws AppException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Map transExpDatas(Map paras, List<? extends Map> datalist) throws AppException {
        return null;
    }

    @Override
    public boolean setCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans,
            Map rowdata,Map trandata,Map cellstylemap) throws AppException {
        String type = (String) colconfig.get("type");
        Object value = rowdata.get(columncode);
        if(istrans&&value!=null){
            String guid = value.toString();
            Map trancodemap = (Map)trandata.get(columncode);
            if(trancodemap!=null){
                Map valuemap = (Map)trancodemap.get(guid);
                if(valuemap!=null){
                    String format = (String)colconfig.get("format");
                    if(format==null){
                        value = valuemap.get("code")+"-"+valuemap.get("name");
                    }else{
                        value = format.replaceAll("#code", ""+valuemap.get("code"))
                                .replaceAll("#name", ""+valuemap.get("name"))
                                .replaceAll("#wholename", ""+valuemap.get("name"));
                    }
                }
            }
        }

        HSSFCellStyle cellStyle_text = (HSSFCellStyle)cellstylemap.get("cellStyle_text");
        HSSFCellStyle cellStyle_text_right = (HSSFCellStyle)cellstylemap.get("cellStyle_text_right");
        HSSFCellStyle cellStyle_text_center = (HSSFCellStyle)cellstylemap.get("cellStyle_text_center");
        HSSFCellStyle cellStyle_amt = (HSSFCellStyle)cellstylemap.get("cellStyle_amt");
        HSSFCellStyle cellStyle_number = (HSSFCellStyle)cellstylemap.get("cellStyle_number");
        HSSFCellStyle cellStyle_p = (HSSFCellStyle)cellstylemap.get("cellStyle_p");
        HSSFCellStyle cellStyle_date = (HSSFCellStyle)cellstylemap.get("cellStyle_date");
        if ("s".equals(type)) {
            cell.setCellStyle(cellStyle_text);
            String align = (String)colconfig.get("align");
            if(align!=null){
                if("right".equals(align)){
                    cell.setCellStyle(cellStyle_text_right);
                }else if("center".equals(align)){
                    cell.setCellStyle(cellStyle_text_center);
                }
            }
            if (value != null) {
                cell.setCellValue(value.toString());
            }
        } else if ("amt".equals(type)) {
            cell.setCellStyle(cellStyle_amt);
            if (value != null) {
                try {
                    cell.setCellValue(Double.parseDouble(value.toString().replaceAll(",", "")));
                } catch (NumberFormatException e) {
                    cell.setCellValue(value.toString());
                    cell.setCellStyle(cellStyle_text);
                }
            }
        } else if ("n".equals(type) || "f".equals(type) || "i".equals(type)) {
            cell.setCellStyle(cellStyle_number);
            if (value != null) {
                try {
                    cell.setCellValue(Double.parseDouble(value.toString()));
                } catch (NumberFormatException e) {
                    cell.setCellValue(value.toString());
                    cell.setCellStyle(cellStyle_text);
                }
            }
        } else if ("p".equals(type)) {
            cell.setCellStyle(cellStyle_p);
            if (value != null) {
                try {
                    cell.setCellValue(Double.parseDouble(value.toString()));
                } catch (NumberFormatException e) {
                    cell.setCellValue(value.toString());
                    cell.setCellStyle(cellStyle_text_right);
                }
            }
        } else if ("date".equals(type)) {
            if (value != null) {
                if (value instanceof Date) {
                    cell.setCellValue((Date) value);
                    cell.setCellStyle(cellStyle_date);
                }
                if (value instanceof String) {
                    try {
                        if (((String) value).length() == 17) {
                            cell.setCellStyle(cellStyle_date);
                            String tmstp = (String) value;
                            Calendar rightNow = Calendar.getInstance();
                            rightNow.set(Integer.parseInt(tmstp.substring(0, 4)),
                                    Integer.parseInt(tmstp.substring(4, 6)) - 1,
                                    Integer.parseInt(tmstp.substring(6, 8)), Integer.parseInt(tmstp.substring(8, 10)),
                                    Integer.parseInt(tmstp.substring(10, 12)),
                                    Integer.parseInt(tmstp.substring(12, 14)));
                            rightNow.set(Calendar.MILLISECOND, Integer.parseInt(tmstp.substring(14, 17)));
                            cell.setCellValue(rightNow.getTime());
                        } else if (((String) value).length() == 8) {
                            cell.setCellStyle(cellStyle_date);
                            String tmstp = (String) value;
                            Calendar rightNow = Calendar.getInstance();
                            rightNow.set(Integer.parseInt(tmstp.substring(0, 4)),
                                    Integer.parseInt(tmstp.substring(4, 6)) - 1,
                                    Integer.parseInt(tmstp.substring(6, 8)), 0, 0, 0);
                            rightNow.set(Calendar.MILLISECOND, 0);
                            cell.setCellValue(rightNow.getTime());
                        } else if (((String) value).length() == 10) {
                            cell.setCellStyle(cellStyle_date);
                            String tmstp = (String) value;
                            Calendar rightNow = Calendar.getInstance();
                            rightNow.set(Integer.parseInt(tmstp.substring(0, 4)),
                                    Integer.parseInt(tmstp.substring(5, 7)) - 1,
                                    Integer.parseInt(tmstp.substring(8, 10)), 0, 0, 0);
                            rightNow.set(Calendar.MILLISECOND, 0);
                            cell.setCellValue(rightNow.getTime());
                        } else {
                            cell.setCellValue(value.toString());
                            cell.setCellStyle(cellStyle_text);
                        }
                    } catch (Exception e) {
                        cell.setCellValue(value.toString());
                        cell.setCellStyle(cellStyle_text);
                    }

                } else {
                    cell.setCellValue(value.toString());
                    cell.setCellStyle(cellStyle_text);
                }

            } else {
                cell.setCellStyle(cellStyle_date);
            }
        } else {
            cell.setCellStyle(cellStyle_text);
            if (value != null) {
                cell.setCellValue(value.toString());
            }
        }
        return true;
    }

    @Override
    public void exp(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {
        String busbo = (String) paras.get("busbo");
        if (busbo == null) {
            throw new AppException("0", "导出组件业务BO不能为空！");
        }
        IImpExpABO busImpExpABO = (IImpExpABO) ServiceFactory.getBean(busbo);
        busImpExpABO.exp(paras, request, response);
        if (paras.get("userdefined") != null) {
            return;
        }
        paras.put("busImpExpABO", busImpExpABO);
        List uitablecolsconfig = genDataTableconfig(paras);
        boolean islinenumber = (Boolean)paras.get("islinenumber");
        if (islinenumber) {
            PerfDTO dto = new PerfDTO();
        	dto.put("columncode", "_linenumber");
        	dto.put("name", "序号");
        	dto.put("isvisiable", "1");
        	dto.put("colwidth", "30");
        	dto.put("type", "s");
        	uitablecolsconfig.add(0, dto);
        }
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("导出数据");
        int headrow = this.genExpHead(uitablecolsconfig, workbook, sheet);
        List datalist = busImpExpABO.busExpDatas(paras);

        Map uitableconfig = (Map) paras.get("uitableconfig");
        String stristotal = String.valueOf(uitableconfig.get("istotal"));
        boolean istotaltag = "1".equals(stristotal);
        if (istotaltag) {
            PerfDTO dto = new PerfDTO();
        	datalist.add(0, dto);
        }
        List columncodes = new ArrayList();
        List elementcodes = new ArrayList();

        String elementcode = null;
        String columncode = null;
        Map columncodemap = new HashMap();
        Map m = null;
        for (int i = 0; i < uitablecolsconfig.size(); i++) {
            m = (Map) uitablecolsconfig.get(i);
            elementcode = (String) m.get("elementcode");
            columncode = (String) m.get("columncode");
            if (elementcode != null) {
                columncodes.add(columncode);
                elementcodes.add(elementcode);
                columncodemap.put(columncode, columncode);
            }
        }
        paras.put("columncodes", columncodes);
        paras.put("elementcodes", elementcodes);
        if (datalist != null && datalist.size() != 0) {
            HSSFRow row;
            HSSFCell cell;
            Map trandata = busImpExpABO.transExpDatas(paras, datalist);
            if (trandata == null) {
                trandata = this.transExpDatas(paras, datalist);
            }
            Map col = null;
            Map cellstylemap = this.getCellStyleMap(workbook);
            boolean istrans = true;
            Map rowdata = null;
            String istotal = null;
            Map totalmap = new HashMap();
            for (int i = 0; i < datalist.size(); i++) {
                rowdata = (Map)datalist.get(i);
                if(istotaltag){
                	if(i==0){
                		rowdata.put("_linenumber", "合计");
                	}else{
                		rowdata.put("_linenumber", i);
                	}
                }else{
                	rowdata.put("_linenumber", (i+1));
                }
                row = sheet.createRow(headrow + i);
                for (int j = 0; j < uitablecolsconfig.size(); j++) {
                    col = (Map) uitablecolsconfig.get(j);
                    columncode = (String) col.get("columncode");
                    if(istotaltag){
                    	istotal = String.valueOf(col.get("istotal"));
                    	if(istotal.equals("1")){
                    		BigDecimal num =(BigDecimal) totalmap.get(columncode);
                    		if(num==null){
                    			num = new BigDecimal("0");
                    		}
                    		Object value = rowdata.get(columncode);
                    		if(value==null){
                    			value = "0";
                    		}
                    		totalmap.put(columncode, num.add(new BigDecimal(value.toString())));
                    	}
                    }
                    if (columncodemap.containsKey(columncode)) {
                        istrans = true;
                    } else {
                        istrans = false;
                    }
                    cell = row.createCell(j);
                    if(!busImpExpABO.setCellValue(paras, col, cell, columncode, istrans,rowdata, trandata, cellstylemap)){
                        this.setCellValue(paras, col, cell, columncode, istrans,rowdata, trandata, cellstylemap);
                    }
                }
            }

            if(istotaltag){
            	row = sheet.getRow(headrow);
            	HSSFCellStyle cellStyle_amt = (HSSFCellStyle)cellstylemap.get("cellStyle_amt");
            	HSSFCellStyle cellStyle_text = (HSSFCellStyle)cellstylemap.get("cellStyle_text");
            	for (int j = 0; j < uitablecolsconfig.size(); j++) {
                    col = (Map) uitablecolsconfig.get(j);
                    columncode = (String) col.get("columncode");
                    cell = row.getCell(j);
                    cell.setCellStyle(cellStyle_amt);
                    istotal = String.valueOf(col.get("istotal"));
                    if (istotal != null && "1".equals(istotal)) {
                		BigDecimal value = (BigDecimal)totalmap.get(columncode);
                		try {
                			double v = Double.parseDouble(value.toString().replaceAll(",", ""));
                			if(v!=0){
                				cell.setCellValue(v);
                			}
                        } catch (NumberFormatException e) {
                            cell.setCellValue(value.toString());
                            cell.setCellStyle(cellStyle_text);
                        }
                	}
                }
            }

        }
        String expfilename = (String) paras.get("expfilename");
        if (expfilename == null) {
            expfilename = "expdata.xls";
        }
        OutputStream out = null;
        try {
            String fileName = URLEncoder.encode(expfilename, "UTF-8");
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);
            out = response.getOutputStream();
            workbook.write(out);
        } catch (IOException e) {
            throw new AppException(e);
        } finally {
            try {
                if (out != null) {
                    out.flush();
                    out.close();
                }
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            }
        }
    }

    /**
     * @return cellStyle_text
     */
    public HSSFCellStyle getCellStyle_text(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_text = workbook.createCellStyle();
        cellStyle_text.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_text.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_text.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_text.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_text.setDataFormat(format.getFormat("@"));
        return cellStyle_text;
    }
    /**
     * @return cellStyle_text
     */
    public HSSFCellStyle getcellstyle_text_center(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_text = workbook.createCellStyle();
        cellStyle_text.setAlignment(HorizontalAlignment.CENTER);//
        cellStyle_text.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_text.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_text.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_text.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_text.setDataFormat(format.getFormat("@"));
        return cellStyle_text;
    }

    /**
     * @return cellStyle_text_right1
     */
    public HSSFCellStyle getCellStyle_text_right(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_text_right = workbook.createCellStyle();
        cellStyle_text_right.setAlignment(HorizontalAlignment.CENTER);//
        cellStyle_text_right.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_text_right.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_text_right.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_text_right.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_text_right.setDataFormat(format.getFormat("@"));
        return cellStyle_text_right;
    }

    /**
     * @return cellStyle_amt
     */
    public HSSFCellStyle getCellStyle_amt(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_amt = workbook.createCellStyle();
        cellStyle_amt.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_amt.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_amt.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_amt.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_amt.setDataFormat(format.getFormat("#,##0.00"));
        return cellStyle_amt;
    }

    /**
     * @return cellStyle_number
     */
    public HSSFCellStyle getCellStyle_number(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_number = workbook.createCellStyle();
        cellStyle_number.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_number.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_number.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_number.setBorderTop(BorderStyle.THIN);// 上边框
        return cellStyle_number;
    }

    /**
     * @return cellStyle_p
     */
    public HSSFCellStyle getCellStyle_p(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_p = workbook.createCellStyle();
        cellStyle_p.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_p.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_p.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_p.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_p.setDataFormat(format.getFormat("#0.########%"));
        return cellStyle_p;
    }

    /**
     * @return cellStyle_date
     */
    public HSSFCellStyle getCellStyle_date(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle_date = workbook.createCellStyle();
        cellStyle_date.setBorderBottom(BorderStyle.THIN);// 下边框
        cellStyle_date.setBorderLeft(BorderStyle.THIN);// 左边框
        cellStyle_date.setBorderRight(BorderStyle.THIN);// 右边框
        cellStyle_date.setBorderTop(BorderStyle.THIN);// 上边框
        HSSFDataFormat format = workbook.createDataFormat();
        cellStyle_date.setDataFormat(format.getFormat("yyyy-mm-dd"));
        return cellStyle_date;
    }

    public Map getCellStyleMap(HSSFWorkbook workbook){
        Map cellstylemap = new HashMap();
        cellstylemap.put("cellStyle_text",this.getCellStyle_text(workbook));
        cellstylemap.put("cellStyle_text_right",this.getCellStyle_text_right(workbook));
        cellstylemap.put("cellStyle_text_center",this.getcellstyle_text_center(workbook));
        cellstylemap.put("cellStyle_amt",this.getCellStyle_amt(workbook));
        cellstylemap.put("cellStyle_number",this.getCellStyle_number(workbook));
        cellstylemap.put("cellStyle_p",this.getCellStyle_p(workbook));
        cellstylemap.put("cellStyle_date",this.getCellStyle_date(workbook));
        return cellstylemap;
    }

    /**
     * 查询数据时，检查codes中的数据是否全部在List<DicRangeDTO>的code里
     * @param dicRange 翻译的数据集集合
     * @param codes	需翻译的code集合
     * @return
     */
    private Set<String> dicRangeNotInCodes(List<DicRangeDTO> dicRange, Collection<String> codes){
        Set<String> result = new HashSet<String>();
        if(dicRange.size() == 0) {
            return result;
        }
        for(String code:codes){
            boolean codeInList=false;
            for (DicRangeDTO dicRangeDTO : dicRange) {
                if(code.equalsIgnoreCase(dicRangeDTO.getCode())){
                    //如果有匹配，则不再验证此code
                    codeInList=true;
                    break;
                }
            }
            //有code没有匹配上，则直接返回false
            if(!codeInList) {
                result.add(code);
            }
        }
        return result;
    }

    /**
     * 数据翻译，对excel中的数据源进行翻译（code/code-name翻译成guid）
     * @return
     */
    public List analyData(List datalist, List collist) throws Exception {
        IDataSetService dataSetService = PerfServiceFactory.getIDataSetService();
        boolean hasError = false;
        String lasterrormsg = null;
        //计算有几行表头
        int heads = this.getTableHeadNum(collist);
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        for (int i = 0; i < collist.size(); i++) {//按导入列翻译数据
            Map<String, List<Integer>> codes = new HashMap<String, List<Integer>>();
            Map map = (Map) collist.get(i);
            String colcode = (String) map.get("columncode");
            String csid = (String) map.get("csid");
            if (csid != null && csid.trim().length() != 0) {
                //取到数据中整列code值
                for (int j = 0; j < datalist.size(); j++) {
                    Map datamap = (Map) datalist.get(j);
                    if (datamap.get(colcode.toLowerCase()) != null) {
                        String codevalue = datamap.get(colcode.toLowerCase()) + "";
                        //edited by zhangkai,针对-1的值进行处理
                        if (codevalue.indexOf("-") > -1 && codevalue.indexOf("-1") <0) {
                            codevalue = codevalue.split("-")[0];
                        }
                        datamap.put(colcode.toLowerCase(), codevalue);
                        if(codes.get(codevalue)==null){
                            codes.put(codevalue, new ArrayList<Integer>());
                            codes.get(codevalue).add(j+2);
                        }else{
                            codes.put(codevalue, new ArrayList<Integer>());
                            codes.get(codevalue).add(j+2);
                        }
                    }
                }
                if (codes.size() == 0) {
                    continue;
                }
                String wheresql = ((Fasp2DaoSupport) ServiceFactory.getBean("buscore.framework.dao"))
                        .createInSql("code", codes.keySet());
                List<DicRangeDTO> dicRange = null;
                try {
                    dicRange = dataSetService.getRangesByWhereSql(dataSetService.getDataSetByGuid(csid).getElementcode()
                            , wheresql);
                }catch(Exception e){
                    hasError=true;
                    logger.error("翻译CSID:"+ csid +"出错"+e.getMessage());
                    lasterrormsg = map.get("name") + "获取数据项值集报错,翻译CSID:"+ csid;
                    ImportErrorDTO dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), 1, lasterrormsg);
                    errordao.saveErrorMsg(dto,true);
                    continue;
                }
                if (dicRange.size() == 0) {
                    hasError=true;
                    for(String errorCode:codes.keySet()){
                        for(int line:codes.get(errorCode)){
                            lasterrormsg=map.get("name")+"翻译失败，检查CODE="+errorCode+"是否存在！";
                            ImportErrorDTO dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), line + heads, lasterrormsg);
                            errordao.saveErrorMsg(dto,true);
                        }
                    }
                    continue;
                }
                //检查codes中的数据是否全部在List<DicRangeDTO>的code里
                Set<String> rangeNotInCodes =dicRangeNotInCodes(dicRange, codes.keySet());
                if(rangeNotInCodes.size()>0){
                    hasError=true;
                    for(String errorCode:rangeNotInCodes){
                        for(int line:codes.get(errorCode)){
                            lasterrormsg=map.get("name")+"翻译失败，检查CODE="+errorCode+"是否存在！";
                            ImportErrorDTO dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), line + heads, lasterrormsg);
                            errordao.saveErrorMsg(dto,true);
                        }
                    }
                    continue;
                }
                for (int j = 0; j < datalist.size(); j++) {
                    Map datamap = (Map) datalist.get(j);
                    for (int k = 0; k < dicRange.size(); k++) {
                        Map dicmap = dicRange.get(k);
                        if ((datamap.get(colcode.toLowerCase()) + "").equals(dicmap.get("code") + "")) {
                            datamap.put(colcode.toLowerCase() + "", dicmap.get("guid"));
                            break;
                        }
                    }
                }
            } else {//当数据源在busfw_t_uicolumnsource中配置时候翻译处理
//                boolean flag = false;
//                for (int k = 0; k < collist.size(); k++) {
//                    Map uisource = (Map) collist.get(k);
//                    if (colcode.toLowerCase().equals(uisource.get("columncode").toString().toLowerCase())) {
//                        flag = true;
//                        break;
//                    }
//                }
//                if (flag) {
//                    for (int j = 0; j < datalist.size(); j++) {
//                        Map datamap = (Map) datalist.get(j);
//                        if (datamap.get(colcode.toLowerCase()) != null) {
//                            String codevalue = datamap.get(colcode.toLowerCase()) + "";
//                            //edited by zhangkai,针对-1的值进行处理
//                            if (codevalue.indexOf("-") > -1 && codevalue.indexOf("-1") <0) {
//                                codevalue = codevalue.split("-")[0];
//                            }
//                            datamap.put(colcode.toLowerCase(), codevalue);
//                        }
//                    }
//                }
            }
        }
        if(hasError){
            throw new AppException("ANA-ERROR",lasterrormsg);
        }
        return datalist;
    }

    private String getNoRepeat(Set<String> codes){
        HashSet<String> result = new HashSet<String>();
        for(String code:codes){
            result.add(code);
        }
        return result.toString();
    }


    /**
     * 内容读取
     *
     * @param f-- 文件
     * @return
     */
    public InputStream getInputStream(File f) {
        ByteArrayInputStream io = null;//字节数组输入流
        ByteArrayOutputStream bout = new ByteArrayOutputStream();//字节数组输出流
        try {
            int loop = f.getSize();
            for (int j = 0; j < loop; j++) {
                bout.write(f.getBinaryData(j));//获取文件中数据
            }
            io = new ByteArrayInputStream(bout.toByteArray());//将数据放到缓冲区
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (bout != null) {
                try {
                    bout.flush();
                    bout.close();
                } catch (IOException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }
        return io;
    }

    /**
     * 采集表解析流中的数据.
     * @param
     * @return
     * @throws Exception
     * @throws .
     */
    public List<ImportDataDTO> doParse(List cols) throws Exception {
        Sheet st = null;
        if("xlsx".equals(file.getFileExt())){
            XSSFWorkbook wb = new XSSFWorkbook(inputStream);//将流中的数据通过构造方法初始化在工作薄对象中
            st = wb.getSheetAt(0);
        } else {
            HSSFWorkbook wb = new HSSFWorkbook(inputStream);//将流中的数据通过构造方法初始化在工作薄对象中
            st = wb.getSheetAt(0);
        }
        //解析Excel文件中的数据
        return this.parseExcel(st, cols);
    }

    /**
     * 解析Excel文件中的数据.
     * @return List<List> 导入列
     * @throws Exception
     * @throws .
     */
    private List<ImportDataDTO> parseExcel(Sheet sheet,List cols) throws Exception {
        //计算有几行表头
        int heads = this.getTableHeadNum(cols);
        List<ImportDataDTO> result = new ArrayList<ImportDataDTO>();
        // 获得数据总行数
        int rowCount = sheet.getLastRowNum();
        // 逐行读取数据
        for (int rowIndex = (heads+1); rowIndex <= rowCount; rowIndex++) {
            // 获得行对象
            int number = 0;//计数器
            Row row = sheet.getRow(rowIndex);
            if (row != null) {
                // 获得本行中单元格的个数
                int columnCount = row.getLastCellNum();
                //如果单元格的格子数比列多一个，则去掉首个序号单元格
                int start = 0;
                if(cols.size()==(columnCount-1)){
                    start = 1;
                }
                String[] lineArray = new String[cols.size()];
                // 获得本行中单元格中的数据
                for (int columnindex = start; columnindex < columnCount; columnindex++) {
                    Cell cell = row.getCell(columnindex);
                    // row.getCell(cellnum)
                    // 获得指定单元格中的数据
                    Object cellStr = this.getCellString(cell);
                    lineArray[columnindex-start] = (String)cellStr;
                }
                for(int i = 0;i < lineArray.length;i++){
                    if(lineArray[i]==null){
                        number = number+1;
                    }
                }
                //空行跳过
                if(number==lineArray.length){
                    continue;
                }
                //把每列数据对应到相应的导入列上
                ImportDataDTO maprow = this.getRowData(lineArray, cols, rowIndex + 1);
                result.add(maprow);
            }
        }
        return result;
    }

    //获取采集表的表头层数
    public int getTableHeadNum(List cols){
        int num = 0;
        for(int i = 0; i < cols.size(); i++){
            Map col = (Map) cols.get(i);
            int headnum = 0;
            String head = (String) col.get("head");
            if (head != null && !"".equals(head)) {
                headnum = head.split(",").length;
            }
            if(headnum > num){
                num = headnum;
            }
        }
        return num;
    }

    /**
     * 把每列数据对应到相应的导入列上.
     * @param lineArray
     * @param row
     * @throws Exception
     */
    public ImportDataDTO getRowData(Object[] lineArray, List cols, int row) {
        ImportDataDTO map = new ImportDataDTO();
        Map m = new HashMap();
        for (int i = 0; i < lineArray.length; i++) {
            Map columMap = (Map) cols.get(i);
            // 无字段配置跳出
            if (columMap == null) {
                break;
            }
            Object value = lineArray[i];
            // 获取字段名称
            String fieldname = (String) columMap.get("columncode");
            m.put(fieldname, value);
            // 设置行数
            m.put("linenum", row);
            map.putAll(m);
        }
        return map;
    }

    /**
     * 解析指定单元格中的数据.
     * @param cell 单元格对象
     * @return Object
     * @throws AppException 异常
     * @throws
     */
    private Object getCellString(Cell cell)  {
        Object result = null;
        if (cell != null) {
            CellType cellType = cell.getCellType();
            switch (cellType) {
                case STRING:
                    // result = cell.getRichStringCellValue().getString();
                    result = cell.getStringCellValue();
                    break;
                case NUMERIC:
                    result = new DecimalFormat("0.#######").format(cell.getNumericCellValue());
                    break;
                case FORMULA:
                    result = cell.getNumericCellValue();
                    break;
                case ERROR:
                    result = null;
                    break;
                case BOOLEAN:
                    result = cell.getBooleanCellValue();
                    break;
                case BLANK:
                    result = null;
                    break;
            }
        }
        return result;
    }

    private static void setColumnTypeString(Workbook workbook,Sheet sheet,int columnIndex) {
        //把所有的cell设置为字符类型，避免输入001，就变成了1
        CellStyle css = workbook.createCellStyle();

        DataFormat format = workbook.createDataFormat();

        css.setDataFormat(format.getFormat("@"));

        sheet.setDefaultColumnStyle(columnIndex,css);
    }

    private static String[] columnAlphabets = new String[] { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
            "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
            "AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH", "AI", "AJ", "AK", "AL",
            "AM", "AN", "AO", "AP", "AQ", "AR", "AS", "AT", "AU", "AV", "AW", "AX", "AY", "AZ",
            "BA", "BB", "BC", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BK", "BL",
            "BM", "BN", "BO", "BP", "BQ", "BR", "BS", "BT", "BU", "BV", "BW", "BX", "BY", "BZ",
            "CA", "CB", "CC", "CD", "CE", "CF", "CG", "CH", "CI", "CJ", "CK", "CL",
            "CM", "CN", "CO", "CP", "CQ", "CR", "CS", "CT", "CU", "CV", "CW", "CX", "CY", "CZ",
            "DA", "DB", "DC", "DD", "DE", "DF", "DG", "DH", "DI", "DJ", "DK", "DL",
            "DM", "DN", "DO", "DP", "DQ", "DR", "DS", "DT", "DU", "DV", "DW", "DX", "DY", "DZ",
            "FA", "FB", "FC", "FD", "FE", "FF", "FG", "FH", "FI", "FJ", "FK", "FL",
            "FM", "FN", "FO", "FP", "FQ", "FR", "FS", "FT", "FU", "FV", "FW", "FX", "FY", "FZ"
    };

    private String intToAlphabet(int i) {
        return columnAlphabets[i];
    }

    /**
     * 读取报告文件内容
     * @return
     */
    public List<Map<Integer, Object>> readXml() throws DocumentException, IOException {
        List<List<String>> rwolist = null;
        int num = 0;
        Map<Integer, Object> data = new HashMap();
        ByteArrayOutputStream baos = null;
        List<Map<Integer, Object>> list = new ArrayList<>();
        try {
            //io转string,处理特殊字符
            baos = new ByteArrayOutputStream();
            int i;
            while ((i = inputStream.read()) != -1) {
                baos.write(i);
            }
            StringBuffer str = new StringBuffer();
            str.append(baos.toString().replace("&#10;","")
                    .replace("<Data ss:Type=\"String\"></Data>","<Data ss:Type=\"String\">@@@</Data>")
                    .replace("<Data ss:Type=\"Number\"></Data>","<Data ss:Type=\"Number\">0</Data>"));
            SAXReader sax = SecureXmlParser.createSecureSaxReader();
            Document document = sax.read(new ByteArrayInputStream(str.toString().getBytes("UTF-8")));
            Element rootElement = document.getRootElement();
            Iterator iterator = rootElement.elementIterator();
            while (iterator.hasNext()) {
                Element element = (Element) iterator.next();
                if ("Worksheet".equals(element.getName())) {
                    this.getNodeData(element, rwolist, num, data);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (baos != null) {
                baos.close();
            }
        }
        if (!data.isEmpty()) {
            list.add(PerfUtil.sortMapByKey(data));
        }
        return list;
    }

    private void getNodeData(Element e, List rowlist, int num, Map<Integer, Object> data){
        Iterator iterator = e.elementIterator();
        Element element  = null;
        while (iterator.hasNext()) {
            element = (Element) iterator.next();
            String tabname = element.getName();
            List nodes = element.content();
            if ("WorksheetOptions".equals(tabname)) {
                break;
            }
            if ("Row".equals(tabname)) {
                num++;
                rowlist = new ArrayList();
            }
            if ("Cell".equals(tabname)) {
//                Attribute attribute = element.attribute(0);
//                if (attribute != null) {
//                    String index = attribute.getStringValue();
//                    String name = attribute.getName();
//                    if ("Index".equals(name)) {
//                        int n = Integer.parseInt(index);
//                        if (n>=1) {
//                            rowlist.add("###");
//                        }
//                    }
//                }
                Element dataele = element.element("Data");
                if (dataele == null) {
                    rowlist.add("@@@");
                }
            }
            if ("Data".equals(tabname)) {
                String str = "";
                for (Object obj : nodes) {
                    Node node = (Node) obj;
                    str += node.getText();
                }
                rowlist.add(str);
            }
            getNodeData(element, rowlist, num, data);
        }
        if (rowlist != null) {
            data.put(num, rowlist);
        }
    }
}
