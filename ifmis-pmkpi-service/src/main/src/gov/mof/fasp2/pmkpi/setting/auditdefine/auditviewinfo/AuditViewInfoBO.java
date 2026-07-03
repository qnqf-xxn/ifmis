package gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.apache.commons.lang3.StringUtils;

import java.text.SimpleDateFormat;
import java.util.*;

public class AuditViewInfoBO  extends PmkpiBO{

	private AuditViewInfoDAO auditViewInfoDAO;

    public void setAuditViewInfoDAO(AuditViewInfoDAO auditViewInfoDAO) {
        this.auditViewInfoDAO = auditViewInfoDAO;
    }
    
    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) {
    	Map<String, Object> backMap = new HashMap<String, Object>(); 
    	String checkSql=(String)params.get("querySql");
    	if(!StringUtils.isEmpty(checkSql)){
    		checkSql=" and "+checkSql;
    	}
        List<Map<String, Object>> wfdata = auditViewInfoDAO.getViewData(checkSql);
        backMap.put("data", wfdata);
        return backMap;
    }
    /**
     * 删除数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> delData(HashMap<String, Object> params)  throws AppException{
    	 //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("list");
       	try{
       		if (deldatas.size() > 0) {
            	auditViewInfoDAO.saveAll(deldatas, auditViewInfoDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + auditViewInfoDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                auditViewInfoDAO.delDatas(auditViewInfoDAO.VIEW_TABLE, delsql);
            }
       	}catch(Exception e){
       		logger.error(e.getMessage(), e);
       		params.put("error", "删除报错，操作0行数据！");
           }
        
        return params;
    }
    
    /**
     * 页面跳转根据guid查询数据方法
     * @param guid --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getEditData(String guid) {
            Map map = new HashMap();
        	List list=auditViewInfoDAO.getEditData(guid);
            if (list.size() > 0) {
    			map = (Map) list.get(0);
    		}
        return map;
    }
    
    
    /**
     * 视图校验
     * @param parms --
     * @return --
     */
    
    public Map<String, Object> checksql(HashMap<String,Object> parms) throws AppException {
    	return auditViewInfoDAO.checksql(parms);
    }
    
    /**
     * 视图保存
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
    	String id=(String)parms.get("guid");
       	String code=(String)parms.get("code");
       	String checkSql=(String)parms.get("checksql");
       	String view="create or replace view "+code+ " as "+checkSql;
       	parms.put("year", CommonUtil.getYear());
       	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
       	parms.put("createtime", formatter.format(new Date()));
       	parms.put("status", "1");
       	parms.put("appid", "pmkpi");
       	parms.put("province", CommonUtil.getProvince());
       	try{
	       		auditViewInfoDAO.createView(view);
	       	}catch(Exception e){
	       		parms.put("error", "创建视图失败");
	       		return parms;
	    }  
       	try{
       		if(StringUtils.isEmpty(id)){
       		id = StringUtil.createUUID();
       		parms.put("guid",id);
       		auditViewInfoDAO.saveView(parms,auditViewInfoDAO.VIEW_TABLE);
       		}else{ 
       		String updatetime=formatter.format(new Date());
       		parms.put("updatetime",updatetime);
			List<String> cols = new ArrayList<String>(parms.keySet());
			cols.remove("province");
			cols.remove("year");
       		auditViewInfoDAO.update(cols,parms,auditViewInfoDAO.VIEW_TABLE);
       		}
       	}catch(Exception e){
       		logger.error(e.getMessage(), e);
       		parms.put("error", "编辑视图失败");
           }
    	return parms;
    }
}
