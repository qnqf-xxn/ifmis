package gov.mof.fasp2.pmkpi.common;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.exception.CauseAppException;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ClassUtil;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.busfw.ui.datatable.AbstractDatatableQueryData;
import gov.mof.fasp2.busfw.ui.datatable.IDatatableQueryData;
import gov.mof.fasp2.busfw.ui.datatable.IDatatableUIconfig;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.busfw.ui.dto.EditFormDTO;
import gov.mof.fasp2.busfw.ui.dto.TabpageDTO;
import gov.mof.fasp2.busfw.ui.dto.UIconfigDTO;
import gov.mof.fasp2.busfw.ui.editform.UIEditformCacheInit;
import gov.mof.fasp2.busfw.ui.queryform.IQueryformUIconfig;
import gov.mof.fasp2.busfw.ui.queryform.UIQueryformCacheInit;
import gov.mof.fasp2.busfw.ui.tabpage.UITabpageCacheInit;
import gov.mof.fasp2.busfw.ui.toolbutton.UIFunctionCacheInit;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditDAO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.perfcommon.auditdefine.AuditDefineService;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfset.datarule.IPmkpiRightService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class PmkpiBO extends AbstractDatatableQueryData implements
		IDatatableQueryData {
	/**
	 * 日志.
	 */
	protected Logger logger = LogFactory.getLog(this.getClass());

	private PmkpiDAO pmkpiDAO;

	private PmkpiDAO getPmkpiDAO() {
		if (pmkpiDAO == null) {
			pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
		}
		return pmkpiDAO;
	}

	/**
	 * 工作流
	 */
	private IWorkflowService workflowService;

	private IWorkflowService getIWorkflowService() {
		if (workflowService == null) {
			workflowService = PerfServiceFactory.getIWorkflowService();
		}
		return workflowService;
	}

	@Override
	public String getVodSql(Map sqlmap) throws AppException {
		String menusql = (String) sqlmap.get("querySql");//菜单个性业务拼接条件
		String wheresql = (String) sqlmap.get("querySql");//查询区封装的参数
		String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
		String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
		String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql");//表格配置的sql
        String workflow = (String) sqlmap.get("workflow");//工作流
        String tabcode = (String) sqlmap.get("tabcode");//页签
		String leftmenuid = (String) sqlmap.get("leftmenuid");
		StringBuffer sql = new StringBuffer("select count(1) from ");
		if (PerfUtil.getIsHbei()) {
			tablecode += "_HB";
		}
		sql.append(tablecode).append(" t where ");
		String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
		sql.append(datarule);
		if (menusql != null && !menusql.isEmpty()) {
			sql.append(" and (").append(menusql).append(")");
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
		String wfsql = this.getWfSql(tabcode, workflow);
		if (wfsql != null && !wfsql.isEmpty()) {
			sql.append(" and ( ").append(wfsql);
			if (tabcode != null && !tabcode.isEmpty() && "waitaudit".equals(tabcode)) {
				sql.append(" or wfstatus is null ");
			}
			sql.append(" )");
		}
		String columncode = "agencyguid";
		sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, "PMKPI_FASP_T_PUBAGENCY"));
		return sql.toString();
	}

	/**
	 * 获取页面数据权限.
	 * @param menuguid -- 菜单.
	 * @param tablealias -- 别名,t.;a.
	 * @param wheresql -- 要关联的sql.
	 * @return wheresql.
	 * @throws AppException -- 自定义异常.
	 */
	public String getDataRuleByMenuguid(String menuguid, String tablealias, String wheresql) throws AppException {
		IPmkpiRightService pmkpiRightService = PerfServiceFactory.getPmkpiRightService();
		String datasql = pmkpiRightService.getPageDataRights(menuguid, tablealias);
		if ("1=1".equals(datasql)) {
			datasql = " ";
			datasql += tablealias + ".agencyguid = '";
			datasql += CommonUtil.getCurrentUser().getAgency();
			datasql += "'";
		}
		if (wheresql == null || wheresql.isEmpty()) {
			wheresql = " and " + datasql;
		} else {
			if ("1=1".equals(wheresql)){ //1=1去掉
				wheresql = datasql;
			} else {
				wheresql += " and " + datasql;
			}

		}
		return wheresql;
	}

	/**
	 * <p>获取页面数据权限，没有权限则返回空权限条件</p >
	 *
	 * @param menuguid -- 菜单.
	 * @param tablealias -- 别名,t.;a.
	 * @param wheresql -- 要关联的sql.
	 * @return wheresql.
	 * @throws AppException -- 自定义异常.
	 * @author hw
	 * @date 2021/8/23 9:01
	 * @param
	 */
	public String getDataRuleByMenuguidNull(String menuguid, String tablealias, String wheresql) throws AppException {
		IPmkpiRightService pmkpiRightService = PerfServiceFactory.getPmkpiRightService();
		String datasql = pmkpiRightService.getPageDataRights(menuguid, tablealias);
		String sql = "1=1";
		if (sql.equals(datasql)) {
			datasql = " 1<>1 ";
		}
		if (wheresql == null || wheresql.isEmpty()) {
			wheresql = " and " + datasql;
		} else {
			if (sql.equals(wheresql)){ //1=1去掉
				wheresql = datasql;
			} else {
				wheresql += " and " + datasql;
			}
		}
		return wheresql;
	}

	/**
	 * 获取左侧树显示数据.
	 *
	 * @param menuId
	 *            -- 菜单.
	 * @throws AppException
	 *             -- 自定义异常
	 * @rturn --
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLeftTree(String menuId, String treesource)
			throws AppException {
		// 数据权限
		String sql = this.getDicDSDataListByWheresql("t", menuId, treesource);
		return getPmkpiDAO().getLeftTree(getPmkpiDAO().PMKPI_TABLE_T_AGENCY, sql);
	}

	/**
	 * 获取数据权限sql
	 * @return --
	 */
	public String getDicDSDataListByWheresql(String tableAlias, String menuid,
											 String elementcode) throws AppException {
		IPmkpiRightService iPmkpiRightService = PerfServiceFactory.getPmkpiRightService();
		String sql = iPmkpiRightService.getPageDataRights(menuid, tableAlias);
		sql = sql.replace(tableAlias + ".agencyguid","t.guid");
		UserDTO user = SecureUtil.getCurrentUser();
		if (sql == null || sql.isEmpty()|| "1=1".equals(sql)) {
			if("PMKPIAGENCYALLPAY".equals(elementcode)){
				sql = " t.guid='" + user.getAgency() + "'";
			}else if ("PMKPIDEPT".equals(elementcode)){
				sql = " t.guid='" + user.getUpagencyid() + "'";
			}
		}
		return sql;
	}

	/**
	 * 获取工作流查询sql
	 *
	 * @param wftype
	 *            --工作流类型-待审/已审/经办
	 * @param workflow
	 *            --工作流guid
	 * @return
	 */
	public String getWfSql(String wftype, String workflow) throws AppException {
		String wfsql = "";
		List<String> wfids = new ArrayList<String>();
		if(workflow!=null) {
			wfids.add(workflow);
		}
		if ("waitaudit".equals(wftype)) { // 待送审/审核
			//待办页签过滤掉退回的数据优化sql 不直接调用接口结果
			wfsql = getIWorkflowService().getWFSqlByWfIds(wfids);
			if (!StringUtil.isEmpty(wfsql)) {
				wfsql = " ("+wfsql+") and not exists (select 1 from p#busfw_t_dcworkflowlogs logs where " +
						" logs.billid = t.guid and logs.createtime = t.lastupdatetime and logs.type in ('2', '3', '8') " + PerfUtil.yearProvinceSql("logs") + ") ";
			}
		} else if ("alreadyaudit".equals(wftype)) { // 已送审/审核
			wfsql = getIWorkflowService().getDoneExceptBackWFSqlByWfIds(wfids,null);
		} else if ("alldeals".equals(wftype)) { // 曾经办
			wfsql = getIWorkflowService().getToDoneWFSqlByWfIds(wfids);
		} else if ("back".equals(wftype)) {
			wfsql = getIWorkflowService().getBackWFSqlByWfIds(wfids);
			if (!StringUtil.isEmpty(wfsql)) {
				wfsql = " ("+wfsql+") and exists (select 1 from p#busfw_t_dcworkflowlogs logs where " +
						" logs.billid = t.guid and logs.createtime = t.lastupdatetime and logs.type in ('2', '3', '8') " + PerfUtil.yearProvinceSql("logs") + ") ";
			}
		}
		return StringUtil.isNullOrEmpty(wfsql) ? null : "(" + wfsql + ")";
	}

	/**
	 * 获取工作流查询sql
	 *
	 * @param wftype 工作流类型-待审/已审/经办
	 * @param workflow 工作流guid
	 * @param alias 别名
	 * @return
	 */
	public String getWfSql(String wftype, String workflow, String alias) throws AppException {
		String wfsql = "";
		String aliasstr = "";
		if(alias!=null){
			aliasstr = alias+".";
		}
		List<String> wfids = new ArrayList<String>();
		wfids.add(workflow);
		if ("waitaudit".equals(wftype)) { // 待送审/审核
			wfsql = getIWorkflowService().getWFSqlByWfIds(wfids, alias);
			if (!StringUtil.isEmpty(wfsql)) {
				wfsql = " ("+wfsql+") and not exists (select 1 from p#busfw_t_dcworkflowlogs logs where " +
						" logs.billid = " + aliasstr + "guid and logs.createtime = " + aliasstr + "lastupdatetime and logs.type in ('2', '3', '8') " + PerfUtil.yearProvinceSql("logs") + ") ";
			}
		} else if ("alreadyaudit".equals(wftype)) { // 已送审/审核
			wfsql = getIWorkflowService().getDoneExceptBackWFSqlByWfIds(wfids, alias);
		} else if ("alldeals".equals(wftype)) { // 曾经办
			wfsql = getIWorkflowService().getToDoneWFSqlByWfIds(wfids, alias);
		} else if ("back".equals(wftype)) {
			wfsql = getIWorkflowService().getBackWFSqlByWfIds(wfids, alias);
			if (!StringUtil.isEmpty(wfsql)) {
				wfsql = " ("+wfsql+") and exists (select 1 from p#busfw_t_dcworkflowlogs logs where " +
						" logs.billid = " + aliasstr + "guid and logs.createtime = " + aliasstr + "lastupdatetime and logs.type in ('2', '3', '8') " + PerfUtil.yearProvinceSql("logs") + ") ";
			}
		}
		return StringUtil.isNullOrEmpty(wfsql) ? null : "(" + wfsql + ")";
	}

	/**
	 * @Description:编辑区附件管理获取guidfang
	 * @return -返回同步数据
	 * @throws AppException
	 *             -异常
	 * @throws
	 */
	public String getCreateguid() {
		return StringUtil.createUUID(); // 获取guid信息;
	}

	/**
	 * 缓存获取uitabpage数据
	 *
	 * @return --
	 */
	public List<UIconfigDTO> getUiTabpageCache(String uikey) throws AppException {
		UITabpageCacheInit uiTabpageCacheInit = PerfServiceFactory.getUITabpageCacheInit();
		return uiTabpageCacheInit.get(uikey);
	}

	/**
	 * 缓存获取editform数据
	 *
	 * @return --
	 */
	public List<UIconfigDTO> getUiEditformCache(String uikey) throws AppException {
		UIEditformCacheInit uiEditformCacheInit = PerfServiceFactory.getUIEditformCacheInit();
		return uiEditformCacheInit.get(uikey);
	}

	/**
	 * 缓存获取queryform数据
	 *
	 * @return --
	 */
	public List<UIconfigDTO> getUIQueryformCache(String uikey) throws AppException {
		UIQueryformCacheInit uiQueryformCacheInit = PerfServiceFactory.getUIQueryformCacheInit();
		return uiQueryformCacheInit.get(uikey);
	}

	/**
	 * 缓存获取queryform数据
	 *
	 * @return --
	 */
	public List<UIconfigDTO> getUIFunctionCache(String uikey) throws AppException {
		UIFunctionCacheInit uiFunctionCacheInit = PerfServiceFactory.getUIFunctionCacheInit();
		return uiFunctionCacheInit.get(uikey);
	}

	/**
	 * 获取uieditform数据
	 * @param uikey
	 * @return
	 * @throws AppException
	 */
	public List<UIconfigDTO> getEditformData(String uikey) throws AppException {
		List<UIconfigDTO> editfromlist = this.getUiEditformCache(uikey);
		if (editfromlist == null || editfromlist.isEmpty()) {
			String sql = "select t.* from busfw_t_uieditform t where t.key = '"+ uikey +"'";
			editfromlist = getPmkpiDAO().query(sql, new RowMapper() {
				public Object mapRow(ResultSet rs, int index) throws SQLException {
					EditFormDTO m = new EditFormDTO();
					m.setGuid(rs.getString("guid"));
					m.setType(rs.getString("type"));
					m.setName(rs.getString("name"));
					m.setColcode(rs.getString("columncode"));
					m.setIsvisiable(rs.getInt("isvisiable"));
					m.setDefaultvalue(rs.getString("defaultvalue")==null?null:rs.getString("defaultvalue").replaceAll("\"", "\'"));
					String config =rs.getString("config");
					if(config!=null) {
						config = config.replaceAll("\"", "\'");
						config = config.replaceAll("@@", "\'");
					}
					m.setConfig(config);
					m.setRequirement(rs.getInt("requirement"));
					m.setOrdernum(rs.getInt("ordernum"));
					m.setTablecode(rs.getString("tablecode"));
					m.setColspannum(rs.getInt("colspannum"));
					m.setShowlevel(rs.getString("showlevel"));
					String textarearows = rs.getString("textarearows");
					if(StringUtils.isEmpty(textarearows)) {
						m.setTextarearows(0);
					}else {
						m.setTextarearows(rs.getInt("textarearows"));
					}
					m.setKey(rs.getString("key"));
					m.setIsedit(rs.getInt("isedit"));
					m.setFromsource(rs.getInt("fromsource"));
					m.setBottomcontrl(rs.getInt("bottomcontrl"));
					m.setSetvalue(rs.getInt("setvalue"));
					m.setHead(rs.getString("head"));
					return m;
				}
			});
		}
		return editfromlist;
	}

	/**
	 * 获取uitabpage数据
	 * @param uikey
	 * @return
	 * @throws AppException
	 */
	public List<Map<String, Object>> getTabData(String uikey) throws AppException {
		List<UIconfigDTO> uiTabList = this.getUiTabpageCache(uikey);
		if (uiTabList == null || uiTabList.size() == 0) {
			String getCheckTabSql = "select t.* from busfw_t_uitabpage t where t.key = '"+ uikey +"'";
			uiTabList = getPmkpiDAO().query(getCheckTabSql, new RowMapper() {
				public Object mapRow(ResultSet rs, int index) throws SQLException {
					TabpageDTO map = new TabpageDTO();
					map.setGuid(rs.getString("GUID"));
					map.setCode(rs.getString("CODE"));
					map.setAppid(rs.getString("APPID"));
					map.setKey(rs.getString("KEY"));
					map.setName(rs.getString("NAME"));
					map.setIsvisiable(rs.getInt("ISVISIABLE"));
					map.setOrdernum(rs.getInt("ORDERNUM"));
					map.setClassname(rs.getString("CLASSNAME"));
					map.setClick(rs.getString("CLICK"));
					map.setDisabled(rs.getInt("DISABLED"));
					map.setTitle(rs.getString("TITLE"));
					map.setFilter(rs.getString("FILTER"));
					map.setHidebtns(rs.getString("HIDEBTNS"));
					map.setConfig(rs.getString("CONFIG"));
					map.setWfstatus(rs.getString("WFSTATUS"));
					map.setWaitflag(rs.getString("WAITFLAG"));
					map.setComponentId(rs.getString("COMPONENTID"));
					map.setComponentKey(rs.getString("COMPONENTKEY"));
					map.setComponentConfig(rs.getString("COMPONENTCONFIG"));
					map.setComponentDraw(rs.getString("COMPONENTDRAW"));
					map.setComponentServiceid(rs.getString("COMPONENTSERVICEID"));
					map.setComponentCallbackfn(rs.getString("COMPONENTCALLBACKFN"));
					map.setDefaultfilter(rs.getString("DEFAULTFILTER"));
					return map;
				}
			});
		}
		List tabList = new ArrayList();
		if (uiTabList != null && uiTabList.size() > 0) {
			int i = 1;
			for (UIconfigDTO tabpage: uiTabList) {
				int isvisiable = (int) tabpage.get("isvisiable");
				if (isvisiable == 1) {
					tabpage.put("ordernum", i);
					tabList.add(tabpage);
					i++;
				}
			}
		}
		return tabList;
	}

	/**
	 * 获取agency数据
	 * @return
	 * @throws AppException
	 */
	public List<Map<String, Object>> getAgencyData(String agency) throws AppException {
		return getPmkpiDAO().getAgencyData(agency);
	}

	/**
	 * 调用工作流公用方法（具体动作配置为参数）
	 * @param actioncode --工作流动作
	 * @param flowid --工作流id
	 * @param remark --审核退回意见
	 * @param tablecode --调用工作流后根据id修改那个表的数据
	 * @param datalist --数据list
	 * @return --操作结果
	 * @throws AppException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, Object> workflow(String actioncode, String flowid, String remark, String tablecode, List<Map<String, Object>> datalist) throws AppException {
		Map map = new HashMap();
		List wflist = new ArrayList();
		List<String> guids = new ArrayList<String>();
		for (Map<String, Object> m : datalist){
			String guid = (String) m.get("guid");
			guids.add(guid);
		}
		try {
			if("create".equals(actioncode)) { //新增
				getPmkpiDAO().saveAll(datalist, tablecode);
				wflist = getIWorkflowService().createProcess(flowid, guids, remark);
			} else if ("sendaudit".equals(actioncode) || "audit".equals(actioncode) || "auditbatch".equals(actioncode)) { //送审、审核
				if (getIWorkflowService().hasDatarightProcess(flowid, guids)){
					wflist = getIWorkflowService().doProcess(flowid, guids, remark);
				} else {
					throw new AppException("用户没有送审/审核操作权限");
				}
			} else if ("cancelsendaudit".equals(actioncode) || "cancelaudit".equals(actioncode)) { //取消送审、取消审核
				wflist = getIWorkflowService().cancelProcess(flowid, guids, remark);
			} else if ("back".equals(actioncode)){//退回
				if (getIWorkflowService().hasDatarightProcessByBack(flowid, guids)) {
					wflist = getIWorkflowService().multiBackProcess(flowid, guids, remark);
//					wflist = getIWorkflowService().backProcess(flowid, guids, remark);
				} else {
					throw new AppException("用户没有退回操作权限");
				}
			} else if ("createnosave".equals(actioncode)) {
				Map tempMap = datalist.get(0);
				List<String> cols = new ArrayList<String>(tempMap.keySet());
				getPmkpiDAO().updateAll(cols, datalist, tablecode);
				wflist = getIWorkflowService().createProcess(flowid, guids);
			}
			HashMap m = null;
			HashMap wfmap = new HashMap(wflist.size() + 100);
			for (int i = 0; i < wflist.size(); i++) {
				m = (HashMap) wflist.get(i);
				wfmap.put(m.get("billid"), m);
			}
			for (Map<String, Object> datamap : datalist) {
				m = (HashMap) wfmap.get(datamap.get("guid"));
				datamap.put("wfstatus", m.get("wfstatus"));
				datamap.put("wfid", m.get("wfid"));
				datamap.put("auditor", m.get("userid"));
				datamap.put("lastupdatetime", m.get("createtime"));
			}
			List columns = new ArrayList();
			columns.add("wfstatus");
			columns.add("wfid");
			columns.add("auditor");
			columns.add("lastupdatetime");
			getPmkpiDAO().updateAllByPK(columns, datalist, "guid", tablecode);
		} catch (AppException e) {
			throw new AppException(e.getCode(), e.getMessage().replace(e.getCode() + "-", ""));
		}
		return map;
	}

	/**
	 * 审核定义.
	 * @param list --
	 * @param busguid -- 业务唯一标识（业务定义/菜单id/或菜单id拼接工作流状态）
	 * @param actioncode --页签编码
	 * @return --审核定义信息
	 * @throws AppException --
	 */
	public Map<String, Object> auditdefine(List<Map<String, Object>> list, String busguid, String actioncode, Map<String, Object> params) throws AppException {
		if (params != null && !params.isEmpty()) {
			String queryYear = (String) params.get("queryYear");
			String queryProvince = (String) params.get("queryProvince");
			if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
				this.setYearAndProvince(queryYear, queryProvince);
			}
		}
		String wheresql = "";
		if("edb".equals(DbTypeUtil.getCurrentDBType())){
			createTmpTable(getPmkpiDAO().PMKPI_TABLE_TMP_GUIDS);
			createTmpTable(getPmkpiDAO().PMKPI_TMP_AUDITDEFINEWHERESQL);
		}
		getPmkpiDAO().saveAll(list, getPmkpiDAO().PMKPI_TABLE_TMP_GUIDS);
		wheresql = " exists (select 1 from "+ getPmkpiDAO().PMKPI_TABLE_TMP_GUIDS +" aguid where aguid.guid = busguid)";
		//存到临时表中 perf_tmp_auditdefinewheresql  物理表：perf_t_auditdefinewheresql
		if (params != null && params.size() > 0) {
			getPmkpiDAO().save(params,"perf_tmp_auditdefinewheresql");
		}
		//退回不走审核定义，直接返回
		if ("back".equals(actioncode)) {
			Map map = new HashMap();
			map.put("success", true);
			return map;
		}
		AuditDefineService auditDefineService = (AuditDefineService) ServiceFactory.getBean("pmkpi.auditdefine.AuditDefineService");
		return auditDefineService.checkAuditDefinenewspec(list, busguid, wheresql, params);
	}


	/**
	 * 查询节点审核类型
	 * @param workflow 工作流
	 * @param prevwfstatus --当前数据状态
	 */
	public List<Map<String, Object>> queryPrevAuditType(String workflow , String prevwfstatus) throws AppException {
		return getPmkpiDAO().queryPrevAuditType(workflow, prevwfstatus);
	}

	/**
	 * 查询当前数据状态的结果状态
	 * @param workflow 工作流
	 */
	public List<Map<String, Object>> queryWfstatusType(String workflow) throws AppException {
		return getPmkpiDAO().queryWfstatusType(workflow);
	}

	/**
	 * @Title: isNumeric
	 * @Description: TODO(判断非数字字符)
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		try {
			new BigDecimal(str).toString();
		} catch (Exception e) {
			return false;// 异常 说明包含非数字。
		}
		return true;
	}

	/**
	 * 创建临时表
	 * @return
	 * @throws AppException
	 */
	public void createTmpTable(String tablecode){
		getPmkpiDAO().createTmpTable(tablecode);
	}

	/**
	 * 根据guid查询数据
	 * @param guid
	 * @return
	 */
	public Map getByGuid(String tablecode, String guid) {
		List list = getPmkpiDAO().getByGuid(tablecode, guid);
		Map map = new HashMap();
		if (list.size() > 0) {
			map = (Map) list.get(0);
		}
		return map;
	}

	/**
	 * 根据guid查询数据
	 * @param guid--
	 * @param  -- 区分编辑哪个是主单信息.
	 * @return
	 */
	public Map getByGuid(String tablecode, String guid, String iswf) {
		List list = getPmkpiDAO().getByGuid(tablecode, guid, iswf);
		Map map = new HashMap();
		if (list.size() > 0) {
			map = (Map) list.get(0);
		}
		return map;
	}

	/**
	 * 查询数据
	 * @param tablecode --表名
	 * @param wheresql --查询条件
	 * @param orderby --拍序
	 * @return
	 */
	public List<Map<String, Object>> getDatas(String tablecode, String wheresql, String orderby) {
		return getPmkpiDAO().getDatas(tablecode, wheresql, orderby);
	}

	/**
	 * 查询数据
	 * @param tablecode --表名
	 * @param wheresql --查询条件
	 * @param orderby --拍序
	 * @return
	 */
	public List<Map<String, Object>> getDatas(String tablecode, String wheresql, String orderby, String[] str) {
		return getPmkpiDAO().getDatas(tablecode, wheresql, orderby, str);
	}

	/**
	 * 基础规范字段赋值
	 * @param map
	 * @return
	 */
	public Map<String, Object> getBasMap(Map<String, Object> map, String type) {
		try {
			return getPmkpiDAO().getBasMap(map, type);
		} catch (AppException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 预警规则.
	 * @param params
	 * @return
	 */
	public String getWarn(HashMap<String, Object> params) {
		String warmtype = (String) params.get("warmtype");//预警类型
		List<Map<String, Object>> warnData;
		//缓存中获取预警sql
		String cacheKey = getPmkpiDAO().PMKPI_CACHE_WARN + warmtype;
		String cacheData = PerfUtil.getCacheData(cacheKey);
		if ("unwarn".equals(cacheData)) {
			return "";
		}
		String warnsql = "";
		if (cacheData != null) {
			warnsql = cacheData;
		} else {
			warnData = getPmkpiDAO().getDatas(getPmkpiDAO().PMKPI_TABLE_T_WARNSET, "type='" + warmtype + "'", null);
			if (warnData.size() > 0) {
				warnsql = (String) warnData.get(0).get("warnsql");
			}
			PerfUtil.reflashCacheData(cacheKey, StringUtil.isEmpty(warnsql) ? "unwarn" : warnsql, false);
		}
		logger.info("预警类型：" + warmtype);
		String taskguid = (String) params.get("taskguid");//任务guid
		String indexval = (String) params.get("indexval");//实际完成值
		String targetvalue = (String) params.get("targetvalue");//年度指标值
		String mainguid = (String) params.get("mainguid");//主单guid
		String proguid = (String) params.get("proguid");//项目guid
		String pro_code = (String) params.get("procode");//项目编码
		String isexpfunc = (String) params.get("iswarnfunc");//是否达到预计支出进度
		String isperfgoal = (String) params.get("isperfgoal");//是否达到预期绩效目标
		String actualvalue = (String) params.get("actualvalue");//绩效自评填报-实际完成值，indexval作为指标值
		String agencyguid = (String) params.get("agencyguid");//单位id
		String findex = (String) params.get("findex");//一级指标 山西按照二级指标区分规则
		String sindex = (String) params.get("sindex");//二级指标
		String weight = params.get("weight") == null || "".equals(params.get("weight")) ? "0" : params.get("weight") + "";//权重
		String month = (String) params.get("taskstage");
		String completeanalysis = (String) params.get("completeanalysis");//全年预计完成情况
		String completepossibility = (String) params.get("completepossibility");
		String depttask = (String) params.get("depttask");
		if ((month == null || month.isEmpty()) && !StringUtil.isEmpty(taskguid)) {
			Map<String, Object> taskMap = getPmkpiDAO().getDataMap(getPmkpiDAO().PMKPI_TABLE_T_TAKSSET, " guid='" + taskguid + "'");
			month = (String) taskMap.get("taskstage");//监控月份
		}
		String score = params.get("score") == null || "".equals(params.get("score")) ? "0" : params.get("score") + "";//得分
		if (!StringUtil.isEmpty(warnsql)) {
			if (!StringUtil.isEmpty(indexval)) {
				warnsql = warnsql.replace("#indexval#", indexval);
			}
			if (!StringUtil.isEmpty(targetvalue)) {
				warnsql = warnsql.replace("#targetvalue#", targetvalue);
			}
			if (!StringUtil.isEmpty(month)) {
				warnsql = warnsql.replace("#month#", month);
			}
			if (!StringUtil.isEmpty(mainguid)) {
				warnsql = warnsql.replace("#mainguid#", mainguid);
			}
			if (!StringUtil.isEmpty(proguid)) {
				warnsql = warnsql.replace("#proguid#", proguid);
			}
			if (!StringUtil.isEmpty(pro_code)) {
				warnsql = warnsql.replace("#pro_code#", pro_code);
			}
			if (!StringUtil.isEmpty(isexpfunc)) {
				warnsql = warnsql.replace("#isexpfunc#", isexpfunc);
			}
			if (!StringUtil.isEmpty(isperfgoal)) {
				warnsql = warnsql.replace("#isperfgoal#", isperfgoal);
			}
			if (!StringUtil.isEmpty(actualvalue)) {
				warnsql = warnsql.replace("#actualvalue#", actualvalue);
			}
			if (!StringUtil.isEmpty(agencyguid)) {
				warnsql = warnsql.replace("#agencyguid#", agencyguid);
			}
			if (!StringUtil.isEmpty(weight) && !"null".equals(weight)) {
				warnsql = warnsql.replace("#weight#", weight);
			}
			if (!StringUtil.isEmpty(taskguid) && !"null".equals(taskguid)) {
				warnsql = warnsql.replace("#taskguid#", taskguid);
			}
			if (!StringUtil.isEmpty(score)) {
				warnsql = warnsql.replace("#score#", score);
			}
			if (!StringUtil.isEmpty(findex)) {
				warnsql = warnsql.replace("#findex#", findex);
			}
			if (!StringUtil.isEmpty(sindex)) {
				warnsql = warnsql.replace("#sindex#", sindex);
			}
			if (!StringUtil.isEmpty(completeanalysis)) {
				warnsql = warnsql.replace("#completeanalysis#", completeanalysis);
			}
			if (!StringUtil.isEmpty(completepossibility)) {
				warnsql = warnsql.replace("#completepossibility#", completepossibility);
			}
			if (!StringUtil.isEmpty(depttask)) {
				warnsql = warnsql.replace("#depttask#", depttask);
			}
			logger.info("预警类型：" + warmtype + "---warnsql---:" + warnsql);
			warnData = getPmkpiDAO().queryForList(warnsql);
			if (warnData != null && warnData.size()>0){
				if(!"null".equals(warnData.get(0).get("value") + "")) {
					return warnData.get(0).get("value") + "";
				}
			}
		}
		return "";
	}

	/**
	 * 查询表格列配置.
	 * @param key
	 * @return
	 */
	public List<Map<String, Object>> getCols(String key) throws AppException {
		IDatatableUIconfig datatableUIconfig = PerfServiceFactory.getIDatatableUIconfig();
		List list = datatableUIconfig.query(key);
		List colList = new ArrayList();
		if (list != null && list.size() > 0) {
			DatatableDTO datatableDTO = (DatatableDTO) list.get(0);
			colList = datatableDTO.getCols();
		}
		return colList;
	}

	/**
	 * 查询表格配置.
	 * @param key
	 * @return
	 */
	public Map<String, Object> getTable(String key) throws AppException {
		IDatatableUIconfig datatableUIconfig = PerfServiceFactory.getIDatatableUIconfig();
		List list = datatableUIconfig.query(key);
		Map<String, Object> tableMap = new HashMap<>();
		if (list != null && list.size() > 0) {
			tableMap = (DatatableDTO) list.get(0);
		}
		return tableMap;
	}

	/**
	 * 查询查询区配置.
	 * @param key
	 * @return
	 */
	public List<Map<String, Object>> getQueryFrom(String key) {
		IQueryformUIconfig queryuifrom = PerfServiceFactory.getIQueryformUIconfig();
		List<UIconfigDTO> queryforms = null;
		List list = new ArrayList<>();
		try {
			queryforms = queryuifrom.get(key);
			if (queryforms != null) {
				queryforms.forEach(data -> {
					data.put("year",CommonUtil.getYear());
					data.put("province", CommonUtil.getProvince());
				});
				list = queryforms;
			}
		} catch (AppException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 查询数据.
	 * @param tablecode --表名
	 * @param wheresql  --查询条件
	 * @return --
	 */
	public Map<String, Object> getDataMap(String tablecode, String wheresql) {
		return getPmkpiDAO().getDataMap(tablecode, wheresql);
	}

	/**
	 * 查询数据.
	 * @param tablecode --表名
	 * @param wheresql  --查询条件
	 * @return --
	 */
	public Map<String, Object> getDataMap(String tablecode, String wheresql, String[] strs) {
		return getPmkpiDAO().getDataMap(tablecode, wheresql, strs);
	}

	/**
	 * 校验字段是否可为空
	 * @param datas
	 * @return
	 */
	public List<Map<String, Object>> checkImpColNullable(List<Map<String, Object>> datas,List<Map<String, Object>> cols) throws AppException {
		List<Map<String, Object>> errorlist = new ArrayList<>();
		FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
		ImportErrorDTO dto = null;
		String fileguid = "";
		if (FileUploadService.fileguids.get() != null) {//框架导入功能
			fileguid = FileUploadService.fileguids.get();
		} else {//绩效导入功能
			fileguid = ImpExpAComponet.FILE_GUIDS.get();
		}
		for (Map colsmap : cols) {
			String nullable = colsmap.get("nullable") + "";
			if (!"1".equals(nullable)) {
				String colname = (String) colsmap.get("columncode");
				String title = (String) colsmap.get("name");
				colname = colname.toLowerCase();
				int j = 1;
				for (Map map : datas) {
					Integer linenum = (Integer) map.get("linenum");
					j++;
					String context = String.valueOf(map.get(colname)).trim();
					if (StringUtil.isEmpty(context) || "null".equals(context)) {
						dto = new ImportErrorDTO(fileguid, linenum == null ? j : linenum, title + "不能为空，请填写！");
						errordao.saveErrorMsg(dto);
						errorlist.add(dto);
					}
				}
			}
		}
		return errorlist;
	}

	/**
	 * 校验字段长度
	 * @param datas
	 * @return
	 */
	public List<Map<String, Object>> checkImpColLength(List<Map<String, Object>> datas,List<Map<String, Object>> cols) throws AppException {
		List<Map<String, Object>> errorlist = new ArrayList<>();
		FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
		ImportErrorDTO dto = null;
		String fileguid = "";
		if (FileUploadService.fileguids.get() != null) {//框架导入功能
			fileguid = FileUploadService.fileguids.get();
		} else {//绩效导入功能
			fileguid = ImpExpAComponet.FILE_GUIDS.get();
		}
		for (Map colsmap : cols) {
			String collength = (String) colsmap.get("datalength");
			if (collength != null && !collength.isEmpty() && !"0".equals(collength)) {
				int strlength = Integer.parseInt(collength);
				String colname = (String) colsmap.get("columncode");
				String title = (String) colsmap.get("name");
				colname = colname.toLowerCase();
				int j = 1;
				//字符串字节长度
				for (Map map : datas) {
					Integer linenum = (Integer) map.get("linenum");
					j++;
					String context = map.get(colname) + "";
					if (!StringUtil.isEmpty(context) && !"null".equals(context) ) {
						int realLength = 0, len = context.length(), charCode = -1;
						for (int i = 0; i < len; i++) {
							charCode = context.charAt(i);
							if (charCode>=0 && charCode <= 128) {
								realLength += 1;
							} else {
								realLength += 2;
							}
						}
						if (realLength > strlength) {
							dto = new ImportErrorDTO(fileguid, linenum == null ? j : linenum, title + "长度超长，请重新填写！");
							errordao.saveErrorMsg(dto);
							errorlist.add(dto);
						}
					}
				}
			}
		}
		return errorlist;
	}

	/**
	 * 校验导入指标层次分类关系是否正确
	 * @return
	 */
	public List<Map<String, Object>> checkIndexFrame(List<Map<String, Object>> datas) throws AppException {
		List<Map<String, Object>> errorlist = new ArrayList<>();
		StringBuffer error = null;
		FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
		ImportErrorDTO dto = null;
		String fileguid = "";
		if (FileUploadService.fileguids.get() != null) {//框架导入功能
			fileguid = FileUploadService.fileguids.get();
		} else {//绩效导入功能
			fileguid = ImpExpAComponet.FILE_GUIDS.get();
		}
		Pattern valpattern = Pattern.compile("[*_-]");
		if(PerfUtil.get_isCheckSpace()){
			valpattern = Pattern.compile("[ 　*_-]");
		}
		Pattern spacePattern = Pattern.compile("[ 　]"); // 匹配全角/半角空格
		Matcher matcher = null;
		for (Map data : datas) {
			error = new StringBuffer();
			Integer linenum = (Integer) data.get("linenum");
			String findex = (String) data.get("findex");
			String sindex = (String) data.get("sindex");
			String computesign = (String) data.get("computesign");
			String indexval = (String) data.get("indexval");
			String qnindexval = (String) data.get("qnindexval");
			String snindexval = (String) data.get("snindexval");
			String meterunit = (String) data.get("meterunit");
			//指标是否适用，1是，2否，否不校验
			String isapply = StringUtil.isNullOrEmpty((String) data.get("isapply")) ? "1" : (String) data.get("isapply");
			String name = (String) data.get("name");
			if(!"2".equals(isapply)){
				if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign)) {
					if (!StringUtil.isNullOrEmpty(qnindexval) && !PerfUtil.isNumeric(qnindexval)) {
						error.append("定量指标，前年指标值为数字 ");
					}
					if (!StringUtil.isNullOrEmpty(snindexval) && !PerfUtil.isNumeric(snindexval)) {
						error.append("定量指标，上年指标值为数字 ");
					}
					if (!StringUtil.isNullOrEmpty(indexval) && !PerfUtil.isNumeric(indexval)) {
						error.append("定量指标，指标值为数字 ");
					}
					if (StringUtil.isNullOrEmpty(meterunit)) {
						error.append("定量指标，请填写计量单位 ");
					}
				} else {
					if (!StringUtil.isEmpty(indexval)) {
						matcher = valpattern.matcher(indexval);
						if (matcher.find()) {
							String msg = "定性指标值填写不支持特殊字符，请重新填写 ";
							if(PerfUtil.get_isCheckSpace()){
								msg = "定性指标值填写不支持特殊字符和空格，请重新填写 ";
							}
							error.append(msg);
						}
						if (PerfUtil.get_isCheckSpace() && "null".equals(indexval)) {
							error.append("定性指标值填写不能为null，请重新填写 ");
						}
						if (PerfUtil.get_isCheckSpace() && "NULL".equals(indexval)) {
							error.append("定性指标值填写不能为NULL，请重新填写 ");
						}
					}
				}
				if (!StringUtil.isEmpty(name) && PerfUtil.get_isCheckSpace()) {
					matcher = spacePattern.matcher(name);
					if (matcher.find()) {
						error.append("指标名称填写不支持空格，请重新填写 ");
					}
					if ("null".equals(name)) {
						error.append("指标名称填写不能为null，请重新填写 ");
					}
					if ("NULL".equals(name)) {
						error.append("指标名称填写不能为NULL，请重新填写 ");
					}
				}
			}
			if (StringUtil.isEmpty(findex)) {
				error.append("请填写一级指标 ");
			}
			if (StringUtil.isEmpty(sindex)) {
				error.append("请填写二级指标 ");
			}
			if (StringUtil.isEmpty(name)) {
				error.append("请填写三级指标名称 ");
			}
			if (StringUtil.isEmpty(computesign)) {
				error.append("请填写计算符号 ");
			}
			if (!StringUtil.isEmpty(findex) && !StringUtil.isEmpty(sindex)) {
				sindex = sindex.substring(0, 1);
			}
			if (!StringUtil.isEmpty(findex) && !StringUtil.isEmpty(sindex) && !findex.equals(sindex)) {
				error.append("一二级指标对应不上，请查看！");
			}
			if (!StringUtil.isEmpty(error.toString())) {
				error.insert(0,"三级指标：" + name);
				dto = new ImportErrorDTO(fileguid, linenum, error.toString());
				errordao.saveErrorMsg(dto);
				errorlist.add(dto);
			}
		}
		return errorlist;
	}

	public int getDataCount(String tablecode, String wheresql) {
		return getPmkpiDAO().getDataCount(tablecode, wheresql);
	}

	/**
	 * 查询左侧树。
	 * @return
	 * @throws AppException
	 * @param config
	 */
	public Map getLeftTabTree(Map config) throws AppException {
		this.getLeftTabDatas(config);
		List<Map<String, Object>> tabList = (List<Map<String, Object>>) config.get("leftTabDatas");
		Object[] tabs = new Object[tabList.size()];
		if (tabList != null && tabList.size() > 0) {
			Map leftconfig = null;
			config.put("lefttab", tabList.get(0));
			for (int i=0; i < tabList.size(); i++) {
				Map<String, Object> tabMap = tabList.get(i);
				String type = (String) tabMap.get("code");
				leftconfig = new HashMap();
				List<Map<String, Object>> list = new ArrayList<>();
				Map<String, Object> map = new HashMap<>();
				map.put("guid","treeroot");
				map.put("superid","0");
				map.put("levelno","1");
				map.put("isleaf","0");
				list.add(map);

				leftconfig.put("datas", list);
				leftconfig.put("showRootNode", Boolean.TRUE);
				leftconfig.put("dosearch", Boolean.FALSE);
				leftconfig.put("outformart", "#code-#name");
				leftconfig.put("expandlevel", 3);
				leftconfig.put("name", tabMap.get("name"));

				Map f1 = new HashMap();
				f1.put("name", tabMap.get("name"));
				f1.put("hidebtns", tabMap.get("hidebtns"));
				f1.put("leftwfid", tabMap.get("leftwfid"));
				f1.put("leftmenuid", tabMap.get("leftmenuid"));
				f1.put("ordernum", tabMap.get("ordernum"));
				f1.put("config", tabMap.get("config"));
				f1.put("code", type);
				f1.put("click", "tabChange");
				f1.put("treeinfo", leftconfig);
				tabs[i] = f1;
			}
		}
		Map m = new HashMap();
		m.put("onlydata", Boolean.TRUE);
		String lefttabnum = (String) config.get("lefttabnum");//代办左侧树页签在第几位，部门整体与项目
		if (!StringUtil.isEmpty(lefttabnum)){
			m.put("activeTab", Integer.parseInt(lefttabnum) - 1);
		} else {
			m.put("activeTab", 0);
		}
		m.put("dosearch", Boolean.TRUE);
		m.put("tabs", tabs);
		return m;
	}

	/**
	 * 查询左侧树页签数据
	 * @param config
	 * @return
	 */
	public void getLeftTabDatas(Map config) throws AppException {
		String tabkey = (String) config.get("tabkey");
		if (StringUtil.isEmpty(tabkey)) {
			tabkey = (String) config.get("pageurl");//获取页面key
		}
		String cacheKey = getPmkpiDAO().PMKPI_CACHE_LEFTTAB + tabkey;
		String cacheData = PerfUtil.getCacheJSONData(cacheKey);
		if (!StringUtil.isEmpty(cacheData)) {
			config.put("leftTabDatas", PerfUtil.parseString2List(cacheData));
		} else {
			String wheresql = " key = '" + tabkey + "' and isvisiable=1";
			List tabList = getPmkpiDAO().getDatas("v_perf_t_treetab", wheresql, " order by ordernum");
			config.put("leftTabDatas", tabList);
			String data = PerfUtil.parse2Json(tabList);
			PerfUtil.reflashCacheJSONData(cacheKey, data, false);
		}
	}

	/**
	 * 修改时过滤年度，区划字段
	 * @param tablecode
	 * @return
	 * @throws AppException
	 */
	public List getTablecol(String tablecode) throws AppException {
		List<String> cols = new ArrayList<String>();
		IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
		List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
		for (DicColumnDTO dicDto : dicColumnDTOs) {
			String col = dicDto.getDbcolumncode();
			if (!"YEAR".equals(col) && !"PROVINCE".equals(col)) {
				cols.add(dicDto.getDbcolumncode());
			}
		}
		return cols;
	}

	/**
	 * 工作流双流程
	 * @param params
	 * @throws AppException
	 */
	public void wfParallel(HashMap<String, Object> params) throws AppException {
		String modeltype = (String) params.get("modeltype");
		String bustype = (String) params.get("bustype");
		String mainworkflow = (String) params.get("mainworkflow");
		String subworkflow = (String) params.get("subworkflow");
		String actioncode = (String) params.get("actioncode");
		String tablecode = "V_PERF_T_BUSWFPARALLEL";
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		List<Map<String, Object>> saveList = new ArrayList<>();
		List<Map<String, Object>> delList = new ArrayList<>();
		for (Map<String, Object> map : datas){
			String guid = (String) map.get("guid");
			String wfstatus = (String) map.get("wfstatus");
			List<Map<String, Object>> wfbranchList = getPmkpiDAO().getWfBranchConfig(mainworkflow, wfstatus, actioncode);
			if(wfbranchList.size()>0){
				Map<String, Object> configMap = JSON.parseObject(wfbranchList.get(0).get("config").toString());
				Boolean iswfparallel = (Boolean) configMap.get("iswfparallel");
				if(iswfparallel != null && iswfparallel) {
					if ("cancelsendaudit".equals(actioncode) || "cancelaudit".equals(actioncode)) {
						String sql = "select * from V_PERF_T_BUSWFPARALLEL t where t.mainguid = '" + guid + "'";
						saveList = getPmkpiDAO().queryForList(sql);
						for (Map umap : saveList) {
							umap.put("updatetime", PerfUtil.getServerTimeStamp());
							umap.put("lastupdatetime", PerfUtil.getServerTimeStamp());
							umap.put("is_deleted", 1);
						}
						List columns = new ArrayList();
						columns.add("updatetime");
						columns.add("lastupdatetime");
						columns.add("is_deleted");
						getPmkpiDAO().updateAllByPK(columns, saveList, "guid", tablecode);
					}else {
						if ("create".equals(actioncode) || "sendaudit".equals(actioncode) || "audit".equals(actioncode)) {
							Map<String, Object> saveMap = new HashMap<>();
							saveMap.put("guid", CommonUtil.createGUID());
							saveMap.put("mainguid", map.get("guid"));
							saveMap.put("modeltype", modeltype);
							saveMap.put("bustype", bustype);
							saveMap.put("agencyguid", map.get("agencyguid"));
							saveMap.put("creater", map.get("creater"));
							saveMap.put("createtime", PerfUtil.getServerTimeStamp());
							saveMap.put("updatetime", PerfUtil.getServerTimeStamp());
							saveMap.put("status", 1);
							saveMap.put("is_deleted", 2);
							saveMap.put("province", CommonUtil.getProvince());
							saveMap.put("year", CommonUtil.getYear());
							saveMap.put("finintorgguid", map.get("finintorgguid"));
							saveMap.put("manage_dept_code", map.get("manage_dept_code"));
							saveMap.put("manage_mof_dep_code", map.get("manage_mof_dep_code"));
							saveMap.put("mof_dep_code", map.get("mof_dep_code"));
							saveMap.put("dept_code", map.get("dept_code"));
							saveMap.put("agency_code", map.get("agency_code"));
							String proguid = (String) map.get("proguid");
							if (proguid == null || proguid.isEmpty()) {
								saveMap.put("proguid", map.get("guid"));
							} else {
								saveMap.put("proguid", proguid);
							}
							saveList.add(saveMap);
							delList.add(map);
						}
						getPmkpiDAO().saveAll(delList, getPmkpiDAO().PMKPI_TABLE_TMP_GUIDS);
						String sql = "update V_PERF_T_BUSWFPARALLEL t set t.is_deleted = 1 where exists (select * from " + getPmkpiDAO().PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.mainguid)";
						getPmkpiDAO().execute(sql);
						this.workflow("create", subworkflow, "", tablecode, saveList);
					}
				}
			}
		}
	}

	/**
	 * 工作流双流程
	 * @param params
	 * @throws AppException
	 */
	public void wfParallelAudit(HashMap<String, Object> params) throws AppException {
		String modeltype = (String) params.get("modeltype");
		String bustype = (String) params.get("bustype");
		String mainworkflow = (String) params.get("mainworkflow");
		String subworkflow = (String) params.get("subworkflow");
		String actioncode = (String) params.get("actioncode");
		String tablecode = "V_PERF_T_BUSWFPARALLEL";
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		List<Map<String, Object>> saveList = new ArrayList<>();
		for (Map<String, Object> map : datas){
			String guid = (String) map.get("guid");
			String wfstatus = (String) map.get("wfstatus");
			if ("create".equals(actioncode) || "sendaudit".equals(actioncode) || "audit".equals(actioncode)) {
				List<Map<String, Object>> wfbranchList = getPmkpiDAO().getWfBranchConfig(mainworkflow, wfstatus, "audit");
				if(wfbranchList.size()>0){
					Map<String, Object> configMap = JSON.parseObject(wfbranchList.get(0).get("config").toString());
					Boolean wfparallel = (Boolean) configMap.get("wfparallel");
					if(wfparallel != null && wfparallel){
						String sql = "select * from V_PERF_T_BUSWFPARALLEL t where t.mainguid = '" + guid + "' and t.wfstatus <> '011'";
						saveList = getPmkpiDAO().queryForList(sql);
						try{
							if(saveList.size()>0){
								throw new AppException("提示", "请绩效处完成审核后继续操作!");
							}
						}catch (AppException e) {
							throw new AppException(e.getMessage());
						}
					}
				}
			}
		}
	}

	/**
	 * 左侧树点击节点进行sql过滤
	 * @param isleaf
	 * @param columncode
	 * @param value
	 * @return
	 */
	public String getLeftTreeWheresql(String isleaf, String columncode, String value, String tablecode){
		String wheresql = "";
		String number = "1";
		if(number.equals(isleaf)) {
			wheresql = " and t." + columncode + " ='" + value + "' ";
		} else if (!number.equals(isleaf) && !"treeroot".equals(value)){
			wheresql = " and t." + columncode + " like '" + value + "%'";
		}
		return wheresql;
	}

	/**
	 * 三级指标编码赋值
	 * @return
	 */
	public List<Map<String, Object>> setIndexCode(List<Map<String, Object>> indexdata) throws AppException {
		return getPmkpiDAO().setIndexCode(indexdata);
	}
	/**
	 * <p>页签数据必填校验</p >
	 * @author hw
	 * @date 2022/6/24 11:18
	 */
    public Map<String, Object> checkTabPageData(HashMap<String, Object> params) throws AppException {
        logger.info("---页签数据必填校验---start---");
        Map<String, Object> returnMap = new HashMap<>();
        String checkkey = (String) params.get("checkkey"); // 填报key
        String mainTable = (String) params.get("checktable"); // 主表-不可为空
        List<Map<String, Object>> datas = (List) params.get("datas"); //送审数据
		List<String> warnList = new ArrayList<>();
		//获取全部显示页签校验做校验
		List<UIconfigDTO> tablist = this.getUiTabpageCache(checkkey);
		if (tablist == null || tablist.size() == 0) {
			String getCheckTabSql = "select t.* from busfw_t_uitabpage t where t.key = '"+ checkkey +"'";
			tablist = getPmkpiDAO().query(getCheckTabSql, new RowMapper() {
				public Object mapRow(ResultSet rs, int index) throws SQLException {
					TabpageDTO map = new TabpageDTO();
					map.setGuid(rs.getString("GUID"));
					map.setCode(rs.getString("CODE"));
					map.setAppid(rs.getString("APPID"));
					map.setKey(rs.getString("KEY"));
					map.setName(rs.getString("NAME"));
					map.setIsvisiable(rs.getInt("ISVISIABLE"));
					map.setOrdernum(rs.getInt("ORDERNUM"));
					map.setClassname(rs.getString("CLASSNAME"));
					map.setClick(rs.getString("CLICK"));
					map.setDisabled(rs.getInt("DISABLED"));
					map.setTitle(rs.getString("TITLE"));
					map.setFilter(rs.getString("FILTER"));
					map.setHidebtns(rs.getString("HIDEBTNS"));
					map.setConfig(rs.getString("CONFIG"));
					map.setWfstatus(rs.getString("WFSTATUS"));
					map.setWaitflag(rs.getString("WAITFLAG"));
					map.setComponentId(rs.getString("COMPONENTID"));
					map.setComponentKey(rs.getString("COMPONENTKEY"));
					map.setComponentConfig(rs.getString("COMPONENTCONFIG"));
					map.setComponentDraw(rs.getString("COMPONENTDRAW"));
					map.setComponentServiceid(rs.getString("COMPONENTSERVICEID"));
					map.setComponentCallbackfn(rs.getString("COMPONENTCALLBACKFN"));
					map.setDefaultfilter(rs.getString("DEFAULTFILTER"));
					return map;
				}
			});
		}
		List<Map<String, Object>> checktabList = new ArrayList<>();
		//从perf_t_uitabpage_chec取87、2016数据获取tablecode
		List<Map<String, Object>> checList87;
		String cacheKey = getPmkpiDAO().PMKPI_CACHE_UITABPAGEDATA + "87_" + checkkey;
		String cacheData = PerfUtil.getCacheJSONData(cacheKey);
		if (!StringUtil.isEmpty(cacheData)) {
			checList87 = PerfUtil.parseString2List(cacheData);
		} else {
			checList87 = getPmkpiDAO().getDatas("perf_t_uitabpage_chec", "t.key = '" + checkkey + "' and t.province = '87' and t.year ='2016'  ", null);
			PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(checList87), false);
		}
		Map<String,Object> initMap = new HashMap<>();
		checList87.forEach(tempobj -> {
			String tempcode = (String) tempobj.get("code");
			initMap.put(tempcode,tempobj);
		});
		//获取页面配置中不校验的页签
		List<Map<String, Object>> checkTabs = getPmkpiDAO().getCheckTabs(checkkey);
		Map<String,Object> curMap = new HashMap<>();
		checkTabs.forEach(tempobj -> {
			String tempcode = (String) tempobj.get("code");
			curMap.put(tempcode,tempobj);
		});
		//校验页签的87 2016的配置校验表提示
		String tabcode = null;
		String tabname = null;
		int isvisiable = 0;
		String checktable = null;
		for(int i=0;i<tablist.size();i++) {
			UIconfigDTO checktabcfg = tablist.get(i);
			tabcode = (String) checktabcfg.get("code");
			tabname = (String) checktabcfg.get("name");
			isvisiable = (int) checktabcfg.get("isvisiable");
			if(isvisiable == 1){
				if (!curMap.containsKey(tabcode) && !initMap.containsKey(tabcode)){ //当前页签在87和当前年度配置都没有
					warnList.add("[" + tabcode + "]-" +tabname + "页签必填信息缺失，请检查配置项！");
				} else if (!curMap.containsKey(tabcode) && initMap.containsKey(tabcode)) { //当前页签在87有在当前年度配置没有
					Map tempintmap = (Map) initMap.get(tabcode);
					String ischecktab = tempintmap.get("ischecktab") + "";
					checktable = (String) tempintmap.get("checktable");
					if ("1".equals(ischecktab) && StringUtil.isEmpty(checktable)) {
						warnList.add("[" + tabcode + "]-" + tabname + "页签必填缺失对应的表配置，请检查配置项！");
					} else if ("1".equals(ischecktab)){
						checktabcfg.put("checktable",checktable);
						checktabList.add(checktabcfg);
					}
				} else if (curMap.containsKey(tabcode) && initMap.containsKey(tabcode)){//当前页签在87和在当前年度配置都有
					Map tempcurmap = (Map) curMap.get(tabcode);
					String ischecktab = tempcurmap.get("ischecktab") + "";
					checktable = (String) tempcurmap.get("checktable");
					if("1".equals(ischecktab) && "v_perf_file".equals(checktable)){//附件是1的也要校验
						checktabcfg.put("checktable",checktable);
						checktabList.add(checktabcfg);
					}
				}
			}
		}
		//必填校验配置缺失直接返回
		if(warnList.size() > 0){
			returnMap.put("esg", warnList);
			return returnMap;
		}
		List<Map<String, Object>> checkmsgList = new ArrayList<>();//提示信息集合
		for (Map<String, Object> checkTab : checktabList) {
			tabcode = (String) checkTab.get("code");//配置的校验页签code
			tabname = (String) checkTab.get("name");//配置的校验页签名
			String checkTable = (String) checkTab.get("checktable");//配置的校验表名
			String tabConfig = (String) checkTab.get("config");
			Map<String,Object> resullt = this.getCheckWheresql(checkTable,datas,mainTable,tabConfig);
			List<String> sqlList = (List<String>) resullt.get("sqlList");//对应页签得校验sql（CHECKTABLE支持配置多个为多个sql，一般为1个）
			Map<String, Object> reMap = (Map<String, Object>)resullt.get("reMap");//数据对应关系
			for (String sql : sqlList) {
				List<Map<String, Object>> checkdatas = getPmkpiDAO().queryForList(sql);
				if (checkdatas == null || checkdatas.isEmpty()) {//全部都查询不到数据说明全部不通过，返回提示
					String finalTabcode = tabcode;
					String finalTabname = tabname;
					reMap.forEach((key, val) ->{
						Map<String, Object> checkmsg = new HashMap<>();
						checkmsg.put("proname",val);
						checkmsg.put("tabcode", finalTabcode);
						checkmsg.put("tabname", finalTabname);
						checkmsgList.add(checkmsg);
					});
					break;
				}
				Map queryMap = new HashMap();//校验通过的数据
				for (Map<String, Object> checkdata : checkdatas) {
					String keyguid = (String) checkdata.get("keyguid");
					BigDecimal datacount = new BigDecimal(checkdata.get("datacount").toString());
					int count = datacount.intValue();
					if(count > 0){//查询到业务表数据的说明有数据
						queryMap.put(keyguid,datacount);
					}
				}
				String finalTabcode = tabcode;
				String finalTabname = tabname;
				reMap.forEach((key, val) ->{
					if (!queryMap.containsKey(key)){//返回结果中没有的数据，即校验不通过项目
						Map<String, Object> checkmsg = new HashMap<>();
						checkmsg.put("proname",val);
						checkmsg.put("tabcode", finalTabcode);
						checkmsg.put("tabname", finalTabname);
						checkmsgList.add(checkmsg);
					}
				});
				if (checkmsgList.size() > 0){ //应为是同一个页签，校验完第一个checktable不满足直接提示不需要校验第二个了
					break;
				}
			}
		}
		//根据项目名称分组 然后组装提示信息放入warnList
		Map<String,List<Map<String, Object>>> map = checkmsgList.stream().collect(Collectors.groupingBy(x -> (String)x.get("proname")));
		for (String proname : map.keySet()){
			String warnStr = "【" + proname + "】必填页签：";
			String pageTitle = "";
			List<Map<String, Object>> msglist = map.get(proname);
			for (Map<String, Object> msg : msglist) {
				pageTitle += msg.get("tabname") + "，";
			}
			if (!StringUtil.isEmpty(pageTitle)) {
				warnList.add(warnStr + pageTitle.substring(0, pageTitle.length() - 1) + "；");
			}
		}
		returnMap.put("esg", warnList);
        logger.info("---页签数据必填校验---end---");
        return returnMap;
    }

	/**
	 * 校验页签必填sql获取
	 * @param checkTable
	 * @param datas
	 * @param mainTable
	 * @param tabConfig
	 * @return
	 */
	public Map<String,Object> getCheckWheresql(String checkTable, List<Map<String, Object>> datas, String mainTable, String tabConfig) {
		List<String> sqlList = new ArrayList<>();
		Map<String, Object> reMap = new HashMap<>();
		String keycode = "mainguid";
		String[] checkTables = checkTable.split(",");
		StringBuffer bufferid = new StringBuffer();
		StringBuffer bufferproguid = new StringBuffer();
		StringBuffer buffercode = new StringBuffer();
		List<Map<String, Object>> relist = new ArrayList<>();
		for (Map<String, Object> data : datas) {
			String guid = (String) data.get("guid");
			String procode = (String) data.get("pro_code");
			String proguid = (String) data.get("proguid");
			bufferid.append("'").append(guid).append("',");
			bufferproguid.append("'").append(proguid).append("',");
			buffercode.append("'").append(procode).append("',");
			Map<String, Object> relMap = new HashMap<>();
			String name = (String) data.get("name");
			if(StringUtil.isEmpty(name)){
				name = (String) data.get("pro_name");
			}
			if(StringUtil.isEmpty(name)){
				name = (String) data.get("projname");
			}
			relMap.put("guid",guid);
			relMap.put("billguid",guid);
			relMap.put("mainguid",guid);
			relMap.put("pro_code",procode);
			relMap.put("proname",name);
			relist.add(relMap);
		}
		if (bufferid.length() > 0) {
			bufferid.deleteCharAt(bufferid.length() - 1);
		}
		if (bufferproguid.length() > 0) {
			bufferproguid.deleteCharAt(bufferproguid.length() - 1);
		}
		if (buffercode.length() > 0) {
			buffercode.deleteCharAt(buffercode.length() - 1);
		}

		for (String tablecode : checkTables) {
			String whereSql = " t.mainguid in (" + bufferid.toString() + ")";//默认条件 子表
			String prosql = "";
			if (tablecode.toLowerCase().replaceAll("v_", "").equals(mainTable.toLowerCase().replaceAll("v_", ""))) {
				whereSql = " t.guid in (" + bufferid.toString() + ")";//条件 子表 = 主表
				keycode = "guid";
			} else if ("v_perf_file".equals(tablecode.toLowerCase())) {
				whereSql = " t.billguid in (" + bufferid.toString() + ")";//条件 附件表
				keycode = "billguid";
				if(!StringUtil.isEmpty(tabConfig)){
					Map<String, Object> configMap = JSON.parseObject(tabConfig);
					String filebustype = (String)configMap.get("filebustype");
					if(!StringUtil.isEmpty(tabConfig)){
						whereSql += "and exists (select 1 from perf_filetype pf where pf.bustype = '"+filebustype+"' and pf.guid = t.filetype)";
					}
				}
			} else if("pm_perf_goal_info".equals(tablecode.toLowerCase()) || "pm_perf_indicator".equals(tablecode.toLowerCase())){
				prosql = " t.mainguid in (" + bufferproguid.toString() + ")";
				keycode = "mainguid";
				whereSql = " t.yearflag = '1' and t.is_backup = 2 and t.is_deleted = 2 and "+ prosql;//条件 总体绩效
			}else if("v_pm_perf_goal_info".equals(tablecode.toLowerCase()) || "v_pm_perf_indicator".equals(tablecode.toLowerCase())){
				if(PerfUtil.getIsHbei()){
					prosql = " t.mainguid in (" + bufferproguid.toString() + ")";
					keycode = "mainguid";
				}else{
					prosql = " t.pro_code in (" + buffercode.toString() + ")";
					keycode = "pro_code";
				}
				whereSql = " t.yearflag = '0' and "+ prosql;//条件 年度绩效
			}
			String sql = "select count(1) as datacount, " + keycode + " as keyguid from " + tablecode + " t where " + whereSql + " group by " + keycode;
			sqlList.add(sql);
		}
		for (Map<String, Object> redata : relist) {
			String keyvalue = (String) redata.get(keycode);
			String proname = (String) redata.get("proname");
			reMap.put(keyvalue,proname);
		}
		Map<String,Object> result = new HashMap<>();
		result.put("reMap",reMap);
		result.put("sqlList",sqlList);
		return result;
	}

	/**
	 * 页面页签待办总数
	 * @param params
	 * @return
	 */
	public Map<String, Object> getTabPendingTask(HashMap params) throws AppException {
		String isShowTabPendingTask = PerfUtil.getSystemSet("isShowTabPendingTask");
		String waittabcode = (String) params.get("waittabcode");
		if(!"1".equals(isShowTabPendingTask)){
			return null;
		}
		List<Map<String,Object>> tabpageList = (List<Map<String,Object>>) params.get("tabpage");//菜单所有页签
		String key = (String) params.get("key");
		String cacheKey = getPmkpiDAO().PMKPI_CACHE_PENDINGTASK + key;
		List<Map<String, Object>> datas = null;
		String leftnum = params.get("leftnum") + "";
		String cacheData = PerfUtil.getCacheJSONData(cacheKey);
		if (!StringUtil.isEmpty(cacheData)) {
			datas = PerfUtil.parseString2List(cacheData);
		} else {
			String wheresql = "key='" + key + "'";
			datas = this.getDatas("V_PERF_PENDINGTASK", wheresql, null);
			String data = PerfUtil.parse2Json(datas);
			PerfUtil.reflashCacheJSONData(cacheKey, data, false);
		}
		if (!StringUtil.isEmpty(leftnum) && !"null".equals(leftnum) && datas.size() > 0) {
			datas = datas.stream().filter(map-> leftnum.equals(map.get("lefttabnum"))).collect(Collectors.toList());
		}
		if (datas.size() == 0) {
			return null;
		}
		String oneTabcode = "";
		if (tabpageList == null || tabpageList.size() == 0) {
			return null;
		} else {
			//待办跳转，如果调整的是已退回，则不查询已退回
			if (!StringUtil.isEmpty(waittabcode)) {
				oneTabcode = waittabcode;
			} else {
				oneTabcode = (String) tabpageList.get(0).get("code");
			}
		}
		Map<String, Object> backMap = new HashMap<>();
		String finalOneTabcode = oneTabcode;
		datas.forEach(data -> {
			String tabcode ="";
			String beanid = (String) data.get("beanid");
			String mothod = (String) data.get("mothod");
			String param = (String) data.get("param");
			Map<String, Object> queryMap = null;
			if(param !=null && !StringUtil.isEmpty(param) && !"{}".equals(param)) {
				queryMap = JSON.parseObject(param, Map.class);
				tabcode = (String) queryMap.get("tabcode");//页签
			}
			String finalTabcode = tabcode;
			Map<String, Object> finalQueryMap = queryMap;
			tabpageList.forEach(tabdata -> {
				String code = (String) tabdata.get("code");
				if (finalTabcode.equals(code) && !finalOneTabcode.equals(code)){
					int dataNum = 0;
					if (!StringUtil.isEmpty(beanid) && !StringUtil.isEmpty(mothod)) {
						Object o = PerfServiceFactory.getBean(beanid);
						Object[] p = new Object[]{1};
						p[0] = finalQueryMap;
						Object obj = null;
						try {
							obj = this.runFunction(o, mothod, p);
						} catch (Exception e) {
							e.printStackTrace();
						}
						if ("getVodSql".equals(mothod)) {
							dataNum = this.getDataCount("(" + obj + ")", null);
						} else {
							List<Map<String, Object>> dataList = new ArrayList<>();
							if (obj instanceof List) {
								dataList = (List<Map<String, Object>>) obj;
							} else if (obj instanceof Map) {
								Map<String, Object> dataMap = (Map<String, Object>) obj;
								dataList = (List<Map<String, Object>>) dataMap.get("data");
							}
							dataNum = dataList.size();
						}
						if (dataNum != 0) {
							backMap.put(code, dataNum);
						}
					}
				}
			});
		});
		return backMap;
	}

	public Object runFunction(Object c, String mothedname, Object[] params) throws Exception {
		Method invokeMethod = null;
		if (params == null) {
			invokeMethod = c.getClass().getMethod(mothedname, null);
		} else {
			Class[] paramscls = new Class[params.length];
			for (int i = 0; i < params.length; i++) {
				paramscls[i] = params[i].getClass();
			}
			try {
				invokeMethod = c.getClass().getMethod(mothedname, paramscls);
			} catch (NoSuchMethodException e) {
				invokeMethod = ClassUtil.getMethodName(c, mothedname, paramscls);
			}
		}
		Object invoke = null;
		try {
			invoke = invokeMethod.invoke(c, params);
		} catch (InvocationTargetException e) {
			throw CauseAppException.causeAppException(e.getTargetException());
		} catch (Exception e) {
			throw CauseAppException.causeAppException(e);
		}
		return invoke;
	}

	/**
	 * <p>根据pro_code反查发生调整的项目的guid</p >
	 *
	 * @author hw
	 * @date 2022/11/23 16:31
	 * @param
	 */
	public String getProGuid(String proGuid, String proCode){
		String proSql = " t.guid ='" + proGuid + "'";
		List<Map<String, Object>> proInfo = this.getDatas(getPmkpiDAO().PMKPI_TABLE_PROJECT_INFO, proSql, null);
		if (proInfo == null || proInfo.isEmpty()) {
			proSql = " t.pro_code ='" + proCode + "'";
			proInfo = this.getDatas(getPmkpiDAO().PMKPI_TABLE_PROJECT_INFO, proSql, null);
			if (proInfo != null && !proInfo.isEmpty()) {
				proGuid = (String) proInfo.get(0).get("guid");
			}
		}
		return proGuid;
	}

    /**
     * <p>当年预算金额：</p >
     * 汇总预算年度(登录年度)部门预算项目年度预算表 或 对下转移支付年度预算表 变动后预算数,如获取无数据默认给0
     * BGT_PM_ANNUAL.CUR_AMT   BGT_TRA.CUR_AMT
     *
     * @param proCode : 项目code
     * @author hw
     * @date 2022/12/2 10:46
     */
    public BigDecimal getProjAmt(String proCode) {
        BigDecimal projAmt;
        String sql = "select nvl(sum(cur_amt),0) as projamt from v_bgt_pm_annual where pro_code = '" + proCode + "' and is_deleted = 2";
        List<Map<String, Object>> list = getPmkpiDAO().queryForList(sql);
		projAmt = (BigDecimal) list.get(0).get("projamt");
		if (projAmt.compareTo(new BigDecimal("0")) == 0) {
			sql = "select nvl(sum(cur_amt),0) as projamt from v_bgt_tra where pro_code = '" + proCode + "' and is_deleted = 2";
			list = getPmkpiDAO().queryForList(sql);
			projAmt = (BigDecimal) list.get(0).get("projamt");
		}
        return projAmt;
    }

    public List<Map<String, Object>> getProDetail(HashMap<String, Object> params) {
        String rectype = (String) params.get("rectype");
        String guid = (String) params.get("guid");
        String tablecode;
        String sql = "select t.* from ";
        String whereSql = " t where exists (select 1 from " + RectificationAddProjDAO.PERF_T_RECTIFY + " r where r.pro_code = t.pro_code and r.guid = '" + guid + "' ";
        if ("rectifyperfself".equals(rectype)) { //绩效自评
            tablecode = PerfSelfApplyDAO.SELFEVALTASK_TABLE;
            sql += tablecode + whereSql + ")";
        } else if ("rectifydepteval".equals(rectype)) { //部门评价
            tablecode = DeptAuditDAO.PERF_TABLE_DEPTEVAL;
            sql += tablecode + whereSql + ")";
        } else if ("rectifyfinancialeval".equals(rectype)) {  //财政评价
            tablecode = ProConfirmDAO.PERF_TABLE_PROCONFIRM;
            sql += tablecode + whereSql + ")";
        } else {  //绩效监控
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
            sql += tablecode + whereSql + " and r.taskstage = t.taskstage )";
        }
        logger.info("---整改详情-查询业务数据：" + sql);
        List list = getPmkpiDAO().queryForList(sql.toString());
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        List<Map<String, Object>> datas = new ArrayList<>();
        datas.add(map);
        return datas;
    }


	/**
	 * <p>校验指标名称不可重复</p >
	 *
	 * @author hw
	 * @date 2022/5/30 17:00
	 * @param
	 */
	public Map<String, Object> nameDuplicateCheck(List<Map<String, Object>> indexList) {
		logger.info("---校验指标名称是否重复----start---");
		List<Map<String, Object>> myList = indexList.stream().filter(myMap -> "3".equals(PerfUtil.mapGetInt(myMap, "levelno") + "")).collect(Collectors.toList());
		Map<String, Object> backMap = new HashMap<String, Object>();
		Map<String, Object> errMap = null;
		List<Map<String, Object>> errdata = new ArrayList<>();
		for (Map<String, Object> map : myList) {
			String name = StringUtil.isNullOrEmpty(map.get("name")) ? "" : (String) map.get("name");
			List<Map<String, Object>> totalList1 = myList.stream().filter(map1 -> name.equals(map1.get("name"))).collect(Collectors.toList());
			if (totalList1.size() > 1) {
				errMap = new HashMap<String, Object>();
				errMap.put("remark", "【" + name + "】指标名称重复" + totalList1.size() + "次，无法保存；");
				errMap.put("code", "002");
				errMap.put("name", "校验指标名称");
				errMap.put("explain", "指标名称不可重复");
				errdata.add(errMap);
			}
		}
		if (errdata != null && !errdata.isEmpty()) {
			errdata = errdata.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() ->
					new TreeSet<>(Comparator.comparing((o) -> o.get("remark") + ""))), ArrayList::new)); // 去重
			logger.info("---errdata：" + errdata.toString());
			backMap.put("success", false);
			backMap.put("redata", errdata);
		}
		logger.info("---校验指标名称是否重复----end---");
		return backMap;
	}

	/**
	 * 查询节点审核类型
	 * @param workflow 工作流
	 * @param prevwfstatus --当前数据状态
	 */
	public List<Map<String, Object>> queryAuditType(String workflow , String prevwfstatus) throws AppException {
		return getPmkpiDAO().queryAuditType(workflow, prevwfstatus);
	}

	/**
	 * 处理一二三级指标数据
	 * @param indexList
	 * @param frametype
	 * @param isSelfTemp--是否自评固话指标
	 */
	public void setIndexDatas(List<Map<String, Object>> indexList, String frametype, boolean isSelfTemp){
		getPmkpiDAO().setIndexDatas(indexList, frametype, isSelfTemp);
	}


	/**
	 * 校验字段长度
	 *
	 * @param indexList
	 * @return
	 */
	public Map<String, Object> checkColLength(List<Map<String, Object>> indexList, String tablecode) {
		List<Map<String, Object>> columnlist = getPmkpiDAO().getCol(tablecode);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		for (Map colsMap : columnlist) {
			String collength = (String) colsMap.get("datalength");
			if (StringUtil.isEmpty(collength) || "0".equals(collength)) {
				continue;
			}
			int strLength = Integer.parseInt(collength); //规定长度
			String colName = (String) colsMap.get("columncode");
			String title = (String) colsMap.get("name");
			colName = colName.toLowerCase();
			for (Map indexMap : indexList) {
				String context = indexMap.get(colName) != null ? String.valueOf(indexMap.get(colName)).trim() : "";
				/*int i = 0; //录入长度
				if (!StringUtil.isEmpty(context)) {
					for (char chr : context.toCharArray()) {
						if ((int) chr > 127) {
							i += 3;
						} else {
							i++;
						}
					}
				}*/
				// 由于Java是基于Unicode编码的，因此，一个汉字的长度为1，而不是2。
				// 但有时需要以字节单位获得字符串的长度。例如，“123abc测试”按字节长度计算是10，而按Unicode计算长度是8。
				// 为了获得10，需要从头扫描根据字符的Ascii来获得具体的长度。
				// 如果是标准的字符，Ascii的范围是0至255，如果是汉字或其他全角字符，Ascii会大于255。
				// 因此，可以使用Character.codePointAt方法来获得以字节为单位的字符串长度。
				int len = 0; //录入长度
				if (!StringUtil.isEmpty(context)) {
					for(int i = 0; i < context.length(); i++)
					{
						int ascii = Character.codePointAt(context, i);
						if(ascii >= 0 && ascii <=255)
							len++;
						else
							len += 2;
					}
				}
				if (len > strLength) {
					Map<String, Object> errMap = new HashMap<String, Object>();
					List<Map<String, Object>> errdata = new ArrayList<>();
					errMap.put("remark","字段：" + title + "长度超长，请重新填写！");
					errMap.put("code", "001");
					errMap.put("name", "校验字段填写长度");
					errMap.put("explain", "校验字段填写长度");
					errdata.add(errMap);
					returnMap.put("success", false);
					returnMap.put("redata", errdata);
					return returnMap;
				}
			}
		}
		return returnMap;
	}

	/**
	 * 设置查询数据年度、区划
	 * @param year
	 * @param province
	 */
	public void setYearAndProvince(String year, String province) {
		getPmkpiDAO().setYearAndProvince(year, province);
	}

	public void updateAllByColumn(String columnname, Collection<String> guid, String tabcode, String upsql, String wheresql) throws AppException {
		getPmkpiDAO().updateAllByColumn(columnname, guid, tabcode, upsql, wheresql);
	}

	public String createInSql(String colnumcode, List<String> list) throws AppException {
		return getPmkpiDAO().createInSql(colnumcode, list);
	}

	/**
	 * 查询数据.
	 * @param params -- 参数.
	 * @return
	 * @throws AppException -- 自定义异常.
	 */
	public List<Map<String, Object>> getAIDatas(HashMap<String,Object> params) throws AppException {
		String type = (String)params.get("type");// 类型
		if(!StringUtil.isNullOrEmpty(type) && "depttrace".equals(type)){
			return this.getDeptTraceAIDatas(params);
		}else{
			return this.getAuditAIDatas(params);
		}
	}

	public List<Map<String, Object>> getDeptTraceAIDatas(HashMap<String,Object> params) throws AppException {
		List<Map<String, Object>> datas = new ArrayList();
		String dept_code = (String)params.get("dept_code");// 部门
		String month = (String)params.get("month");// 监控阶段
		String wheresql = "dept_code = ? and month = ?";
		// 一、部门绩效监控整体概述
		Map<String, Object> reportinfo = getPmkpiDAO().getDataMap("aireport_v_depttraceinfo",wheresql,new String[]{dept_code,month});
		List<Map<String, Object>> bgtproList = getPmkpiDAO().getDatas("aireport_v_depttracebgtlist",wheresql,null,new String[]{dept_code,month});
		// 二、年度预算执行情况
		String total_pro_bgt_content = "";
		if(bgtproList.size()>0){
			for (int i = 0; i < bgtproList.size(); i++) {
				total_pro_bgt_content += bgtproList.get(i).get("pro_bgt_content");
			}
		}
		reportinfo.put("pro_bgt_content",total_pro_bgt_content);
		// 三、绩效目标完成情况
		List<Map<String, Object>> indexproList = getPmkpiDAO().getDatas("aireport_v_depttraceindexlist",wheresql,null,new String[]{dept_code,month});
		String total_pro_index_content = "";
		String currentProCode = null;
		if(indexproList.size()>0){
			for (int i = 0; i < indexproList.size(); i++) {
				Map<String, Object> promap = indexproList.get(i);
				String pro_code = (String) promap.get("pro_code");
				String pro_name = (String) promap.get("pro_name");
				String dept_name = (String) promap.get("dept_name");
				String agency_name = (String) promap.get("agency_name");
				if (!pro_code.equals(currentProCode)) {
					currentProCode = pro_code;
					// 每个项目开始
					total_pro_index_content += "["+pro_code+"]"+pro_name+"项目为"+dept_name+"部门下的"+agency_name+"单位的绩效监控项目\\n";
				}
				total_pro_index_content += promap.get("pro_index_content");
			}
		}
		reportinfo.put("pro_index_content",total_pro_index_content);
		List<Map<String, Object>> problemproList = getPmkpiDAO().getDatas("aireport_v_depttraceproblem",wheresql,null,new String[]{dept_code,month});
		// 四、存在问题及原因分析
		String total_pro_problem_content = "";
		if(problemproList.size()>0){
			for (int i = 0; i < problemproList.size(); i++) {
				total_pro_problem_content += problemproList.get(i).get("pro_problem_content");
			}
		}
		reportinfo.put("pro_problem_content",total_pro_problem_content);
		// 五、下一步工作安排
		List<Map<String, Object>> nextworkproList = getPmkpiDAO().getDatas("aireport_v_depttracenextwork",wheresql,null,new String[]{dept_code,month});
		String total_pro_nextwork_content = "";
		if(nextworkproList.size()>0){
			for (int i = 0; i < nextworkproList.size(); i++) {
				total_pro_nextwork_content += nextworkproList.get(i).get("pro_nextwork_content");
			}
		}
		reportinfo.put("pro_nextwork_content",total_pro_nextwork_content);
		datas.add(reportinfo);
		return PerfUtil.upperMapKeyAndDefNullStr(datas);
	}

	public List<Map<String, Object>> getAuditAIDatas(HashMap<String,Object> params) throws AppException {
		IDataSetService dataSetService = (IDataSetService) PerfServiceFactory.getBean("bus.dic.dataset.service");
		List<Map<String, Object>> queryset = (List<Map<String, Object>>) params.get("queryset");
		List<Map<String, Object>> datas = new ArrayList();
		Map<String, Object> datasourceMap = null;
		StringBuffer wsql = null;
		List cols = null;
		for (Map<String, Object> map : queryset) {
			wsql = new StringBuffer();
			datasourceMap = new HashMap<>();
			String querycol = (String) map.get("querycol");//根据哪个字段查询数据
			String tablecode = (String) map.get("tablecode");//查询数据表
			String dcol = (String) map.get("dcol");//数据对应取值字段是哪个
			String datacols = (String) map.get("datacols");//返回字段，多个逗号分割
			String wheresql = (String) map.get("wheresql");//查询条件
			String[] datacolList = datacols.split(",");
			cols = getPmkpiDAO().getCol(tablecode);
			if (cols != null) {
				for (Object obj : cols) {
					Map colMap = (Map) obj;
					String columncode = (String) colMap.get("columncode");
					String csid = (String) colMap.get("csid");
					if (!StringUtil.isNullOrEmpty(csid)) {
						//查询dicds/dicdssource配置
						DataSetDTO dataSetDTO = dataSetService.getDataSetByGuid(csid);
						if (dataSetDTO != null) {
							String elementcode = dataSetDTO.getString("elementcode");
							//查询翻译数据
							if (Arrays.asList(datacolList).contains(columncode) && !StringUtil.isNullOrEmpty(elementcode)) {
								datasourceMap.put(columncode, PerfUtil.getSourceData(elementcode, null));
							}
						} else {
							logger.debug(csid + "----------没找到对应数据源配置，请检查");
						}
					}
				}
			}
			List<String> l = (List<String>) params.get(dcol);
			wsql.append(this.createInSql(querycol, l));
			if (!StringUtil.isNullOrEmpty(wheresql)) {
				wsql.append(" and ").append(wheresql);
			}
			List<Map<String, Object>> list = this.getDatas(tablecode, wsql.toString(), null);
			for (Map<String, Object> m : list) {
				Map<String, Object> dataMap = new HashMap<>();
				for (String col : datacolList) {
					//是否翻译字段
					if (datasourceMap.keySet().contains(col)) {
						List<Map<String, Object>> sourceList = (List<Map<String, Object>>) datasourceMap.get(col);
						for (Map<String, Object> d : sourceList) {
							if (d.get("guid").equals(m.get(col))) {
								dataMap.put(col, d.get("name"));
								break;
							}
						}
					} else {
						dataMap.put(col, StringUtil.isNullOrEmpty(m.get(col)) ? "" : m.get(col));
					}
				}
				datas.add(dataMap);
			}
		}
		return datas;
	}

	/**
	 * 纳入ai辅助审核的任务队列
	 * @param params
	 * @return
	 */
	public Map<String, Object> aiSupportAuditTask(HashMap<String,Object> params) throws AppException {
		Map<String, Object> backMap = new HashMap<String, Object>();
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		String actioncode = (String) params.get("actioncode");
		List<Map<String, Object>> waitdatalist = new ArrayList<>();
		for (Map<String, Object> data : datas) {
			String pro_code = (String) data.get("pro_code");
			if(!StringUtil.isNullOrEmpty(pro_code)){
				Map waitdatamap = new HashMap();
				waitdatamap.put("pro_code",pro_code);
				waitdatamap.put("actioncode",actioncode);
				waitdatamap.put("year",CommonUtil.getYear());
				waitdatamap.put("province", CommonUtil.getProvince());
				waitdatalist.add(waitdatamap);
			}else{
				backMap.put("success", false);
				backMap.put("msg", "列表数据缺少PRO_CODE项目编码，无法纳入智能辅助审核队列");
				return backMap;
			}
		}
		if(waitdatalist.size()>0){
			getPmkpiDAO().saveAll(waitdatalist, "PERF_T_WAITAISUPPORTAUDIT");
		}
		backMap.put("success", true);
		return  backMap;
	}

	/**
	 * 导入数据处理.
	 *
	 * @param params -- 参数集合.
	 * @return -- list.
	 */
	public List<Map<String, Object>> impDatas(HashMap<String, Object> params) throws AppException {
		//表名
		String impguid = (String) params.get("impguid");
		String tablecode = PerfMidsaveBO.MIDSAVE_TABLE;
		String wheresql = " guid=? ";
		Map<String, Object> impdata = this.getDataMap(tablecode, wheresql, new String[]{impguid});
		if (!impdata.isEmpty()) {
			String data = (String) impdata.get("data");
			List<Map<String, Object>> indexList = PerfUtil.parseString2List(data);
			PerfServiceFactory.getPmkpiDAO().deleteGUID(impguid, tablecode);
			return indexList;
		}

		return new ArrayList<>();
	}

}
