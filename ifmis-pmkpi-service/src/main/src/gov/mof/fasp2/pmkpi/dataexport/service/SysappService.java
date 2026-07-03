package gov.mof.fasp2.pmkpi.dataexport.service;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dao.ISysappDAO;
import gov.mof.fasp2.pmkpi.dataexport.dto.SysappDTO;

import java.util.List;

public class SysappService implements ISysappService {
	
	private ISysappDAO iSysappDAO;

    public ISysappDAO getiSysappDAO() {
		return iSysappDAO;
	}

	public void setiSysappDAO(ISysappDAO iSysappDAO) {
		this.iSysappDAO = iSysappDAO;
	}

	/**
     * 获取所有系统
     */
	@Override
	public List<SysappDTO> getAllSysapps() throws AppException {
		
		return iSysappDAO.getAllSysapps();
	}
}