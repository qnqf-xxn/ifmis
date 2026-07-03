package gov.mof.fasp2.pmkpi.tabfream;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.appexception.DicTableAppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;
import java.util.*;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:47 2020/8/24  chongdayong
 */
public class TabfreamBO extends PmkpiBO {
    private TabfreamDAO tabfreamDAO;

    public void setTabfreamDAO(TabfreamDAO tabfreamDAO) {
        this.tabfreamDAO = tabfreamDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf");
        String saveAgency = (String) sqlmap.get("saveAgency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String proguid = (String) sqlmap.get("proguid"); //项目id.
        String querycode = (String) sqlmap.get("querycode");
        String bustype = (String) sqlmap.get("bustype");
        String procode = (String) sqlmap.get("procode");
        String mainguid = (String) sqlmap.get("mainguid");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        if ("true".equals(querycode)) {
            if ("program".equals(bustype)) {
                sql.append(" pro_code='").append(procode).append("'");
            } else {
                sql.append(" mainguid='").append(proguid).append("'");
            }
        } else if (!StringUtil.isEmpty(mainguid)){
            sql.append(" mainguid='").append(mainguid).append("'");
        } else {
            String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1"); //数据权限
            sql.append(datarule);
            String columncode = "agencyguid";
            sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, tabfreamDAO.PMKPI_TABLE_T_AGENCY));
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and (").append(wfsql).append(") ");
        }
        return sql.toString();
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        String proguid = (String) params.get("proguid"); //项目id.
        String querycode = (String) params.get("querycode");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String saveAgency = (String) params.get("saveAgency"); //湖北调整部门资金根据部门编码查询
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            tabfreamDAO.setYearAndProvince(queryYear, queryProvince);
        }
        if ("true".equals(querycode)) {
            if ("program".equals(bustype)) {
                wheresql = "pro_code='" + procode + "'";
            } else {
                wheresql = "mainguid='" + proguid + "'";
            }
        } else {
            wheresql = "mainguid='" + mainguid + "'";
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        if("V_PERF_T_DEPTPROEXP".equals(tablecode) || "V_PERF_T_DEPTAMT".equals(tablecode)){ //湖北部门总资金的情况添加排序
            orderby = " order by ordernum";
        }
        List<Map<String, Object>> data = tabfreamDAO.getDatas(tablecode, wheresql, orderby);
        if("V_PERF_T_DEPTAMT".equals(tablecode) && data.size() == 0){ //湖北总资金查询87模板数据
            wheresql = " province = '87' and year = 2016";
            data = tabfreamDAO.getDatas("PERF_T_DEPTAMT", wheresql, orderby);
            data.forEach(m->{
                m.put("guid", StringUtil.createUUID());
                m.put("mainguid", mainguid);
                m.put("province", CommonUtil.getProvince());
                m.put("year", CommonUtil.getYear());
                m.put("rowtype","add"); //模板默认新增
            });
        }
        if("V_PERF_T_ADJDEPTAMT".equals(tablecode) && data.size() == 0){ //湖北部门绩效调整总体资金调整
            wheresql = " agencyguid = '"+saveAgency+"'";
            data = tabfreamDAO.getDatas("V_PERF_T_DEPTAMT", wheresql, orderby);
            if (data.size() == 0) {
                wheresql = " province = '87' and year = 2016";
                data = tabfreamDAO.getDatas("PERF_T_DEPTAMT", wheresql, orderby);
            }
            data.forEach(m->{
                if(StringUtil.isEmpty(proguid)){
                    m.put("proguid", m.get("mainguid"));
                }else{
                    m.put("proguid", proguid);
                }
                m.put("guid", StringUtil.createUUID());
                m.put("mainguid", mainguid);
                m.put("province", CommonUtil.getProvince());
                m.put("year", CommonUtil.getYear());
                m.put("rowtype","add"); //模板默认新增
            });
        }
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(data.size()==0){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    data = (List<Map<String, Object>>) midsavedata.get("result");
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        backMap.put("data", data);
        return backMap;
    }




    /**
     * 获取左侧树数据.
     *
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sysvalue = PerfUtil.getSystemSet("dept_letftree");
        if (sysvalue != null && !sysvalue.isEmpty()) {
            leftconfig.put("datas", this.getLeftTree(menuId, sysvalue));
        }
        return leftconfig;
    }

    /**
     * 根据guid查询数据
     *
     * @param guid
     * @return
     * @throws AppException
     * @throws DicTableAppException
     */
    public Map getDataByGuid(String tablecode, String guid, String iswf){
        List list = new ArrayList();
        if (iswf != null && "true".equals(iswf)) {
            list = tabfreamDAO.getDataByGuid(tablecode, guid);
        } else {
            list = tabfreamDAO.getDataByMainguid(tablecode, guid);
        }
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

    /**
     * 基础信息修改
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = "";
        String tablecode = (String) config.get("tablecode");
        String agency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        String iswf = (String) config.get("iswf");
        String bustype = (String) config.get("bustype");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        if (iswf == null || "".equals(iswf) || "false".equals(iswf)) {
            guid = (String) infodata.get("guid");
        } else {
            guid = (String) config.get("mainguid");
        }
        infodata.put("bustype", bustype);
        if (agency == null || agency.isEmpty()) {
            agency = (String) infodata.get("agencyguid");
        }
        //根据部门或单位查询处室id
        String finintorgguid = getFinintorgguid(agency);
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (null != guid && !guid.isEmpty()) {
            Map map = null;
            List<Map> datas = tabfreamDAO.getDataByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                infodata.remove("year");
                infodata.remove("province");
                map.putAll(infodata);
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("finintorgguid", finintorgguid);
                String wfis = (String) map.get("wfid");
                if (iswf != null && "true".equals(iswf) && (wfis == null || wfis.isEmpty())) {
                    l.clear();
                    l.add(map);
                    if(!StringUtil.isEmpty(workflow)){
                        this.workflow("createnosave", workflow, "", tablecode, l);
                    }else{
                        map.put("mainguid", config.get("mainguid"));
                        tabfreamDAO.update(map, tablecode);
                    }
                } else {
                    map.put("mainguid", config.get("mainguid"));
                    tabfreamDAO.update(map, tablecode);
                }
            } else {//新增
                String newguid = this.getCreateguid();
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", agency);
                infodata.put("finintorgguid", finintorgguid);
                //初始化有效状态
                infodata.put("status", "1");
                if (iswf != null && "true".equals(iswf)) {
                    infodata.put("guid", guid);
                    this.getBasMap(infodata, "add");
                    if(!StringUtil.isEmpty(workflow)){
                        this.workflow("create", workflow, "", tablecode, l);
                    }else{
                        tabfreamDAO.save(infodata, tablecode);
                    }
                } else {
                    infodata.put("guid", newguid);
                    infodata.put("mainguid", config.get("mainguid"));
                    this.getBasMap(infodata, "add");
                    infodata.put("is_last_inst",2);
                    tabfreamDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
        }
        if(PerfUtil.getIsNINGXIA() && "v_perf_t_protraceanalysis".equalsIgnoreCase(tablecode)){// 宁夏 监控分析时，一般监控需要更新主表目标预警
            String depttask = (String) infodata.get("remark");
            if("1".equals(depttask)){
                HashMap<String, Object> params = new HashMap<>();
                params.put("warmtype","depttaskgoalwarn");
                params.put("completepossibility",infodata.get("completepossibility"));
                params.put("depttask",depttask);
                String goalwarn = this.getWarn(params);
                String mainguid = (String) infodata.get("mainguid");
                tabfreamDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.goalwarn='" + goalwarn + "' where t.guid='" + mainguid + "'");
            }
        }
        return this.auditdefine(l, busguid, "perf", null);
    }

    /**
     * 根据部门或单位获取处室id
     * @param agency
     * @return
     */
    private String getFinintorgguid(String agency) {
        String wheresql = "";
        List<Map<String, Object>> data = null;
        wheresql = " t.guid = '" + agency + "'";
        data = tabfreamDAO.getDatas(PmkpiDAO.PMKPI_TABLE_T_AGENCY, wheresql,"order by code");
        String finintorgguid =null;
        if (data!=null && data.size()!=0){
            finintorgguid = (String) data.get(0).get("finintorg");
        }
        return finintorgguid;
    }


    /**
     * 送审/审核/退回/取消审核
     *
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
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 列表保存.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        String saveAgency = (String) params.get("saveAgency");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<String> deltables = (List<String>) params.get("deltables");
        List<String> delcols = (List<String>) params.get("delcols");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency);
                this.getBasMap(map, "add");
                map.put("is_last_inst",2);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("update_time", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            tabfreamDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            tabfreamDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            tabfreamDAO.saveAll(deldatas, tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            if ("bgt_perf_goal_info".equals(tablecode.toLowerCase()) || "v_bgt_perf_goal_info".equals(tablecode.toLowerCase())) {
                tabfreamDAO.updateIsDeleteDatas(tablecode, delsql);
            } else {
                tabfreamDAO.delDatas(tablecode, delsql);
            }
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    tabfreamDAO.delDatas(deltable, delsql);
                }
            }
        }
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable("PERF_TMP_AUDITERRORINFO");
            createTmpTable("PERF_TMP_DEPTFUNCERROR");
            createTmpTable("PERF_TMP_AUDITINDEXERROR");
        }
        //部门申报年度任务页签,
        if ("V_PERF_T_DEPTTASK".equals(tablecode) && !StringUtil.isEmpty(tablecode)){
            //更新年度任务总金额到主表
            String querysql = "select sum(t.TOTALAMT) as TOTALAMT from "+tablecode+" t where mainguid ='"+mainguid+"' order by t.MAINGUID";
            List<Map<String,Object>> listdata = tabfreamDAO.queryForList(querysql);
            BigDecimal totalamt = new BigDecimal("0");
            if (listdata.size() > 0) {
                Map amtdatas= listdata.get(0);
                totalamt = (BigDecimal) amtdatas.get("totalamt");
            }
            tabfreamDAO.update("update v_perf_t_deptperfdeclare set tasktoalamt ="+totalamt +" where guid = '"+mainguid+"'");
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 保存审核标识
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveauditDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode ="perf_t_proauditmark";
        String pro_code = (String) params.get("pro_code");
        String pro_id = (String) params.get("pro_id");
        String agency_code = (String) params.get("agency_code");
        logger.debug("------保存方法-------------" +
                "项目编码："+pro_code +"---------项目id："+pro_id+"-----------d单位："+agency_code);
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        Map<String,Object> datamap = new HashMap<>();
        datamap.put("guid",this.getCreateguid());
        datamap.put("pro_code",pro_code);
        datamap.put("pro_id",pro_id);
        datamap.put("agency_code",agency_code);
        datamap.put("creater", SecureUtil.getCurrentUser().getGuid());
        datamap.put("createtime", PerfUtil.getServerTimeStamp());
        datamap.put("updatetime", PerfUtil.getServerTimeStamp());
        datamap.put("province", SecureUtil.getUserSelectProvince());
        datamap.put("year", CommonUtil.getYear());
        datamap.put("is_audit","1"); //已审核标识
        addlist.add(datamap);
        String wheresql =" pro_id ='"+pro_id+"'";
        if (addlist.size() > 0) {
            tabfreamDAO.delDatas(tablecode,wheresql);
            tabfreamDAO.saveAll(addlist, tablecode);
        }
        backMap.put("success", true);
        return backMap;
    }

    /**
     * 编辑区查询
     *
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String tablecode = (String) params.get("tablecode");
        String iswf = (String) params.get("iswf");
        String procode = (String) params.get("procode");
        String querycode = (String) params.get("querycode");
        String bustype = (String) params.get("bustype");
        String proguid = (String) params.get("proguid");
        String isqueryAgency = (String) params.get("isqueryAgency");
        String isnzzj = (String) params.get("isnzzj");
        String compconfigid = (String) params.get("compconfigid"); //监控分析
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            tabfreamDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String url = (String) params.get("url");
        if("/pmkpi/program/report/payindex".equals(url)){
            Map<String, Object> proMap = this.getDataMap(tablecode, "pro_code =?",new String[]{procode});
            mainguid = (String) proMap.get("guid");
        }
        Map<String, Object> map = null;
        if ("true".equals(querycode)) {
            String wheresql = "";
            if (PerfUtil.getIsHbei() || "dept".equals(bustype)) {
                if ("true".equals(iswf)) {
                    wheresql = "guid='" + proguid + "'";
                } else {
                    wheresql = "mainguid='" + proguid + "'";
                }
            } else {
                if ("true".equals(iswf)) {
                    wheresql = "pro_code='" + procode + "'";
                } else {
                    wheresql = "mainguid='" + proguid + "'";
                }
            }
            map = this.getDataMap(tablecode, wheresql);
        } else {
            if ("true".equals(isnzzj) && !PerfUtil.getIsHbei()) {
                map = this.getDataByProCode(tablecode, procode);
            }else if ("true".equals(isnzzj) && PerfUtil.getIsHbei()) {
                map = this.getDataByGuid(tablecode, proguid, iswf);
            }else{
                map = this.getDataByGuid(tablecode, mainguid, iswf);
            }
            if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
                //业务表无数据，查询有暂存返回暂存
                if(map.isEmpty()){
                    PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                    Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                    if(midsavedata!=null && midsavedata.get("result")!=null){
                        map = (Map<String, Object>) midsavedata.get("result");
                    }
                }else{
                    backMap.put("hidButtons", "暂存");
                }
            }
            if ("true".equals(iswf)) {
                backMap.put("hidButtons", "暂存");
            }
            if (map.isEmpty()) {
                if (!"false".equals(isqueryAgency)) {
                    List<Map<String, Object>> agencyList = this.getAgencyData(saveAgency);
                    if (null != agencyList && agencyList.size() != 0) {
                        String name = (String) agencyList.get(0).get("name");
                        String code = (String) agencyList.get(0).get("code");
                        map.put("name", name);
                        map.put("code", code);
                    }
                }
                if ("true".equals(iswf)) {
                    map.put("guid", mainguid);
                } else {
                    map.put("mainguid", mainguid);
                    map.put("guid", StringUtil.createUUID());
                }
                if("1".equals(PerfUtil.getSystemSet("IS_TIANJIN"))){ //天津项目申报的时候，单位和主管部门默认。
                    map.put("manage_dept_code",saveAgency.substring(0,3));
                    map.put("agency_code",saveAgency);
                }
                if (PerfUtil.getIS_HUBEI() && "PERF_T_DEPTPERFDECLARE".equalsIgnoreCase(tablecode)) { //湖北下一年自动获取上一年的长期目标截止年份
                    List uplist = tabfreamDAO.getMainMap(saveAgency);
                    int endyear = 0;
                    if (uplist.size() > 0){
                        Map mainMap = (Map) uplist.get(0);
                        Object o = PerfUtil.transformUpperCase(mainMap).get("endyear");
                        if (o == null) {
                            endyear= 0;
                        } else {
                            endyear = Integer.parseInt(o.toString());
                        }
                        if (endyear >= Integer.parseInt(CommonUtil.getYear())) {
                            map.put("endyear", endyear);
                        }
                    }
                }
            }
        }

        //监控分析页签 预算执行预警和绩效目标完成预警字段从监控主表获取值
        if("analysisformaleditform".equals(compconfigid)){
            String wheresql = "guid='" + mainguid + "'";
            tablecode = "v_perf_t_promonitor";
            Map<String, Object> goalMap = tabfreamDAO.getDataMap(tablecode, wheresql);
            String bgtwarn = (String) goalMap.get("bgtwarn");
            String goalwarn = (String) goalMap.get("goalwarn");
            if ("red".equals(bgtwarn)) {
                bgtwarn = "红色";
            } else if ("yellow".equals(bgtwarn)) {
                bgtwarn = "黄色";
            } else if ("green".equals(bgtwarn)) {
                bgtwarn = "绿色";
            } else if ("blue".equals(bgtwarn)) {
                bgtwarn = "蓝色";
            }else{
                bgtwarn = "";
            }
            if ("red".equals(goalwarn)) {
                goalwarn = "红色";
            } else if ("yellow".equals(goalwarn)) {
                goalwarn = "黄色";
            } else if ("green".equals(goalwarn)) {
                goalwarn = "绿色";
            } else if ("blue".equals(goalwarn)) {
                goalwarn = "蓝色";
            }else{
                goalwarn = "";
            }
            map.put("bgtwarn",bgtwarn);
            map.put("goalwarn",goalwarn);
            if(PerfUtil.getIsNINGXIA()){// 标记是否为一般监控，用于后面是否走预警判断
                String depttask = (String) goalMap.get("depttask");
                String provincetask = (String) goalMap.get("provincetask");
                String ramark = ("1".equals(depttask)&&"2".equals(provincetask))? "1" : "2";
                map.put("remark",ramark);
            }
        }

        //项目监控分析页签
        if("analysisformaleditform".equals(compconfigid) && "protrace".equals(bustype)){
            //查询年度绩效目标
            String wheresql = "pro_code='" + procode + "' and yearflag = '0'";
            tablecode = "v_pm_perf_goal_info";
            Map<String, Object> goalMap = tabfreamDAO.getDataMap(tablecode, wheresql);
            String yeargoal = (String) goalMap.get("kpi_target");
            map.put("yeargoal",yeargoal);
        }

        //部门监控分析页签
        if("analysisformaleditform".equals(compconfigid) && "depttrace".equals(bustype)){
            //查询年度绩效目标
            String wheresql = "mainguid='" + proguid + "'";
            tablecode = "v_bgt_perf_goal_info";
            Map<String, Object> goalMap = tabfreamDAO.getDataMap(tablecode, wheresql);
            String ndgoal = (String) goalMap.get("kpi_target");
            map.put("ndgoal",ndgoal);
        }
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        try {
            tabfreamDAO.saveAll(deldatas, tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            tabfreamDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    tabfreamDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }


    /**
     * 列表保存.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> saveall(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //关联字段
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String workflow = (String) params.get("workflow");
        List<String> savecomponentis = (List<String>) params.get("savecomponentis");
        Map<String, Object> tableconfig = (Map<String, Object>) params.get("tableconfig"); //组件
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();//数据
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        for (String componentid : savecomponentis) {
            //表名
            String tablecode = (String) tableconfig.get(componentid);
            String busguid = (String) tableconfig.get(componentid + "_busguid");
            if (componentid.indexOf("editform") != -1) {
                Map<String, Object> infodata = (Map<String, Object>) tableconfig.get(componentid + "_infodata");
                //当前登录用户
                UserDTO user = SecureUtil.getCurrentUser();
                l.add(infodata);
                String province = SecureUtil.getUserSelectProvince();
                if (null != mainguid && !"".equals(mainguid)) {
                    Map map = null;
                    List<Map> datas = tabfreamDAO.getDataByGuid(tablecode, mainguid);
                    if (datas != null && datas.size() > 0) {//修改
                        map = datas.get(0);
                        map.putAll(infodata);
                        map.put("updatetime", StringUtil.getSysDBDate());
                        tabfreamDAO.update(map, tablecode);
                    } else {//新增
                        infodata.put("createtime", StringUtil.getSysDBDate());
                        infodata.put("updatetime", StringUtil.getSysDBDate());
                        infodata.put("guid", mainguid);
                        infodata.put("creater", user.getGuid());
                        infodata.put("province", province);
                        infodata.put("year", CommonUtil.getYear());
                        infodata.put("agencyguid", saveAgency);
                        //初始化有效状态
                        infodata.put("status", "1");

                        this.workflow("create", workflow, "", tablecode, l);
                    }
                }
            }
            if (componentid.indexOf("datatable") != -1) {
                //全部数据
                List<Map<String, Object>> datas = (List<Map<String, Object>>) tableconfig.get(componentid + "_datas");
                //修改数据
                List<Map<String, Object>> updatas = (List<Map<String, Object>>) tableconfig.get(componentid + "_updatas");
                //删除数据
                List<Map<String, Object>> deldatas = (List<Map<String, Object>>) tableconfig.get(componentid + "_deldatas");
                List<String> deltables = (List<String>) tableconfig.get(componentid + "_deltables");
                List<String> delcols = (List<String>) tableconfig.get(componentid + "_delcols");
                l = datas;
                List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
                int i = 1;
                for (Map<String, Object> map : datas) {
                    String rowtype = (String) map.get("rowtype");
                    map.put("ordernum", i++);
                    if (rowtype != null && "add".equals(rowtype)) {
                        map.put("createtime", StringUtil.getSysDBDate());
                        map.put("updatetime", StringUtil.getSysDBDate());
                        map.put("creater", SecureUtil.getCurrentUser().getGuid());
                        map.put("province", SecureUtil.getUserSelectProvince());
                        map.put("year", CommonUtil.getYear());
                        map.put("agencyguid", saveAgency);
                        addlist.add(map);
                    } else {
                        uplist.add(map);
                    }
                }
                if (addlist.size() > 0) {
                    tabfreamDAO.saveAll(addlist, tablecode);
                }
                if (uplist.size() > 0) {
                    tabfreamDAO.updateAllByPK(uplist, "guid", tablecode);
                }
                if (deldatas.size() > 0) {
                    tabfreamDAO.saveAll(deldatas, tabfreamDAO.PMKPI_TABLE_TMP_AGENCY);
                    String delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                    tabfreamDAO.delDatas(tablecode, delsql);
                    if (deltables != null && deltables.size() > 0) {
                        String col = "mainguid";
                        int j = 0;
                        for (String deltable : deltables) {
                            if (delcols != null && delcols.size() > 0) {
                                col = delcols.get(j);
                            }
                            delsql = " exists(select 1 from " + tabfreamDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                            tabfreamDAO.delDatas(deltable, delsql);
                        }
                    }
                }
            }
            backMap.put("componentid", componentid);
            backMap = this.auditdefine(l, busguid, "perf", backMap);
            boolean success = (Boolean) backMap.get("success");
            String errtype = (String) backMap.get("errtype");
            if (!success && "force".equals(errtype)) {
                throw new PerfAppException("checkAuditDefine", errtype, backMap);
            } else if (!success) {
                return backMap;
            }
        }
        return backMap;
    }

    /**
     * 查询部门已申报数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDeclareData(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String wheresql = "";
        List<Map<String, Object>> data = null;
        String saveAgency = (String) parms.get("saveAgency");
        wheresql = " t.agencyguid = '" + saveAgency + "'";
        data = tabfreamDAO.getDeclareData("V_PERF_T_DEPTPERFDECLARE", wheresql);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 获取公式信息
     * @param params
     * @return
     */
    public Map<String, Object> getEditFormal(HashMap<String, Object> params) {
        Map<String,Object> backMap = new HashMap<>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> formallist = tabfreamDAO.getEditFormal(tablecode,mainguid,saveAgency);
        Map<String, Object> info = new HashMap<>();
        Map<String, Object> sumMap = new HashMap<>();
        List<String> colList = new ArrayList<>();
        for (Map<String, Object> formalMap : formallist) {
            String columncode = (String) formalMap.get("columncode");
            info.put(columncode, formalMap.get("value"));
            String sumcol = (String) formalMap.get("sumcol");
            if (sumcol != null && !sumcol.isEmpty()) {
                String cols = sumcol;
                for (Map<String, Object> map : formallist) {
                    String sub = (String) map.get("columncode");
                    if (sumcol.indexOf(sub) != -1) {
                        colList.add(sub);
//                        cols = cols.replace("[","");
//                        cols = cols.replace("]","");
                        sumMap.put(sub, columncode + "=" + cols);
                    }
                }
            }
        }
        backMap.put("info", info);//计算数据
        backMap.put("colList", colList);//改变的列
        backMap.put("sumMap", sumMap);//计算符号
        return backMap;
    }

    /**
     * 获取公式数据
     * @param sql
     * @return
     */
    public BigDecimal getFormalValue(String sql) {
        Map<String, Object> map = tabfreamDAO.queryForMap(sql);
        BigDecimal value = new BigDecimal(map.get("value") + "");
        return value;
    }

    /**
     * <p>湖北-判断当前部门是否是试点部门</p >
     *
     * @author hw
     * @date 2022/9/26 10:20
     * @param
     */
    public Boolean isPilot() {
        Boolean flag = false;
        String agencyguid = SecureUtil.getCurrentUser().getAgency();
        logger.info("---湖北-判断当前部门是否是试点部门：agencyguid = " + agencyguid);
        String newApplyDepts = PerfUtil.getSystemSet("PILOT_DEPTS");  // 湖北-试点部门配置
        if (PerfUtil.getIS_HUBEI() && !StringUtils.isEmpty(newApplyDepts) && !StringUtils.isEmpty(agencyguid) && agencyguid.length() >= 3) {
            Map<String, Object> tabMap = JsonUtils.jsonToMap(newApplyDepts);
            String agencys = (String) tabMap.get("agencys");
            String[] split = agencys.split(",");
            List<String> list = Arrays.asList(split);
            agencyguid = agencyguid.substring(0, 3);
            flag = list.contains(agencyguid);
        }
        return flag;
    }

    /**
     * 根据 procode 查询数据
     *
     * @param procode
     * @return
     * @throws AppException
     * @throws DicTableAppException
     */
    public Map getDataByProCode(String tablecode, String procode){
        List list = new ArrayList();
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where pro_code = '").append(procode).append("'");
        logger.info("---根据procode查询数据：" + sql);
        list = tabfreamDAO.queryForList(sql.toString());
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

    /**
     * 获取上年绩效目标/指标复制.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> copyPerf(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String copytype = (String)params.get("copytype");
        String saveAgency = (String)params.get("saveAgency");//部门编码
        Integer year = Integer.parseInt(CommonUtil.getYear()) -1;
        String tablecode = "";
        String orderby = "";
        String querysql ="t.agencyguid = '"+saveAgency+"' and is_deleted = 2 and is_backup = 2 and t.province ='"+CommonUtil.getProvince()+"' and t.year ='"+year+"'";
        if(copytype!=null && "goal".equals(copytype)){
            tablecode = "BGT_PERF_GOAL_INFO";
            orderby = " order by t.updatetime";
        } else if(copytype!=null && "index".equals(copytype)){
            tablecode = "BGT_PERF_INDICATOR";
            orderby = " order by t.ordernum";
        }
        List<Map<String, Object>> data = tabfreamDAO.getDatas(tablecode, querysql, orderby);
        if(data.size() == 0){
            throw new PerfAppException("0", "找不到上年绩效数据无法复制！");
        }
        if(copytype!=null && "index".equals(copytype)){
            data.forEach(map ->{
                map.put("year",CommonUtil.getYear());
                map.put("fiscal_year",CommonUtil.getYear());
                String guid = CommonUtil.createGUID();
                map.put("guid",guid);
                map.put("kpi_id",guid);
                map.put("mainguid", mainguid);
                map.put("rowtype","add");
                map.put("indexval","");//202X指标值 不复制
                map.put("kpi_val","");//202X指标值 不复制
            });
        }else if(copytype!=null && "goal".equals(copytype)){//前台页面不修改编辑内容直接点保存不触发保存方法
            Map<String, Object> goalmap = data.get(0);
            String guid = CommonUtil.createGUID();
            String timeStamp = PerfUtil.getServerTimeStamp();
            querysql ="t.agencyguid = '"+saveAgency+"' and is_deleted = 2 and t.province ='"+CommonUtil.getProvince()+"' and t.year ='"+CommonUtil.getYear()+"'";
            List<Map<String, Object>> nowlist = tabfreamDAO.getDatas(tablecode, querysql, orderby);
            if(nowlist.size()>0){//存在当年数据处理guid作为修改依据
                guid = (String) nowlist.get(0).get("guid");
            }
            goalmap.put("guid",guid);
            goalmap.put("kpi_dep_id",guid);
            goalmap.put("mainguid", mainguid);
            goalmap.put("year",CommonUtil.getYear());
            goalmap.put("fiscal_year",CommonUtil.getYear());
            if(nowlist.size()>0){//存在当年数据时直接更新数据
                goalmap.put("updatetime", timeStamp);
                goalmap.put("update_time", timeStamp);
                List<String> cols = new ArrayList<String>(goalmap.keySet());
                cols.remove("province");
                cols.remove("year");
                tabfreamDAO.update(cols, goalmap, tablecode);
            }else{
                goalmap.put("createtime", timeStamp);
                goalmap.put("updatetime", timeStamp);
                goalmap.put("update_time", timeStamp);
                goalmap.put("create_time", timeStamp);
                tabfreamDAO.save(goalmap, tablecode);
            }
        }
        backMap.put("data", data);
        return backMap;
    }

}
