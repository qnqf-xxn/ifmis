package gov.mof.fasp2.pmkpi.setting.uservagency;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserVAgencyBO extends PmkpiDAO {

	private UserVAgencyDAO userVAgencyDAO;

	@Resource(name="pmkpi.uservagency.UserVAgencyDAO")
	public void setUserVAgencyDAO(UserVAgencyDAO userVAgencyDAO) {
		this.userVAgencyDAO = userVAgencyDAO;
	}

	/**
	 * 查询用户树
	 * @return
	 */
	public List<Map<String, Object>> getUserTree() {
		List<Map<String, Object>> treelist = userVAgencyDAO.getUserTree();
		//单位用户拼接上处室用户
		List<Map<String, Object>> busofficelist = userVAgencyDAO.getBusofficeUser();
		List<Map<String, Object>> treeslist = new ArrayList<Map<String, Object>>();
		treeslist.addAll(busofficelist);
		treeslist.addAll(treelist);
		return treeslist;
	}

	/**
	 * 查询单位树
	 * @return
	 */
	public List<Map<String, Object>> getAgencyTree() {
		List<Map<String, Object>> agencylist = userVAgencyDAO.getAgencyTree();
		List<Map<String, Object>> busofficelist = userVAgencyDAO.getBusofficeTree();
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();
		treelist.addAll(busofficelist);
		treelist.addAll(agencylist);
		return treelist;
	}

	/**
	 * 保存对应关系
	 * @param params
	 * @throws AppException
	 */
	@SuppressWarnings("unchecked")
	public void saveUserAndAgencyData(HashMap<String, Object> params) throws AppException {
		//用户数据
		List<Map<String, Object>> userdata = (List<Map<String, Object>>) params.get("userdata");
		//单位数据
		List<Map<String, Object>> agencydata = (List<Map<String, Object>>) params.get("agencydata");
		//用户GUID
		String userguid = (String) userdata.get(0).get("guid");
		//存储的List _checked=checked
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(agencydata.size() > 0){
			userVAgencyDAO.saveAll(userdata, userVAgencyDAO.PMKPI_TABLE_TMP_GUIDS);
			String delsql = " exists (select 1 from " + userVAgencyDAO.PMKPI_TABLE_TMP_GUIDS +" a where a.guid = t.userguid )";
			userVAgencyDAO.delDatas("V_PMKPI_T_USERVAGENCY", delsql);
			for (Map<String, Object> map : agencydata) {
				//String isleaf = map.get("isleaf").toString();
				Map<String, Object> savemap = new HashMap<String, Object>();
				//if(isleaf != null && "1".equals(isleaf)){
					savemap.put("userguid", userguid);
					savemap.put("agency", map.get("guid"));
					savemap.put("year", CommonUtil.getYear());
					savemap.put("province", CommonUtil.getProvince());
					list.add(savemap);
				//}
			}
		}else{
			userVAgencyDAO.saveAll(userdata, userVAgencyDAO.PMKPI_TABLE_TMP_GUIDS);
			String del = " exists (select 1 from " + userVAgencyDAO.PMKPI_TABLE_TMP_GUIDS +" a where a.guid = t.userguid )";
			userVAgencyDAO.delDatas("V_PMKPI_T_USERVAGENCY",del);
		}
		userVAgencyDAO.saveAll(list, "V_PMKPI_T_USERVAGENCY");
	}

	/**
	 * 查询已选择单位树
	 * @return
	 */
	public List<Map<String, Object>> getselectAgencyTree(String userguid) {
		List<Map<String, Object>> agencylist = userVAgencyDAO.getselectAgencyTree(userguid);
		List<Map<String, Object>> busofficelist = userVAgencyDAO.getselectBusofficeTree(userguid);
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();
		treelist.addAll(busofficelist);
		treelist.addAll(agencylist);
		return treelist;
	}

	/**
	 * 查询上年已选择单位树
	 * @return
	 */
	public List<Map<String, Object>> getLastYearAgencyTree(HashMap<String, Object> params) {
		String userguid = (String) params.get("userguid");
		Integer year = SecureUtil.getUserSelectYear();
		year = year - 1;
		List<Map<String, Object>> agencylist = userVAgencyDAO.getLastYearselectAgencyTree(userguid,year);
		List<Map<String, Object>> busofficelist = userVAgencyDAO.getLastYearselectBusofficeTree(userguid,year);
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();
		treelist.addAll(busofficelist);
		treelist.addAll(agencylist);
		return treelist;
	}

	/**
	 * 同步上年配置数据保存
	 * @param params
	 * @throws AppException
	 */
	@SuppressWarnings("unchecked")
	public void saveCopyUserAndAgencyData(HashMap<String, Object> params) throws AppException {
		//用户数据
		List<Map<String, Object>> userdata = (List<Map<String, Object>>) params.get("userdata");
		String userguid = (String) userdata.get(0).get("guid"); //用户GUID
		//单位数据
		List<Map<String, Object>> agencydatas = this.getselectAgencyTree(userguid);  //今年配置的单位
		List<Map<String, Object>> lastagencydatas = (List<Map<String, Object>>) params.get("lastagencydata");  //上年配置单位数据

		//循环判断
		for (Map<String, Object> agencydata : agencydatas) {
			String agency = (String) agencydata.get("code") +"_"+ (String)agencydata.get("name");
			for (Map<String, Object> lastagencydata : lastagencydatas) {
				String lastagency = (String) lastagencydata.get("code") +"_"+ (String)agencydata.get("name");
				if (agency.equals(lastagency)){
					lastagencydatas.remove(lastagencydata);
					break;
				}
			}
		}
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(lastagencydatas.size() > 0){
			for (Map<String, Object> map : lastagencydatas) {
				Map<String, Object> savemap = new HashMap<String, Object>();
				savemap.put("userguid", userguid);
				savemap.put("agency", map.get("guid"));
				savemap.put("year", CommonUtil.getYear());
				savemap.put("province", CommonUtil.getProvince());
				list.add(savemap);
			}
		}
		userVAgencyDAO.saveAll(list, "V_PMKPI_T_USERVAGENCY");
	}
}