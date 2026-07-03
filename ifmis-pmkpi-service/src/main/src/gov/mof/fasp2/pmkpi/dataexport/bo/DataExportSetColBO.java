package gov.mof.fasp2.pmkpi.dataexport.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.ui.datatable.AbstractDatatableQueryData;
import gov.mof.fasp2.pmkpi.dataexport.dao.IDataExportColSetDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DataExportSetColBO extends AbstractDatatableQueryData {
    /**
     * @Fields MESSAGETABLE : 信息表
     */
    public static final String MESSAGETABLE = "FASP_T_DICCOLUMN";

    private IDataExportColSetDAO dataExportColSetDAO;
    
    
    
    public IDataExportColSetDAO getDataExportColSetDAO() {
		return dataExportColSetDAO;
	}



	public void setDataExportColSetDAO(IDataExportColSetDAO dataExportColSetDAO) {
		this.dataExportColSetDAO = dataExportColSetDAO;
	}



	@SuppressWarnings("rawtypes")
	@Override
    public String getVodSql(Map sqlmap) throws AppException {
        String whereSql = null;
        if(sqlmap.containsKey("code")){
            String tablecode = String.valueOf(sqlmap.get("code"));
            if(tablecode !=null){
                whereSql = "tablecode = '"+tablecode+"'";
            } 
        }
        String sql  = "select NAME,DBCOLUMNCODE,COLUMNID from "+ DataExportSetColBO.MESSAGETABLE;
        if (whereSql != null) {
            sql += " where " + whereSql;
        }
        sql += "order by DBCOLUMNCODE desc";
        sqlmap.clear();
        return sql;
    }



	public List<Object> findByTempcode(HashMap<String, Object> map)throws AppException {
		return dataExportColSetDAO.questByTempcode(map);
	}



	public boolean saveSetCol(HashMap<String, Object> map)throws AppException {
		return dataExportColSetDAO.saveSetCol(map);
	}

}