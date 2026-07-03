package gov.mof.fasp2.pmkpi.evalcase;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class EvalCaseBO extends PmkpiBO {

    private EvalCaseDAO evalCaseDAO;
    /**
     * 注入dao.
     * @param evalCaseDAO --dao.
     * @throws
     */
    public void setEvalCaseDAO(EvalCaseDAO evalCaseDAO) {
        this.evalCaseDAO = evalCaseDAO;
    }
    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String querytype = (String)sqlmap.get("querytype");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        if(querytype!=null && "query".equals(querytype)){
            returnsql.append(" where  1=1");
        }else{
            returnsql.append(" where  t.province = '"+SecureUtil.getUserSelectProvince()+"'");
        }
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()) {
            wsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wsql.append(" and ").append(tabfilter);
        }
        if (wsql.length() > 0) {
            returnsql.append(wsql);
        }
        String columncode = "province";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, "V_ELE_VD08001"));
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param querytype -- 查询方式
     * @return --
     */
    public Map<String, Object> getTreeData(String querytype) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "区划");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        List<Map<String, Object>> datas = new ArrayList<>();
        if(querytype!=null && "query".equals(querytype)){
            datas = this.getLeftTreeProvince("PERF_T_EVALCASE","province",false);
        }else{
            datas = this.getLeftTreeProvince("PERF_T_EVALCASE","province",true);
        }
        leftconfig.put("datas", datas);
        return leftconfig;
    }

    public List<Map<String, Object>> getLeftTreeProvince(String tablecode, String columncode, boolean isreport) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct a.* from ").append("V_ELE_VD08001 a");
        if(!isreport){
            sql.append(" start with exists (select 1 from ").append(tablecode).append(" t where a.guid = t.").append(columncode).append(") ");
        }else{
            sql.append(" where a.guid = '").append(SecureUtil.getUserSelectProvince()).append("'");
        }
        sql.append(" connect by prior a.superguid = a.guid");
        sql.append(" order by code ");
        logger.info("---获取左侧树数据-不走临时表：" + sql.toString());
        return evalCaseDAO.queryForList(sql.toString());
    }

    /**
     * 根据guid查询数据
     * @param guid--
     * @param  -- 区分编辑哪个是主单信息.
     * @return
     */
	public Map getByGuid(String tablecode, String guid, String iswf) {
		List list = evalCaseDAO.getByGuid(tablecode, guid, iswf);
		Map map = new HashMap();
		if (list.size() > 0) {
			map = (Map) list.get(0);
		}
		return map;
	}
	
	/**
	 * 编辑区保存
	 * @param config --
	 * @return
	 * @throws AppException
	 */
	public Map infosave(HashMap config) throws AppException {
	    Map<String,Object> backMap = new HashMap<String, Object>();
	    String guid = (String) config.get("mainguid");
	    String iswf = (String) config.get("iswf");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
		//当前登录用户
		UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        infodata.put("pro_id", guid);
        if (guid != null && !guid.isEmpty()) {
			//Map map = null;
			List<Map> datas = evalCaseDAO.getByGuid(tablecode, guid, iswf);
			if (datas != null && datas.size() > 0) {//修改
                infodata.put("update_time", StringUtil.getSysDBDate());
                List<String> cols = new ArrayList<String>(infodata.keySet());
                evalCaseDAO.update(cols, infodata, tablecode); //修改字段
            } else {//新增
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", SecureUtil.getUserSelectProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                //初始化有效状态
                infodata.put("status", "1");
                infodata.put("protype", "gov");
                this.getBasMap(infodata,"add");
                if(iswf != null && "true".equals(iswf)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                    this.workflow("create",workflow, "", tablecode, l);
                } else {
                    infodata.put("mainguid", guid);
                    evalCaseDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
		}
		return this.auditdefine(l, busguid,"perf", null);
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
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
//        List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<String> deltables = (List<String>) params.get("deltables");
        List<String> delcols = (List<String>) params.get("delcols");

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
                map.put("agencyguid", saveAgency); //这个考虑一级项目挂在处室处理?以后处理,页面得传递columncode
                map.put("mainguid", mainguid); 
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            evalCaseDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            evalCaseDAO.saveAll(uplist, evalCaseDAO.PMKPI_TABLE_TMP_AGENCY);
            String selsql = " exists(select 1 from " + evalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            List<Map<String,Object>> tl =  evalCaseDAO.queryForList("select t.* from "+tablecode+" t where 1=1 and "+selsql);
            for (Map map:tl) {
                for (Map map1:uplist) {

                    if(map.get("guid")==map1.get("guid")||map.get("guid").equals(map1.get("guid"))){
                        map.putAll(map1);
                        break;
                    }
                }
            }
            evalCaseDAO.updateAllByPK(tl, "guid", tablecode);
            evalCaseDAO.delDatas(evalCaseDAO.PMKPI_TABLE_TMP_AGENCY,"");
        }
        if (deldatas.size() > 0) {
            evalCaseDAO.saveAll(deldatas, evalCaseDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + evalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            evalCaseDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + evalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    evalCaseDAO.delDatas(deltable, delsql);
                }
            }
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency") ;
        String iswf = (String) params.get("iswf"); //区分是主编辑区，其他编辑区不要这个参数
        Map<String, Object> map = this.getByGuid(tablecode, mainguid, iswf);
        String agencycode = (String)map.get("agency_code");
        String deptcode = (String)map.get("manage_dept_code");
        if(StringUtils.isEmpty(agencycode)){
            agencycode = saveAgency;
        }
        if(StringUtils.isEmpty(deptcode)){
            if(saveAgency!=null&&saveAgency.length()>3){
                deptcode = saveAgency.substring(0,3);
            }
        }
        map.put("agency_code",agencycode);
        map.put("manage_dept_code",deptcode);
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
            evalCaseDAO.saveAll(deldatas, evalCaseDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + evalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            evalCaseDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String delTable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + evalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    evalCaseDAO.delDatas(delTable, delsql);
                }
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
    
    /**
     * 列表查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        List<Map<String, Object>> data = null;
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        wheresql = " t.mainguid = '" + mainguid + "'";
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        data = evalCaseDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    public Map<String, Object> getFundDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String viewtype = (String) params.get("viewtype");//查询状态
        String tablesql = (String) params.get("tablesql"); //页签过滤sql
        String orderby = (String) params.get("orderby");
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            wheresql += " and " + tablesql;
        }
        List<Map<String, Object>> bgtfundList = evalCaseDAO.getDatas(tablecode, wheresql, orderby);
        if (bgtfundList != null && bgtfundList.size() > 0) {//存在业务数据直接返回
            bgtfundList.get(0).put("hidButtons", "暂存");
            backMap.put("data", bgtfundList);
            backMap.put("hidButtons","暂存");
            return backMap;
        }
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            PerfMidsaveBO perfMidsaveBO = (PerfMidsaveBO) ServiceFactory.getBean("pmkpi.perfmidsave.PerfMidsaveBO");
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
            if(midsavedata!=null && midsavedata.get("result")!=null){
                backMap.put("data", (List<Map<String, Object>>) midsavedata.get("result"));
                return backMap;
            }
        }
        if(bgtfundList.size() == 0){//返回单行空数据
            bgtfundList.add(new HashMap<>());
            backMap.put("data", bgtfundList);
            return backMap;
        }
        return backMap;
    }

    public Map<String, Object> saveFundDatas(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> fundList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> map : datas) {
            map.put("guid", this.getCreateguid());
            map.put("province", CommonUtil.getProvince());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", saveAgency);
            map.put("mainguid", mainguid);
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("update_time", PerfUtil.getServerTimeStamp());
            fundList.add(map);
        }
        //删除保存
        String delsql = " mainguid='" + mainguid + "'";
        evalCaseDAO.delDatas(tablecode, delsql);
        evalCaseDAO.saveAll(fundList, tablecode);
        return this.auditdefine(fundList, busguid,"perf", null);
    }

}
