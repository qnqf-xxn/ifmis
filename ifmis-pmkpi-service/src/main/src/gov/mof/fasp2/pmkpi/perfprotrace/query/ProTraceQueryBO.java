package gov.mof.fasp2.pmkpi.perfprotrace.query;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceQueryBO extends PmkpiBO {
	
	private ProTraceQueryDAO proTraceQueryDAO;

    public void setProTraceQueryDAO(ProTraceQueryDAO proTraceQueryDAO) {
        this.proTraceQueryDAO = proTraceQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String tasktype= (String) sqlmap.get("tasktype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String deptwfststus = (String) sqlmap.get("deptwfststus");
        String jxwfststus = (String) sqlmap.get("jxwfststus");
        String deptcode = (String) sqlmap.get("deptcode");//数据分析大屏跳转-只查询本部门数据
        if (PerfUtil.getIsHbei() && ProTraceManageDAO.PERF_VIEW_TRACEMANAGE.equals(tablecode)) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String columncodes = proTraceQueryDAO.getColumncodes(tablecode, "t");
        columncodes += ",decode(nvl(a.isrectify,0),0,'否','是') as isrectify,decode(nvl(a.rectifyend,0),0,'否','是') as rectifyend";
        if (!StringUtil.isEmpty(columncodes)) {
            columncodes += ",case when depttask='1' and provincetask='2' and wfstatus='" + deptwfststus + "' then '011'";
            if (PerfUtil.getIsGuangXi()) {
                columncodes += " when provincetask='1' and nvl(audittype,0) <> '2' and wfstatus='" + jxwfststus + "' then '011'";
            }
            columncodes += " else wfstatus end wfstatus";
        } else {
            columncodes = "t.*";
        }
        StringBuffer returnsql = new StringBuffer("select ");
        returnsql.append(columncodes).append(" from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" left join perf_v_rectify a on t.taskguid = a.taskguid");
        if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)){
            returnsql.append(" and a.PROGUID = t.PROGUID");
        }else{
            returnsql.append(" and a.procode = t.pro_code");
        }
        returnsql.append(" where t.tasktype='").append(tasktype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceQueryDAO.PMKPI_TABLE_T_AGENCY));
        if(!StringUtil.isEmpty(deptcode)){//数据分析大屏跳转-只查询本部门数据
            returnsql.append(" and t." + columncode + " like '" + deptcode + "%'");
        }else{
            returnsql.append(datarule);
        }
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        if (PerfUtil.getIsHbei()) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String tasktype = (String) params.get("tasktype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        String deptcode = (String) params.get("deptcode");//数据分析大屏跳转-只查询本部门数据
        if(!StringUtil.isEmpty(deptcode)){
            datarule = " t.agencyguid like '" + deptcode + "%'";
        }
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        return proTraceQueryDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 判断发起整改的数据 表中是否存在
     * @param params
     * @return
     */
    public Integer getDatas(HashMap<String, Object> params){
        String projguid = (String) params.get("projguid");
        String pro_code = (String) params.get("pro_code");
        String rectype = (String) params.get("rectype");
        String taskguid = (String) params.get("taskguid");
        String lefttabtype = (String) params.get("lefttabtype");
        String sql ="";
        if("protrace".equals(lefttabtype)){ //项目支出
            if(PerfUtil.getIsHbei()){
                sql ="select count(*) from v_PERF_T_RECTIFY where proguid = '"+projguid+"' and rectype ='"+ rectype +"' and taskguid = '"+taskguid+"'";
            }else {
                sql ="select count(*) from v_PERF_T_RECTIFY where pro_code = '"+pro_code+"' and rectype ='"+ rectype +"' and taskguid = '"+taskguid+"'";
            }
        }else if ("depttrace".equals(lefttabtype)){ //部门整体
            sql ="select count(*) from v_PERF_T_RECTIFY where proguid = '"+projguid+"' and rectype ='"+ rectype +"' and taskguid = '"+taskguid+"'";
        }
        return proTraceQueryDAO.queryForInt(sql);
    }

    /**
     * 查询项目的整改内容(项目第一次发起整改的数据)
     * @param params
     * @return
     */
    public List getDataList(HashMap<String, Object> params) {
        String projguid = (String) params.get("projguid");
        String pro_code = (String) params.get("pro_code");
        String lefttabtype = (String) params.get("lefttabtype");
        String taskguid = (String) params.get("taskguid");
        String rectype = (String) params.get("rectype");
        String sql = "";
        if ("protrace".equals(lefttabtype)) { //项目支出
            if(PerfUtil.getIsHbei()){
                sql = "select * from (select * from v_PERF_T_RECTIFY where proguid = '" + projguid + "' and rectype ='"+ rectype +"' and taskguid ='"+ taskguid +"' order by createtime) where rownum=1";
            }else {
                sql = "select * from (select * from v_PERF_T_RECTIFY where pro_code = '" + pro_code + "' and rectype ='"+ rectype +"' and taskguid ='"+ taskguid +"' order by createtime) where rownum=1";
            }
        } else if ("depttrace".equals(lefttabtype)) { //部门整体
            sql = "select * from (select * from v_PERF_T_RECTIFY where proguid = '" + projguid + "' and rectype ='"+ rectype +"' and taskguid ='" + taskguid +"' order by createtime) where rownum=1";
        }
        logger.debug("查询整改详情：" + sql);
        return proTraceQueryDAO.queryForList(sql);
    }

    /**
     * 查询主表目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> showHisTrace(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String procode = params.get("procode") == null ? (String) params.get("pro_code") : (String) params.get("procode");
        String deptwfststus = (String) params.get("deptwfststus");
        String jxwfststus = (String) params.get("jxwfststus");
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_ALLYEAR;
        String querytype = (String) params.get("querytype");//查询类型， showhistraceyear 为历史年度，其他为本年度
        String year = CommonUtil.getYear();//本年度
        String columncodes = proTraceQueryDAO.getColumncodes(tablecode, "t");
        columncodes += ",decode(nvl(a.isrectify,0),0,'否','是') as isrectify,decode(nvl(a.rectifyend,0),0,'否','是') as rectifyend";
        if (!StringUtil.isEmpty(columncodes)) {
            columncodes += ",case when depttask='1' and provincetask='2' and wfstatus='" + deptwfststus + "' then '011'";
            if (PerfUtil.getIsGuangXi()) {
                columncodes += " when provincetask='1' and nvl(audittype,0) <> '2' and wfstatus='" + jxwfststus + "' then '011'";
            }
            columncodes += " else wfstatus end wfstatus";
        } else {
            columncodes = "t.*";
        }
        StringBuffer returnsql = new StringBuffer("select ");
        returnsql.append(columncodes).append(" from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" left join ").append(ProTraceManageDAO.PERF_VIEW_RECTIFY_ALLYEAR).append(" a on t.taskguid = a.taskguid and t.province = a.province and t.year =a.year and a.procode = t.pro_code");
        returnsql.append(" where t.pro_code = '" +procode+ "' ");
        if(!StringUtil.isNullOrEmpty(querytype) && "showhistraceyear".equals(querytype)){//历史年度查询 排除本年度
            returnsql.append(" and t.year <> '" +year+ "' ");
        }else{//本年度查询
            returnsql.append(" and t.year = '" +year+ "' ");
        }
        returnsql.append(" order by create_time desc");
        List list = proTraceQueryDAO.queryForList(returnsql.toString());
        backMap.put("data", list);
        return backMap;
    }
}
