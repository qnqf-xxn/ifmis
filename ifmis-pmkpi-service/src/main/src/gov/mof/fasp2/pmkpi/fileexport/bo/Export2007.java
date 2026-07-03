
package gov.mof.fasp2.pmkpi.fileexport.bo;

import gov.mof.fasp2.buscore.framework.reportexcel.ReportDown2007Component;

import java.util.List;
import java.util.Map;

public class Export2007 extends ReportDown2007Component implements IExcelExport {

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

	@Override
	public List<Map> loadData(int page, Map config, List dataList) {
		// TODO Auto-generated method stub
		return bo.loadData(page, config,dataList);
	}

}