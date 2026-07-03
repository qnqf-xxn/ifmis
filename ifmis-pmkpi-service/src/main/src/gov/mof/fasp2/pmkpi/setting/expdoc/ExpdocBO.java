package gov.mof.fasp2.pmkpi.setting.expdoc;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: BusAppendBO
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:10:57
 */
public class ExpdocBO extends PmkpiBO {
	private ExpdocDAO expdocDAO;

	public void setExpdocDAO(ExpdocDAO expdocDAO) {
		this.expdocDAO = expdocDAO;
	}

	public String getVodSql(Map sqlmap) throws AppException {
		StringBuffer sql = new StringBuffer();
		String tablecode = (String) sqlmap.get("tablecoe");
		String querySql = (String) sqlmap.get("querySql");
		sql.append(" select * from ").append(tablecode);
		if(querySql!=null&& !querySql.isEmpty()){
			sql.append(" where (").append(querySql).append(") ");
		}
		sql.append(" order by updatetime");
		return sql.toString();
	}

	/**
	 * 删除
	 * @param parms --
	 * @return
	 */
	public Map<String, Object> del(HashMap<String, Object> parms) {
		Map<String, Object> backMap = new HashMap<String, Object>();
		String tablecode = (String) parms.get("tablecode");
		List<Map<String,Object>> dellist =  (List<Map<String,Object>>)parms.get("datas");
		try {
			expdocDAO.saveAll(dellist,expdocDAO.PMKPI_TABLE_TMP_GUIDS);
			String delsql = " exists(select 1 from " + expdocDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ";
			expdocDAO.delDatas(tablecode, delsql);
			delsql = " exists(select 1 from " + expdocDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
			expdocDAO.delDatas("v_perf_t_expdocsub", delsql);
			backMap.put("flg","1");
		}catch (AppException e){
			logger.error("删除模板定义时："+e.getMessage());
			backMap.put("flg","2");
		}
		return backMap;
	}
}
