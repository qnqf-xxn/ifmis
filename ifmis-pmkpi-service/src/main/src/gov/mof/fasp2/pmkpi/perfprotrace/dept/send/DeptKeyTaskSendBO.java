package gov.mof.fasp2.pmkpi.perfprotrace.dept.send;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptKeyTaskSendBO extends PmkpiBO {
    private DeptKeyTaskSendDAO deptKeyTaskSendDAO;

    public void setDeptKeyTaskSendDAO(DeptKeyTaskSendDAO deptKeyTaskSendDAO) {
        this.deptKeyTaskSendDAO = deptKeyTaskSendDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //V_PERF_T_PROMONITOR   V_PERF_ADJUSTPROJECT_INFO
        String wheresql = (String) sqlmap.get("querySql");   //查询区
        String tablecode = (String) sqlmap.get("tablecode");  //表名
        String tabfilter = (String) sqlmap.get("tablesql");   //ui表条件
        String menuid = (String) sqlmap.get("menuid");   //菜单
        String tabcode = (String) sqlmap.get("tabcode"); //页签类型
        String treeid = (String) sqlmap.get("treeid"); //任务guid
        StringBuffer sql = new StringBuffer("select t.*,a.provincetask,a.guid as moniguid,a.taskguid,a.proguid from ");
        sql.append(tablecode).append(" t left join ").append(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE)
                .append(" a on a.pro_code = t.pro_code ").append(" where exists (select 1 from V_PERF_T_TASKSET s where s.tasktype='protrace' and s.guid = a.taskguid) ");
        if ("waitsend".equals(tabcode)) { //未下达的重点监控
            sql.append(" and a.provincetask = 3 ");
        } else { //已下达的重点监控
            sql.append(" and a.provincetask = 1 ");
        }
        if (!"treeroot".equals(treeid)) {
            sql.append(" and a.taskguid='").append(treeid).append("'");
        }
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            sql.append(" and ").append(tabfilter);
        }
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        sql.append(" and ").append(datarule);
        return sql.toString();
    }

    /**
     * 获取左侧树数据.
     *
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        StringBuffer whrereSql = new StringBuffer(" exists ( select 1 from " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " m where m.provincetask = 3 ");
        String datarule = this.getDataRuleByMenuguidNull(menuId, "m", "1=1");
        whrereSql.append(" and ").append(datarule);
        whrereSql.append(" and m.taskguid = t.guid) and t.tasktype='protrace' ");
        List<Map<String, Object>> eledatas = deptKeyTaskSendDAO.getDatas("V_PERF_T_TASKSET", whrereSql.toString(), null);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "绩效任务");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", eledatas);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    public Map<String, Object> send(HashMap<String, Object> parms) throws AppException {
        return null;
    }

    /**
     * <p>下达任务/取消下达</p >
     *
     * @param
     * @author hw
     * @date 2022/4/6 14:53
     */
    public Map<String, Object> sendtask(HashMap<String, Object> parms) throws AppException {
        Integer provincetask = (Integer) parms.get("provincetask");
        Map<String, Object> backMap = new HashMap();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = ProTraceManageDAO.PERF_TABLE_TRACEMANAGE;
        try {
            for (Map map : datas) {
                String moniguid = (String) map.get("moniguid");
                map.put("guid", moniguid);
                map.put("provincetask", provincetask);
            }
            List<String> columns = new ArrayList<>();
            columns.add("guid");
            columns.add("provincetask");
            columns.add("PROJECTKIND");
            columns.add("PRO_LEVONE_CODE");
            columns.add("PRO_LEV");
            deptKeyTaskSendDAO.updateAllByPK(columns, datas, "guid", tablecode);
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

}
