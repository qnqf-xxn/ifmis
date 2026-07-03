package gov.mof.fasp2.pmkpi.dataexport.dao;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.HashMap;
import java.util.List;

public interface IDataExportDAO {
    /**
     * 保存导入模板
     * @param importtemplateDTO
     * @return
     * @throws AppException
     * @throws
     */
    public boolean saveTemp(ExportTemplateDTO exportTemplateDTO) throws AppException;
    /**
     * 通过GUID取模板信息
     * @param guid
     * @return
     * @throws AppException
     * @throws
     */
    public ExportTemplateDTO getExportTemplateDTO(String guid);
    /**
     * 修改模板
     * @param noticeDTO
     * @return
     * @throws AppException
     * @throws
     */
    public boolean updateTemp(ExportTemplateDTO exportTemplateDTO) throws AppException;
    /**
     * 添加和修改模板，检查是否已经存在
     * @param HashMap map
     * @return
     * @throws AppException
     * @throws
     */
	public boolean checkRepeat(HashMap<String, Object> map) throws AppException;
	/**
	 * 根据传入的GUID，删除模板
	 * @param guids
	 */
	public void deleteTemp(String guids)throws AppException;
	public ExportTemplateDTO findExportTemplateDTO2(String rs);
	//导出数据表中数据
	public List<Object> findDBtable(ExportTemplateDTO dto);
	public Object[] findAllCol(ExportTemplateDTO dto);
}