package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentObjectDAO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.*;
import java.util.stream.Collectors;


public class RandomCommentObjectBO extends PmkpiBO {

    private RandomCommentObjectDAO randomCommentObjectDAO;

    public void setRandomCommentObjectDAO(RandomCommentObjectDAO randomCommentObjectDAO) {
        this.randomCommentObjectDAO = randomCommentObjectDAO;
    }
    

	IWorkflowService workflowService = (IWorkflowService)ServiceFactory.getBean("datacommon.wf.WorkflowService");
	/**
	 *  列表的查询方法.
	 * <p>Title: getVodSql</p>
	 * <p>Description: </p>
	 * @param params
	 * @return
	 * @throws AppException
	 * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
	 */
	@Override
	public String getVodSql(Map params) throws AppException {
		List queryConfig = (List) params.get("queryConfig");
		String wheresql = (String) params.get("querySql"); //查询区封装的参数
		Map<String, Object> backMap = new HashMap<String, Object>();
		List<Map<String, Object>> data = null;
		String menuid = (String) params.get("menuid");
		String agency = (String) params.get("agency");
		String tablecode = (String) params.get("tablecode");
		String tabfilter = (String) params.get("tabfilter");
		String tablesql = (String) params.get("tablesql");
		String orderby = (String) params.get("orderby");
		String tabcode = (String) params.get("tabcode");
		String ctablecode = (String) params.get("ctablecode");
		String bustype = (String) params.get("bustype");
		String isleaf = (String) params.get("isleaf");
		String workflow = (String) params.get("workflow");
		if (tabcode != null && "create".equals(tabcode)) {
			tablecode = ctablecode;
		}
		String elementcode = PerfUtil.getSystemSet("agency_lefttree");
		logger.info("左侧树要素"+elementcode+"####");
		if (StringUtil.isEmpty(elementcode)){
			elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
		}
		String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
		logger.info("---数据权限：" +menuid +"--"+ datarule);

		IDataSetService dss = PerfServiceFactory.getIDataSetService();
		if (!"2".equals(isleaf) && !"treeroot".equals(agency)) {
			datarule += " start with superguid='" + agency + "' connect by prior guid = superguid";
			datarule = " 1= 1" + datarule;
			List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
			randomCommentObjectDAO.saveAll(eledatas, randomCommentObjectDAO.PMKPI_TABLE_TMP_AGENCY);
		} else if ((agency != null && "treeroot".equals(agency))) {
			datarule = " 1= 1" + datarule;
			List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
			randomCommentObjectDAO.saveAll(eledatas, randomCommentObjectDAO.PMKPI_TABLE_TMP_AGENCY);
		}

		StringBuffer returnsql = new StringBuffer("select * from ");
		returnsql.append(tablecode).append(" t where t.bustype='" + bustype + "'");
		if("waitaudit".equals(tabfilter)){
			returnsql.append(" and t.ISSCOPE='0'");
		} else if("alreadyaudit".equals(tabfilter)){
			returnsql.append(" and t.ISOBJECT='1'");
		}
		if(queryConfig != null&&queryConfig.size() > 0) {
			Map<String, String> queryParam = (Map<String, String>) queryConfig.get(0);
			String wfstatus = queryParam.get("wfstatus");
			String projname = queryParam.get("projname");
			String finintorgguid = queryParam.get("finintorgguid");
			String vcol2 = queryParam.get("vcol2");
			String amtmax = queryParam.get("amtmax");
			String amtmin = queryParam.get("amtmin");
			String adjuststatus = queryParam.get("adjuststatus");
			DecimalFormat formater = new DecimalFormat("0");
			formater.setRoundingMode(RoundingMode.HALF_UP);
			if(wfstatus!=null && !wfstatus.isEmpty()){
				String[] split = wfstatus.split(",");
				StringBuilder resultStr = new StringBuilder();
				for (int i = 0; i < split.length; i++) {
					if(resultStr.length() == 0 || resultStr == null){
						resultStr.append("(")
								.append("WFSTATUS")
								.append("=")
								.append("'")
								.append(split[i])
								.append("'")
								.append(")");
					} else {
						resultStr.append(resultStr)
								.append("or")
								.append("(")
								.append("WFSTATUS")
								.append("=")
								.append("'")
								.append(split[i])
								.append("'")
								.append(")");
					}
				}
				String result = resultStr.toString();
				returnsql.append(" and ("+result+")");
			}
			if(projname!=null && !projname.isEmpty()){
				returnsql.append(" and projname like '%"+projname+"%'");
			}
			if(finintorgguid!=null && !finintorgguid.isEmpty()){
				returnsql.append(" and finintorgguid in ('"+finintorgguid.replaceAll("\\,", "','")+"')");
			}
			if(vcol2!=null && !vcol2.isEmpty()){
				returnsql.append(" and vcol2 in ('"+vcol2.replaceAll("\\,", "','")+"')");
			}
			if(adjuststatus!=null && !adjuststatus.isEmpty()){
				returnsql.append(" and adjuststatus in ('"+adjuststatus.replaceAll("\\,", "','")+"')");
			}
			if(amtmax!=null && !amtmax.isEmpty()){
				if(isNumeric(amtmax)){
					returnsql.append(" and amt >= "+amtmax);
				}
			}
			if(amtmin!=null && !amtmin.isEmpty()){
				if(isNumeric(amtmin)){
					returnsql.append(" and amt <= "+amtmin);
				}
			}
		}
		if (tablesql != null && !tablesql.isEmpty()) {
			returnsql.append(" and ").append(tablesql);
		}
		if (isleaf != null && "1".equals(isleaf)) {
			returnsql.append(" and t.agencyguid = '").append(agency).append("'");
		} else {
			returnsql.append(" and exists(select 1 from ").append(randomCommentObjectDAO.PMKPI_TABLE_TMP_AGENCY)
					.append(" a where a.guid =t.agencyguid)");
		}
		String wfsql = this.getWfSql(tabfilter, workflow);
		if (wfsql != null && !wfsql.isEmpty()) {
			returnsql.append(" and ").append(wfsql);
		}
		if (orderby != null && !orderby.isEmpty()) {
			returnsql.append(" ").append(orderby);
		}
		logger.error("抽评对象确定-----查询sql----------" + returnsql);
		return returnsql.toString();
	}

	/**
	 * <p>左侧树</p >
	 * @param
	 * @author
	 * @date 2022/10/27 16:06
	 */
	public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
		String lefttabtype = (String) params.get("lefttabtype");
		String tablecode = (String) params.get("tablecode");
		String leftmenuid = (String) params.get("leftmenuid");
		String menuId = (String) params.get("menuid");
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
		//根据权限查询单位
		String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
		datarule += " and bustype='" + lefttabtype + "'";
		data = randomCommentObjectDAO.getLeftTree(tablecode, datarule);
		if (data.size() == 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("guid","treeroot");
			map.put("code","00");
			map.put("name","全部");
			map.put("superid","0");
			map.put("levelno","1");
			map.put("isleaf","0");
			data.add(map);
		}
		return data;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> submitObject(HashMap<String,Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");

		String isObject = (String) config.get("isObject");
		String tablecode = (String) config.get("tablecode");
		String workflow = (String) config.get("wfid");
        String actioncode = (String) config.get("actioncode");
        String remark = (String) config.get("remark");

		if(datas!=null && datas.size() > 0){
			for(int i=0;i<datas.size();i++){
				Map strmap = datas.get(i);
 				Map map = new HashMap<String,String>();
 				map.putAll(strmap);
//				map.put("isobject", isObject);
				String wfstatus = (String)map.get("wfstatus");
				String wfid = (String)map.get("wfid");
				map.put("isobject", "0");
				if("audit".equals(actioncode)){
					List<WorkflowBranchDTO> WorkflowBranchDTOList = workflowService.queryWorkflowBranchsByWfStatus(wfid, wfstatus);
					String configs = WorkflowBranchDTOList.get(0).getAction();
					if("audit".equals(configs) && "1".equals(isObject)){
						map.put("isobject", "1");
					}
				}
				projList.add(map);
//				randomCommentObjectDAO.update("update "+tablecode+" set isobject = '"+isObject+"',israndom = '"+isRandom+"' where guid ='"+guid+"'");
			}
			if(projList!=null && projList.size() > 0){
				randomCommentObjectDAO.updateAllByPK(projList, "guid", tablecode);
			}
			this.workflow(actioncode, workflow, remark, tablecode, datas);
		}
		config.put("success", true);
		return config;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
		String tablecode = (String) config.get("tablecode");

		if(datas!=null && datas.size() > 0){
			for(int i=0;i<datas.size();i++){
				Map strmap = datas.get(i);
 				Map map = new HashMap<String,String>();
				String guid = (String)strmap.get("guid");
				map.put("guid", guid);
				map.put("isobject", null);
				map.put("wfid", null);
				map.put("wfstatus", null);
				map.put("auditor", null);
				projList.add(map);
				randomCommentObjectDAO.update("delete from "+tablecode+" where guid ='"+guid+"'");
//				randomCommentObjectDAO.update("update "+tablecode+" set isobject = null,wfid = null,wfstatus = null,auditor = null where guid ='"+guid+"'");
			}
		}
		config.put("success", true);
		return config;
	}

	/**
	 * 批量导入评价对象 通过项目编码
	 * @param impDatas
	 * @param impCols
	 * @param tablecode
	 * @param resultList
	 * @param busParams
	 * @throws AppException
	 */
	public void importRandomObject(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
		if (impDatas != null && impDatas.size() > 0) {
			List<Map<String, Object>> errorlist = this.checkImportDatas(impDatas,busParams);
			if (errorlist.size() > 0) {
				throw new AppException("ANA-ERROR", "导入数据错误");
			} else {
				RandomCommentObjectBO randomCommentObjectBO = (RandomCommentObjectBO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectBOTX");
				randomCommentObjectBO.importResultDatas(impDatas, impCols, tablecode, resultList, busParams);
			}

		}
	}

	/**
	 * 校验导入数据
	 * @param impDatas
	 * @param busParams
	 * @return
	 * @throws AppException
	 */
	public List<Map<String, Object>> checkImportDatas(List<Map<String, Object>> impDatas, HashMap busParams) throws AppException {
		RandomCommentObjectBO randomCommentObjectBO = (RandomCommentObjectBO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectBOTX");
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
		for (Map data : impDatas) {
			error = new StringBuffer();
			Integer linenum = (Integer) data.get("linenum");
			String pro_code = (String) data.get("pro_code");
			if (StringUtil.isEmpty(pro_code)) {
				error.append("请填写项目编码 ");
			}
			if (!StringUtil.isEmpty(error.toString())) {
				dto = new ImportErrorDTO(fileguid, linenum, error.toString());
				errordao.saveErrorMsg(dto);
				errorlist.add(dto);
			}
		}
		//根据项目编码 校验项目是否可导入
		List<Map<String, Object>> proObjectList = randomCommentObjectBO.getImportProDataList(impDatas,busParams);
		if(proObjectList.size() == 0){
			error = new StringBuffer();
			error.append("所有项目编码在项目库中不存在或不在可选择范围内 ");
			if (!StringUtil.isEmpty(error.toString())) {
				dto = new ImportErrorDTO(fileguid, 0, error.toString());
				errordao.saveErrorMsg(dto);
				errorlist.add(dto);
			}
		}
		if(proObjectList.size() > 0 && errorlist.size() == 0){
			Set<String> proCodes = proObjectList.stream().map(map -> map.get("pro_code").toString()).collect(Collectors.toSet());
			for (Map data : impDatas) {
				error = new StringBuffer();
				Integer linenum = (Integer) data.get("linenum");
				String pro_code = (String) data.get("pro_code");
				if (!proCodes.contains(pro_code)) {
					error.append("项目编码["+pro_code+"]在项目库中不存在或不在可选择范围内 ");
				}
				if (!StringUtil.isEmpty(error.toString())) {
					dto = new ImportErrorDTO(fileguid, linenum, error.toString());
					errordao.saveErrorMsg(dto);
					errorlist.add(dto);
				}
			}
		}
		return errorlist;
	}

	/**
	 * 导入数据入库
	 * @param impDatas
	 * @param impCols
	 * @param tablecode
	 * @param resultList
	 * @param busParams
	 * @throws AppException
	 */
	public void importResultDatas(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
		RandomCommentObjectBO randomCommentObjectBO = (RandomCommentObjectBO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectBOTX");
		RandomCommentObjectDAO randomCommentObjectDAO = (RandomCommentObjectDAO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectDAO");
		String actioncode = "audit";
		String remark = "";
		String workflow = (String) busParams.get("workflow");
		List<Map<String, Object>> proObjectList = randomCommentObjectBO.getImportProDataList(impDatas,busParams);
		if(proObjectList.size() > 0){
			proObjectList.forEach(m->{m.put("isobject","1");m.put("guid",StringUtil.createUUID());}); //提交状态
			randomCommentObjectDAO.saveAll(proObjectList, tablecode); //保存数据
			randomCommentObjectBO.workflow(actioncode, workflow, remark, tablecode, proObjectList); //流转到待提交
			randomCommentObjectBO.workflow(actioncode, workflow, remark, tablecode, proObjectList); //流转到已提交
		}
	}

	/**
	 * 查询可导入选择项目范围数据
	 * @param impDatas
	 * @param busParams
	 * @return
	 * @throws AppException
	 */
	public List<Map<String, Object>> getImportProDataList(List<Map<String, Object>> impDatas, HashMap busParams) throws AppException {
		RandomCommentObjectDAO randomCommentObjectDAO = (RandomCommentObjectDAO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectDAO");
		List<Map<String, Object>> proObjectList;
		List<Map<String, Object>> procodes = new ArrayList<>();
		String bustype = (String) busParams.get("bustype");
		Map<String, Object> pmap;
		for (Object impMap : impDatas) {
			HashMap<String, Object> data = (HashMap<String, Object>) impMap;
			String pro_code = (String) data.get("pro_code");
			pmap = new HashMap<>();
			pmap.put("guid",pro_code);
			procodes.add(pmap);
		}
		logger.info("--------导入 项目code："+procodes.toString());
		randomCommentObjectDAO.saveAll(procodes, randomCommentObjectDAO.PMKPI_TABLE_TMP_GUIDS);
		StringBuffer sql = new StringBuffer(" t.province='").append(SecureUtil.getUserSelectProvince()).append("'").append(" and t.year=").append(SecureUtil.getUserSelectYear());
		sql.append(" and t.ISSCOPE='0' ").append(" and T.ISOBJECT IS NULL ").append(" and T.ISRANDOM IS NULL ").append(" and T.WFSTATUS IS NULL AND T.WFID IS NULL ");
		sql.append(" and t.bustype='").append(bustype).append("' ");
		sql.append(" and exists(select 1 from ").append(randomCommentObjectDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid = t.pro_code ) ");
		proObjectList = randomCommentObjectDAO.getDatas("V_PERF_T_RANDOMCOMMENT_PROJ", sql.toString(), "order by pro_code");
		return proObjectList;
	}

}
