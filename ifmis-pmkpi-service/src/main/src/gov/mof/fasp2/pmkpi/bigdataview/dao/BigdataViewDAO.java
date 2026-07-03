package gov.mof.fasp2.pmkpi.bigdataview.dao;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class BigdataViewDAO extends PmkpiDAO {
	/**
	 * 根据guid查询数据
	 * @param guid
	 * @return
	 */
	public List getByGuid(String tablecode, String guid){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ");
		sql.append(tablecode).append(" where guid = '").append(guid).append("'");
		return this.queryForList(sql.toString());
	}
	
    public void deleteByGuid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (null != where && !where.isEmpty()) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }
    
    public void updateData(String tablecode,String setSql, String guid) {
        String sql = "update "+tablecode+" set "+ setSql +" where guid ='"+guid+"'";
        this.execute(sql);
    }


}
