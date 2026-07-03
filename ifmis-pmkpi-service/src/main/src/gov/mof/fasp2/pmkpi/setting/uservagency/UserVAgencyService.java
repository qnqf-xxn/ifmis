package gov.mof.fasp2.pmkpi.setting.uservagency;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PageComponent(serviceid = "pmkpiUserVAgencyService", 
        viewid = "pmkpiUserVAgencyService",
        jsLib = "/pmkpi/setting/uservagency/uservagencyservice.js",
        jsObjectName = "Ext.lt.uatemplate.AllotIndex")
public class UserVAgencyService extends PmkpiService {

	private UserVAgencyBO userVAgencyBO;

	@Resource(name="pmkpi.uservagency.UserVAgencyBOTX")
	public void setUserVAgencyBO(UserVAgencyBO userVAgencyBO) {
		this.userVAgencyBO = userVAgencyBO;
	}
	
	/**
	 * 查询用户树
	 * @return
	 * @throws AppException
	 */
	public Map<String,Object> getUserTree() throws AppException {
		Map<String,Object> remp = new HashMap<String, Object>();
        List<Map<String,Object>> treelist = userVAgencyBO.getUserTree();
        remp.put("userTree", treelist);
        return remp;
    }
	
	/**
	 * 查询单位树
	 * @return
	 * @throws AppException
	 */
	public Map<String,Object> getAgencyTree() throws AppException {
		Map<String,Object> remp = new HashMap<String, Object>();
        List<Map<String,Object>> treelist = userVAgencyBO.getAgencyTree();
        remp.put("agencyTree", treelist);
        return remp;
    }
	
	/**
	 * 查询已选择单位树
	 * @return
	 * @throws AppException
	 */
	public Map<String,Object> getselectAgencyTree(String userguid) throws AppException {
		Map<String,Object> remp = new HashMap<String, Object>();
        List<Map<String,Object>> treelist = userVAgencyBO.getselectAgencyTree(userguid);
        remp.put("agencyTree", treelist);
        return remp;
    }
	
	/**
     * 保存对应关系.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveUserAndAgencyData(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
        	userVAgencyBO.saveUserAndAgencyData(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

	/**
	 * 查询上年选择的单位
	 * @return
	 * @throws AppException
	 */
	public Map<String,Object> getLastYearAgencyTree(HashMap<String, Object> params) throws AppException {
		Map<String,Object> remp = new HashMap<String, Object>();
		List<Map<String,Object>> treelist = userVAgencyBO.getLastYearAgencyTree(params);
		remp.put("agencyTree", treelist);
		return remp;
	}

	/**
	 * 保存对应关系.
	 * @param params --
	 * @return --
	 */
	public Map<String, Object> saveCopyUserAndAgencyData(HashMap<String, Object> params) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			userVAgencyBO.saveCopyUserAndAgencyData(params);
			rs.put("success", true);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code",e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}

}
