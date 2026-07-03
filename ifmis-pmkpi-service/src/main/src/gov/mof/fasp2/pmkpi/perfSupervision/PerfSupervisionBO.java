package gov.mof.fasp2.pmkpi.perfSupervision;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import java.util.*;


public class PerfSupervisionBO extends PmkpiBO {

    private PerfSupervisionDAO perfSupervisionDAO;

    public void setPerfSupervisionDAO(PerfSupervisionDAO perfSupervisionDAO) {
        this.perfSupervisionDAO = perfSupervisionDAO;
    }
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
		String protype= (String) sqlmap.get("protype");
		List queryConfig = (List) sqlmap.get("queryConfig");
		String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
		String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
		logger.debug("左侧树要素"+elementcode+"####");
		if (StringUtil.isEmpty(elementcode)){
			elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
			columncode = "agencyguid";
		}
		StringBuffer returnsql = new StringBuffer("select * from ");
		returnsql.append(tablecode).append(" t ");
		returnsql.append(" where 1=1 and t.protype='").append(protype).append("'");
				//.append("' and t.prolev='").append(prolev).append("'");
		String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
		datarule = datarule.replace("t.agencyguid","t.guid");
		IDataSetService dss = PerfServiceFactory.getIDataSetService();
		if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
			datarule += " start with superguid='" + saveAgency + "' connect by prior guid = superguid";
			datarule = " 1= 1" + datarule;
			List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
			List list = new ArrayList();
			Map map = new HashMap();
			map.put("guid",saveAgency);
			list.add(map);
			eledatas.addAll(list);
			perfSupervisionDAO.saveAll(eledatas, perfSupervisionDAO.PMKPI_TABLE_TMP_AGENCY);
		} else {
			datarule = " 1= 1" + datarule;
			List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
			perfSupervisionDAO.saveAll(eledatas, perfSupervisionDAO.PMKPI_TABLE_TMP_AGENCY);
		}
		if(queryConfig != null) {
			if (queryConfig.size() > 0) {
				Map map = (Map) queryConfig.get(0);
				String proname = (String) map.get("proname");
				String amtmax = (String) map.get("amtmax");
				String amtmin = (String) map.get("amtmin");
				String finintirgguid = (String)map.get("finintirgguid");
				String is_add = (String)map.get("is_add");
				String bgtwf = (String) map.get("bgtwf");
				if (proname != null && !proname.isEmpty()) {
					returnsql.append(" and t.proname = '").append(proname).append("'");
				}
				if (finintirgguid != null && !finintirgguid.isEmpty()) {
					returnsql.append(" and t.finintirgguid in (").append(finintirgguid).append(")");
				}
				if (is_add != null && !is_add.isEmpty()) {
					returnsql.append(" and t.is_add in (").append(is_add).append(")");
				}
				if (amtmax != null && !amtmax.isEmpty()) {
					returnsql.append(" and t.proamt >= '").append(amtmax).append("'");
				}
				if (amtmin != null && !amtmin.isEmpty()) {
					returnsql.append(" and t.proamt <= '").append(amtmin).append("'");
				}
				if (bgtwf != null && !bgtwf.isEmpty()) {
					returnsql.append(" and t.taskguid = '").append(bgtwf).append("'");
				}
			}
		}
		if (tablesql != null && !tablesql.isEmpty()){
			returnsql.append(" and ").append(tablesql);
		}
		if (tabfilter != null && !tabfilter.isEmpty()){
			returnsql.append(" and ").append(tabfilter);
		}
		String wfsql = this.getWfSql(tabcode, workflow);
		if (wfsql != null && !wfsql.isEmpty()) {
			returnsql.append(" and (").append(wfsql).append(") ");
		}
		if ("1".equals(isleaf)) {
			returnsql.append(" and t.").append(columncode).append("='").append(saveAgency).append("'");
		} else if("2".equals(isleaf)){
			returnsql.append(" and t.").append("dept").append("='").append(saveAgency).append("'");
		}
		return returnsql.toString();
	}

	/**
	 * 查询左侧树。
	 * @param menuId -- 菜单.
	 * @return
	 * @throws AppException
	 */
	public Map getTraceLeftTree(String menuId) throws Exception {
		Map leftconfig = new HashMap();
		List<String> types = new ArrayList<String>();
		types.add("prodetail");
		types.add("promain");
		types.add("propay");
		Object[] tabs = new Object[types.size()];
		for (int i = 0; i < types.size(); i++) {
			String type = types.get(i);
			leftconfig = new HashMap();
			String datarule = this.getDataRuleByMenuguid(type + perfSupervisionDAO.PERF_T_SUPERVISION, "t", "1=1");
			datarule += " and protype = '" + type + "'";
			//根据权限查询单位
//			if ("propay".equals(type)){
//				leftconfig.put("datas", this.getLeftTree(menuId,perfSupervisionDAO.getSystemDepttree()));
//			} else if ("prodetail".equals(type)) {
//				leftconfig.put("datas", this.getLeftTree(menuId,perfSupervisionDAO.getSystemAgencytree()));
//			} else if ("promain".equals(type)) {
//				leftconfig.put("datas", this.getLeftTree(menuId,perfSupervisionDAO.getSystemDepttree()));
//			}
			List<Map<String, Object>> list = perfSupervisionDAO.getTreeList(datarule, "V_PERF_T_SUPERVISIONVIEW");
			perfSupervisionDAO.saveAll(list, perfSupervisionDAO.PMKPI_TABLE_TMP_AGENCY);
			list = perfSupervisionDAO.getLeftTree();
			if(list == null){
				list = new ArrayList<>();
			}
			if (list.size() == 0) {
				Map<String, Object> map = new HashMap<>();
				map.put("guid","treeroot");
				map.put("code","00");
				map.put("name","全部");
				map.put("superid","0");
				map.put("levelno","1");
				map.put("isleaf","0");
				list.add(map);
				leftconfig.put("datas", list);
			} else {
				if ("propay".equals(type)){
					list = perfSupervisionDAO.getLeftTree();
					leftconfig.put("datas", list);
				} else if ("prodetail".equals(type)) {
					leftconfig.put("datas", list);
				} else if ("promain".equals(type)) {
					leftconfig.put("datas", list);
				}
			}
			leftconfig.put("showRootNode", Boolean.TRUE);
			leftconfig.put("dosearch", Boolean.FALSE);
			leftconfig.put("outformart", "#code-#name");
			leftconfig.put("expandlevel", 2);
			Map f1 = new HashMap();

			if ("prodetail".equals(type)){
				leftconfig.put("name", "二级项目");
				f1.put("name", "二级项目");
			} else if ("promain".equals(type)){
				leftconfig.put("name", "一级项目");
				f1.put("name", "一级项目");
			} else if ("propay".equals(type)) {
				leftconfig.put("name", "转移支付");
				f1.put("name", "转移支付");
			}
			f1.put("ordernum", i);
			f1.put("code", type);
			f1.put("click", "tabChange");
			f1.put("treeinfo", leftconfig);
			tabs[i] = f1;
		}
		Map m = new HashMap();
		m.put("onlydata", Boolean.TRUE);
		m.put("activeTab", 0);
		m.put("dosearch", Boolean.TRUE);
		m.put("tabs", tabs);
		return m;
	}

	/**
	 * 查询左侧树数据
	 * @param params
	 * @return
	 * @throws AppException
	 */
	public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
		String tablecode = (String) params.get("tablecode");
		String protype = (String) params.get("protype");
		String datarule = this.getDataRuleByMenuguid(protype + perfSupervisionDAO.PERF_T_SUPERVISION, "t", "1=1");
		//根据权限查询单位
		List<Map<String, Object>> list = perfSupervisionDAO.getTreeList(datarule, tablecode);
		perfSupervisionDAO.saveAll(list, perfSupervisionDAO.PMKPI_TABLE_TMP_AGENCY);
		return perfSupervisionDAO.getLeftTree();
	}

	/**
	 * 送审/审核/退回/取消审核
	 * @param params --
	 * @return --
	 */
	public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("list");
		String tablecode = (String) params.get("tablecode");
		String workflow = (String) params.get("workflow");
		String actioncode = (String) params.get("actioncode");
		String remark = (String) params.get("remark");
		//审核定义
		String busguid = (String) params.get("busguid");
		this.workflow(actioncode, workflow, remark, tablecode, datas);
		//20240102 监审终审时，根据 pro_code+year+province 删除之前的所有数据
		String wfstatus = (String) datas.get(0).get("wfstatus");
		if (wfstatus != null && "011".equals(wfstatus)) {
			List<String> procodes = new ArrayList<>();
			for (Map<String, Object> data : datas) {
				String mainguid = (String) data.get("mainguid");
				if(!procodes.contains(mainguid)){
					procodes.add(mainguid);
				}
			}
			String codesql = perfSupervisionDAO.createInSql("mainguid", procodes);
			perfSupervisionDAO.saveAll(datas, perfSupervisionDAO.PMKPI_TABLE_TMP_GUIDS);
			perfSupervisionDAO.delDatas("V_PERF_T_SUPERVISION", codesql + " and not exists (select 1 from " + perfSupervisionDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ");
		}
		return this.auditdefine(datas, busguid, "perf", null);
	}

	public Map save(HashMap config) throws AppException{
		List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("list");
		String tablecode = (String) config.get("tablecode");

		if(datas!=null && datas.size() > 0){
			perfSupervisionDAO.updateAllByPK(datas, "guid", tablecode);
		}
		return config;
	}

	public void updateIsSuper(String procode) {
		logger.debug("--------updateIsSuper 监审强制调整进入-------------");
		Map maplev = perfSupervisionDAO.queryForMap("SELECT * FROM v_perf_project_info WHERE pro_code = '" + procode + "' ");
		String pro_code = (String) maplev.get("pro_code");
		logger.debug("--------procode---------"+pro_code+"----");
		String sql = "update PERF_T_SUPERVISION set isadj = '0' where mainguid = '"+pro_code+"'";
		perfSupervisionDAO.update(sql);
	}

	public Map saveIndex(HashMap config) throws AppException{
		config.put("result", true);
		config.put("reason", "成功");
		String taskguid = (String) config.get("taskguid");
		//预算到一上部门审核岗之后的所有项目
		String proStr = "select pro_code,pro_levone_code from v_pm_project_info " +
				"where lastaudit = 1 " +
				"and is_deleted = 2 " +
				"and level_no = 2 " +
				"and pro_cat_code in ('22','3','31','32','33') " +
				"and pro_code in (select distinct pro_code from v_Bgt_t_Hc1100002019 t " +
										"where taskguid='"+taskguid+"' " +
										"and is_deleted=2 " +
										"and agencyguid in (select distinct agencyguid from Busfw_t_Dctableprocess " +
																"where taskguid='"+taskguid+"' ";
		if("9EE3A842793449818960559B00660C1B".equals(taskguid)){//二上不需要部门已送审流程
			proStr = proStr + "))";
		}else {
			proStr = proStr + "and WFSTATUS not in ('000','008')))";
		}
		List<Map<String, Object>> prolist = perfSupervisionDAO.queryForList(proStr);
		logger.debug("待推送监审项目数量---"+prolist.size()+"---####");

		if(prolist.size() > 0){
			for (Map<String, Object> proMap : prolist) {
				String procode = null;
				String protype = null;
				String workflow = null;
				//String prolevcode = (String) proMap.get("pro_levone_code");
				for (int i = 0; i < 2; i++) {
					if(i == 0){//二级code
						procode = (String) proMap.get("pro_code");
						protype = "prodetail";
						workflow = "ACB7014749AFD762BBFD99D8304BA3FC";
					} else {// 一级code
						procode = (String) proMap.get("pro_levone_code");
						protype = "promain";
						workflow = "ACB7014749AFD762BBFD99D8304BA3FB";
					}
					if(!StringUtils.isEmpty(procode)){
						//项目是否存在指标
						String proIndCount = "select nvl(count(1),0) as cou from v_pm_perf_indicator where yearflag = 0 and is_deleted = 2 and pro_code = '"+procode+"'";
						//项目是否存在监审指标
						String proIndSupCount = "select nvl(count(1),0) as cou from v_perf_t_supervision t where t.taskguid = '"+taskguid+"' and t.mainguid = '"+procode+"'";
						Map<String, Object> proIndMap =  perfSupervisionDAO.queryForMap(proIndCount);
						Map<String, Object> proIndSupMap = perfSupervisionDAO.queryForMap(proIndSupCount);
						//Integer.parseInt(proIndMap.get("cou").toString());
						Integer proInt = Integer.parseInt(proIndMap.get("cou").toString());
						Integer proIntSup = Integer.parseInt(proIndSupMap.get("cou").toString());

						//Integer proIntSup = (Integer) proIndSupMap.get("cou");
						// 存在项目年度指标并且不存在监审指标记录的项目
						if(proInt > 0 && proIntSup <= 0){
							String indicatorSql = "SELECT * FROM v_pm_perf_indicator WHERE pro_code = '" + procode + "' and yearflag = '0' and is_deleted = 2 ";
							List<Map<String, Object>> indicatorList = perfSupervisionDAO.queryForList(indicatorSql); //

							if (indicatorList != null && !indicatorList.isEmpty()) {
								List<Map<String, Object>> saveList = new ArrayList<>();
								for (Map<String, Object> indicatorLMap : indicatorList) {
									HashMap<String, Object> map = new HashMap<>();
									String uuid = StringUtil.createUUID();
									map.put("guid", uuid);
									map.put("mainguid", procode);
									map.put("status", "0");
									map.put("createtime", PerfUtil.getServerTimeStamp());
									map.put("updatetime", PerfUtil.getServerTimeStamp());
									map.put("creater", "admin");
									//PROVINCE
									map.put("province", indicatorLMap.get("mof_div_code"));
									map.put("year", indicatorLMap.get("fiscal_year"));
									map.put("protype", protype);
									map.put("wfid", workflow);
									map.put("indexguid", indicatorLMap.get("kpi_id"));
									map.put("isadd", indicatorLMap.get("is_add"));
									map.put("isadj", "0");
									map.put("taskguid", taskguid);
									saveList.add(map);
								}
								this.workflow("create", workflow, "", "PERF_T_SUPERVISION", saveList);
							}
						}
					}
				}
			}
		}else{
			config.put("result", false);
			config.put("reason", "该单位不存在未推送的监审项目");
		}
		return config;
	}
}
