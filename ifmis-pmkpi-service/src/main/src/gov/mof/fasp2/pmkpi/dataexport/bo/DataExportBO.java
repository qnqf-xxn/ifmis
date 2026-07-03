package gov.mof.fasp2.pmkpi.dataexport.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busfw.ui.datatable.AbstractDatatableQueryData;
import gov.mof.fasp2.busfw.ui.queryform.QueryFormService;
import gov.mof.fasp2.pmkpi.dataexport.dao.DataExportDAO;
import gov.mof.fasp2.pmkpi.dataexport.dao.IDataExportDAO;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataExportBO extends AbstractDatatableQueryData {

	private IDataExportDAO dataExportDAO;
	
	public IDataExportDAO getDataExportDAO() {
		return dataExportDAO;
	}

	public void setDataExportDAO(DataExportDAO dataExportDAO) {
		this.dataExportDAO = dataExportDAO;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String getVodSql(Map sqlmap) throws AppException {
		String whereSql = null;
        if(sqlmap.containsKey("appid")){
            String appid = String.valueOf(sqlmap.get("appid"));
            if(appid !=null){
                whereSql = "appid = '"+appid+"'";
            } 
        }
        List<Object> list =(List<Object>) sqlmap.get("queryConfig");
		if(null!=list && list.size() == 2){
			 QueryFormService qfs = (QueryFormService) ServiceFactory.getBean("busfw.queryform");
			 HashMap querycondition = (HashMap) list.get(0);
	            HashMap uiConfig = (HashMap) list.get(1);
	            String wsql = qfs.convertParam(querycondition, uiConfig);
	            if (null != wsql && !"".equals(wsql)) {
	                if(whereSql!=null){
	                    whereSql += " and " + wsql;
	                }else{
	                    whereSql = wsql;
	                }
	            }
		}
        String sql  = "select GUID,CODE,NAME,SIGN,TYPE,ENCRYPTION,ENALGORITHM,TITLE,DATASOURCE,CONDITION,RESULTSET,APPID from  "+ DataExportDAO.EXPORTTABLE;
        if (whereSql != null) {
            sql+= " where " + whereSql;
        }
        sql += " order by NAME desc";
        return sql;
	}

	public boolean saveTemp(ExportTemplateDTO exportTemplateDTO) throws AppException {
		
			return dataExportDAO.saveTemp(exportTemplateDTO);
	}

	public boolean findCheckRepeat(HashMap<String, Object> map) throws AppException {
		return dataExportDAO.checkRepeat(map);
	}

	public ExportTemplateDTO findExportTemplateDTO(String guid) {
		
		return dataExportDAO.getExportTemplateDTO(guid);
	}

	public boolean updateTemp(ExportTemplateDTO exportTemplateDTO) throws AppException {
		return dataExportDAO.updateTemp(exportTemplateDTO);
	}

	public void deleteTemp(String guids) throws AppException {
		dataExportDAO.deleteTemp(guids);
		
	}

	public ExportTemplateDTO findExportTemplateDTO2(String rs) {
		return dataExportDAO.findExportTemplateDTO2(rs);
	}

	public List<Object> findDBtable(ExportTemplateDTO dto) {
		return dataExportDAO.findDBtable(dto);
	}
	public Object[] findAllCol(ExportTemplateDTO dto) {
		return dataExportDAO.findAllCol(dto);
	}



}