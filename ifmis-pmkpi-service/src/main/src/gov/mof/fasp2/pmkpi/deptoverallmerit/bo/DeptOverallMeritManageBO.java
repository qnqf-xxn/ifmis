package gov.mof.fasp2.pmkpi.deptoverallmerit.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.deptoverallmerit.dao.DeptOverallMeritManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptOverallMeritManageBO extends PmkpiBO {
    private DeptOverallMeritManageDAO deptOverallMeritManageDAO;

    public void setDeptOverallMeritManageDAO(DeptOverallMeritManageDAO deptOverallMeritManageDAO) {
        this.deptOverallMeritManageDAO = deptOverallMeritManageDAO;
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
//        String date =StringUtil.getSysDBDate();
		//String dyear =date.substring(0,4);
		//String dmonth =date.substring(4,6);
		//String dday =date.substring(6,8);
        //String pagetype = (String) params.get("pagetype");
        List<Map<String, Object>> data = null;
//        List queryConfig = (List) params.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) params.get("querySql");
        String menuid = (String)params.get("menuid");
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
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
            deptOverallMeritManageDAO.saveAll(eledatas, deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "PMKPIDEPT");
            deptOverallMeritManageDAO.saveAll(treeData, deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype='").append(bustype).append("'");
        sql.append(" and t.ismain='1'");
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
            sql.append(" and exists(select * from ").append(deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        data = deptOverallMeritManageDAO.queryForList(sql.toString());
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
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        String sysvalue = deptOverallMeritManageDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
    }
    
    /**
     * 保存绩效自评
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        //String workflow = (String) parms.get("workflow");
        String tablecode = (String) parms.get("tablecode");
        //String modelguid = (String) parms.get("modelguid");
        String bustype = (String) parms.get("bustype");
        List<String> fromtables = (List<String>)parms.get("fromtables");
        List<Map<String, Object>> tasklist = new ArrayList<Map<String, Object>>();
        Map<String, Object> taskMap = null;
        deptOverallMeritManageDAO.saveAll(datas, PmkpiDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = " exists(select * from "+ PmkpiDAO.PMKPI_TABLE_TMP_AGENCY + " a where t.mainguid=a.guid)";
//        List<Map<String, Object>> indexList = deptOverallMeritManageDAO.getDatas(fromtables.get(0)/*"perf_t_projperfindex"*/, " code ='perf_deptoverallmerit' ", "order by ordernum");
        List<Map<String, Object>> descList = deptOverallMeritManageDAO.getDatas(fromtables.get(1)/*"perf_t_projperfdesc"*/, wheresql, "order by guid");
        for (Map<String, Object> map : datas) {
            String perfguid = "";
            List<Map<String, Object>> datas1 = deptOverallMeritManageDAO.getDatas("V_PERF_T_SELFEVALTASK", " t.agencyguid = '" + map.get("agencyguid") + "' and t.bustype = 'dept'", "");
            if(datas1.size() > 0){
                Map<String, Object> map1 = datas1.get(0);
                perfguid = (String) map1.get("guid");
            }
            String newguid = this.getCreateguid();
        	String mainproguid = (String) map.get("guid");
        	taskMap = new HashMap<String, Object>();
    		for (Map<String, Object> descmap : descList) {
    			String proguid =  (String) descmap.get("mainguid");
    			if (proguid.equals(mainproguid)) {
    				descmap.put("guid", this.getCreateguid());
    				descmap.put("mainguid", newguid);
    				descmap.put("createtime", StringUtil.getSysDBDate());
    				descmap.put("updatetime", StringUtil.getSysDBDate());
    				descmap.put("creater", SecureUtil.getCurrentUserID());
    				descmap.put("province", SecureUtil.getUserSelectProvince());
    				descmap.put("year", CommonUtil.getYear());
    				descmap.put("agencyguid", map.get("mainguid"));
    			}
    		}
//    		for (Map<String, Object> indexmap : indexList) {
//    			String proguid =  (String) indexmap.get("mainguid");
//    			if (proguid.equals(mainproguid)) {
//    				indexmap.put("indexguid", this.getCreateguid());//主键，因为层级关系需要guid和superid对应
//    				indexmap.put("mainguid", newguid);
//    				indexmap.put("createtime", StringUtil.getSysDBDate());
//    				indexmap.put("updatetime", StringUtil.getSysDBDate());
//    				indexmap.put("creater", SecureUtil.getCurrentUserID());
//    				indexmap.put("province", SecureUtil.getUserSelectProvince());
//    				indexmap.put("year", CommonUtil.getYear());
//    				indexmap.put("agencyguid", map.get("agencyguid"));
//    			}
//    		}
            
            taskMap.put("createtime", StringUtil.getSysDBDate());
            taskMap.put("updatetime", StringUtil.getSysDBDate());
            taskMap.put("guid", newguid);
            taskMap.put("perfgoalguid", perfguid);
            taskMap.put("code", map.get("code"));
            taskMap.put("name", map.get("name"));
            taskMap.put("creater", SecureUtil.getCurrentUserID());
            taskMap.put("province", SecureUtil.getUserSelectProvince());
            taskMap.put("year", CommonUtil.getYear());
            taskMap.put("agencyguid", map.get("agencyguid"));
            taskMap.put("finintorgguid", map.get("finintorgguid"));
            taskMap.put("bustype", bustype);
            taskMap.put("ismain", "1");
            taskMap.put("reportstatus", "0"); //已下达
            tasklist.add(taskMap);
        }
//        this.workflow("create", workflow, null, tablecode, tasklist);
//        deptOverallMeritManageDAO.saveAll(indexList, "perf_t_deptscoreindex");
        deptOverallMeritManageDAO.saveAll(tasklist, tablecode);
        deptOverallMeritManageDAO.saveAll(descList, "perf_t_wordcontent");
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
        	deptOverallMeritManageDAO.saveAll(deldatas, deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptOverallMeritManageDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptOverallMeritManageDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptOverallMeritManageDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
