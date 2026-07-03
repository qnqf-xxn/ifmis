package gov.mof.fasp2.pmkpi.dataexport.component;

import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.List;

public abstract class AbstractExport extends Fasp2DaoSupport{
	//返回数据
	public abstract List<Object> findData(ExportTemplateDTO dto);
	
}