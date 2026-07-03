package gov.mof.fasp2.pmkpi.dataexport.dao;


import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.HashMap;
import java.util.List;

public interface IDataExportColSetDAO {
	 /**
     * 保存设置列的信息
     * @return
     * @throws AppException
     * @throws
     */
	public boolean saveSetCol(HashMap<String, Object> map) throws AppException;
    /**
     * 根据tempid查询已经保存的列信息
     * @return
     * @throws AppException
     * @throws
     */
    public List<Object> questByTempcode(HashMap<String, Object> map) throws AppException;
}