package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.FeedbackAuditIndexDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import org.apache.commons.lang.StringUtils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedbackAuditIndexBO extends PmkpiBO {
    private FeedbackAuditIndexDAO feedbackAuditIndexDAO;

    public void setFeedbackAuditIndexDAO(FeedbackAuditIndexDAO feedbackAuditIndexDAO) {
        this.feedbackAuditIndexDAO = feedbackAuditIndexDAO;
    }

    /**
     * 根据左侧页签和数据反查左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = RectificationAddProjDAO.PERF_T_RECTIFY;
        String leftmenuid = (String) params.get("leftmenuid");
        String bustype = (String) params.get("bustype");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + bustype + "' ";
        return feedbackAuditIndexDAO.getLeftTree(tablecode,datarule);
    }

    /**
     * 添加终审标识
     * @param params -- 参数.
     * @param  datas -- 走完工作流后的数据
     * @throws AppException
     */
    public void isFinal(HashMap<String, Object> params, List<Map<String, Object>> datas) throws AppException {
        String actioncode = (String) params.get("actioncode");
        StringBuilder sql = new StringBuilder("guid in('");
        for (int i=0;i<datas.size();i++){
            Map<String, Object> map =datas.get(i);
            String guid = (String) map.get("guid");
            if (guid != null) {
                if (i!=0){
                    sql.append("','");
                }
                sql.append(guid);
            }
        }
        sql.append("')");
        Map mapList = (Map)datas.get(0); //取第一个状态对于批量来说是有问题的，后续改掉
        String wfstatus = (String)mapList.get("wfstatus");
        StringBuilder upSql = new StringBuilder("update ").append(RectificationAddProjDAO.PERF_T_RECTIFY).append(" set");
        if(("audit".equals(actioncode) ||"auditbatch".equals(actioncode)) && "011".equals(wfstatus)){
            upSql.append(" isfinal = '1' ,rectifyend = 1");
            upSql.append(" where ").append(sql);
            feedbackAuditIndexDAO.update(upSql.toString());
            //处理部标2.0规范表中关于项目监控,处理整改的几个字段. 只处理项目监控
            updateTraceIndex(true, sql.toString());
        }
        //终审状态取消审核  讲终审标识再改为未终审
        if("cancelaudit".equals(actioncode)){
            upSql = new StringBuilder("update ").append(RectificationAddProjDAO.PERF_T_RECTIFY).append(" set");
            upSql.append(" isfinal = '2' ,rectifyend = 0");
            upSql.append(" where ").append(sql);
            feedbackAuditIndexDAO.update(upSql.toString());
            //处理部标2.0规范表中关于项目监控,处理整改的几个字段. 只处理项目监控
            updateTraceIndex(false, sql.toString());
        }
    }

    /**
     * 处理部标2.0中关于
     * @param  type -- true ：终审 false:取消终审
     * @param  filter -- 语句的过滤条件.
     * @throws AppException --自定义异常.
     */
    public void updateTraceIndex(Boolean type, String filter) throws AppException {
        String sql = "select c.guid, t.rectifydesc, t.feedbackdesc from v_perf_t_promonitor c, " + RectificationAddProjDAO.PERF_T_RECTIFY + " t" +
                " where c.pro_code is not null and c.taskguid = t.taskguid and c.pro_code = t.pro_code" +
                " and t.rectype = 'rectifytrace' and t.bustype = 1 and t." + filter;
        if (!type) {
            sql = sql + " and t.wfstatus = '011'";
        }
        List<Map> list = this.feedbackAuditIndexDAO.queryForList(sql);
        if (list.size() > 0) {
            list.forEach(e ->{
                e.put("is_perf_rectify",type?1:2);
                e.put("perf_task_id",e.get("guid"));
                e.put("rectify_advise",type?e.get("rectifydesc"):"");
                e.put("rectify_epilog",type?e.get("feedbackdesc"):"");
            });
            List<String> cols = new ArrayList<String>();
            cols.add("IS_PERF_RECTIFY");
            cols.add("RECTIFY_ADVISE");
            cols.add("RECTIFY_EPILOG");
            feedbackAuditIndexDAO.updateAllByPK(cols,list,"PERF_TASK_ID","V_PAY_PERF_MONITOR_INFO");
        }
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
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        //根据数据的业务阶段选择对应的工作流    绩效监控、绩效自评、部门评价、财政评价
        String  rectype = (String) datas.get(0).get("rectype");
        workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
        String[] str = workflow.split(",");
        for(String wfid : str) {
            String[] entry = wfid.split(":");
            entry[1] = StringUtils.substringBetween(entry[1], "'", "'"); //去掉字符串首尾的单引号''
            if (rectype != null && entry[0].trim().equals(rectype)){
                workflow =entry[1];
                break;
            }
        }
        // gm 2021/12/14 删除不用的审核定义代码逻辑，统一走框架的流程
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        this.isFinal(params, datas); // 处理正向与反向审核的逻辑
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 表格查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(feedbackAuditIndexDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //页面类型
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String bustype = (String) sqlmap.get("bustype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String type = (String) sqlmap.get("type");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype=").append(bustype);
        sql.append(" and ").append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        /*if (type != null && !type.isEmpty()){
            sql.append(" and t.type ='").append(type).append("'");
        }*/
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        //循环过滤条件
        String wfsql = " ";
        String[] str = null;
        if (workflow != null && !workflow.isEmpty()) {
            workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
            str = workflow.split(",");
            for (int i = 0; i < str.length; i++) {
                int index = str[i].indexOf("'");
                str[i] = str[i].substring(index + 1, str[i].length() - 1);
                wfsql += this.getWfSql(tabcode, str[i]);
                if (i < str.length - 1) {
                    wfsql += " or ";
                }
            }
            if (wfsql != null && !wfsql.isEmpty()) {
                sql.append("  and (").append(wfsql).append(")");
            }
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, feedbackAuditIndexDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }


    /**
     * 查询结果应用意见.
     * @param params --
     * @return --
     */
    public Map<String, Object> getResultOpinionDatas(HashMap<String, Object> params) {
        Map map = new HashMap();
        String mainguid = (String) params.get("mainguid");
        String queryYear = (String) params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String) params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            feedbackAuditIndexDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String wheresql = " t.guid = '" + mainguid + "'";
        Map<String, Object>  data = feedbackAuditIndexDAO.getDataMap(RectificationAddProjDAO.PERF_T_RECTIFY, wheresql);
        map.put("result", data);
        map.put("success", true);
        return map;
    }

    /**
     * 结果应用意见保存
     * @param params
     * @return
     * @throws AppException
     * @throws ParseException
     */
    public Map infosave(HashMap params) throws AppException, ParseException {
        String mainguid = (String)params.get("mainguid");
        String busguid = (String) params.get("busguid");
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String wheresql = " t.guid = '" + mainguid + "'";
        Map<String, Object>  map = feedbackAuditIndexDAO.getDataMap(RectificationAddProjDAO.PERF_T_RECTIFY, wheresql);
        if (!map.isEmpty()) {
            map.putAll(datas);
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            feedbackAuditIndexDAO.update(map, RectificationAddProjDAO.PERF_T_RECTIFY);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }

}
