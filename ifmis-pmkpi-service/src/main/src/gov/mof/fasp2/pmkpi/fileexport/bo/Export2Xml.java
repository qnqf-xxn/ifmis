
package gov.mof.fasp2.pmkpi.fileexport.bo;

import gov.mof.fasp2.buscore.framework.reportexcel.ReportDown2007Component4XML;

import java.util.List;
import java.util.Map;

public class Export2Xml extends ReportDown2007Component4XML implements IExcelExport {

    private final ExportBO bo = null;

    @Override
    public List<Map> loadData(int page, Map config) {
        // TODO Auto-generated method stub
        return bo.loadData(page, config);
    }

    @Override
    public String getFileName(Map config) {
        // TODO Auto-generated method stub
        return bo.getFileName(config);
    }
}