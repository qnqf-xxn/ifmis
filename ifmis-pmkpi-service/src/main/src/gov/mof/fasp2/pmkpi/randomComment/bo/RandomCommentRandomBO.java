package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentRandomDAO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.*;

public class RandomCommentRandomBO extends PmkpiBO {

    private RandomCommentRandomDAO randomCommentRandomDAO;

    public void setRandomCommentRandomDAO(RandomCommentRandomDAO randomCommentRandomDAO) {
        this.randomCommentRandomDAO = randomCommentRandomDAO;
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
        String menuid = (String)params.get("menuid");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        String isleaf = (String)params.get("isleaf");
        String bustype = (String) params.get("bustype");

        if (tabcode != null && !tabcode.isEmpty() && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            randomCommentRandomDAO.saveAll(eledatas, randomCommentRandomDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            randomCommentRandomDAO.saveAll(treeData, randomCommentRandomDAO.PMKPI_TABLE_TMP_AGENCY);
        }

        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.bustype='"+bustype+"'");
        if("wait".equals(tabfilter)){
        	sql.append(" and t.ISSCOPE= '0' and t.ISOBJECT IS NULL and t.ISRANDOM IS NULL ");
        } else if("done".equals(tabfilter)){
        	sql.append(" and t.ISSCOPE= '0' and t.ISOBJECT IS NULL and t.ISRANDOM = '1' ");
        }
		if(queryConfig != null&&queryConfig.size() > 0) {
			Map<String, String> queryParam = (Map<String, String>) queryConfig.get(0);
			String wfstatus = queryParam.get("wfstatus");
			String projname = queryParam.get("projname");
			String finintorgguid = queryParam.get("finintorgguid");
			String vcol2 = queryParam.get("vcol2");
			String amtmax = queryParam.get("amtmax");
			String amtmin = queryParam.get("amtmin");
			DecimalFormat formater = new DecimalFormat("0");
			formater.setRoundingMode(RoundingMode.HALF_UP);
			if(wfstatus!=null && !wfstatus.isEmpty()){
				String[] split = wfstatus.split(",");
				StringBuilder resultStr = new StringBuilder();
				for (int i = 0; i < split.length; i++) {
					if(resultStr.length() == 0){
						resultStr.append("(")
								.append("WFSTATUS")
								.append("=")
								.append("'")
								.append(split[i])
								.append("'")
								.append(")");
					} else {
						resultStr.append(resultStr)
								.append("or")
								.append("(")
								.append("WFSTATUS")
								.append("=")
								.append("'")
								.append(split[i])
								.append("'")
								.append(")");
					}
				}
				String result = resultStr.toString();
				sql.append(" and ("+result+")");
			}
			if(projname!=null && !projname.isEmpty()){
				sql.append(" and projname like '%"+projname+"%'");
			}
			if(finintorgguid!=null && !finintorgguid.isEmpty()){
				sql.append(" and finintorgguid in ('"+finintorgguid.replaceAll("\\,", "','")+"')");
			}
			if(vcol2!=null && !vcol2.isEmpty()){
				sql.append(" and vcol2 in ('"+vcol2.replaceAll("\\,", "','")+"')");
			}
			if(amtmax!=null && !"".equals(amtmax)){
				if(isNumeric(amtmax)){
					sql.append(" and amt >= "+amtmax);
				}
			}
			if(amtmin!=null && !amtmin.isEmpty()){
				if(isNumeric(amtmin)){
					sql.append(" and amt <= "+amtmin);
				}
			}
		}
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(randomCommentRandomDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }

        if (!StringUtil.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
		logger.error("随机抽评管理-----查询sql----------" + sql);
		return sql.toString();
    }

	/**
	 * <p>左侧树</p >
	 * @param
	 * @author
	 * @date 2022/10/27 16:06
	 */
	public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
		String lefttabtype = (String) params.get("lefttabtype");
		String tablecode = (String) params.get("tablecode");
		String leftmenuid = (String) params.get("leftmenuid");
		String menuId = (String) params.get("menuid");
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
		//根据权限查询单位
		String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
		datarule += " and bustype='" + lefttabtype + "'";
		data = randomCommentRandomDAO.getLeftTree(tablecode, datarule);
		if (data.size() == 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("guid","treeroot");
			map.put("code","00");
			map.put("name","全部");
			map.put("superid","0");
			map.put("levelno","1");
			map.put("isleaf","0");
			data.add(map);
		}
		return data;
	}

	public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        String bustype = (String)params.get("bustype");
        String randomprojcount = (String)params.get("randomprojcount");
        Map<String, Object> forMap = new HashMap<String, Object>();
        List<Map<String, Object>> queryForList = new ArrayList<Map<String,Object>>();
        queryForList = randomCommentRandomDAO.queryForList("select * from V_PERF_t_random where bustype = '"+bustype+"'");
        if(queryForList!=null && queryForList.size() > 0){
            forMap = queryForList.get(0);
        }
        forMap.put("randomproj", randomprojcount);
        Map result = new HashMap();
        for(Map.Entry<String, Object> entry : forMap.entrySet()){
            String mapKey = entry.getKey().toLowerCase();
            result.put(mapKey, entry.getValue());
        }
        return result;
}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> submitRandom(HashMap<String,Object> config) throws AppException {
		List<Map<String, Object>> newList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("data");
		String bustype = (String) config.get("bustype");
		String israndom = (String) config.get("israndom");
		String tablecode = (String) config.get("tablecode");
		List<Map<String,Object>> randomList = this.getRandomList(datas, datas.size(),bustype);
		if(randomList!=null && randomList.size() > 0){
			for(int i=0;i<randomList.size();i++){
				Map strmap = randomList.get(i);
 				Map map = new HashMap<String,String>();
 				map.putAll(strmap);
//				String guid = (String)strmap.get("guid");
 				String guid = StringUtil.createUUID();
				map.put("guid", guid);
				map.put("israndom", israndom);
				newList.add(map);
//				randomCommentRandomDAO.update("update "+tablecode+" set israndom = '"+israndom+"' where guid ='"+guid+"'");
			}
		}
		if(newList!=null && newList.size() > 0){
			randomCommentRandomDAO.saveAll(newList, tablecode);
		}
		
//		if(newList!=null && newList() > 0){
//			randomCommentRandomDAO.updateAllByPK(newList, "guid", tablecode);
//		}
		config.put("result", newList);
		config.put("success", true);
		return config;
	}
	
	public Map save(HashMap config)  throws AppException{
		String random = (String) config.get("random");
		String bustype = (String) config.get("bustype");
		randomCommentRandomDAO.update("delete from V_PERF_T_RANDOM where bustype = '"+bustype+"'");
		Map map = new HashMap<String,String>();
		map.put("guid", StringUtil.createUUID());
		map.put("random", random);
		map.put("bustype", bustype);
		map.put("province", SecureUtil.getUserSelectProvince());
		map.put("year", CommonUtil.getYear());
		randomCommentRandomDAO.save(map, "PERF_T_RANDOM");
		return config;
	}
	
	/**  
	 * @Title: getRandomList  
	 * @Description: TODO(随机抽取)  
	 * @param paramList
	 * @param count
	 * @return   
	 */ 
	public List<Map<String, Object>> getRandomList(List<Map<String, Object>> paramList,int count,String bustype){
	    if(count==0){
	        return null;
	    }
	    List<Map<String, Object>> newList=new ArrayList();//生成新的list集合
		//int temp = randomCommentRandomDAO.queryForInt("select random from PERF_T_RANDOM where bustype = '"+bustype+"'");
		//if(count<=temp){//如果数据小于被抽取的数量
		//	newList.addAll(paramList);
		//}else {
		//	Collections.shuffle(paramList);
		//	newList = paramList.subList(0, temp);
		//}
		List list = randomCommentRandomDAO.queryForList("select random from V_PERF_T_RANDOM where bustype = '" + bustype + "'");
		if(list.size() > 0){
			Map map = (Map) list.get(0);
			String temp = (String) map.get("random");
			String[] split = temp.split(",");
			for(int i=0;i<split.length;i++){
				String selfresult = "";
				if(i==0){
					selfresult = "优";
				}else if(i==1){
					selfresult = "良";
				}else if(i==2){
					selfresult = "中";
				}else if(i==3){
					selfresult = "差";
				}
				List lists = randomCommentRandomDAO.queryForList("select * from V_PERF_T_RANDOMCOMMENT_PROJ t where t.bustype = '" + bustype + "' and t.ISSCOPE= '0' and t.ISOBJECT IS NULL and t.ISRANDOM IS NULL and t.selfresult ='"+selfresult+"' ");
				int sp = Integer.valueOf(split[i]);
				if(lists.size()<=sp){//如果数据小于被抽取的数量
					newList.addAll(lists);
				}else {
					Collections.shuffle(lists);
					List<Map<String, Object>> subList = lists.subList(0, sp);
					newList.addAll(subList);
				}
			}
		}


	    return newList;
	}

	public boolean queryRandom(String bustype) throws AppException {
	    int count = randomCommentRandomDAO.queryForInt("select count(1) from V_PERF_T_RANDOM where bustype = '"+bustype+"' and random is not null");
		if(count > 0){
			return true;
		} else {
			return false;
		}		
	}

	public String queryRandomCount(String bustype) throws AppException {
		List<Map<String, Object>> datas = randomCommentRandomDAO.queryForList("select random from V_PERF_T_RANDOM where bustype = '"+bustype+"' ");
		String str = "";
		if(datas.size() > 0){
			Map map = datas.get(0);
			str = (String) map.get("random");
		}
		return str;

	}

	public Map<String, Object> delByGuids(HashMap<String, Object> config) throws AppException {
		List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
		String tablecode = (String) config.get("tablecode");

		if (datas != null && datas.size() > 0) {
			for (int i = 0; i < datas.size(); i++) {
				Map strmap = datas.get(i);
				Map map = new HashMap<String, String>();
				String guid = (String) strmap.get("guid");
				map.put("guid", guid);
				map.put("isscope", null);
				projList.add(map);
				randomCommentRandomDAO.update("delete from " + tablecode + " where guid ='" + guid + "'");
			}
		}
		config.put("success", true);
		return config;
	}

}
