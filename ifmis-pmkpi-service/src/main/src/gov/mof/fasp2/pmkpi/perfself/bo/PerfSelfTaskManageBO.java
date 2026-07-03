package gov.mof.fasp2.pmkpi.perfself.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfTaskManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfTaskManageBO extends PmkpiBO {
    private PerfSelfTaskManageDAO perfSelfTaskManageDAO;

    public void setPerfSelfTaskManageDAO(PerfSelfTaskManageDAO perfSelfTaskManageDAO) {
        this.perfSelfTaskManageDAO = perfSelfTaskManageDAO;
    }

    @Override
	public String getVodSql(Map sqlmap) throws AppException {
        //页面类型
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String ,String> queryParam = new HashMap<String, String>();
        if(queryConfig!=null&&queryConfig.size()>0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String where=(String) sqlmap.get("tabsql");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String tabcode = (String) sqlmap.get("tabcode");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String tablename = (String) sqlmap.get("tablecode");
        String tablecode = "";
        String wsql = "";
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
            tablecode = perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK;
            wsql = " bustype='" + lefttabtype + "'";
        } else {//待下达
            if ("dept".equals(lefttabtype)) {//部门整体待下达
                tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_DEPTPERFDECLARE;
            } else {//项目支出待下达
                if(PerfUtil.getIsNINGXIA()){ // 宁夏-项目支出和转移支付共用一个视图
                    tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_SELFPROJECT_CHECK_NX;
                } else {
                    if ("program".equals(lefttabtype)) {
                        tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_SELFPROJECT_CHECK;
                        if (!StringUtil.isEmpty(tablename) && tablename.equals("V_PERF_PERFSELFPROJECT_INFO")){//包含一级项目
                            tablecode = tablename;
                        }
                    } else if ("transprogram".equals(lefttabtype)){//结转项目
                        tablecode = perfSelfTaskManageDAO.PERF_TABLE_TRANSPROJECT;
                    } else if ("parentprogram".equals(lefttabtype)) {//一级项目
                        tablecode = perfSelfTaskManageDAO.PERF_TABLE_SELFPARENTPROJECT_CHECK;
                    }
                }
            }
        }
        sql.append(tablecode).append(" t ");
        if (!StringUtil.isEmpty(wsql)) {
            sql.append(" where ").append(wsql);
        } else {
            sql.append(" where ");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if ("waitaudit".equals(tabcode)) {
            sql.append(" not exists(select 1 from ").append(perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK).append(" d where ");
            if (PerfUtil.getIsHbei() || "dept".equals(lefttabtype)) {
                sql.append(" t.guid = d.projguid");
            } else {
                sql.append(" t.pro_code = d.pro_code");
            }
            sql.append(" and d.bustype='").append(lefttabtype).append("'").append(")");
            if (!StringUtil.isEmpty(tablesql)){
                sql.append(" and ").append(tablesql);
            }
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
        if(PerfUtil.getIsNINGXIA() && !"dept".equals(lefttabtype)){
            sql.append(" and t.bustype='").append(lefttabtype).append("'");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfTaskManageDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule);
    	return sql.toString();
    }

    /**
     * 保存绩效下达任务与项目.
     * @param parms -- 参数.
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        Map<String, Object> infodata = (Map<String, Object>) parms.get("infodata");
        String bustype = (String) parms.get("bustype");
        List<Map<String, Object>> tasklist = new ArrayList<Map<String, Object>>();
        Map<String, Object> taskMap = null;
        for (Map<String, Object> map : datas) {
        	String newguid = this.getCreateguid();
            taskMap = new HashMap<>(); //浙江一体化建设
            taskMap.put("createtime", PerfUtil.getServerTimeStamp ());
            taskMap.put("updatetime", PerfUtil.getServerTimeStamp());
            taskMap.put("guid", newguid);
            taskMap.put("creater", SecureUtil.getCurrentUserID());
            taskMap.put("arrangercreater", SecureUtil.getCurrentUserID());
            taskMap.put("province", SecureUtil.getUserSelectProvince());
            taskMap.put("year", CommonUtil.getYear());
            taskMap.put("agencyguid", map.get("agencyguid"));
            if ("dept".equals(bustype)) {
                taskMap.put("name", map.get("name"));
                taskMap.put("code", map.get("code"));
                taskMap.put("finintorgguid", map.get("finintorgguid"));
            } else {
                taskMap.put("name", map.get("pro_name"));
                taskMap.put("code", map.get("pro_code"));
                taskMap.put("finintorgguid",map.get("mof_dep_code"));
            }
            taskMap.put("prokind", map.get("prokind"));
            taskMap.put("perfgoalguid", map.get("projguid"));
            taskMap.put("projguid", map.get("guid"));
            taskMap.put("bustype", bustype);
            taskMap.put("evalstatus", "1"); //已下达
            taskMap.put("is_deleted", "2"); //不是删除
            taskMap.put("pro_code", map.get("pro_code")); //项目编码
            taskMap.put("manage_dept_code",map.get("manage_dept_code"));
            taskMap.put("manage_mof_dep_code",map.get("manage_mof_dep_code"));
            taskMap.put("mof_dep_code",map.get("mof_dep_code"));
            taskMap.put("dept_code",map.get("dept_code"));
            taskMap.put("pro_lev",map.get("pro_lev"));
            taskMap.put("pro_total_amt",map.get("pro_total_amt"));  //项目总金额
            taskMap.put("projectkind",map.get("projectkind"));  //支出项目类别
            taskMap.put("pro_levone_code",map.get("pro_levone_code"));  //专项资金、一级项目编码
            taskMap.put("provincetask", "2");
            taskMap.put("v_colk1",map.get("v_colk1"));
            taskMap.put("v_colk2",map.get("v_colk2"));
            taskMap.put("v_colk3",map.get("v_colk3"));
            taskMap.put("v_colk4",map.get("v_colk4"));
            taskMap.put("v_colk5",map.get("v_colk5"));//扩展字段
            if(PerfUtil.getIsNINGXIA() && !"dept".equals(bustype)){
                taskMap.put("protype",map.get("protype"));
            }
            taskMap.putAll(infodata); //下达任务信息放到表中
            tasklist.add(taskMap);
        }
        perfSelfTaskManageDAO.saveAll(tasklist, perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK);
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
    public Map<String, Object> delTask(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
        	perfSelfTaskManageDAO.saveAll(deldatas, perfSelfTaskManageDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + perfSelfTaskManageDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            perfSelfTaskManageDAO.delDatas(perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK, delsql);
            //删除单个财政/部门下达的数据
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + perfSelfTaskManageDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t." + col + ")";
                    perfSelfTaskManageDAO.delDatas(deltable, delsql);
                }
            }
            //删除对应的暂存数据
            if (deltables != null && deltables.size() > 0) {
                delsql = " exists(select 1 from " + perfSelfTaskManageDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid )";
                Map delparams = new HashMap();
                delparams.put("delsql",delsql);
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                perfMidsaveBO.delData(delparams);
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     * @author hw
     * @date 2021/7/17 16:06
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String tabcode = (String) params.get("tabcode");
        String tablesql = (String) params.get("tablesql");
        String tabsql = (String) params.get("tabsql");
        String tablename = (String) params.get("tablecode");
        String tablecode = "";
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "");
        String wheresql = "";
        if (!"waitaudit".equals(tabcode)) {//已下达
            tablecode = perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK;
            wheresql = " bustype='" + lefttabtype + "'";
        } else {//待下达
            if ("dept".equals(lefttabtype)) {//部门整体待下达
                tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_DEPTPERFDECLARE;
            } else {//项目支出待下达
                if(PerfUtil.getIsNINGXIA()){ // 宁夏-项目支出和转移支付共用一个视图
                    tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_SELFPROJECT_CHECK_NX;
                } else {
                    if ("program".equals(lefttabtype)) {
                        tablecode = perfSelfTaskManageDAO.PMKPI_TABLE_SELFPROJECT_CHECK;
                        if (!StringUtil.isEmpty(tablename) && tablename.equals("V_PERF_PERFSELFPROJECT_INFO")){//包含一级项目
                            tablecode = tablename;
                        }
                    } else if ("transprogram".equals(lefttabtype)){//结转项目
                        tablecode = perfSelfTaskManageDAO.PERF_TABLE_TRANSPROJECT;
                    } else if ("parentprogram".equals(lefttabtype)) {//一级项目
                        tablecode = perfSelfTaskManageDAO.PERF_TABLE_SELFPARENTPROJECT_CHECK;
                    }
                }
            }
            //待下达
            if("1".equals(isZJ) && "program".equals(lefttabtype)){
                datarule = "";
            }
            wheresql += " not exists(select 1 from " + perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK + "  d where ";
            if (PerfUtil.getIsHbei() || "dept".equals(lefttabtype)) {
                wheresql += " t.guid = d.projguid";
            } else {
                wheresql += " t.pro_code = d.pro_code";
            }
            wheresql += " and d.bustype='" + lefttabtype + "')";
            if (!StringUtil.isEmpty(tablesql)){
                wheresql += " and " + tablesql;
            }
        }
        wheresql += datarule;
        if (!StringUtil.isEmpty(tabsql)){
            wheresql += " and " + tabsql;
        }
        if(PerfUtil.getIsNINGXIA() && !"dept".equals(lefttabtype)){
            wheresql += " and t.bustype='" + lefttabtype + "'";
        }
        return perfSelfTaskManageDAO.getLeftTree(tablecode, wheresql);
    }

    /**
     * 标记、取消标记项目
     * @param
     */
    public Map<String, Object> provincetask(HashMap<String, Object> params) throws AppException {
        String protype = (String) params.get("protype");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> map : datas) {
            if ("province".equals(protype)) {
                map.put("provincetask", "1");
            } else {
                map.put("provincetask", "2");
            }
        }
        List<String> cols = new ArrayList<>();
        cols.add("provincetask");
        perfSelfTaskManageDAO.updateAll(cols, datas, perfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK);
        Map<String, Object> map = new HashMap<>();
        map.put("flg", "1");
        return map;
    }
}
