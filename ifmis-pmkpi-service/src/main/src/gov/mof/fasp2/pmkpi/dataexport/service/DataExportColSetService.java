package gov.mof.fasp2.pmkpi.dataexport.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.bo.DataExportSetColBO;

import java.util.HashMap;
import java.util.List;

public class DataExportColSetService implements IDataExportColSetService {
	
	private DataExportSetColBO dataExportColSetBO;
	

	public DataExportSetColBO getDataExportColSetBO() {
		return dataExportColSetBO;
	}

	public void setDataExportColSetBO(DataExportSetColBO dataExportColSetBO) {
		this.dataExportColSetBO = dataExportColSetBO;
	}

	@Override
	public boolean saveSetCol(HashMap<String, Object> map) throws AppException {
		return dataExportColSetBO.saveSetCol(map);
	}

	@Override
	public List<Object> questByTempcode(HashMap<String, Object> map)
			throws AppException {
		return dataExportColSetBO.findByTempcode(map);
	}

}