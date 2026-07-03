package gov.mof.fasp2.pmkpi.setting.buspage.ui;

import gov.mof.fasp2.buscore.framework.cache.service.CacheManager;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: UiBO
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午05:33:07
 */
public class UiSetBO extends PmkpiBO {
	private UiSetDAO uiSetDAO;

	public void setUiSetDAO(UiSetDAO uiSetDAO) {
		this.uiSetDAO = uiSetDAO;
	}

	private CacheManager cacheManager;

	private CacheManager getCacheManager() {
		if (cacheManager == null) {
			cacheManager = (CacheManager) ServiceFactory.getBean("buscore.cache.cachemanager");
		}
		return cacheManager;
	}
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String) sqlmap.get("tablecode");
        String uikey = (String) sqlmap.get("uikey");
        StringBuffer returnsql;
        if ("BUSFW_T_UITABPAGE".equals(tablecode.toUpperCase().replaceAll("P#", ""))) {
            returnsql = new StringBuffer("select distinct t.*,'' as isquery, nvl(b.ischecktab, a.ischecktab) as ischecktab, nvl(b.checktable, a.checktable) as checktable from ");
            returnsql.append(tablecode).append(" t left join perf_t_uitabpage_chec a on a.key = t.key and a.code = t.code and a.year='2016' and a.province='87' ");
            returnsql.append(" left join v_perf_t_uitabpage_chec b on b.key = t.key and b.code = t.code ");
            returnsql.append(" where t.key='").append(uikey).append("'");
        } else {
            returnsql = new StringBuffer("select t.*,'' as isquery from ");
            returnsql.append(tablecode).append(" t where t.key='").append(uikey).append("'");
        }
        returnsql.append(" order by t.ordernum");
        return returnsql.toString();
    }

	/**
	 * 查询数据.
	 * @param param --
	 * @return --
	 */
	public List<Map<String, Object>> getData(HashMap<String, Object> param) {
		String key = (String) param.get("key");
		String tablecode = (String) param.get("tablecode");
		return uiSetDAO.getData(tablecode, key);
	}

	/**
     * 保存方法.
     * @param params --.
     * @return mesg -- 审核定义校验.
     */
	public void save(Map<String, Object> params) throws AppException {
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		//删除数据
//		List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
		//编辑区数据
		Map<String, Object> editdatas = (Map<String, Object>) params.get("editdatas");
		String tablecode = (String) params.get("tablecode");
		if(editdatas != null){
			uiSetDAO.save(editdatas, uiSetDAO.PMKPI_TABLE_TMP_AGENCY);
			String delsql = " exists(select 1 from " + uiSetDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
			if(datas.get(0).get("province")!=null && datas.get(0).get("year")!=null){//配置出province和year让他保存物理表
				uiSetDAO.delDatas("P#BUSFW_T_UITABLE", delsql + "and t.province = '"+datas.get(0).get("province")+"' and t.year ="+datas.get(0).get("year"));
				editdatas.put("province",datas.get(0).get("province"));
				editdatas.put("year",datas.get(0).get("year"));
				uiSetDAO.save(editdatas, "P#BUSFW_T_UITABLE");
			}else{
				uiSetDAO.delDatas("busfw_t_uitable", delsql);
				uiSetDAO.save(editdatas, "busfw_t_uitable");
			}
		}
		if (datas.size() > 0) {
			String key = (String) datas.get(0).get("key");
			String delsql = " t.key = '"+key+"'";
			if(datas.get(0).get("province")!=null && datas.get(0).get("year")!=null){//浙江，保存配置时保存视图年度会串，列配置出province和year让他保存物理表
				uiSetDAO.delDatas(tablecode.contains("BUSFW_T_")?("P#"+tablecode):tablecode, " t.key = '"+key+"' and t.province = '"+datas.get(0).get("province")+"' and t.year ="+datas.get(0).get("year"));
				uiSetDAO.saveAll(datas, tablecode.contains("BUSFW_T_")?("P#"+tablecode):tablecode);
			}else{
				uiSetDAO.delDatas(tablecode, delsql);
				uiSetDAO.saveAll(datas, tablecode);
			}
			List<String> cachenames = new ArrayList();
			if ("busfw_t_uifunction".equals(tablecode) || "BUSFW_T_UIFUNCTION".equals(tablecode)) {
				cachenames.add("busfw.cache.ui.uifunction");
			} else if ("busfw_t_uiqueryform".equals(tablecode) || "BUSFW_T_UIQUERYFORM".equals(tablecode)) {
				cachenames.add("busfw.cache.ui.uiqueryform");
			} else if ("busfw_t_uieditform".equals(tablecode) || "BUSFW_T_UIEDITFORM".equals(tablecode)) {
				cachenames.add("busfw.cache.ui.uieditform");
			} else if ("busfw_t_uitabpage".equals(tablecode) || "BUSFW_T_UITABPAGE".equals(tablecode)) {
				this.saveCheckTab(datas, delsql, key); //表权限配置入库
				cachenames.add("busfw.cache.ui.uitabpage");
			} else if ("busfw_t_uicolumn".equals(tablecode) || "BUSFW_T_UICOLUMN".equals(tablecode)) {
				cachenames.add("busfw.cache.ui.uidatatable");
			} else if ("v_perf_t_treetab".equals(tablecode) || "V_PERF_T_TREETAB".equals(tablecode)) {
				String cacheKey = uiSetDAO.PMKPI_CACHE_LEFTTAB + key;
				PerfUtil.reflashSynCacheJSONData(cacheKey, PerfUtil.parse2Json(datas), false);
			}
			if (cachenames.size() > 0) {
				getCacheManager().refreshCache(cachenames);
			}
		}
	}

    /**
	 * 查询数据.
	 * @return --
	 */
	public List<Map<String, Object>> getData(String tablecode, String wheresql, String ordernum) {
		return uiSetDAO.getData(tablecode, wheresql, ordernum);
	}

    /**
     * 获取编辑区表格数据.
     * @param param --
     * @return --
     */
	public List<Map<String,Object>> getUIData(HashMap<String, Object> param) {
		String uikey = (String) param.get("uikey");
		String tablecode = (String) param.get("tablecode");
		return uiSetDAO.getUIData(uikey,tablecode);
	}

	/**
	 * 获取编辑区表格数据.
	 * @param  --
	 * @return --
	 */
	public List<Map<String,Object>> getcolumn(String key, String tablecode) {
		return uiSetDAO.getUIData(key,tablecode);
	}

	/**
	 * <p>表权限配置入库</p >
	 *
	 * @author hw
	 * @date 2022/7/5 14:56
	 * @param
	 */
    public void saveCheckTab(List<Map<String, Object>> datas, String wheresql, String key) throws AppException {
    	logger.info("---保存页签是否校验配置信息-start...");
        List<Map<String, Object>> checks = new ArrayList<>();
		List<String> uncodes = new ArrayList<>();//不校验集合
		String tablecode = "v_perf_t_uitabpage_chec";
        for (Map<String, Object> map : datas) {
            String ischecktab = map.get("ischecktab") + "";
			String isvisiable = map.get("isvisiable") + "";
			String checktable = (String) map.get("checktable");
			//默认全部交验，不校验的保存到中间表
			if (("2".equals(ischecktab) && !"v_perf_file".equals(checktable) && "1".equals(isvisiable)) || ("1".equals(ischecktab) && "v_perf_file".equals(checktable))) {
				map.put("mainguid", map.get("guid"));
				map.put("tabname", map.get("name"));
				map.put("key", key);
				map.put("ischecktab", ischecktab);
				map.put("createtime", PerfUtil.getServerTimeStamp());
				map.put("updatetime", PerfUtil.getServerTimeStamp());
				map.put("year", SecureUtil.getUserPartitionYear());
				map.put("province", SecureUtil.getUserSelectProvince());
				map.remove("_locationposition");
				map.remove("_sortid");
				if (!uncodes.contains(map.get("code"))) {
					checks.add(map);
				}
				uncodes.add((String) map.get("code"));
            }
        }
		uiSetDAO.delDatas(tablecode, wheresql);
		String values;
		if (checks.size() > 0) {
        	uiSetDAO.saveAll(checks, tablecode);
			values = PerfUtil.parse2Json(checks);
		} else {
			values = PerfUtil.parse2Json(PerfUtil.NODATA);
		}
		String cacheKey = uiSetDAO.PMKPI_CACHE_UITABPAGEDATA + key;
		PerfUtil.reflashSynCacheJSONData(cacheKey, values, false);
		logger.info("---保存页签是否校验配置信息-end...");
    }

    /**
     * 获取表权限数据集
     * @return
     */
	public List getCheckTabData() throws AppException {
		IDataSetService iDataSetService = PerfServiceFactory.getIDataSetService();
		return iDataSetService.getAllRangesByWhereSql("PERFIYESORNO", null);
	}
}
