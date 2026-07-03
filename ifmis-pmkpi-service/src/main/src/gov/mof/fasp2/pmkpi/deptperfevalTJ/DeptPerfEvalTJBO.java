package gov.mof.fasp2.pmkpi.deptperfevalTJ;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

public class DeptPerfEvalTJBO extends PmkpiBO {

    private DeptPerfEvalTJDAO deptPerfEvalTJDAO;

    public void setDeptPerfEvalTJDAO(DeptPerfEvalTJDAO deptPerfEvalTJDAO) {
        this.deptPerfEvalTJDAO = deptPerfEvalTJDAO;
    }

    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public Map<String, Object> save(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String workflow = (String) params.get("workflow");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        List<String> updatecols = (List)params.get("updatecols");
        if(updatecols==null){
            updatecols = new ArrayList<>();
        }
        List<String> delcols =  (List)params.get("delcols");
        if(delcols==null){
            delcols = new ArrayList<>();
        }
        if(year==null||year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province==null||province.isEmpty()){
            province = SecureUtil.getUserSelectProvince();
        }
        // 获取单位处室关系映射
        List<Map<String, Object>> agencylist = deptPerfEvalTJDAO.getDatas("pmkpi_fasp_t_pubagency", null, "order by code");
        Map<Object, Object> agencyFinMap = new HashMap<>();
        if (agencylist.size()>0) {
            agencyFinMap = agencylist.stream()
                    // 排序加null处理：update_time为空的排在最后，避免比较空指针
                    .sorted(Comparator.comparing(
                            l -> (Date) l.get("update_time"),
                            Comparator.nullsLast(Comparator.reverseOrder())
                    ))
                    // guid非空过滤
                    .filter(l -> l.get("guid") != null)
                    // toMap的value加null处理：finintorgguid为null时转成空字符串
                    .collect(Collectors.toMap(
                            l -> l.get("guid"),
                            l -> l.get("finintorgguid") != null ? l.get("finintorgguid") : "",
                            (existing, newValue) -> existing, // 重复guid取第一条
                            HashMap::new
                    ));
        }
        List<Map<String, Object>> addlist = new ArrayList<>();
        List<Map<String, Object>> uplist = new ArrayList<>();
        int i = 1;
        String timstamp = PerfUtil.getServerTimeStamp();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if(map.get("ordernum") == null || StringUtil.isEmpty(map.get("ordernum")+"")){
                map.put("ordernum", i++);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("agencyguid", map.get("dept_code"));
                map.put("finintorgguid", agencyFinMap.get(map.get("dept_code")));
                map.put("create_time", timstamp);
                map.put("update_time", timstamp);
                map.put("province", province);
                map.put("year", year);
                addlist.add(map);
            } else {
                map.put("update_time", timstamp);
                uplist.add(map);
            }
        }
        delcols.remove("guid");
//        if (addlist.size() > 0) {
//            deptPerfEvalTJDAO.saveAll(addlist, tablecode);
//        }
        if(addlist.size() > 0){
            this.workflow("create", workflow, "", tablecode, addlist);
        }
        if (uplist.size() > 0) {
            deptPerfEvalTJDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode),uplist, "guid", tablecode,updatecols);
        }
        if (deldatas.size() > 0) {
            deptPerfEvalTJDAO.saveAll(deldatas, deptPerfEvalTJDAO.PMKPI_TABLE_TMP_GUIDS);
            Map<String,Object> map1 = (Map)(((List)deldatas).get(0));
            StringBuffer delsql = new StringBuffer(" exists(select 1 from ");
            delsql.append(deptPerfEvalTJDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid=t.guid) ");
            for (String str:delcols) {
                delsql.append(" and ").append(str).append("='").append(map1.get(str)).append("'");
            }
            deptPerfEvalTJDAO.delDatas(tablecode, delsql.toString());
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String querySql = (String)params.get("querySql");
        String wheresql = " 1=1 ";
        if(tablesql != null && !tablesql.isEmpty()){
            wheresql += " and " + tablesql;
        }
        if(querySql != null && !querySql.isEmpty()){
            wheresql += " and " + querySql;
        }
        List<Map<String, Object>> data = deptPerfEvalTJDAO.getTableDatas(tablecode, wheresql, "order by ordernum");
        backMap.put("data", data);
        return backMap;
    }

    @Override
    public String getVodSql(Map params) throws AppException {
        String tablecode = params.get("tablecode")!=null ? (String)params.get("tablecode") : "V_PERF_T_DEPTPERFEVALTJ";
        String tablesql = (String)params.get("tablesql");
        String wheresql = (String)params.get("querySql");
        String menuid = (String) params.get("menuid");
        String workflow = (String) params.get("workflow");
        String tabcode = (String) params.get("tabcode");
        String tabfilter = (String) params.get("tabfilter");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        String wfsql = this.getWfSql(tabcode, workflow);
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerfEvalTJDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String sourcedatarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIDEPT");
            if (!"treeroot".equals(agency)) {
                sourcedatarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIDEPT",sourcedatarule);
            deptPerfEvalTJDAO.saveAll(eledatas, deptPerfEvalTJDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,"PMKPIDEPT");
            deptPerfEvalTJDAO.saveAll(treeData, deptPerfEvalTJDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("WITH deptperfevalyj_files AS (" +
                " select a.billguid,a.filetype,count(1) as file_count from v_perf_file a where a.filetype in ('deptperfevalTJ_file1','deptperfevalTJ_file2')  group by a.billguid,a.filetype )" +
                " select t.*," +
                " case when nvl(f1.file_count,0)>0 then '已上传' else '未上传' end as file1, case when nvl(f2.file_count,0)>0 then '已上传' else '未上传' end as file2 from ");
        sql.append(tablecode).append(" t left join deptperfevalyj_files f1 on t.guid = f1.billguid and f1.filetype ='deptperfevalTJ_file1'" +
                " left join deptperfevalyj_files f2 on t.guid = f2.billguid and f2.filetype ='deptperfevalTJ_file2' ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and ( ").append(wfsql);
            if (!StringUtil.isNullOrEmpty(tabcode) && "waitaudit".equals(tabcode)){
                sql.append(" or wfstatus is null ");
            }
            sql.append(" )");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("' ");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptPerfEvalTJDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid) ");
        }
        sql.append(datarule);
        return sql.toString();
    }

    /**
     * 查询左侧树数据
     *
     * @param menuId
     * @return
     * @throws AppException
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算部门");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = "PMKPIDEPT";
        if (!StringUtils.isNullOrEmpty(treesource)){
            // 数据权限
            String sql = this.getDicDSDataListByWheresql("t", menuId, treesource);
            if ("PMKPIDEPT".equals(treesource)) {
                sql += " and isleaf = 0 and length(guid)=3 ";
            }
            List datas = deptPerfEvalTJDAO.getLeftTree(PmkpiDAO.PMKPI_TABLE_T_AGENCY, sql);
            leftconfig.put("datas", datas);
        }
        return leftconfig;
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
        String tablecode = params.get("tablecode")!=null ? (String)params.get("tablecode") : "V_PERF_T_DEPTPERFEVALTJ";
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
