package gov.mof.fasp2.pmkpi.setting.auditdefine.define;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuditDefinedBO extends PmkpiBO  {

	private AuditDefinedDAO auditDefinedDAO;

    public void setAuditDefinedDAO(AuditDefinedDAO auditDefinedDAO) {
        this.auditDefinedDAO = auditDefinedDAO;
    }

    /**
     * 查询数据方法
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) {
    	Map<String, Object> backMap = new HashMap<String, Object>(); 
        List<Map<String, Object>> data = auditDefinedDAO.getData(parms);
        backMap.put("data", data);
        return backMap;
    }

	/**
	 * 保存数据方法
	 * @param config
	 * @return
	 * @throws AppException
	 */
	public Map<String, Object> save(HashMap<String, Object> config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        String guid = (String) config.get("guid");
        if(null != guid && !guid.isEmpty()){
            Map map = null;
            List<Map> datas = auditDefinedDAO.getByGuid(auditDefinedDAO.TABLE_CODE, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                map.putAll(config);
                map.put("updatetime", StringUtil.getSysDBDate());
                auditDefinedDAO.update(map, auditDefinedDAO.TABLE_CODE);
            } 
            backMap.put("success", true);
        }else {//新增
        	config.put("createtime", StringUtil.getSysDBDate());
        	config.put("updatetime", StringUtil.getSysDBDate());
        	config.put("guid", StringUtil.createUUID());
        	config.put("creater", user.getGuid());
        	config.put("province", CommonUtil.getProvince());
        	config.put("year", CommonUtil.getYear());
            config.put("isalltable", "2");
            config.put("recordadopt", "1");
        	auditDefinedDAO.save(config, auditDefinedDAO.TABLE_CODE);
        	backMap.put("success", true);
        }
        return backMap;
	}
	

    /**
     * 删除数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> deldatas(HashMap<String, Object> params)  throws AppException{
    	 //需要删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
       	try{
       		if (deldatas != null && deldatas.size() > 0) {
       			auditDefinedDAO.saveAll(deldatas, auditDefinedDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + auditDefinedDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                auditDefinedDAO.delDatas(auditDefinedDAO.TABLE_CODE, delsql);
            }
       	}catch(Exception e){
       		logger.error(e.getMessage(), e);
       		params.put("error", "删除报错，操作0行数据！");
           }
        
        return params;
    }

}
