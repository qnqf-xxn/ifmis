package gov.mof.fasp2.pmkpi.dataexport.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.dataexport.bo.DataExportBO;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.HashMap;
import java.util.List;


public class DataExportService implements IDataExportService {

	private DataExportBO dataExportBO;
	
	public DataExportBO getDataExportBO() {
		return dataExportBO;
	}

	public void setDataExportBO(DataExportBO dataExportBO) {
		this.dataExportBO = dataExportBO;
	}


	/**
	 * 保存导入模板
	 * @param importtemplateDTO
	 * @return
	 * @throws AppException
	 * @throws
	 */
	@Override
	public boolean saveTemp(ExportTemplateDTO exportTemplateDTO)
			throws AppException {
		if(exportTemplateDTO.getGuid()==null){
			String guid = StringUtil.createUUID();
			exportTemplateDTO.setGuid(guid);
		}
		return dataExportBO.saveTemp(exportTemplateDTO);
		
	}

	@Override
	public boolean checkRepeat(HashMap<String,Object> map) throws AppException {
		return dataExportBO.findCheckRepeat(map);
	}

	@Override
	public ExportTemplateDTO getExportTemplateDTO(String guid) {
		return dataExportBO.findExportTemplateDTO(guid);
	}

	@Override
	public boolean updateTemp(ExportTemplateDTO exportTemplateDTO)
			throws AppException {
		return dataExportBO.updateTemp(exportTemplateDTO);
	}


	@Override
	public void deleteTemp(String guids) throws AppException {
		dataExportBO.deleteTemp(guids);
		
	}
	@Override
	public ExportTemplateDTO findExportTemplate(String rs) {
		return dataExportBO.findExportTemplateDTO2(rs);
	}
	@Override
	public List<Object> findDBtable(ExportTemplateDTO dto) {
		return dataExportBO.findDBtable(dto);
	}
	@Override
	public Object[] findAllCol(ExportTemplateDTO dto) {
		return dataExportBO.findAllCol(dto);
	}








}