package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndexCheckBO extends PmkpiBO {
    private IndexCheckDAO indexCheckDAO;

    @Resource(name = "pmkpi.setting.indexlib.report.IndexRpDAO")
    public void setIndexCheckDAO(IndexCheckDAO indexCheckDAO) {
        this.indexCheckDAO = indexCheckDAO;
    }

    /**
     * 保存指标数据.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tabtype = (String) params.get("tabtype");
        String indextype = (String) params.get("indextype");
        String workflow = (String) params.get("workflow");  //工作流
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> dataList = new ArrayList<>();
        if (datas != null && datas.size() >= 0) {
            String guid = "";
            for (Map<String, Object> map : datas) {
                guid = this.getCreateguid();
                String indexcategories = (String)map.get("indexcategories");
                if("#".equals(indexcategories) || "0".equals(indexcategories)){
                    map.put("indexcategories", map.get("industrycategory"));
                }
                if (PerfUtil.getIS_HUBEI()) {//湖北模式
                    if("dept".equals(indextype) && "INDEXCOMFUNC_HuBei".equals(tabtype)) {
                        //处理项目名称
                        String sql = "select * from v_perf_indexcomfunc t where t.guid ='" + map.get("industrycategory") + "'";
                        logger.info("项目查询sql：" + sql);
                        List<Map<String, Object>> list = indexCheckDAO.queryForList(sql);
                        if (list.size() > 0) {
                            map.put("pro_type", list.get(0).get("superguid"));
                            map.put("pro_name", list.get(0).get("name"));
                        }
                    }
                }
                if (indextype != null && "dept".equals(indextype)) {
                    if (!"PMKPIDEPT".equals(tabtype)) {
                        map.put("is_pm_perf_ind", 1);
                    } else {
                        map.put("is_pm_perf_ind", 2);
                    }
                }
                map.put("is_last_inst", 2);
                map.put("is_common_ind", 2);
                map.put("adjuststatus",map.get("upstatus"));  //数据状态：1新增 2修改 3删除
                map.put("adjustguid",map.get("guid"));  //调整前指标guid
                map.put("apply_status", 1);
                map.put("guid", guid);
                map.put("status", 1);
                map.put("indexvalue", map.get("kpi_val"));
                map.put("name", map.get("perf_ind_name"));
                map.put("parent_id", map.get("sindex"));
                map.put("ind_id", guid);
                map.put("level_no", 3);
                map.put("is_leaf", 1);
                map.remove("wfstatus");
                if (StringUtil.isNullOrEmpty((String) map.get("value_desc"))) {
                    map.put("value_desc", map.get("perf_ind_name"));
                }
                map.put("biz_key", null); // 业务唯一标识
                this.getBasMap(map, "add");
                dataList.add(map);
            }
            indexCheckDAO.setIndexCode(dataList);
            this.workflow("create", workflow, "", indexCheckDAO.PMKPI_TABLE_BASE_INDEX, dataList);
        }
        return backMap;
    }

    /**
     * 查询指标层次.
     *
     * @param sqlmap -- sql.
     * @return
     * @throws AppException -- 异常.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tabtype = (String) sqlmap.get("tabtype");
        String menuid = (String) sqlmap.get("menuid"); //菜单guid.
        String querySql = (String) sqlmap.get("querySql");
        String tabcode = (String) sqlmap.get("tabcode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow"); //工作流
        StringBuffer sql = new StringBuffer();
        //sql = "select t.*,'' as upstatus from " + indexCheckDAO.PMKPI_TABLE_BASE_INDEX + " t where ";
        if(PerfUtil.getIS_HUBEI()){
            //湖北指标列表查询失败  报错‘无法解析的成员访问表达式[A.ELE_CODE]’ 达梦给出的解决方案 查询sql添加  /*+VIEW_PULLUP_FLAG(0)*/
            sql.append("select /*+VIEW_PULLUP_FLAG(0)*/ t.*,'' as upstatus from "+indexCheckDAO.PMKPI_TABLE_BASE_INDEX).append(" t where ");
        }else{
            sql.append("select t.*,'' as upstatus from "+indexCheckDAO.PMKPI_TABLE_BASE_INDEX).append(" t where ");
        }
        sql.append("t.wfstatus = '011' and t.is_deleted <> 1 and nvl(t.adjuststatus,0) <> '3' and ");
        StringBuffer wheresql = new StringBuffer("");
        if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) {
            wheresql.append(" t.framesystem = 'DEPT'");
        } else {
            wheresql.append(" t.framesystem = 'PM001'");
        }
        //处理区分部门指标与项目指标
        wheresql.append(" and is_common_ind <> 1 and agency_code is not null ");
        //过滤掉已经发起调整的数据
        wheresql.append(" and not exists (select 1 from V_BAS_PERF_INDICATOR a where a.ADJUSTGUID = t.guid) ");
        String datarule = this.getDataRuleByMenuguid(menuid, "m", null);
        datarule = datarule.replace("m.agencyguid", "m.guid"); //这块是否可以直接优化，替换为agency_code?
        wheresql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m where m.guid=t.agency_code ").append(datarule).append(") ");
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wheresql.append(" and (").append(wfsql).append(") ");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wheresql.append(" and ").append(tabfilter);
        }

        if (querySql != null && !querySql.isEmpty()) {
            wheresql.append(" and (").append(querySql).append(")");
        }
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql.append(wheresql);
        }
        sql.append(" order by t.findex,t.sindex,t.perf_ind_code");
        logger.debug("查询列表sql："+sql.toString());
        return sql.toString();
    }


}
