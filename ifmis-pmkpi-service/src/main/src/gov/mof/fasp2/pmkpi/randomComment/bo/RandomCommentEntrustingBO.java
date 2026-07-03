package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentEntrustingDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomCommentEntrustingBO extends PmkpiBO {

    private RandomCommentEntrustingDAO randomCommentEntrustingDAO;

    public void setRandomCommentEntrustingDAO(RandomCommentEntrustingDAO randomCommentEntrustingDAO) {
        this.randomCommentEntrustingDAO = randomCommentEntrustingDAO;
    }

	/**
	 *  列表的查询方法.
	 * <p>Title: getVodSql</p>
	 * <p>Description: </p>
	 * @param params
	 * @return
	 * @throws AppException
	 * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
	 */
	@Override
	public String getVodSql(Map params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = null;
        List queryConfig = (List) params.get("queryConfig");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where 1=1 ");
		if(queryConfig != null&&queryConfig.size() > 0) {
			Map<String, String> queryParam = (Map<String, String>) queryConfig.get(0);
			String agencyname = queryParam.get("agencyname");
			if(agencyname!=null && !agencyname.isEmpty()){
				sql.append(" and agencyname like '%"+agencyname+"%'");
			}
		}
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
		logger.debug("抽评委托第三方-----查询sql----------" + sql);
		return sql.toString();
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> submit(HashMap<String,Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
		String guids = (String) config.get("guids");
		String tablecode = (String) config.get("tablecode");
		logger.error("委托第三方表："+tablecode);
		Map<String, Object> data = datas.get(0);
		if(guids != null && !guids.isEmpty()){
			String[] split = guids.split(",");
			if(split.length > 0){
				for (int i = 0; i < split.length; i++) {
					Map map = new HashMap<String,String>();
					String meachguid = (String)data.get("guid");
					map.put("meachguid", meachguid);
					map.put("guid", split[i]);
					projList.add(map);
					randomCommentEntrustingDAO.update("update "+tablecode+" set meachguid = '"+meachguid+"' where guid ='"+split[i]+"'");
				}
			}
		}
		config.put("success", true);
		return config;
	}
}
