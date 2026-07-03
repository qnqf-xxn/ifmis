package gov.mof.fasp2.pmkpi.bigdataview.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.bigdataview.dao.BigdataViewDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.*;


public class BigdataViewBO extends PmkpiBO {

	private BigdataViewDAO bigdataViewDAO;

	public void setBigdataViewDAO(BigdataViewDAO bigdataViewDAO) {
		this.bigdataViewDAO = bigdataViewDAO;
	}

	/*监控大屏--开始*/
	/**
	 *查询初始化数据
	 * @return
	 */
	public Map<String, Object> getTraceInintData(){
		Map<String, Object> returnmap = new HashMap<>();
		//A1-A4
		List<Map<String, Object>> alist = bigdataViewDAO.getDatas("perf_v_dvtraceinfo",null,null);
		if(alist.size()>0){
			returnmap.putAll(alist.get(0));
		}
		//C-2上报情况分析
		List<Map<String, Object>> c2list = bigdataViewDAO.getDatas("perf_v_dvtracereportinfo",null,null);
		if(c2list.size()>0){
			returnmap.putAll(c2list.get(0));
		}
		return returnmap;
	}

	/**
	 *B-1部门监控完成系数排名
	 * @return
	 */
	public List<Map<String, Object>> getTraceDeptDeviateListData(String desc){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		String table = "perf_v_dvtracedeptbgtget";
		if("1".equals(desc)){
			table = "perf_v_dvtracedeptbgtgetdesc";
		}
		List<Map<String, Object>> list = bigdataViewDAO.getDatas(table,"ROWNUM < 6",null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}

	/**
	 *B-2报送及时性分析 改 拟调整预算资金项目情况
	 * @return
	 */
	public List<Map<String, Object>> getTraceProjectReportData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> list = bigdataViewDAO.getDatas("perf_v_dvtracedeptreport",null,null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}

	/**
	 *C-1指标偏离度
	 * @return
	 */
	public List<Map<String, Object>> getTraceIndexDeviateListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> c1list = bigdataViewDAO.getDatas("perf_v_dvtraceindexdeviate",null,null);
		if(c1list.size()>0){
			returnlist = c1list;
		}
		return returnlist;
	}

	/**
	 *D-1部门报送情况 改 项目监控整体情况汇总表
	 * @return
	 */
	public List<Map<String, Object>> getTraceDeptWarnData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvtracedeptwarn",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}
	/**
	 *E-1 项目偏差原因情况分析
	 * @return
	 */
	public List<Map<String, Object>> getProjproblemData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> list = bigdataViewDAO.getDatas("perf_v_dvtraceproblem",null,null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}

	/*监控大屏--结束*/

	/*自评大屏--开始*/
	/**
	 *B-1 预算执行率分布图
	 * 体现预算执行率低于30%，30%-60%，60%-80%，80%-100%和100%的项目分布占比
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalBgtgetRate(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> list = bigdataViewDAO.getDatas("perf_v_dvevalselfbgtrate",null,null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}

	/**
	 *B-2 自评情况分析
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalEvalListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> list = bigdataViewDAO.getDatas("perf_v_dvevalselfdeptscore","ROWNUM < 6",null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}

	/**
	 *查询文本数据A1-A3
	 * @return
	 */
	public Map<String, Object> getSelfevalTextData(){
		Map<String, Object> returnmap = new HashMap<>();
		List<Map<String, Object>> alist = bigdataViewDAO.getDatas("perf_v_dvevalselfinfo",null,null);
		if(alist.size()>0){
			returnmap.putAll(alist.get(0));
		}
		return returnmap;
	}

	/**
	 *C-1 各项指标完成度
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalIndexListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvevalselfindex",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}

	/**
	 *C-2 绩效指标调整率分析
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalIndexAdjListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvevalselfindexadjfx",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}

	/**
	 *C-4 绩效指标调整率分析
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalIndexAdjListData2(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvevalselfindexadjfx2",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}

	/**
	 *C-3 绩效指标调整率
	 * @return
	 */
	public List<Map<String, Object>> getSelfevalIndexAdjRateListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvevalselfindexadj",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}
	/*自评大屏--结束*/

	/*对比大屏--开始*/
	/**
	 *A-1 监控纳入自评情况对比
	 * @return
	 */
	public List<Map<String, Object>> getDbfxInevalListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvdbinevalrate",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}
	/**
	 *查询文本数据B1-B6
	 * @return
	 */
	public Map<String, Object> getDbfxTextData(){
		Map<String, Object> returnmap = new HashMap<>();
		List<Map<String, Object>> alist = bigdataViewDAO.getDatas("perf_v_dvdbinfo",null,null);
		if(alist.size()>0){
			returnmap.putAll(alist.get(0));
		}
		return returnmap;
	}
	/**
	 *C-1 监控、自评情况对比
	 * @return
	 */
	public List<Map<String, Object>> getDbfxInevalRateListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> list = bigdataViewDAO.getDatas("perf_v_dvdballinevalrate",null,null);
		if(list.size()>0){
			returnlist = list;
		}
		return returnlist;
	}
	/**
	 *D-1  监控、自评运行情况统计
	 * @return
	 */
	public List<Map<String, Object>> getDbfxAnalysisListData(){
		List<Map<String, Object>> returnlist = new ArrayList<>();
		List<Map<String, Object>> d1list = bigdataViewDAO.getDatas("perf_v_dvdbanalysis",null,null);
		if(d1list.size()>0){
			returnlist = d1list;
		}
		return returnlist;
	}
	/*对比大屏--结束*/

	/**
	 * 查询列表
	 * @param sqlmap
	 * @return
	 * @throws AppException
	 */
	@Override
	public String getVodSql(Map sqlmap) throws AppException {
		String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
		String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
		String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
		String tablecode = (String)sqlmap.get("tablecode");
		String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
		String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
		String deptcode = (String) sqlmap.get("deptcode");//数据分析大屏跳转-只查询本部门数据
		String queryyear = (String) sqlmap.get("queryyear");
		StringBuffer returnsql = new StringBuffer("select t.* from ").append(tablecode).append(" t where t.year =").append(queryyear);
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
		returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, bigdataViewDAO.PMKPI_TABLE_T_AGENCY));
		if(!StringUtil.isEmpty(deptcode)){//数据分析大屏跳转-只查询本部门数据
			returnsql.append(" and t." + columncode + " like '" + deptcode + "%'");
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
		String tablecode = (String) params.get("tablecode");
		String deptcode = (String) params.get("deptcode");
		String queryyear = (String) params.get("queryyear");
		String datarule = "t.year = "+queryyear;
		if(!StringUtil.isEmpty(deptcode)){
			datarule +=" and t.agencyguid like '" + deptcode + "%'";
		}
		return bigdataViewDAO.getLeftTree(tablecode, datarule);
	}
}
