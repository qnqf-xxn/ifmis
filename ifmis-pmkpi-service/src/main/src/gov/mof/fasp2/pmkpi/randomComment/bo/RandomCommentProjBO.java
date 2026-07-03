package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentProjDAO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomCommentProjBO extends PmkpiBO {

    private RandomCommentProjDAO randomCommentProjDAO;

    public void setRandomCommentProjDAO(RandomCommentProjDAO randomCommentProjDAO) {
        this.randomCommentProjDAO = randomCommentProjDAO;
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
            randomCommentProjDAO.saveAll(eledatas, randomCommentProjDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
//        	String sysvalue = this.getSystem("perf_performanceLefttree");
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            randomCommentProjDAO.saveAll(treeData, randomCommentProjDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.ISSCOPE='0' ");
        sql.append(" and T.ISOBJECT IS NULL ");
        sql.append(" and T.ISRANDOM IS NULL ");
        sql.append(" and T.WFSTATUS IS NULL AND T.WFID IS NULL");
        sql.append(" and t.bustype='"+bustype+"'");
        if(queryConfig != null&&queryConfig.size() > 0) {
            Map<String, String> queryParam = (Map<String, String>) queryConfig.get(0);
            String wfstatus = queryParam.get("wfstatus");
            String projname = queryParam.get("projname");
            String finintorgguid = queryParam.get("finintorgguid");
            String vcol2 = queryParam.get("vcol2");
            String amtmax = queryParam.get("amtmax");
            String amtmin = queryParam.get("amtmin");
            String adjuststatus = queryParam.get("adjuststatus");
            DecimalFormat formater = new DecimalFormat("0");
            formater.setRoundingMode(RoundingMode.HALF_UP);
            if(wfstatus!=null && !wfstatus.isEmpty()){
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
            if(adjuststatus!=null && !adjuststatus.isEmpty()){
                sql.append(" and adjuststatus in ('"+adjuststatus.replaceAll("\\,", "','")+"')");
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
        if (tablesql != null && !tablecode.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(randomCommentProjDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
		logger.error("抽评选择项目-----查询sql----------" + sql);
        return sql.toString();
    }

/*
    *//**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     *//*
    public Map<String, Object> getTreeData(String menuId) throws AppException {
    	Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("outformart", "#name");
        leftconfig.put("onlydata", Boolean.TRUE);
        leftconfig.put("activeTab", 0);
        leftconfig.put("dosearch", Boolean.TRUE);
        String[] dics= new String[]{"PMKPIPROKIND","PMKPIAGENCYALLPAY"};
        String[] dicname= new String[]{"绩效类型","预算单位"};
        leftconfig.put("dicname", dicname);
        leftconfig.put("tabs", this.getLeftTrees(menuId,dics,leftconfig));
        leftconfig.put("dics", dics);
        return leftconfig;
    }*/

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId,String bustype) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        String sysvalue = "program".equals(bustype) ? randomCommentProjDAO.getSystemAgencytree() : randomCommentProjDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
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
        data = randomCommentProjDAO.getLeftTree(tablecode, datarule);
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
	public Map<String, Object> submitProj(HashMap<String,Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");

		String isObject = (String) config.get("isObject");
		String tablecode = (String) config.get("tablecode");
		String workflow = (String) config.get("workflow");
        String actioncode = (String) config.get("actioncode");
        String remark = (String) config.get("remark");
        String busguid = (String) config.get("busguid");
        UserDTO user = SecureUtil.getCurrentUser();
		if(datas!=null && datas.size() > 0){
			for(int i=0;i<datas.size();i++){
				Map strmap = datas.get(i);
 				Map map = new HashMap<String,String>();
				String perfgoalguid = (String)strmap.get("perfgoalguid");
                String pro_code = (String)strmap.get("pro_code");
                String guid = StringUtil.createUUID();
				map.put("perfgoalguid", perfgoalguid);
				map.put("guid", guid);
				map.put("year", CommonUtil.getYear());
				map.put("province", user.getProvince());
				map.put("isscope", "0");
				map.put("isobject", isObject);
                map.put("pro_code", pro_code);
                map.put("creater", SecureUtil.getCurrentUserID());
                map.put("createtime", PerfUtil.getServerTimeStamp());
				projList.add(map);
//				randomCommentProjDAO.update("update PERF_T_RANDOMCOMMENT set isobject = '"+isObject+"' where guid ='"+guid+"'");
			}
//			this.workflow(actioncode, workflow, remark, tablecode, datas);
		}
		if(projList!=null && projList.size() > 0){
			randomCommentProjDAO.saveAll(projList, tablecode);
			this.workflow(actioncode, workflow, remark, tablecode, projList);
		}
		config.put("success", true);
//		if(projList!=null && projList.size() > 0){
//			randomCommentProjDAO.updateAllByPK(projList, "perfgoalguid", "PERF_T_RANDOMCOMMENT");
//		}
		 return this.auditdefine(datas, busguid, actioncode, null);
	}
	
    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        for (int i = 0; i < datas.size(); i++) {
        	Map<String, Object> map = datas.get(i);
        	map.get("rcguid");
		}
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }


}
