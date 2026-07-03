package gov.mof.fasp2.pmkpi.setting.buspage;

import gov.mof.fasp2.buscore.framework.cache.service.CacheManager;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: BusAppendBO
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:10:57
 */
public class BusAppendBO extends PmkpiBO {
	private BusAppendDAO busAppendDAO;

	public void setBusAppendDAO(BusAppendDAO busAppendDAO) {
		this.busAppendDAO = busAppendDAO;
	}

	private CacheManager cacheManager;

	private CacheManager getCacheManager() {
		if (cacheManager == null) {
			cacheManager = (CacheManager) ServiceFactory.getBean("buscore.cache.cachemanager");
		}
		return cacheManager;
	}

	/**
	 * 查询左侧树。
	 * @return
	 * @throws AppException
	 */
	public Map getMenuLeftTree() throws Exception {
		Map leftconfig = new HashMap();
		//根据权限查询单位
		List<Map<String, Object>> list = this.getTreeData();
		leftconfig.put("datas", list);
		leftconfig.put("showRootNode", Boolean.TRUE);
		leftconfig.put("dosearch", Boolean.FALSE);
		leftconfig.put("outformart", "#code-#name");
		leftconfig.put("expandlevel", 1);
		leftconfig.put("name", "菜单");
		return leftconfig;
	}

	public List<Map<String, Object>> getTreeData(){
		return busAppendDAO.getTreeData();
	}

	/**
	 * 获取列表数据.
	 * @param param --
	 * @return --
	 */
	public List<Map<String, Object>> getData(HashMap<String, Object> param) {
		String key = (String) param.get("uikey");
		List<Map<String, Object>> list = busAppendDAO.getData(key);
		String wheresql = " key = '" + key + "'";
		int count = busAppendDAO.getDataCount("v_perf_t_treetab", wheresql);
		if (count > 0) {
			Map<String, Object> leftTabMap = new HashMap<>();
			leftTabMap.put("componentname", "左侧树页签");
			leftTabMap.put("componentid", "pmkpilefttreetab");
			leftTabMap.put("config", "绩效配置，当前页面保存无效");
			leftTabMap.put("url", key);
			list.add(leftTabMap);
		}
		return list;
	}

	/**
	 * 列表保存.
	 * @param params --
	 * @return --
	 */
	public void save(HashMap<String, Object> params) throws AppException {
		//全部数据
		String uikey = (String) params.get("uikey");
		if (uikey == null && uikey.length() == 0) {
			return;
		}
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		if (datas != null && datas.size() > 0) {
			for (Map<String, Object> data : datas) {
				if ("pmkpilefttreetab".equals(data.get("componentid"))) {
					datas.remove(data);
					break;
				}
			}
			String tablecode = "bus_t_pageconsolecomconfig";
			busAppendDAO.delDatas(tablecode, " url='" + uikey + "'");
			busAppendDAO.saveAll(datas, tablecode);
			List<String> cachenames = new ArrayList();
			cachenames.add("buscore.cache.common.console");
			getCacheManager().refreshCache(cachenames);
		}
	}

	/**
	 * 菜单保存.
	 * @param params --
	 * @return --
	 */
	public void saveMenu(HashMap<String, Object> params) throws AppException {
		String pagetype = (String) params.get("pagetype");
		String tablecode = "perf_t_pagemenu";
		Map<String, Object> data = (Map<String, Object>) params.get("data");
		this.getBasMap(data, "add");
		data.put("updatetime", PerfUtil.getServerTimeStamp());
		if (pagetype != null && "add".equals(pagetype)) {
			data.put("guid",this.getCreateguid());
			data.put("createtime", PerfUtil.getServerTimeStamp());
			data.put("creater", SecureUtil.getCurrentUserID());
			data.put("status", 1);
			busAppendDAO.save(data, tablecode);
		} else {
			busAppendDAO.update(data, tablecode);
		}
	}

	/**
	 * 删除
	 * @param parms --
	 * @return
	 */
	public Map<String, Object> del(HashMap<String, Object> parms) {
		Map<String, Object> backMap = new HashMap<String, Object>();
		String guid = (String) parms.get("guid");
		String delsql = " guid='" + guid + "'";
		busAppendDAO.delDatas("perf_t_pagemenu", delsql);
		backMap.put("flg","1");
		return backMap;
	}
}
