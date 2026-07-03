package gov.mof.fasp2.pmkpi.perfcommon.impexp;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import org.apache.poi.hssf.usermodel.HSSFCell;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface IImpExpABO {
    /**
     * 业务处理导入数据
     * @param paras 前台传入参数
     * @param filename 文件名
     * @param datalist 导入数据
     * @return 导入数据
     */
    public List busImpDatas(Map paras,String filename,List<? extends Map> datalist) throws AppException;
    /**
     * 导入数据前台确认后业务处理
     * @param paras 前台传入参数
     * @param datalist 前台确认数据
     * @return 确认后返回值
     */
    public Map busImpConfirmDatasSave(Map paras,ArrayList datalist) throws AppException;
    /**
     * 业务导出数据
     * @param paras 前台参数
     * @return 要导出的业务数据
     */
    public List busExpDatas(Map paras) throws AppException;
    /**导入数据相关接口**/
    public List imp(File file, Map paras) throws Exception;
    /**导入报告数据相关接口**/
    public List impreport(File file, Map paras) throws Exception;
    public List impData(List datas, Map paras) throws AppException;
    public List parseFile(Map paras,String filename,InputStream is) throws AppException ;
    public List beforeParseFile(Map paras,String filename,InputStream is) throws AppException ;
    public boolean isBusGetCellValue();
    public Object getCellValue(Map paras,Map colconfig,HSSFCell cell,String columncode,boolean istrans) throws AppException ;
    /**导出导入模板相关接口**/
    public boolean expImpModel(Map paras,HttpServletRequest request, HttpServletResponse response) throws AppException ;
    public void beforeExpImpModel(Map paras,HttpServletRequest request, HttpServletResponse response) throws AppException ;
    /**导出模板扩展列接口**/
    public List beforeExpImpCols(Map paras) throws AppException ;
    /**导出数据相关接口**/
    public Map transExpDatas(Map paras,List<? extends Map> datalist) throws AppException ;
    public boolean setCellValue(Map paras,Map colconfig,HSSFCell cell,String columncode,boolean istrans,Map rowdata,Map trandata,Map cellstylemap) throws AppException ;

    public void exp(Map paras,HttpServletRequest request, HttpServletResponse response) throws AppException ;
}
