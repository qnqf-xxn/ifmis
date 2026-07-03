package gov.mof.fasp2.pmkpi.perfpromod.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ProModRpBO extends PmkpiBO {
    
    private ProModRpDAO proModRpDAO;

    public void setProModRpDAO(ProModRpDAO proModRpDAO) {
        this.proModRpDAO = proModRpDAO;
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
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String modtype = (String) sqlmap.get("modtype");
        String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
        String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
        logger.debug("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
            columncode = "agencyguid";
        }
        String datarule = " 1=1 ";
        datarule += this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (isleaf != null && saveAgency != null && !"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
            datarule += " and isleaf=1 start with superguid='" + saveAgency + "' connect by prior guid = superguid";
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            proModRpDAO.saveAll(eledatas, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (saveAgency != null && "treeroot".equals(saveAgency)) {
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            proModRpDAO.saveAll(eledatas, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select t.* ");
        returnsql.append(" from ").append(tablecode).append(" t ");
        returnsql.append(" where 1=1");
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wfsql = wfsql.replaceAll("WFSTATUS","t.wfstatus");
            if (!StringUtil.isEmpty(tabcode) && !"alldeals".equals(tabcode)) {
                wfsql = wfsql.replaceAll("wfid","t.wfid");
            }
            wfsql = wfsql.replaceAll("AUDITOR","t.auditor");
            wfsql = wfsql.replaceAll("GUID","t.guid");
            returnsql.append(" and ").append(wfsql);
        }
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.").append(columncode).append("='").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(proModRpDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.").append(columncode).append(")");
        }
        if (modtype != null && !modtype.isEmpty()) {
            returnsql.append(" and t.modtype = '").append(modtype).append("' ");
        }
        return returnsql.toString();
    }
    
    /**
     *
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public StringBuffer getDeptfuncQuerySql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        String mainguid = (String)sqlmap.get("mainguid");
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        sql.append(" (select * from ").append(tablecode).append(" where 1=1 ");
        sql.append(" and mainguid='").append(mainguid).append("'");
        if (tablesql != null && !tablecode.isEmpty()) {
            sql.append(" and ").append(tablecode);
        }
        sql.append(")");
        return sql;
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
        if (prolev == null || prolev.isEmpty()) {
            throw new AppException("请在菜单配置是几级项目申报！");
        }
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        String elementcode = sysvalue;
        String sql = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        sql = sql.replace("agencyguid","guid");
        List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode, sql);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        for (Map<String, Object> map : eledatas) {
            isleaf = map.get("isleaf");
            if (((Number) isleaf).intValue() == 1) {
                treesourcedata.add(map);
            }
        }
        if (elementcode != null && "PMKPIAGENCYALLPAY".equals(elementcode)) {
            proModRpDAO.saveAll(eledatas, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            proModRpDAO.saveAll(treesourcedata, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        leftconfig.put("datas", proModRpDAO.getLeftTree());
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
	    String pagetype = (String) config.get("pagetype");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
		//当前登录用户
		UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (guid != null && !guid.isEmpty()) {
			Map map = null;
			List<Map> datas = proModRpDAO.getByGuid(tablecode, guid, pagetype);
			if (datas != null && datas.size() > 0) {//修改
				map = datas.get(0);
				map.putAll(infodata);
				map.put("updatetime", StringUtil.getSysDBDate());
				proModRpDAO.update(map, tablecode);
			} else {//新增
                infodata.put("createtime", StringUtil.getSysDBDate());
                infodata.put("updatetime", StringUtil.getSysDBDate());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
				//初始化有效状态
                infodata.put("status", "1");
                if(!StringUtil.isEmpty(pagetype)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                    this.workflow("create",workflow, "", tablecode, l);
                } else {
                    infodata.put("mainguid", guid);
                    proModRpDAO.save(infodata, tablecode);
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
            proModRpDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            proModRpDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas != null && deldatas.size() > 0) {
            proModRpDAO.saveAll(deldatas, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + proModRpDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            proModRpDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + proModRpDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    proModRpDAO.delDatas(deltable, delsql);
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
        String pagetype = (String) params.get("pagetype"); //区分是主编辑区，其他编辑区不要这个参数
        Map<String, Object> map = this.getByGuid(tablecode, mainguid, pagetype);
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public void delDatas(HashMap<String, Object> parms) throws AppException {
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        proModRpDAO.saveAll(deldatas, proModRpDAO.PMKPI_TABLE_TMP_AGENCY);
        String delsql = " exists(select 1 from " + proModRpDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
        //删除修订主表
        proModRpDAO.delDatas(tablecode, delsql);
        //删除修订指标表
        delsql = " exists(select 1 from " + proModRpDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
        proModRpDAO.delDatas("V_PERF_PROVISION_INDICATOR", delsql);
        //删除修订目标表
        proModRpDAO.delDatas("V_PERF_PROVISION_GOAL_INFO", delsql);
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
        data = proModRpDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = "V_PERF_T_PROVISIONDECLARE";
        String workflow = (String)params.get("workflow");
        String modtype = (String) params.get("modtype");
        String modtypesql = "";
        if (modtype != null && "total".equals(modtype)) {
            modtypesql = " t.modtype = '"+modtype+"'";
        }else {
            modtypesql = " t.modtype = '"+modtype+"'";
        }
        if (datas != null && datas.size() >= 0) {
            proModRpDAO.saveAll(datas, proModRpDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = "";
            //根据项目信息获取调整主单信息
            wheresql = " exists(select * from "+ proModRpDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.proguid=a.guid) ";
            List<Map<String, Object>> maindatas = proModRpDAO.getDatas(tablecode, wheresql, null);
            //删除临时表数据
            proModRpDAO.delDatas(proModRpDAO.PMKPI_TABLE_TMP_GUIDS, null);
            proModRpDAO.saveAll(maindatas, proModRpDAO.PMKPI_TABLE_TMP_GUIDS);
            //获取项目最大修订次数
            List<Map<String, Object>> revisionnums = proModRpDAO.getJustnums(modtypesql);
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<String, Object>();
                String guid = this.getCreateguid();
                adjustMap.put("revisionnum", 1);
                adjustMap.put("pro_code",map.get("pro_code"));
                adjustMap.put("pro_name",map.get("pro_name"));
                int adjustnum = 0;
                for (Map<String, Object> m : revisionnums) {
                    String proguid = (String) m.get("proguid");
                    adjustnum = this.mapGetInt(m,"revisionnum");
                    String mapGuid= (String) map.get("guid");
                    if (mapGuid != null && mapGuid.equals(proguid)) {
                        adjustMap.put("revisionnum", adjustnum + 1);
                        break;
                    }
                }
                adjustMap.put("proguid", map.get("guid"));
                adjustMap.put("guid", guid);
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", SecureUtil.getUserSelectYear());
                adjustMap.put("agencyguid", agencyguid);
                adjustMap.put("finintorgguid", map.get("mof_dep_code"));
                adjustMap.put("islast", 1);
                adjustMap.put("revisionstatus", "2");
                adjustMap.put("modtype", modtype);
                adjustList.add(adjustMap);
            }
            this.workflow("create", workflow, "", tablecode, adjustList);
        }
        return backMap;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getProgramDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String saveAgency = (String)params.get("saveAgency");
        String querySql = (String)params.get("querySql");
        String tablecode = (String)params.get("tablecode");
        String prolev = (String)params.get("prolev");
        String wheresql = " t.agencyguid = '" + saveAgency + "'";
        if (querySql != null && !querySql.isEmpty()) {
            wheresql += " and " + querySql;
        }
        String protablecode = "v_perf_project_info";
        if (prolev != null && "1".equals(prolev)) {
            protablecode = "perf_t_flprogram";
        } else if (prolev != null && "2".equals(prolev)) {
            protablecode = "perf_t_slprogram";
        }
        List<Map<String, Object>>  data = proModRpDAO.getProgramDatas(wheresql, protablecode, tablecode);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
    }

    /**
     * 获取项目数据.
     * @return
     */
    public List<Map<String, Object>> getPorData(List<Map<String, Object>> proguidList) throws AppException {
        proModRpDAO.saveAll(proguidList, proModRpDAO.PMKPI_TABLE_TMP_GUIDS);
        String wheresql = " exists(select * from "+ PmkpiDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.guid=a.guid)";
        return proModRpDAO.getDatas("v_perf_project_info", wheresql, null);
    }
}
