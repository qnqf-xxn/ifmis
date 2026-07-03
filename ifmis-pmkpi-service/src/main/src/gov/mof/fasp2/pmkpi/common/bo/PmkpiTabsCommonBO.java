package gov.mof.fasp2.pmkpi.common.bo;

import gov.mof.fasp2.buscommon.bill.bo.CommonBO;
import gov.mof.fasp2.buscommon.bill.dto.BillDTO;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PmkpiTabsCommonBO extends CommonBO {

	public List<BillDTO> findTabs(String tabs) throws AppException{
		String sql = "select * from pmkpi_v_uitabs t where t.tabsid = ? order by componentordernum";
		return this.getCommonDAO().queryForList(sql, new Object[]{tabs});
	}

	public List findForm(String tabs) {
		String sql = "select * FROM pmkpi_t_form t where t.guid = ? ";
		return this.getCommonDAO().queryForList(sql, new Object[]{tabs});
	}

	public Map findField(String formid) {
		Map map = new HashMap();
		String textSql = "select * from pmkpi_t_field where formid = ? and plugins = 'text' ";
		List textList = this.getCommonDAO().queryForList(textSql, new Object[]{formid});
		if(textList!=null && textList.size() > 0){
			map.put("textList", textList);
		}
		String selectSql = "select * from pmkpi_t_field where formid = ? and plugins = 'select' ";
		List selectList = this.getCommonDAO().queryForList(selectSql, new Object[]{formid});
		if(selectList!=null && selectList.size() > 0){
			map.put("selectList", selectList);
		}
		
		String textareaSql = "select * from pmkpi_t_field where formid = ? and plugins = 'textarea' ";
		List textareaList = this.getCommonDAO().queryForList(textareaSql, new Object[]{formid});
		if(textareaList!=null && textareaList.size() > 0){
			map.put("textareaList", textareaList);
		}
		return map;
	}

	public Map save(HashMap config) throws AppException {
		UserDTO user = SecureUtil.getCurrentUser();
		String keyguid = config.get("keyguid")==null?"":config.get("keyguid").toString();
		String tablecode = config.get("tablecode")==null?"":config.get("tablecode").toString();
		String delsql = "delete from "+tablecode+" where keyguid = '"+keyguid+"'";
		this.getCommonDAO().update(delsql);
		config.put("guid", StringUtil.createUUID());
		config.put("year", CommonUtil.getYear());
		config.put("keyguid", keyguid);
		config.put("province", user.getProvince());
		try {
			this.getCommonDAO().save(config, tablecode);
			config.clear();
			config.put("success", "success");
		} catch (AppException e) {
			config.clear();
			config.put("error", "error");
		}
		return config;
	}

	public List selWpInfo(String keyguid,String formid) {
		// 获取当前模板的数据保存到那张表里面
		String tablesql = "select * from pmkpi_t_field where formid = '"+formid+"' ";
		List tableList =  this.getCommonDAO().queryForList(tablesql);
		String tablecode = "";
		if(tableList!=null && tableList.size() > 0){
			tablecode = (String)((Map)tableList.get(0)).get("tablename");
			//获取当前模板中的相关数据
			String selsql = "select * from "+tablecode+" where keyguid = '"+keyguid+"'";
			List relist = new ArrayList();
			List list = this.getCommonDAO().queryForList(selsql);
			if(list!=null && list.size()>0){
				Map map = (Map)list.get(0);
				//获取当前模板中所有的字段
				String textSql = "select * from pmkpi_t_field where formid = ? ";
				List textList = this.getCommonDAO().queryForList(textSql, new Object[]{formid});
				if(textList!=null && textList.size()>0){
					for(int i=0;i<textList.size();i++){
						Map reMap = new HashMap();
						Map textMap = (Map)textList.get(i);
						reMap.put("name", textMap.get("fieldname"));
						reMap.put("value", map.get(textMap.get("fieldname")));
						reMap.put("type", textMap.get("plugins"));
						relist.add(reMap);
					}
				}
				return relist;
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
}
