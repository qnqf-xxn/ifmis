package gov.mof.fasp2.pmkpi.dataexport.dao;

import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.SysappDTO;

import java.util.List;

@SuppressWarnings("unchecked")
public class SysappDAO extends Fasp2DaoSupport implements ISysappDAO {

	@Override
	public List<SysappDTO> getAllSysapps() throws AppException {
		String wheresql=" 1=1 ";
		return this.query(null, wheresql, "FW_T_SYSAPP", null, null, SysappDTO.class);
	}

}