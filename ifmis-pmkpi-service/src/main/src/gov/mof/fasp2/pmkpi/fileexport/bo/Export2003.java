
package gov.mof.fasp2.pmkpi.fileexport.bo;

import gov.mof.fasp2.buscore.framework.reportexcel.ReportDownComponent;

import java.util.List;
import java.util.Map;

public class Export2003 extends ReportDownComponent implements IExcelExport {

    public ExportBO bo = new ExportBO();

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

	@Override
	public List<Map> loadData(int page, Map config, List dataList) {
		// TODO Auto-generated method stub
		return bo.loadData(page, config,dataList);
	}

}