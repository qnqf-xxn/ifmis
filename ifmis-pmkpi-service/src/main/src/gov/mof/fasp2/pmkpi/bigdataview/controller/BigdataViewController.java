package gov.mof.fasp2.pmkpi.bigdataview.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.bigdataview.bo.BigdataViewBO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



@Controller
@RequestMapping("/pmkpi/bigdataview")
public class BigdataViewController {
	@Resource(name = "pmkpi.bigdataview.BigdataViewBOTX")
	private BigdataViewBO bigdataViewBO;

	private final static Logger logger = Logger.getLogger(BigdataViewController.class);

	/*监控大屏--开始*/
	/**
	 *查询文本数据A1-A4 C-2上报情况分析
	 * @return
	 */
	@RequestMapping(value = "/trace/getTextData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTraceTextData(){
		return bigdataViewBO.getTraceInintData();
	}

	/**
	 *B-1部门监控完成系数排名 改为 部门全年预计执行情况
	 * @return
	 */
	@RequestMapping(value = "/trace/getDeptDeviateListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTraceDeptDeviateListData(@RequestBody String desc){
		Map<String, Object> rs = new HashMap<String, Object>();
		List xAxis = new ArrayList();
		List series1 = new ArrayList();
		List series2 = new ArrayList();
		List deptcodes = new ArrayList();
		List<Map<String,Object>> option = bigdataViewBO.getTraceDeptDeviateListData(desc);
		if(option.size() > 0){
			for (int i = 0; i < option.size(); i++) {
				Map<String, Object> map = option.get(i);
				deptcodes.add(map.get("dept_code"));
				xAxis.add(map.get("dept_name"));
				series1.add(map.get("yearbgtget"));
				series2.add(map.get("bgtget"));
			}
		}
		rs.put("deptcodes", deptcodes);
		rs.put("xAxis", xAxis);
		rs.put("series1", series1);
		rs.put("series2", series2);
		return rs;
	}

	/**
	 *B-2报送及时性分析
	 * @return
	 */
	@RequestMapping(value = "/trace/getProjectReportData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTraceProjectReportData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getTraceProjectReportData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *C-1指标偏离度
	 * @return
	 */
	@RequestMapping(value = "/trace/getIndexDeviateListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTraceIndexDeviateListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getTraceIndexDeviateListData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *D-1部门报送情况
	 * @return
	 */
	@RequestMapping(value = "/trace/getDeptWarnData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTraceDeptWarnData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getTraceDeptWarnData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *E-1 项目偏差原因情况分析
	 * @return
	 */
	@RequestMapping(value = "/trace/getProjproblemData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getProjproblemData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List divnames = new ArrayList();
		List divscores = new ArrayList();
		List<Map<String,Object>> option = bigdataViewBO.getProjproblemData();
		if(option.size() > 0){
			for (int i = 0; i < option.size(); i++) {
				Map<String, Object> map = option.get(i);
				divnames.add(map.get("name"));
				Map<String,Object> scoremap = new HashMap<>();
				scoremap.put("name",map.get("name"));
				scoremap.put("value",map.get("countc"));
				divscores.add(scoremap);
			}
		}
		rs.put("divnames", divnames);
		rs.put("divscores", divscores);
		return rs;
	}
	/*监控大屏--结束*/

	/*自评大屏--开始*/

	/**
	 *查询文本数据A1-A3
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getTextData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalTextData(){
		return bigdataViewBO.getSelfevalTextData();
	}

	/**
	 *B-1 预算执行率分布图
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getBgtgetRate",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalBgtgetRate(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List divnames = new ArrayList();
		List divscores = new ArrayList();
		List divcodes = new ArrayList();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalBgtgetRate();
		if(option.size() > 0){
			for (int i = 0; i < option.size(); i++) {
				Map<String, Object> map = option.get(i);
				divcodes.add(map.get("ratecode"));
				divnames.add(map.get("ratename"));
				Map<String,Object> scoremap = new HashMap<>();
				scoremap.put("name",map.get("ratename"));
				scoremap.put("value",map.get("ratecount"));
				divscores.add(scoremap);
			}
		}
		rs.put("divcodes", divcodes);
		rs.put("divnames", divnames);
		rs.put("divscores", divscores);
		return rs;
	}

	/**
	 *B-2 自评情况分析
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getEvalListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalEvalListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalEvalListData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *C-1 各项指标完成度
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getIndexListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalIndexListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalIndexListData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *C-2 绩效指标调整率分析
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getIndexAdjListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalIndexAdjListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalIndexAdjListData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *C-4 绩效指标调整率分析
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getIndexAdjListData2",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalIndexAdjListData2(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalIndexAdjListData2();
		rs.put("option", option);
		return rs;
	}

	/**
	 *C-3 绩效指标调整率
	 * @return
	 */
	@RequestMapping(value = "/selfeval/getIndexAdjRateListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSelfevalIndexAdjRateListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getSelfevalIndexAdjRateListData();
		rs.put("option", option);
		return rs;
	}
	/*自评大屏--结束*/

	/*对比大屏--开始*/
	/**
	 *A-1 监控纳入自评情况对比
	 * @return
	 */
	@RequestMapping(value = "/dbfx/getInevalListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDbfxInevalListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getDbfxInevalListData();
		rs.put("option", option);
		return rs;
	}

	/**
	 *查询文本数据B1-B6
	 * @return
	 */
	@RequestMapping(value = "/dbfx/getTextData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDbfxTextData(){
		return bigdataViewBO.getDbfxTextData();
	}

	/**
	 *C-1 监控、自评情况对比
	 * @return
	 */
	@RequestMapping(value = "/dbfx/getInevalRateListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDbfxInevalRateListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List xAxis = new ArrayList();
		List series1 = new ArrayList();
		List series2 = new ArrayList();
		List series3 = new ArrayList();
		List years = new ArrayList();
		List<Map<String,Object>> option = bigdataViewBO.getDbfxInevalRateListData();
		if(option.size() > 0){
			for (int i = 0; i < option.size(); i++) {
				Map<String, Object> map = option.get(i);
				years.add(map.get("year"));
				xAxis.add(map.get("year"));
				series1.add(map.get("traceprocount"));
				series2.add(map.get("evalselfprocount"));
				series3.add(map.get("inevalrate"));
			}
		}
		rs.put("years", years);
		rs.put("xAxis", xAxis);
		rs.put("series1", series1);
		rs.put("series2", series2);
		rs.put("series3", series3);
		return rs;
	}

	/**
	 *D-1  监控、自评运行情况统计
	 * @return
	 */
	@RequestMapping(value = "/dbfx/getAnalysisListData",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDbfxAnalysisListData(){
		Map<String, Object> rs = new HashMap<String, Object>();
		List<Map<String,Object>> option = bigdataViewBO.getDbfxAnalysisListData();
		rs.put("option", option);
		return rs;
	}
	/*对比大屏--结束*/
}



