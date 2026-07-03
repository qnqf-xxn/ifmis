package gov.mof.fasp2.pmkpi.perfSupervision;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.ui.datatable.AbstractDatatableQueryData;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSupervisionUpdateBo extends AbstractDatatableQueryData implements gov.mof.fasp2.buscommon.ui.datatable.IDatatableQueryDataNotWhere {

	private PerfSupervisionDAO perfSupervisionDAO;

	public void setPerfSupervisionDAO(PerfSupervisionDAO perfSupervisionDAO) {
		this.perfSupervisionDAO = perfSupervisionDAO;
	}
	
	@Override
	public String getVodSql(Map sqlmap) throws AppException {
		return null;
	}


	public Map save(HashMap config) throws AppException {
		List<String> guids = (List<String>)config.get("guids");
		Map editformObj = (Map)config.get("editformObj");
		String adjoption = (String) editformObj.get("adjoption");
		String options = (String) editformObj.get("options");
		if(guids!=null && guids.size()>0){
			perfSupervisionDAO.updateOption("PERF_T_SUPERVISION",adjoption,options,"indexguid in ('"+guids.toString().substring(1, guids.toString().length()-1).replaceAll(",", "','")+"')");
		}
		perfSupervisionDAO.update("update perf_t_supervision set isadj = 1 where indexguid in (select indexguid from V_PERF_T_SUPERVISIONVIEW where indexguid in('"+guids.toString().substring(1, guids.toString().length()-1).replaceAll(",", "','")+"') and addindex = '是' )");
		perfSupervisionDAO.update("update perf_t_supervision set isadj = 2 where indexguid in (select indexguid from V_PERF_T_SUPERVISIONVIEW where indexguid in('"+guids.toString().substring(1, guids.toString().length()-1).replaceAll(",", "','")+"') and addindex = '否' )");

		return config;
	}
    
}
