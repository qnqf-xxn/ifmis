package gov.mof.fasp2.pmkpi.deptoverallmerit.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptoverallmerit.dao.DeptOverallMeritReportDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptOverallMeritAuditBO extends PmkpiBO {
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
        //页面类型
        //String pagetype = (String) params.get("pagetype");
        List<Map<String, Object>> data = null;
//        List queryConfig = (List) params.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
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
     * 获取审核数据.
     * @param nodeguid --节点guid
     * @return --
     * @throws AppException
     */
    @SuppressWarnings({"unchecked", "rawtypes" })
    public Map<String, Object> getTableData(String busguid, String audittype, String agencyguid, String nodeguid)
            throws AppException {
        Map<String, Object> rt = new HashMap<String, Object>();
        List<Map<String, Object>> auditlist = deptOverallMeritReportDAO.getAuditData(busguid, audittype, nodeguid);
        String mainguid = "";
        Map<String, Object> editmap = new HashMap<String, Object>();
        if (auditlist.size() > 0) {
            editmap = auditlist.get(0);
            mainguid = String.valueOf(editmap.get("guid"));
        }
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<Map<String, Object>> subdatas = deptOverallMeritReportDAO.getData(mainguid);
        for (Map<String, Object> data : subdatas) {
            data.put("tempguid", data.get("guid"));
        }
        dataMap.put("datas", subdatas);
        rt.putAll(dataMap);
        rt.put("editmap", editmap);
        return rt;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> resMap = new HashMap<String, Object>();
        Map<String, Object> mainMap = (Map<String, Object>) param.get("maindata");
        String mainguid = String.valueOf(param.get("mainguid"));
        String nodeguid = String.valueOf(param.get("nodeguid"));
        String audittype = String.valueOf(param.get("audittype"));
        String agencyguid = String.valueOf(param.get("agency"));
        mainMap.put("mainguid", mainguid);
        mainMap.put("nodeguid", nodeguid);
        mainMap.put("agencyguid", agencyguid);
        mainMap.put("createtime", StringUtil.getSysDBDate());
        mainMap.put("updatetime", StringUtil.getSysDBDate());
        mainMap.put("province", SecureUtil.getUserSelectProvince());
        mainMap.put("type", audittype);
        mainMap.put("year", CommonUtil.getYear());
        if (null == mainMap.get("guid") || StringUtils.isEmpty((String) mainMap.get("guid"))) {
            mainMap.put("guid", this.getCreateguid());
            mainMap.put("userguid", SecureUtil.getCurrentUser().getGuid());
        }
        String guid = mainMap.get("guid").toString();
        if (null != param.get("datas")) {
            List<Map<String, Object>> datas = (List<Map<String, Object>>) param.get("datas");
            for (Map<String, Object> map : datas) {
                map.put("guid", this.getCreateguid());
                map.put("mainguid", mainguid);
                map.put("auditguid", guid);
            }
            deptOverallMeritReportDAO.deleteByMainguid(deptOverallMeritReportDAO.AUDITSUB_TABLE, "auditguid", guid, null);
            deptOverallMeritReportDAO.saveAll(datas, deptOverallMeritReportDAO.AUDITSUB_TABLE);

        }
		String wheresql = " nodeguid='" + nodeguid + "' and userguid='" + SecureUtil.getCurrentUserID() + "' and type='" + audittype + "'";
		deptOverallMeritReportDAO.deleteByMainguid(deptOverallMeritReportDAO.AUDITMAIN_TABLE, "mainguid", mainguid, wheresql);
		deptOverallMeritReportDAO.save(mainMap, deptOverallMeritReportDAO.AUDITMAIN_TABLE);
        return resMap;
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
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 自评提交
     * @param params --
     * @return --
     */
    public Map<String, Object> sendtonext(HashMap<String, Object> params) throws AppException {
    	List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
    	for (Map<String, Object> map : datas) {
    		map.put("reportstatus", "2");
		}
    	String tablecode = (String) params.get("tablecode");
    	String busguid = (String) params.get("busguid");
    	deptOverallMeritReportDAO.updateAllByPK(datas, "guid", tablecode);
    	return this.auditdefine(datas, busguid,"perf", null);
    }
}
