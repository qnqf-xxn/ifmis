package gov.mof.fasp2.pmkpi.dataexport.bo;


import gov.mof.fasp2.buscore.framework.reportexcel.AbstractReportDown;
import gov.mof.fasp2.buscore.framework.server.ServerContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName: ExportFactory
 * @Description: Description of this class
 * @author <a href="mailto:ranwei@szlongtu.com">冉伟</a>于 2015年7月8日 21:26:11
 */
public class DataExportFactory {


	
	/**
	 * 获取下载方式
	 * @param downtypes
	 * @param request
	 * @param response
	 * @return
	 */
    public static AbstractReportDown getDowType(String downtypes, HttpServletRequest request,
            HttpServletResponse response) {
        AbstractReportDown ard;
        if (".xls".equals(downtypes)) {
            ard = new DataExport2003();
        } else if (".xlsx".equals(downtypes)) {
            ard = new DataExport2003();
        } else if (".xml".equals(downtypes)) {
            ard = new DataExport2003();
        } else if(".txt".equals(downtypes)){
            ard = new DataExportTxt();
        }else {
            ard = new DataExport2003();
        }
        ard.setServerContext(new ServerContext(request, response));
        return ard;
    }
}