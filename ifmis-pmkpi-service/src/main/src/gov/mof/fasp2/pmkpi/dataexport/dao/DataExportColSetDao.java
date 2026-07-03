package gov.mof.fasp2.pmkpi.dataexport.dao;

import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTempdetailDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataExportColSetDao extends Fasp2DaoSupport implements
        IDataExportColSetDAO {
	
	public static final String EXPORTCOLSETTABLE="FW_T_EXPORTCOLSET";
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public boolean saveSetCol(HashMap<String,Object> map) throws AppException {
		String tempguid=String.valueOf(map.get("guid"));
		List changecol=(List) map.get("changecol");
//		List recordsetList=(List)map.get("recordset");
//		String tablecode=String.valueOf(map.get("tablecode"));
		//保存之前，不管TEMPID是否存在，先进行删除
		 this.update("DELETE  "+EXPORTCOLSETTABLE+ " WHERE TEMPID ='"+tempguid+"'");
		 ExportTempdetailDTO exportTempdetailDTO=new ExportTempdetailDTO();
			 for(int i=0;i<changecol.size();i++){
				 Map enablemap=(Map) changecol.get(i);
				 String guid = StringUtil.createUUID();
				 exportTempdetailDTO.setGuid(guid);
				 
				 String columnid=String.valueOf(enablemap.get("columnid"));
				 exportTempdetailDTO.setColumnid(columnid);
				 exportTempdetailDTO.setTempid(tempguid);
				 exportTempdetailDTO.setOrdernum(Integer.parseInt(String.valueOf(enablemap.get("_sortid"))));
		        save(exportTempdetailDTO, EXPORTCOLSETTABLE);
			 }
		return true;
	}


	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Object> questByTempcode(HashMap<String,Object> map) throws AppException {
		String sql = "select * from "+EXPORTCOLSETTABLE+" where tempid = '" + map.get("guid").toString()+"' ";
		List list = this.queryForList(sql);
	        if (list.size() > 0) {
	            return list;
	        }
		return null;
	}

}