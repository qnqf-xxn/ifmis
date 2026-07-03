
package gov.mof.fasp2.pmkpi.fileexport.bo;

import gov.mof.fasp2.buscore.framework.reportexcel.AbstractReportDown;
import gov.mof.fasp2.buscore.framework.server.ServerContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExcelExportFactory {
    public static AbstractReportDown getDowType(String downtypes, HttpServletRequest request,
            HttpServletResponse response) {
        AbstractReportDown ard;
        if (".xls".equals(downtypes)) {
            ard = new Export2003();
        } else if (".xlsx".equals(downtypes)) {
            ard = new Export2007();
        } else if (".xml".equals(downtypes)) {
            ard = new Export2Xml();
        } else {
            ard = new Export2003();
        }
        ard.setServerContext(new ServerContext(request, response));
        return ard;
    }
}