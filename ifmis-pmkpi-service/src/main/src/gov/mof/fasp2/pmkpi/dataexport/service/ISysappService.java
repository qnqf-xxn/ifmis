package gov.mof.fasp2.pmkpi.dataexport.service;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.SysappDTO;

import java.util.List;

public interface ISysappService {
	public List<SysappDTO> getAllSysapps() throws AppException;
}