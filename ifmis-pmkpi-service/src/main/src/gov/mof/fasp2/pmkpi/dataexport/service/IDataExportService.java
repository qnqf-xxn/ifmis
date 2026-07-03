package gov.mof.fasp2.pmkpi.dataexport.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.HashMap;
import java.util.List;


public interface IDataExportService {
    /**
     * 保存导入模板
     * @param importtemplateDTO
     * @return
     * @throws AppException
     * @throws
     */
    public boolean saveTemp(ExportTemplateDTO exportTemplateDTO) throws AppException;
   
    /**
     * 添加和修改模板，检查是否已经存在
     * @param HashMap map
     * @return
     * @throws AppException
     * @throws
     */
	public boolean checkRepeat(HashMap<String, Object> map) throws AppException;
	
    /**
     * 通过guid取模板信息
     * @param guid
     * @return
     * @throws AppException
     * @throws
     */
	public ExportTemplateDTO getExportTemplateDTO(String guid);
	  /**
     * 修改模板
     * @param ExportTemplateDTO
     * @return
     * @throws AppException
     * @throws
     */
	public boolean updateTemp(ExportTemplateDTO exportTemplateDTO) throws AppException;
	/**
	 * 根据传入的GUID，删除模板
	 * @param guids
	 */
	public void deleteTemp(String guids)throws AppException;
	/**
	 * 通过code字段查符合要求的FW_T_EXPORTTEMPLATE数据
	 * @param rs对应FW_T_EXPORTTEMPLATE中code字段
	 * @return
	 */
	public ExportTemplateDTO findExportTemplate(String rs);
	/**
	 * 通过数据源查找符合的数据
	 * @param datasource
	 * @return
	 */
	public List<Object> findDBtable(ExportTemplateDTO dto);
	public Object[] findAllCol(ExportTemplateDTO dto);
}