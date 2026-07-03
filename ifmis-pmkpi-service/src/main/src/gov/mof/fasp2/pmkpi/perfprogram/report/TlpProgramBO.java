package gov.mof.fasp2.pmkpi.perfprogram.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.adjust.report.AdjustReportBO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;


public class TlpProgramBO extends PmkpiBO {

    private TlpProgramDAO tlpProgramDAO;
    /**
     * 注入dao.
     * @param tlpProgramDAO --dao.
     * @throws
     */
    public void setTlpProgramDAO(TlpProgramDAO tlpProgramDAO) {
        this.tlpProgramDAO = tlpProgramDAO;
    }
    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where ");
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
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wsql.append(" and (").append(wfsql).append(") ");
        }
        returnsql.append(datarule);
        if (wsql.length() > 0) {
            returnsql.append(wsql);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, tlpProgramDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }
    
    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @param prolev -- 几级项目.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId,String prolev) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        if (StringUtil.isEmpty(prolev)) {
            throw new AppException("请在菜单配置是几级项目申报！");
        }
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
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
			List<Map> datas = tlpProgramDAO.getByGuid(tablecode, guid, iswf);
			if (datas != null && datas.size() > 0) {//修改
                //map = datas.get(0);
                //map.putAll(infodata);
                infodata.put("update_time", StringUtil.getSysDBDate());
                List<String> cols = new ArrayList<String>(infodata.keySet());
                tlpProgramDAO.update(cols, infodata, tablecode); //修改字段
            } else {//新增
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", SecureUtil.getUserSelectProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                //初始化有效状态
                infodata.put("status", "1");
                this.getBasMap(infodata,"add");
                if(iswf != null && "true".equals(iswf)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                    this.workflow("create",workflow, "", tablecode, l);
                } else {
                    infodata.put("mainguid", guid);
                    tlpProgramDAO.save(infodata, tablecode);
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
        return this.auditdefine(datas, busguid, actioncode, null);
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
            tlpProgramDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            tlpProgramDAO.saveAll(uplist, tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY);
            String selsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            List<Map<String,Object>> tl =  tlpProgramDAO.queryForList("select t.* from "+tablecode+" t where 1=1 and "+selsql);
            for (Map map:tl) {
                for (Map map1:uplist) {

                    if(map.get("guid")==map1.get("guid")||map.get("guid").equals(map1.get("guid"))){
                        map.putAll(map1);
                        break;
                    }
                }
            }
            tlpProgramDAO.updateAllByPK(tl, "guid", tablecode);
            tlpProgramDAO.delDatas(tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY,"");
        }
        if (deldatas.size() > 0) {
            tlpProgramDAO.saveAll(deldatas, tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            tlpProgramDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    tlpProgramDAO.delDatas(deltable, delsql);
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
            tlpProgramDAO.saveAll(deldatas, tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            tlpProgramDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String delTable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    tlpProgramDAO.delDatas(delTable, delsql);
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
        data = tlpProgramDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }


    /**
     * 项目基本信息修改，同步修改配置表项目相关字段数据
     * @param year
     * @param province
     * @param proList
     * @return
     * @throws AppException
     */
    public Map<String, Object> upProTableDatas(String year, String province, List<Map<String, Object>> proList) throws AppException {
        Map<String,Object> resultMap = new HashMap<>();
        if (proList != null && proList.size() > 0) {
            List<String> proguids = new ArrayList<>();
            List<String> procodes = new ArrayList<>();
            //查询修改的表
            List<Map<String, Object>> tableList = this.getDatas("perf_t_upcolset", null, null);
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            List<String> uCols = null;
            String prolevel_no = "";
            for (Map prodata : proList) {
                String pro_code = prodata.get("pro_code") == null ? "" : String.valueOf(prodata.get("pro_code"));
                String pro_id = prodata.get("pro_id") == null ? "" : String.valueOf(prodata.get("pro_id"));
                if ("".equals(prolevel_no)) {
                    String level_no = prodata.get("level_no") + "";
                    prolevel_no = level_no;
                }
                proguids.add(pro_id);
                procodes.add(pro_code);
                if (StringUtil.isEmpty(pro_id) || StringUtil.isEmpty(pro_code)) {
                    resultMap.put("result_code", "0001");
                    resultMap.put("reason", "接口参数项目编码或项目GUID为空，请检查！");
                    return resultMap;
                }
            }
            if (tableList.size() > 0) {
                List<String> updatecols = (List<String>) proList.get(0).get("upcols");
                List<String> upcols = new ArrayList<String>();
                if (updatecols != null && updatecols.size() > 0) {
                    for (String upcol : updatecols) {
                        if ("agencyguid".equals(upcol)) {
                            upcols.add("agencyguid-agency_code");
                        } else if ("agency_code".equals(upcol)) {
                            upcols.add("agency_code-agencyguid");
                        }
                        upcols.add(upcol + "-" + upcol);
                    }
                }
                List sqlList = new ArrayList();
                for (Map<String, Object> tableMap : tableList) {
                    uCols = new ArrayList<>();
                    String tablecode = (String) tableMap.get("tablecode"); //修改数据的表名称
                    String upcoltype = (String) tableMap.get("upcoltype");
                    String relevancycol = (String) tableMap.get("relevancycol"); //根据修改表哪个字段进行修改
                    String wheresql = (String) tableMap.get("wheresql"); //修改条件语句
                    String view = tablecode.substring(0, 2);
                    if (!"V_".equals(view) && !"v_".equals(view)) {
                        view = "v_" + tablecode;
                    } else {
                        view = tablecode;
                    }
                    DicTableDTO dicTableDTO = dicQueryService.getDicTable(view.toUpperCase());
                    List tableCols = (List) dicTableDTO.getListCol();
                    //修改字段
                    for (Object obj : tableCols) {
                        Map map = (Map) obj;
                        String columncode = (String) map.get("columncode");
                        for (String str : upcols) {
                            String[] cols = str.split("-");
                            if (columncode.equals(cols[1].toUpperCase()) && !"IS_LAST_INST".equals(columncode)) {
                                uCols.add(columncode.toLowerCase());
                            } else if (columncode.equals(cols[1].toUpperCase()) && "IS_LAST_INST".equals(columncode) && (("v_pm_perf_goal_info_upc".equals(tablecode) && "pro_id".equals(upcoltype)) || ("v_pm_perf_indicator_upc".equals(tablecode) && "pro_id".equals(upcoltype))|| "1".equals(prolevel_no))) {
                                uCols.add(columncode.toLowerCase());
                            }
                        }
                        if ("UPDATE_TIME".equals(columncode) || "UPDATETIME".equals(columncode)) {
                            uCols.add(columncode.toLowerCase());
                        }
                    }
                    for (Map<String, Object> prodata : proList) {
                        String colcode = "pro_id".equals(upcoltype) ? upcoltype : "pro_code";
                        String relevancycolvalue = (String) prodata.get(colcode);
                        relevancycolvalue = PerfUtil.replaceSymbols(relevancycolvalue);// 对获取的值做特殊符号处理避免拼接sql异常
                        String time = PerfUtil.getServerTimeStamp();
                        StringBuilder upsql = new StringBuilder();
                        for (String col : uCols) {
                            Object value;
                            if ("update_time".equals(col) || "updatetime".equals(col)) {
                                value = time;
                            } else if ("agencyguid".equals(col)) {
                                value = prodata.get("agency_code");
                            } else {
                                value = prodata.get(col);
                            }
                            if(value instanceof String){
                                String escapedVal = ((String) value).replaceAll("'", "''");
                                value = "'"+escapedVal+"'";
                            }
                            upsql.append(" ").append(col).append("= ").append(value).append(",");
                        }
                        if (upsql.length() > 0) {
                            upsql.delete(upsql.length() - 1, upsql.length());
                        }
                        String tablename = tlpProgramDAO.getTableName(tablecode);
                        StringBuilder vchsql = new StringBuilder();
                        vchsql.append("update ").append(tablename).append(" t set ");
                        vchsql.append(upsql);
                        vchsql.append(" where ").append(relevancycol).append("= '").append(relevancycolvalue).append("'");
                        if (!StringUtil.isEmpty(wheresql)) {
                            wheresql = wheresql.replace("#province#", province);
                            wheresql = wheresql.replace("#year#", year);
                            vchsql.append(" and ").append(wheresql);
                        }
                        sqlList.add(vchsql.toString());
                    }
                }
                logger.info("-------upProTableDatas 批量更新sql："+sqlList.toString());
                tlpProgramDAO.batchSingleUpdate(sqlList);
            }

            //江西申报终审，调整终审年度绩效指标进入部门指标库并终审.
            if (PerfUtil.getProendTolib() && PerfUtil.get_IsJiangXi()){
                if (proguids != null && proguids.size() > 0){
                    //处理年度绩效指标转换为部门指标库。并终审.
                    StringBuffer prosql = new StringBuffer(" select * from pm_perf_indicator where ");
                    prosql.append(tlpProgramDAO.createInSql("mainguid", proguids));
                    prosql.append(" and is_deleted=2 and is_backup=2 and province='").append(SecureUtil.getUserSelectProvince()).append("'")
                            .append("and year=").append(SecureUtil.getUserSelectYear()).append(" and yearflag='0' and islinked = '1' and is_add = '1'"); //入库标识
                    List<Map> indexlist =tlpProgramDAO.queryForList(prosql.toString());
                    if (indexlist.size() > 0) {
                        prosql = new StringBuffer("select t.pro_id,t.pro_code,t.projectkind from v_perf_allproject_info t where ");
                        prosql.append(tlpProgramDAO.createInSql("pro_id", proguids));
                        List<Map> list = tlpProgramDAO.queryForList(prosql.toString());
                        Map<String,String> proMap = new HashMap<>();
                        list.forEach(r->{
                            String proid = (String) r.get("pro_id");
                            if (!proMap.containsKey(proid)){
                                proMap.put(proid,String.valueOf(r.get("projectkind")));
                            }
                        });
                        String tempstamp = PerfUtil.getServerTimeStamp();
                        indexlist.forEach(r->{
                            r.put("guid",CommonUtil.createGUID());
                            String tempmainguid = String.valueOf(r.get("mainguid"));
                            r.put("wfid","2F62B0E1A972408B8330D3653F836522");
                            r.put("wfstatus","011");
                            r.put("createtime",tempstamp);
                            r.put("create_time",tempstamp);
                            r.put("updatetime",tempstamp);
                            r.put("update_time",tempstamp);
                            r.put("status",1);
                            r.put("framesystem","PM001");
                            r.put("ind_id",r.get("guid"));
                            r.put("perf_ind_code",r.get("code"));
                            r.put("perf_ind_name",r.get("name"));
                            r.put("is_common_ind", "2");
                            r.put("value_desc",r.get("name"));
                            r.put("parent_id",r.get("sindex"));
                            r.put("level_no",3);
                            r.put("is_leaf",1);
                            r.put("is_enabled",1);
                            r.put("start_date","20230801");
                            r.put("end_date","20991230");
                            r.put("indexvalue",r.get("indexval"));
                            r.put("is_pm_perf_ind",1);
                            r.put("is_last_inst",1);
                            if (proMap.containsKey(tempmainguid) && "32".equals(proMap.get(tempmainguid))){
                                r.put("value_change","1");//转移支付项目
                            } else {
                                r.put("value_change","2");//非转移支付项目
                            }
                        });
                        tlpProgramDAO.saveAll(indexlist,"V_BAS_PERF_INDICATOR");
                        //将调整的指标的总体+年度的：是否新增，是否入库，is_add,is_linked,INDEXCATEGORIES,INDUSTRYCATEGORY,INDEXCATEGORY,FILED,OCCUPATION 清空
                        /*String tepsql = " is_add=2,islinked='2',indexcategories = null,industrycategory=null,indexcategory=null,filed=null,occupation=null ";
                        String wheresql = " is_deleted=2 and is_backup=2 and province='" + SecureUtil.getUserSelectProvince() + "'";
                        tlpProgramDAO.updateAllByColumn("mainguid", proguids, "PM_PERF_INDICATOR", tepsql, wheresql);*/
                    }
                }
            }
        }
        resultMap.put("result_code", "0000");
        return resultMap;
    }

    /**
     * 验证总体目标、指标和项目guid的一致性
     * @return
     */
    public Map<String, Object> checkGoalAndIndexByPro(Map<String, Object> proMap, String province) {
        Map<String,Object> resultMap = new HashMap<>();
        String pro_code = proMap.get("pro_code") == null ? "" : String.valueOf(proMap.get("pro_code"));
        String pro_id = proMap.get("pro_id") == null ? "" : String.valueOf(proMap.get("pro_id"));
        String fromguid = proMap.get("fromguid") == null ? "" : String.valueOf(proMap.get("fromguid"));//调整前guid
        if (StringUtil.isEmpty(pro_id) || StringUtil.isEmpty(pro_code)) {
            resultMap.put("result_code", "0001");
            resultMap.put("reason", "项目guid/编码为控制，请求失败！");
            return resultMap;
        }
        String goalTablecode = PerfConstant.PMKPI_BACKUP_GOAL_INFO;
        String indexTablecode = PerfConstant.PMKPI_BACKUP_INDICATOR;
        String wheresql = " yearflag='1' and is_backup=2 and is_deleted=2 and pro_code=? and province=? ";
        String querysql = wheresql + " and mainguid=? ";
        try{
            //是否存在项目总体数据
            int goalnum = tlpProgramDAO.getDataCount(goalTablecode, querysql, new String[]{pro_code, province, pro_id});
            int indexnum = tlpProgramDAO.getDataCount(indexTablecode, querysql, new String[]{pro_code, province, pro_id});
            //调整时才传调整前项目guid，把调整前项目数据过滤掉，不进行修改
            if (!StringUtil.isNullOrEmpty(fromguid)) {
                wheresql += " and mainguid not in('" + fromguid + "')";
            }
            String upsql = "";
            if (goalnum == 0) {
                upsql = " update " + goalTablecode + " set mainguid ='" + pro_id + "' where " + wheresql;
                logger.info("项目和目标一致性更新sql:" + upsql);
                tlpProgramDAO.update(upsql, new String[]{pro_code, province});
            }
            if (indexnum == 0) {
                upsql = " update " + indexTablecode + " set mainguid ='" + pro_id + "' where " + wheresql;
                logger.info("项目和指标一致性更新sql:" + upsql);
                tlpProgramDAO.update(upsql, new String[]{pro_code, province});
            }
        }catch (Exception e) {
            resultMap.put("result_code","0001");
            resultMap.put("reason", "绩效数据修改失败");
            resultMap.put("error",e.getMessage());
        }
        resultMap.put("result_code", "0000");
        return resultMap;
    }

    /**
     * 项目库终审调用
     * @return
     */
    public Map<String, Object> updateAndDel(String province, String year, Map<String, Object> dataMap) throws AppException {
        PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
        List<Map<String, Object>> proauditcolsList = (List<Map<String, Object>>) dataMap.get("proauditcols");
        Map<String,Object> delGoalAndIndexMap = (Map<String, Object>) dataMap.get("delGoalAndIndex");
        Map<String,Object> addadjustMap = (Map<String, Object>) dataMap.get("addadjust");
        //处理更新项目信息
        Map<String, Object> resultMap = new HashMap<>();
        if (proauditcolsList != null && !proauditcolsList.isEmpty()) {
            logger.info("---------------项目终审更新根据项目信息更新绩效数据：---------------" + proauditcolsList);
            this.upProTableDatas(year, province, proauditcolsList);
            //宁夏判断是否是储备年中追加项目
            if (PerfUtil.getIsNINGXIA()) {
                List<Map<String, Object>> proDatas = proauditcolsList.stream().filter(Objects::nonNull)
                        .filter(m -> "1".equals(m.get("stage") + "") && "1".equals(m.get("v_col25") + "")).collect(Collectors.toList());
                if (!proDatas.isEmpty()) {
                    this.saveYearIndexAndGoal(proDatas, year, pmkpiDAO);
                }
            }
        }
        if (delGoalAndIndexMap != null && !delGoalAndIndexMap.isEmpty()) {
            logger.info("---------------项目调整终审同步处理绩效数据：---------------" + delGoalAndIndexMap);
            //获取项目集合数据 集合中存放参数 proguid（储备、调整前项目guid）  adjproguid 调整项目guid
            List<Map<String, Object>> proList = (List<Map<String, Object>>) delGoalAndIndexMap.get("proList");
            //删除类型 1、储备删除 2、调整删除 3、调整终审删除 4、取消调整终审，需要还原调整前数据9、项目终止is_end
            String deltype = (String) delGoalAndIndexMap.get("deltype");
            PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
            prjIndexBO.delGoalAndIndex(deltype, proList);
        }
        //宁夏项目调整，项目信息变更，生成调整数据
        if (PerfUtil.getIsNINGXIA() && addadjustMap != null && !addadjustMap.isEmpty()) {
            logger.info("---------------项目调整项目信息是否变更，变更生成绩效调整数据：---------------" + addadjustMap);
            //获取项目集合数据 集合中存放参数 proguid（调整前项目guid）  fromguid 调整项目guid
            List<Map<String, Object>> proList = (List<Map<String, Object>>) addadjustMap.get("proList");
            List<String> proguidList = proList.stream().map(m-> (String) m.get("pro_id")).collect(Collectors.toList());
            List<String> adjguidList = proList.stream().map(m-> (String) m.get("fromguid")).collect(Collectors.toList());
            List<String> proguids = new ArrayList<>();
            proguids.addAll(proguidList);
            proguids.addAll(adjguidList);
            StringBuffer wheresql = new StringBuffer();
            wheresql.append(" is_deleted=2 and province=? and ").append(pmkpiDAO.createInSql("pro_id", proguids));
            List<Map<String, Object>> prodatas = PerfServiceFactory.getPmkpiDAO().getDatas("pm_project_info", wheresql.toString(), null, new String[]{SecureUtil.getUserSelectProvince()});
            List<Map<String, Object>> adjproList = new ArrayList<>();
            if (!prodatas.isEmpty()) {
                for (Map<String, Object> map : proList) {
                    String proguid = (String) map.get("pro_id");
                    String fromguid = (String) map.get("fromguid");
                    // 1. 预先将prodatas转换为Map，提高查找效率
                    Map<String, Map<String, Object>> proDataMap = prodatas.stream().filter(Objects::nonNull)
                            .filter(m -> m.get("pro_id") != null).collect(Collectors.toMap(m -> (String) m.get("pro_id"),
                                    Function.identity(), (existing, replacement) -> existing
                            ));
                    // 2. 在循环中直接通过Map.get()获取数据
                    Map<String, Object> proMap = proDataMap.get(proguid);
                    Map<String, Object> adjproMap = proDataMap.get(fromguid);
                    // 3. 安全地比较字段a和b
                    if (proMap != null && adjproMap != null) {
                        //项目概述（pro_desc）、项目内容（v_col19）
                        Object proA = proMap.get("pro_desc");
                        Object adjA = adjproMap.get("pro_desc");

                        Object proB = proMap.get("v_col19");
                        Object adjB = adjproMap.get("v_col19");
                        // 如果字段a或字段b的值不同，则添加到列表
                        if (!Objects.equals(proA, adjA) || !Objects.equals(proB, adjB)) {
                            adjproList.add(adjproMap);
                        }
                    }
                }
            }
            if (!adjproList.isEmpty()) {
                HashMap<String, Object> params = new HashMap<>();
                params.put("proList", adjproList);
                params.put("adjustType", "2");
                params.put("isproadj", "true");
                AdjustReportBO adjustReportBO = (AdjustReportBO) PerfServiceFactory.getBean("pmkpi.adjust.report.AdjustReportBOTX");
                resultMap = adjustReportBO.saveAdjust(params);
            }
        }
        return resultMap;
    }


    /**
     * 根据条件查询指标、目标数据.
     * @throws
     */
    public Map<String, Object> getDatasFilter(List<String> proguidList, List<String> procodeList, PmkpiDAO pmkpiDAO) {
        String indtableCode = "";
        String goaltableCode = "";
        StringBuffer wheresql = null;
        StringBuffer indsql = null;
        StringBuffer goalsql = null;
        String province = SecureUtil.getUserSelectProvince();
        List<Map<String,Object>> inddatas = new ArrayList<>();
        List<Map<String,Object>> goaldatas = new ArrayList<>();
        String[] tempFilter = new String[]{"1", "0"};
        Map<String, Object> dataMap = new HashMap<>();
        for (String yearflag : tempFilter) {
            if (yearflag != null && "1".equals(yearflag)) {
                goaltableCode = "pm_perf_goal_info";
                indtableCode = "pm_perf_indicator";
            } else if (yearflag != null && "0".equals(yearflag)) {
                goaltableCode = "v_pm_perf_goal_info";
                indtableCode = "v_pm_perf_indicator";
            }
            wheresql = new StringBuffer();
            if (yearflag != null && "1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' and is_deleted = 2 and is_backup = 2 and t.province='").append(province).append("' and ").append(pmkpiDAO.createInSql("mainguid", proguidList));
            } else if ("0".equals(yearflag)) {
                wheresql.append(" yearflag = '0' and ").append(pmkpiDAO.createInSql("pro_code", procodeList));
            }
            indsql = new StringBuffer();
            indsql.append("select t.* from ").append(indtableCode).append(" t ");
            goalsql = new StringBuffer();
            goalsql.append("select t.* from ").append(goaltableCode).append(" t ");
            if (!StringUtil.isEmpty(wheresql.toString())) {
                indsql.append(" where ").append(wheresql);
                goalsql.append(" where ").append(wheresql);
            }
            indsql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
            logger.debug("指标:::" + indsql);
            logger.debug("目标:::" + goalsql);
            List<Map<String, Object>> indexList = pmkpiDAO.queryForList(indsql.toString());
            List<Map<String, Object>> goalList = pmkpiDAO.queryForList(goalsql.toString());
            inddatas.addAll(indexList);
            goaldatas.addAll(goalList);
        }
        dataMap.put("index", inddatas);
        dataMap.put("goal", goaldatas);
        return dataMap;
    }

    /**
     * 复制整体保存为年度绩效
     * @param proList
     * @param year
     * @return
     */
    private Map<String, Object> saveYearIndexAndGoal(List<Map<String, Object>> proList, String year, PmkpiDAO pmkpiDAO) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        //宁夏年度绩效不走预算，直接进行总体复制
        String is_last_inst = proList.get(0).get("is_last_inst") + "";
        List<Map<String, Object>> saveIndList = new ArrayList<>();
        List<Map<String, Object>> saveGaolList = new ArrayList<>();
        if ("1".equals(is_last_inst)) {
            logger.info("---------------宁夏项目终审复制整体为年度数据---------------");
            List<String> proguidList = new ArrayList<>();
            List<String> procodeList = new ArrayList<>();
            Map<String, Object> proMap = new HashMap<>();
            for (Map<String, Object> map : proList) {
                String proguid = (String) map.get("pro_id");
                String procode = (String) map.get("pro_code");
                proMap.put(procode, proguid);
                proguidList.add(proguid);
                procodeList.add(procode);
            }
            Map<String, Object> datas = this.getDatasFilter(proguidList, procodeList, pmkpiDAO);
            List<Map<String,Object>> indList = (List<Map<String, Object>>) datas.get("index");
            List<Map<String,Object>> goalList = (List<Map<String, Object>>) datas.get("goal");
            for (String procode : procodeList) {
                String proguid = (String) proMap.get(procode);
                List<Map<String, Object>> index = indList.stream().filter(m-> "0".equals(m.get("yearflag")) && procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                List<Map<String, Object>> goal = goalList.stream().filter(m-> "0".equals(m.get("yearflag")) && procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                if (index.isEmpty()) {
                    List<Map<String, Object>> iList = indList.stream().filter(m-> "1".equals(m.get("yearflag")) && proguid.equals(m.get("mainguid"))).collect(Collectors.toList());
                    saveIndList.addAll(iList);
                }
                if (goal.isEmpty()) {
                    List<Map<String, Object>> gList = goalList.stream().filter(m-> "1".equals(m.get("yearflag")) && proguid.equals(m.get("mainguid"))).collect(Collectors.toList());
                    saveGaolList.addAll(gList);
                }
            }
        }
        if (!saveIndList.isEmpty()) {
            for (Map<String, Object> indexMap : saveIndList) {
                this.setData(indexMap, year);
            }
            pmkpiDAO.saveAll(saveIndList, PerfConstant.PMKPI_VPM_INDICATOR);
        }
        if (!saveGaolList.isEmpty()) {
            for (Map<String, Object> goalMap : saveGaolList) {
                this.setData(goalMap, year);
            }
            pmkpiDAO.saveAll(saveGaolList, PerfConstant.PMKPI_VPM_GOAL_INFO);
        }
        return backMap;
    }

    public Map<String, Object> setData(Map<String, Object> map, String year) {
        String time = PerfUtil.getServerTimeStamp();
        String guid = StringUtil.createUUID();
        map.put("guid", guid);
        map.put("kpi_per_id", guid);//项目目标主键
        map.put("kpi_id", guid);//指标主键
        map.put("year", year);
        map.put("fiscal_year", year);
        map.put("yearflag", "0");
        map.put("create_time", time);
        map.put("createtime", time);
        map.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
        map.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
        map.put("update_time", time);
        map.put("updatetime", time);
        map.put("is_last_inst", 1);
        return map;
    }


}
