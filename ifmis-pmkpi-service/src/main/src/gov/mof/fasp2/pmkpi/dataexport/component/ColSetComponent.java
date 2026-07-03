package gov.mof.fasp2.pmkpi.dataexport.component;


import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.dataexport.service.DataExportColSetService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PageComponent(serviceid = "busfw.dataexport.colSetComponent", viewid = "busfw.dataexport.colSetComponent", id = "colSetComponent", jsLib = "/buscommon/dataexport/dataExportColSet.js", jsObjectName = "Ext.lt.dataexport.colSet")
public class ColSetComponent extends AbstractComponentService {

	private DataExportColSetService dataExportColSetService;

	private DataExportColSetService getDataExportColSetService() {
		if (dataExportColSetService == null) {
			return (DataExportColSetService) ServiceFactory.getBean("busfw.dataexport.dataExportColSetService");
		}
		return dataExportColSetService;
	}
	
	public boolean saveSetCol(HashMap<String,Object> map) throws AppException{
		getDataExportColSetService().saveSetCol(map);
		return true;
		
	}
	
	@SuppressWarnings("rawtypes")
	public List questByTempcode(HashMap<String,Object> map) throws AppException {
		List list=getDataExportColSetService().questByTempcode(map);
		return list;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		 	config.put("guid", request.getParameter("guid"));
		 	config.put("tablecode", request.getParameter("code"));
		 	config.put("tempcode", request.getParameter("tempcode"));
		 	
	        return config;
	    }
	
}