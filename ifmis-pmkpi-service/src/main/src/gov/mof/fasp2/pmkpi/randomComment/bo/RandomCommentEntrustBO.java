package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentEntrustDAO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomCommentEntrustBO extends PmkpiBO {

    private RandomCommentEntrustDAO randomCommentEntrustDAO;

    public void setRandomCommentEntrustDAO(RandomCommentEntrustDAO randomCommentEntrustDAO) {
        this.randomCommentEntrustDAO = randomCommentEntrustDAO;
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
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            randomCommentEntrustDAO.saveAll(eledatas, randomCommentEntrustDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            randomCommentEntrustDAO.saveAll(treeData, randomCommentEntrustDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.ISSCOPE='0' ");
        sql.append(" and (T.ISOBJECT='1' or T.ISRANDOM='1') ");
        sql.append(" and t.bustype='"+bustype+"'");
        if("waitaudit".equals(tabfilter)){
        	sql.append(" and T.MEACHGUID is null ");
        } else if("alreadyaudit".equals(tabfilter)){
        	sql.append(" and T.MEACHGUID is not null ");
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
            if(wfstatus!=null && !wfstatus.isEmpty() && !"".equals(wfstatus)){
                String[] split = wfstatus.split(",");
                StringBuilder resultStr = new StringBuilder();
                for (int i = 0; i < split.length; i++) {
                    if(resultStr.length() == 0 || resultStr == null){
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
            if(amtmax!=null && !amtmax.isEmpty()){
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
            sql.append(" and exists(select * from ").append(randomCommentEntrustDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
		logger.debug("抽评委托列表-----查询sql----------" + sql);
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
        data = randomCommentEntrustDAO.getLeftTree(tablecode, datarule);
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

	@SuppressWarnings("unchecked")
	public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
		String tablecode = (String) config.get("tablecode");

		if(datas!=null && datas.size() > 0){
			for(int i=0;i<datas.size();i++){
				Map strmap = datas.get(i);
 				Map map = new HashMap<String,String>();
				String guid = (String)strmap.get("guid");
				map.put("guid", guid);
				map.put("meachguid", null);
				projList.add(map);
				randomCommentEntrustDAO.update("update "+tablecode+" set meachguid = null where guid ='"+guid+"'");
			}
		}
		config.put("success", true);
		return config;
	}

}
