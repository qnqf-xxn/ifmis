package gov.mof.fasp2.pmkpi.perfself.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.ExpDocDAO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.IExpDocABO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfQueryBO extends PmkpiBO implements IExpDocABO {
    private PerfSelfApplyDAO perfSelfApplyDAO;

    public void setPerfSelfApplyDAO(PerfSelfApplyDAO perfSelfApplyDAO) {
        this.perfSelfApplyDAO = perfSelfApplyDAO;
    }

    /**
     * 表格的查询语句.
     *
     * @param sqlmap -- map.
     * @return
     * @throws AppException -- 自定义异常.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //页面类型
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String, String> queryParam = new HashMap<String, String>();
        if (queryConfig != null && queryConfig.size() > 0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String tabcode = (String) sqlmap.get("tabcode");
        String ctablecode = (String) sqlmap.get("ctablecode");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String deptcode = (String) sqlmap.get("deptcode");//数据分析大屏跳转-参数
        String busguid = (String) sqlmap.get("busguid");//数据分析大屏跳转-参数
        String divcode = (String) sqlmap.get("divcode");//数据分析大屏跳转-参数
        //资金条件  ((C2 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C2")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C2"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT <=" + MAXAMOUNT + " ");
        }
        //资金条件  ((C1 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C1")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C1"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT >=" + MINAMOUNT + " ");
        }
        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        if (PerfUtil.getIsHbei()) {
            //河北环境不用code    yearflag  1-总体   0-年度
            tablecode += "_HB";
        }
        sql.append(tablecode).append(" t ");
        sql.append(" where t.bustype='").append(lefttabtype).append("'");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfApplyDAO.PMKPI_TABLE_T_AGENCY));
        if(!StringUtil.isEmpty(deptcode)){//数据分析大屏跳转-只查询本部门数据
            sql.append(" and t." + columncode + " like '" + deptcode + "%'");
        }else if(!StringUtil.isEmpty(busguid)){//数据分析大屏跳转-根据busguid查
            sql.append(" and t.guid = '" + busguid + "'");
        }else if(!StringUtil.isEmpty(divcode)){//数据分析大屏跳转-根据divcode查
            sql.append(" and t.finintorgguid = '" + divcode + "'");
        }else{
            sql.append(datarule);
        }
        return sql.toString();
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
        String tablecode = (String) params.get("tablecode");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        String deptcode = (String) params.get("deptcode");//数据分析大屏跳转-参数
        String busguid = (String) params.get("busguid");//数据分析大屏跳转-参数
        String divcode = (String) params.get("divcode");//数据分析大屏跳转-参数
        if(!StringUtil.isEmpty(deptcode)){
            datarule = " t.agencyguid like '" + deptcode + "%'";
        }else if(!StringUtil.isEmpty(busguid)){//数据分析大屏跳转-根据busguid查
            datarule = " t.guid = '" + busguid + "'";
        }else if(!StringUtil.isEmpty(divcode)){//数据分析大屏跳转-根据divcode查
            datarule = " t.finintorgguid = '" + divcode + "'";
        }
        datarule += " and bustype='" + lefttabtype + "'";
        return perfSelfApplyDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 天津汇总自评导出（根据用户权限导出单张汇总表）
     * @param param 业务传递参数
     * @param templateMap 模板信息
     * @return
     * @throws PerfAppException
     */
    public List<Map<String, Object>> genExpData(Map param, Map templateMap) {
        List<Map<String, Object>> subList = (List<Map<String, Object>>) param.get("subdata");
        ExpDocDAO expDocDAO = (ExpDocDAO)ServiceFactory.getBean("pmkpi.perfcommon.expdoc.ExpDocDAO");
        String menuid = (String) param.get("menuid");
        PmkpiBO pmkpiBO = PerfServiceFactory.getPmkpiBO();
        String datarule = "";
        //默认条件为数据权限
        try {
            datarule = pmkpiBO.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
            List<Map<String, Object>> dataList = expDocDAO.getDatas(PerfSelfApplyDAO.SELFEVALTASK_TABLE, datarule,null);
            expDocDAO.saveAll(dataList, "PERF_TMP_GUIDS");//保存到临时表用于合计

        } catch (AppException e) {
            logger.error("--------获取数据权限异常");
        }
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map subMap = null;
        String expType = String.valueOf(templateMap.get("exptype"));
        String expfilename = String.valueOf(templateMap.get("expfilename"));
        subMap = this.genBusExpData(subList, datarule);
        String agencycodename = (String) subMap.get("agencycodename");
        String month = (String) subMap.get("month");
        String code = (String) subMap.get("code");
        String name = (String) subMap.get("name");
        if (agencycodename != null) {
            expfilename = expfilename.replace("#agency#", agencycodename);
        } else {
            expfilename = expfilename.replace("#agency#", "");
        }
        if (month != null) {
            expfilename = expfilename.replace("#month#", month);
        } else {
            expfilename = expfilename.replace("#month#", "");
        }
        if (code != null) {
            expfilename = expfilename.replace("#code#", code);
        } else {
            expfilename = expfilename.replace("#code#", "");
        }
        if (name != null) {
            expfilename = expfilename.replace("#name#", name);
        } else {
            expfilename = expfilename.replace("#name#", "");
        }
        if (expfilename.contains("#systime#")) {
            expfilename = expfilename.replace("#systime#", "");
            subMap.put("expfilename", expfilename + "." + expType);
        } else {
            subMap.put("expfilename", expfilename +"_"+ PerfUtil.getServerTimeStamp() + "." + expType);
        }
        list.add(subMap);
        return list;
    }

    public Map<String, Object> genBusExpData(List<Map<String, Object>> subList, String wheresql) {
        ExpDocDAO expDocDAO = (ExpDocDAO)ServiceFactory.getBean("pmkpi.perfcommon.expdoc.ExpDocDAO");
        Map<String, Object> dataMap = new HashMap<String, Object>();
        int i=0;
        for (Map<String, Object> cfg : subList) {
            String datakey = String.valueOf(cfg.get("datakey"));
            String tablecode = String.valueOf(cfg.get("tablecode"));
            List<Map<String, Object>> dataList = expDocDAO.getDatas(tablecode, datakey.startsWith("sum") ? " 1=1 " : wheresql, null);
            if (i == 0) {
                if (dataList!=null && dataList.size() > 0) {
                    Map<String, Object> map = dataList.get(0);
                    dataMap.put("agencycodename", map.get("agencycodename"));
                    dataMap.put("month", map.get("month"));
                    dataMap.put("code", map.get("code"));
                    dataMap.put("name", map.get("name"));
                }
            }
            i++;
            dataMap.put(datakey, dataList);
        }
        return dataMap;
    }

}
