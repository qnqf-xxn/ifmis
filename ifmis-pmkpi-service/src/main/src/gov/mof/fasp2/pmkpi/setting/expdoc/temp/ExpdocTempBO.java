package gov.mof.fasp2.pmkpi.setting.expdoc.temp;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
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
public class ExpdocTempBO extends PmkpiBO {
	private ExpdocTempDAO expdocTempDAO;

	public void setExpdocTempDAO(ExpdocTempDAO expdocTempDAO) {
		this.expdocTempDAO = expdocTempDAO;
	}

	public String getVodSql(Map sqlmap) throws AppException {
		String tablecode = (String) sqlmap.get("tablecode");
		String mainguid = (String) sqlmap.get("mainguid");
		StringBuffer returnsql = new StringBuffer("select t.* from ");
		returnsql.append(tablecode).append(" t where t.mainguid='").append(mainguid).append("'");
		returnsql.append(" order by t.ordernum");
		return returnsql.toString();
	}
	
	/**
     * 保存方法.
     * @param params --.
     * @return mesg -- 审核定义校验.
     */
	public void save(Map<String, Object> params) throws AppException {
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		//删除数据
		List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
		List<Map<String, Object>> addlist = new ArrayList<>();
		List<Map<String, Object>> uplist = new ArrayList<>();
		//编辑区数据
		Map<String, Object> editdatas = (Map<String, Object>) params.get("editdatas");
		String maintablecode = (String) params.get("maintablecode");
		String tablecode = (String) params.get("tablecode");
		String mainguid = (String) params.get("mainguid");
		int i = 0;
		for (Map<String, Object> map : datas) {
			String rowtype = (String) map.get("rowtype");
			i++;
			String ordernum = map.get("ordernum") + "";
			if (ordernum == null || ordernum.isEmpty() || "null".equals(ordernum)) {
				map.put("ordernum", i);
			}
			if (rowtype != null && "add".equals(rowtype)) {
				map.put("createtime", PerfUtil.getServerTimeStamp());
				map.put("updatetime", PerfUtil.getServerTimeStamp());
				map.put("province", SecureUtil.getUserSelectProvince());
				map.put("year", SecureUtil.getUserSelectYear());
				map.put("status", 1);
				addlist.add(map);
			} else {
				map.put("updatetime", PerfUtil.getServerTimeStamp());
				uplist.add(map);
			}
		}
		if (addlist.size() > 0) {
			expdocTempDAO.saveAll(addlist, tablecode);
		}
		if (uplist.size() > 0) {
			expdocTempDAO.updateAllByPK(uplist, "guid", tablecode);
		}
		if (deldatas.size() > 0) {
			expdocTempDAO.saveAll(deldatas, expdocTempDAO.PMKPI_TABLE_TMP_GUIDS);
			StringBuffer delsql = new StringBuffer(" exists(select 1 from ");
			delsql.append(expdocTempDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid=t.guid) ");
			expdocTempDAO.delDatas(tablecode, delsql.toString());
		}
		if(editdatas != null){
			editdatas.put("updatetime", PerfUtil.getServerTimeStamp());
			String wheresql = "guid=?";
			int num = expdocTempDAO.getDataCount(maintablecode, wheresql, new String[]{mainguid});
			if (num == 0) {
				editdatas.put("guid", mainguid);
				editdatas.put("createtime", PerfUtil.getServerTimeStamp());
				editdatas.put("province",SecureUtil.getUserSelectProvince());
				editdatas.put("year",SecureUtil.getUserSelectYear());
				editdatas.put("status", 1);
				expdocTempDAO.save(editdatas, maintablecode);
			} else {
				expdocTempDAO.update(editdatas, maintablecode);
			}
		}
		String templatecode = (String) editdatas.get("templatecode");
		if (!StringUtil.isEmpty(templatecode)) {
			Map<String, Object> expdocMap = new HashMap<>();
			expdocMap.put("maindata", editdatas);
			expdocMap.put("subdata", datas);
			String cacheKey = expdocTempDAO.PMKPI_CACHE_EXPEOC + templatecode;
			PerfUtil.reflashSynCacheJSONData(cacheKey, PerfUtil.parse2Json(expdocMap), false);
		}
	}
    
}
