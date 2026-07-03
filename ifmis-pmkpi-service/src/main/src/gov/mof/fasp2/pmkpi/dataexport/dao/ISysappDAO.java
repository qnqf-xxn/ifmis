package gov.mof.fasp2.pmkpi.dataexport.dao;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.SysappDTO;

import java.util.List;

/**
 * @ClassName: ISysappDAO 
 * @Description: Description of this class
 * @author <a href="mailto:kangjinshun@szlongtu.com">康金顺</a> 2015-8-3
 */
public interface ISysappDAO {

	/**
     * 获取所有系统
     * @return
     * @throws AppException
     */
	 public List<SysappDTO> getAllSysapps() throws AppException;
}