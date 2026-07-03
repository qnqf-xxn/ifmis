package gov.mof.fasp2.pmkpi.perfselfreview.manage;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfReviewManageBO extends PmkpiBO {

    public PerfSelfReviewManageDAO perfSelfReviewManageDAO;

    public void setPerfSelfReviewManageDAO(PerfSelfReviewManageDAO perfSelfReviewManageDAO) {
        this.perfSelfReviewManageDAO = perfSelfReviewManageDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String ,String> queryParam = new HashMap<String, String>();
        if(queryConfig!=null&&queryConfig.size()>0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String where=(String) sqlmap.get("tabsql");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String tabcode = (String) sqlmap.get("tabcode");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String tablecode = "";
        //资金条件  ((C2 like '%20%'))
        if(!StringUtil.isEmpty(wheresql) && wheresql.contains("((C2")){
            String cutsql = wheresql.substring(wheresql.indexOf("((C2"),wheresql.lastIndexOf("%'))")+4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT <="+ MAXAMOUNT+" ");
        }
        //资金条件  ((C1 like '%20%'))
        if(!StringUtil.isEmpty(wheresql) && wheresql.contains("((C1")){
            String cutsql = wheresql.substring(wheresql.indexOf("((C1"),wheresql.lastIndexOf("%'))")+4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT >="+ MINAMOUNT +" ");
        }
        StringBuffer sql = new StringBuffer("select * from ");
        if (!"waitaudit".equals(tabcode)) {//已下达
            tablecode = perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK;
        } else {//待下达
            tablecode = perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWPROJECT_CHECK;
        }
        sql.append(tablecode).append(" t where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        sql.append(datarule);
        if ("waitaudit".equals(tabcode)) {
            sql.append(" and not exists(select 1 from ").append(perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK).append(" d where ");
            sql.append(" t.guid = d.selfproguid)");
        }
        if (!StringUtil.isEmpty(where)){
            sql.append(" and t.").append(where);
        }
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfReviewManageDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 保存绩效下达任务与项目.
     * @param parms -- 参数.
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        String workflow = (String) parms.get("workflow");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        for (Map<String, Object> map : datas) {
            String newguid = this.getCreateguid();
            map.put("selfproguid", map.get("guid"));
            map.put("createtime", PerfUtil.getServerTimeStamp ());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("guid", newguid);
            map.put("creater", SecureUtil.getCurrentUserID());
            map.put("arrangercreater", SecureUtil.getCurrentUserID());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("evalstatus", "1"); //已下达
            map.put("is_deleted", "2"); //不是删除
            map.put("wfstatus", "");
            map.put("wfid", "");
        }
        this.workflow("create", workflow, "", perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK, datas);
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delTask(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        List<String> guids = new ArrayList<>();
        for (Map<String, Object> map : deldatas) {
            guids.add((String) map.get("guid"));
        }
        String wheresql = perfSelfReviewManageDAO.createInSql("guid", guids);
        perfSelfReviewManageDAO.delDatas(perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK, wheresql);
        backMap.put("flg","1");
        return backMap;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("leftmenuid");
        String tabcode = (String) params.get("tabcode");
        String tabsql = (String) params.get("tabsql");
        String tablecode = "";
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        String wheresql = datarule;
        if (!"waitaudit".equals(tabcode)) {//已下达
            tablecode = perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK;
        } else {//待下达
            tablecode = perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWPROJECT_CHECK;
            wheresql += " and not exists(select 1 from " + perfSelfReviewManageDAO.PERF_TABLE_SELFREVIEWTASK + "  d where ";
            wheresql += " t.guid = d.selfproguid)";
        }
        if (!StringUtil.isEmpty(tabsql)){
            wheresql += " and " + tabsql;
        }
        return perfSelfReviewManageDAO.getLeftTree(tablecode, wheresql);
    }

}
