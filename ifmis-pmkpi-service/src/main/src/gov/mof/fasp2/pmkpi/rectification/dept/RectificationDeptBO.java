package gov.mof.fasp2.pmkpi.rectification.dept;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationDeptBO extends PmkpiBO {

    private RectificationDeptDAO rectificationDeptDAO;

    public void setRectificationDeptDAO(RectificationDeptDAO rectificationDeptDAO) {
        this.rectificationDeptDAO = rectificationDeptDAO;
    }

    /**
     * 根据左侧页签和数据反查左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(HashMap<String, Object> params) {
        List<Map<String, Object>> eledatas = rectificationDeptDAO.getDatas("v_perf_t_datasource", "elementcode='rectifytype'", "order by ordernum");
        String wheresql = "tasktype = 'protrace'";
        List<Map<String, Object>> taskdata = rectificationDeptDAO.getDatas("V_PERF_T_TASKSET", wheresql, "order by taskstage");
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> eledata : eledatas) {
            data.add(eledata);
        }
        for (Map<String, Object> taskdatum : taskdata) {
            data.add(taskdatum);
        }
        return data;
    }

    //获取左侧树
    public Map<String, Object> getTreeData(Map config) throws AppException {
        List<Map<String, Object>> eledatas = rectificationDeptDAO.getDatas("v_perf_t_datasource", "elementcode='rectifytype'", "order by ordernum");
        String type ="dept";
        String wheresql = "tasktype = 'protrace'";
        List<Map<String, Object>> taskdata = rectificationDeptDAO.getDatas("V_PERF_T_TASKSET", wheresql, "order by taskstage");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> eledata : eledatas) {
            data.add(eledata);
        }
        for (Map<String, Object> taskdatum : taskdata) {
            data.add(taskdatum);
        }
        leftconfig.put("name", "项目支出");
        //leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", data);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    /**
     * 根据id删除数据
     * @param config
     * @return
     * @throws AppException
     */
    public Map delByGuids(HashMap config) throws AppException {
        List<Map<String, Object>> guids = (List<Map<String, Object>>) config.get("list");
        if (guids != null && guids.size()>0) {
            try{
                rectificationDeptDAO.saveAll(guids, rectificationDeptDAO.PMKPI_TABLE_TMP_AGENCY);
                String delsql = " exists(select 1 from " + rectificationDeptDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                rectificationDeptDAO.delDatas(RectificationAddProjDAO.PERF_T_RECTIFY, delsql);

            } catch (AppException e) {
                throw new AppException("数据删除失败！");
            }
        }else {
            config.clear();
            config.put("error", "删除报错，操作0行数据！");
        }
        return config;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> send(HashMap<String, Object> params) {
        String guid = (String) params.get("guid");
        String tablecode = (String) params.get("tablecode");
        String sql = "update " + tablecode + " t set SXSTATE = 1 where guid = '"+guid+"'";
        rectificationDeptDAO.update(sql);
        return null;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> cancleSend(HashMap<String, Object> params) {
        String guid = (String) params.get("guid");
        String tablecode = (String) params.get("tablecode");
        String sql = "update " + tablecode + " t set SXSTATE = 0 where guid = '"+guid+"'";
        rectificationDeptDAO.update(sql);
        return null;
    }

    /**
     * 表格查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        String bustype = (String) sqlmap.get("bustype");
        String treeid = (String)sqlmap.get("treeid");
        String superguid = (String)sqlmap.get("superguid");
        String tabcode = (String)sqlmap.get("tabcode");
        String isleaf = (String)sqlmap.get("isleaf");
        String saveAgency = (String)sqlmap.get("saveAgency");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String querySql = (String) sqlmap.get("querySql");
        String defquery = (String) sqlmap.get("defquery");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String sql = "";
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        StringBuffer sb = new StringBuffer("select * from ");
        sb.append(tablecode).append(" t  where ");
        sb.append(" t.bustype=").append(bustype);
        sb.append(" and ").append(datarule);
        if ("waitaudit".equals(tabcode)) { // 未下达
            sb.append(" and nvl(t.SXSTATE,0) <> 1 ");
        }else if ("alreadyaudit".equals(tabcode)) { // 已下达
            sb.append(" and nvl(t.SXSTATE,0) = 1 ");
        }
        if (saveAgency != null && !"treeroot".equals(saveAgency)){
            if ("1".equals(isleaf) && superguid.equals("rectifytrace")) {  //是否末级节点  1是
                sb.append(" and t.rectype='").append(superguid).append("'");
                sb.append(" and t.taskguid='").append(treeid).append("'");
            }else {
                sb.append(" and t.rectype='").append(treeid).append("'");
            }
        }
        if (!StringUtil.isEmpty(sql)){
            sb.append(sql);
        }
        if(querySql != null && !querySql.isEmpty()){
            sb.append(" and (").append(querySql).append(")");
        }
        if(defquery != null && !defquery.isEmpty()){
            sb.append(" and ").append(defquery);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sb.append(" and ").append(tabfilter);
        }
        return sb.toString();

    }

}