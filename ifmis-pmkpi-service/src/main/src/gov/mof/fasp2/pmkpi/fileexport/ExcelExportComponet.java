/**
 * 
 */

package gov.mof.fasp2.pmkpi.fileexport;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.reportexcel.ReportDownComponent;
import gov.mof.fasp2.buscore.framework.rpcfw.termial.RCPConsoleManager;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busfw.ui.datatable.IDatatableUIconfig;
import gov.mof.fasp2.busfw.ui.datatable.IUIDatatableCacheInit;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.pmkpi.fileexport.bo.ExcelExportFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: FileUploadService
 * @Description: Description of this class
 * @author <a href="mailto:zhoujiyong@szlongtu.com">周继勇</a>于 Jun 12, 2014 3:02:34 PM
 */
@PageComponent(serviceid = "busfwexcelexport", viewid = "excelexport", jsLib = "/busfw/common/ui/ui_export.js", jsObjectName = "Ext.lt.ui.exports")
public class ExcelExportComponet extends AbstractComponentService {

    private IDatatableUIconfig uiconfig = null;

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        // TODO Auto-generated method stub
        return config;
    }

    /**
     * URL转换为linkname
     * @param url
     * @return
     * @throws
     */
    public String parseLinkname2Linkname(String path) {
        String realpath = path.substring(0, path.lastIndexOf("/") + 1);
        return realpath + "*";
    }

    // 通用后台导出方法
    public InputStream down(HashMap config) throws Exception {

        // 根据设置的导出类型调用不同的导出方法

        ReportDownComponent ard = (ReportDownComponent) ExcelExportFactory.getDowType((String) config.get("downtype"),
                this.getRequest(), this.getResponse());
        // 设置下载文件名
        ard.setConsole("application/vnd.ms-excel");
        if (config.get("titleflag") != null && !"".equals(config.get("titleflag"))) {
            ard.setDowInfo(config.get("titleflag").toString());
        } else {
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
            ard.setDowInfo(df.format(new Date()));
        }

        // 获取列配置信息
        // 这里改成缓存取不到直接取数据库
        String key = (String) config.get("key");
        IUIDatatableCacheInit cache = this.getRemoteDatatableCacheBean();
        if (cache.get(key).size() < 0) {
            DatatableDTO tableDTO = (DatatableDTO) cache.get(key).get(0);
            List colList = tableDTO.getCols();
            config.put("tablecode", tableDTO.getTablecode());
            config.put("columns", colList);
        } else {
            // 数据库查询UI配置
            List list2 = this.uiconfig.query(key);
            DatatableDTO tableDTO1 = (DatatableDTO) list2.get(0);
            List colList1 = tableDTO1.getCols();
            config.put("tablecode", tableDTO1.getTablecode());
            config.put("columns", colList1);
        }

        ard.down("", config);
        return RCPConsoleManager.getConsole(this.getRequest()).getFileInputStream();
    }

    // 通用前台导出方法
    public InputStream down2(HashMap config) throws Exception {

        // 获取前台参数
        Map configMap = (Map) config.get("exportinfo");
        List colList = (List) config.get("columns");
        List dataList = (List) config.get("datas");

        // 根据设置的导出类型调用不同的导出方法

        ReportDownComponent ard = (ReportDownComponent) ExcelExportFactory.getDowType((String) configMap
                .get("downtype"), this.getRequest(), this.getResponse());
        // 设置下载文件名
        ard.setConsole("application/vnd.ms-excel");
        if (configMap.get("titleflag") != null && !"".equals(configMap.get("titleflag"))) {
            ard.setDowInfo(configMap.get("titleflag").toString());
        } else {
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
            ard.setDowInfo(df.format(new Date()));
        }

        // 获取列配置信息
        // String key = (String) configMap.get("key");
        // IUIDatatableCacheInit cache = this.getRemoteDatatableCacheBean();
        // DatatableDTO tableDTO = (DatatableDTO) cache.get(key).get(0);
        configMap.put("columns", colList);
        ard.down("", (HashMap) configMap, dataList);
        return RCPConsoleManager.getConsole(this.getRequest()).getFileInputStream();

    }

    private IUIDatatableCacheInit getRemoteDatatableCacheBean() {
        IUIDatatableCacheInit cache = null;
        // 分域部署 业务系统暴露该接口
        Object obj = ServiceFactory.getBean("busfw.cacheinit.uicacheinit.uidatatable");
        if (obj != null) {
            cache = (IUIDatatableCacheInit) obj;
        }
        return cache;
    }

    /**
     * @return uiconfig
     */
    public IDatatableUIconfig getUiconfig() {
        return uiconfig;
    }

    /**
     * @param uiconfig 要设置的 uiconfig
     */
    public void setUiconfig(IDatatableUIconfig uiconfig) {
        this.uiconfig = uiconfig;
    }
}