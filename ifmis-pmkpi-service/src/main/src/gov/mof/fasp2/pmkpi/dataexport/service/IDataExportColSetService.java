package gov.mof.fasp2.pmkpi.dataexport.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.HashMap;
import java.util.List;

public interface IDataExportColSetService {
	/**
	 * 保存设置列的信息
	 * 
	 * @return
	 * @throws AppException
	 * @throws
	 */
	public boolean saveSetCol(HashMap<String, Object> map) throws AppException;

	public List<Object> questByTempcode(HashMap<String, Object> map)
			throws AppException;
}