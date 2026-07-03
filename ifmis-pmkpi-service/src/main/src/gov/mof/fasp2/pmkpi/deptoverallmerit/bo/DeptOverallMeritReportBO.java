package gov.mof.fasp2.pmkpi.deptoverallmerit.bo;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptoverallmerit.dao.DeptOverallMeritReportDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptOverallMeritReportBO extends PmkpiBO {
    private DeptOverallMeritReportDAO deptOverallMeritReportDAO;

    public void setDeptOverallMeritReportDAO(DeptOverallMeritReportDAO deptOverallMeritReportDAO) {
        this.deptOverallMeritReportDAO = deptOverallMeritReportDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String finintorgguid = null;
        UserDTO user = SecureUtil.getCurrentUser();
        if(user.getUsertype()==1){
        	finintorgguid = user.getDivision();
        }
        //页面类型
        //String pagetype = (String) params.get("pagetype");
        List<Map<String, Object>> data = null;
        //List queryConfig = (List) params.get("queryConfig");
        //Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) params.get("querySql");
        String menuid = (String)params.get("menuid");
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String viewtabcode = (String)params.get("viewtabcode");
        String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        //String workflow = (String) params.get("workflow");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        String bustype = (String) params.get("bustype");
        String viewtype = (String) params.get("viewtype");
        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIDEPT");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            deptOverallMeritReportDAO.saveAll(eledatas, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "PMKPIDEPT");
            deptOverallMeritReportDAO.saveAll(treeData, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(viewtabcode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype='").append(bustype).append("'");
        if("audit".equals(viewtype)){
        	sql.append(" and t.finintorgguid ='").append(finintorgguid).append("'");
        }else{
        	sql.append(" and t.ismain='1'");
        }
        if (wheresql != null && !StringUtils.isEmpty(wheresql)){
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
            sql.append(" and (").append(tabfilter).append(")");
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        data = deptOverallMeritReportDAO.queryForList(sql.toString());
        backMap.put("data", data);
        return backMap;
    }
        
    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("name", "查询");
        leftconfig.put("expandlevel", 1);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("datas", this.getLeftTree(menuId,deptOverallMeritReportDAO.getSystemDepttree()));
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //Map<String, Object> urlparameters = (Map<String, Object>) params.get("urlparameters");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }
    
    /**
     * 自评提交
     * @param params --
     * @return --
     */
    public Map<String, Object> sendToFinintorg(HashMap<String, Object> params) throws AppException {
    	List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
    	String tablecode = (String) params.get("tablecode");
    	String actioncode = (String) params.get("actioncode");
    	String bustype = (String)params.get("bustype");
        String menuid = (String)params.get("menuid");
    	String wheresql1 = " t.menuid = '"+menuid+"' and t.bustype = '"+bustype+"' ";
    	List<Map<String, Object>> mdatas = deptOverallMeritReportDAO.getDataList("PERF_T_RANDOMQUALITY_MENU", wheresql1);
    	String code = "";
    	String tmpsql ="";
    	if(mdatas.size() > 0){
    		Map<String, Object> map = mdatas.get(0);
         	code = (String) map.get("code");
         	tmpsql +=" code = '"+code+"'";
        }else{
        	tmpsql +=" 1!=1 ";
        }
    	List<Map<String, Object>> resultdatas = new ArrayList<Map<String,Object>>();
    	for (Map<String, Object> map : datas) {
    		String perfguid = (String)map.get("perfgoalguid");
    		String agencyguid = (String)map.get("agencyguid");
    		String deptfinintorg = getFinintorgguidByAgency(agencyguid);
    		if("cancelsendaudit".equals(actioncode)){
    			map.put("reportstatus",1==(Integer)map.get("reportstatus") ? 0 : 1);
    		}else{
    			map.put("reportstatus",1==(Integer)map.get("reportstatus") ? 2 : 1);
    		}
    		//查询模板有几个处室，分解数据
    		List<Map<String, Object>> tdatas =deptOverallMeritReportDAO.queryForList("select finintorgguid,count(1) from perf_v_deptevalsecoretmp where "+tmpsql+" group by finintorgguid");
    		for (Map<String, Object> tmap : tdatas) {
    			String finintorgguid = (String)tmap.get("finintorgguid");
    			if(finintorgguid!=null && !StringUtils.isEmpty(finintorgguid) && !deptfinintorg.equals(finintorgguid)){
    				Map dmap = new HashMap<String,String>();
    				dmap.putAll(map);
    				dmap.put("finintorgguid", finintorgguid);
    				dmap.put("perfgoalguid", perfguid);
    				dmap.put("ismain", "0");
    				dmap.put("guid", this.getCreateguid());
    				resultdatas.add(dmap); 
    			}
			}
		}
    	//处理处室分解数据
    	if("cancelsendaudit".equals(actioncode)){
    		deptOverallMeritReportDAO.saveAll(datas, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " ismain ='0' and exists(select 1 from " + deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.perfgoalguid)";
    		deptOverallMeritReportDAO.delDatas(tablecode, delsql);
    	}else{
    		deptOverallMeritReportDAO.saveAll(resultdatas, tablecode);
    	}
    	//更新部门数据
    	deptOverallMeritReportDAO.updateAllByPK(datas, "guid", tablecode);
    	String busguid = (String) params.get("busguid");
    	return this.auditdefine(datas, busguid,"perf", null);
    }
    
    public String getFinintorgguidByAgency(String agency){
    	String finintorgguid = "";
    	List<Map<String, Object>> datas =deptOverallMeritReportDAO.queryForList("select finintorgguid from pmkpi_fasp_t_pubagency t where t.guid ='"+agency+"'");
        if(datas!=null && datas.size()>0){
        	finintorgguid = (String) datas.get(0).get("finintorgguid");
        }
        return finintorgguid;
    }
    
    /**
     * 处室打分提交
     * @param params --
     * @return --
     */
    public Map<String, Object> sendtonext(HashMap<String, Object> params) throws AppException {
    	List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
    	String actioncode = (String) params.get("actioncode");
    	for (Map<String, Object> map : datas) {
    		if("cancelsendaudit".equals(actioncode)){
    			map.put("reportstatus",1==(Integer)map.get("reportstatus") ? 0 : 1);
    		}else{
    			map.put("reportstatus",1==(Integer)map.get("reportstatus") ? 2 : 1);
    		}
		}
    	String tablecode = (String) params.get("tablecode");
    	String busguid = (String) params.get("busguid");
    	deptOverallMeritReportDAO.updateAllByPK(datas, "guid", tablecode);
    	return this.auditdefine(datas, busguid,"perf", null);
    }

	public Map<String, Object> checkSubmitstatus(HashMap<String, Object> params)  throws AppException {
		Map<String, Object> rs= new HashMap<String, Object>();
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		deptOverallMeritReportDAO.saveAll(datas, deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY);
        String sql = " reportstatus = '2' and exists(select 1 from " + deptOverallMeritReportDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.perfgoalguid)";
        int count = deptOverallMeritReportDAO.queryForInt("select count(1) c from perf_t_deptoverallmerit t where "+sql+" ");
		if(count>0){
			rs.put("success", false);
		}else{
			rs.put("success", true);
		}
		return rs;
	}

    public Map<String,Object> checkFile (HashMap<String, Object> params){
        String billid = (String) params.get("mainguid");
        Map<String, Object> rs = new HashMap<String, Object>();
        List<Map<String, Object>> data = deptOverallMeritReportDAO.checkFile(billid);
        if(data.size() > 0){
            String msg = "";
            for (Map<String, Object> map: data) {
                if("0".equals(map.get("code"))){
                    if(msg.length() == 0 && "".equals(msg)){
                        msg = (String)map.get("name");
                    } else {
                        msg = msg + (String)map.get("name");
                    }
                }
            }
            if(msg.length() > 0){
                rs.put("success",false);
                rs.put("msg",msg);
            }else{
                rs.put("success",true);
            }

        } else {
            rs.put("success",false);
            rs.put("msg","校验异常，联系管理员！");
        }
        return rs;

    }
}
