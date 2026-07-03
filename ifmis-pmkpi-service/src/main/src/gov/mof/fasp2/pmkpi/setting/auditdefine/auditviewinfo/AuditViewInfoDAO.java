package gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class AuditViewInfoDAO  extends PmkpiDAO{
     
	 /**
     * 视图审核表
     */                                              
    public static final String VIEW_TABLE = "V_PERF_T_CUSTOMAUDITVIEW";

	 /**
     * 视图审核数据查询
     * @param checkSql --
     * @return
     */
    public List<Map<String, Object>> getViewData(String checkSql) {
    	String sql = "select * from "+ VIEW_TABLE +" t where 1=1"+checkSql;
        return this.queryForList(sql);
    }
    
    /**
     * 删除数据.
     * @param tablecode --表名
     * @param wheresql --条件
     * @return --
     */
    public void delDatas(String tablecode, String wheresql) {
        String sql = "delete from " + tablecode + " t where 1=1 ";
        if (wheresql != null && !wheresql.isEmpty()){
            sql += " and " + wheresql;
        }
        this.execute(sql);
    }
    
	
	 /**
    * 视图审核数据查询
    * @param guid --
    * @return
    */
   public List getEditData(String guid) {
		String sql = "select * from "+ VIEW_TABLE +" t where 1=1 and t.guid='"+guid+"'";
        return this.queryForList(sql);
   }
   
   
   /**
    * 视图校验
    * @param parms --
    * @return --
    */
   
   public Map<String, Object> checksql(HashMap<String,Object> parms) throws AppException {
       String sql=(String)parms.get("checksql");
   	try{
   		this.execute(sql);
   	}catch(Exception e){ 
   		parms.put("error", "校验视图失败");
   	        }   
       return parms;
   }
   
   /**
    * 视图保存
    * @param parms --
    * @return --
    */
   public void saveView(HashMap<String,Object> parms,String sql) throws AppException {
   		
	   this.save(parms, sql);
   }
     
   /**
    * 视图修改
    * @param sql --
    * @return --
    */
   public void updateView(String sql) throws AppException {
	   this.execute(sql);
   }
   
   /**
    * 视图创建
    * @param sql --
    * @return --
    */
    public void createView(String sql) throws AppException {
    	this.execute(sql);
   }
}
