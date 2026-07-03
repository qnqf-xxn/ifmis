package gov.mof.fasp2.pmkpi.randomComment.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomIndexEditBO;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomProblemEditBO;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomQualityEditBO;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomQualityEditDAO;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;


@Controller
@RequestMapping("/pmkpi/fileController")
public class ExcleImportController {
	@Resource(name = "pmkpi.randomcomment.RandomQualityEditBOTX")
    private RandomQualityEditBO randomQualityEditBO;
	@Resource(name = "pmkpi.randomcomment.RandomIndexEditBOTX")
    private RandomIndexEditBO randomIndexEditBO;
	@Resource(name = "pmkpi.randomcomment.RandomProblemEditBOTX")
    private RandomProblemEditBO randomProblemEditBO;
	@Resource(name = "pmkpi.randomcomment.RandomQualityEditDAO")
    private RandomQualityEditDAO randomQualityEditDAO;

	protected static Logger logger = Logger.getLogger(ExcleImportController.class);
    /**
     * 用于接收前端上传文件
     * @param request
     * @param file
     */
	
	@RequestMapping(value = "/fileUpload",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> fileUpload1(HttpServletRequest request, HttpServletResponse response) throws PerfAppException{
		Map<String, Object> rs = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = null;
		if (request instanceof MultipartHttpServletRequest) {
			multipartRequest = (MultipartHttpServletRequest) (request);
			Iterator<String> iter = multipartRequest.getFileNames();
			// 菜单
			String menuid = multipartRequest.getParameter("menuid");
			// 获得文件：  
			MultipartFile file = (MultipartFile) multipartRequest.getFile(iter.next()); 
			String fileName = file.getOriginalFilename();
			//String[] split = fileName.split("\\.");
			//String[] nameSplit = split[0].split("-");
			String[] nameSplit = fileName.split("\\.")[0].split("&");
			//FileInputStream fis = null;
			InputStream fis = null;
			Workbook wookbook = null;
			try {
				// 获取一个绝对地址的流
				fis = file.getInputStream();

				//fis = new FileInputStream(file);
			} catch (IOException e) {
				logger.error(e.getMessage(), e);
				rs.put("error", true);
				rs.put("code", "解析文件流异常");
				return rs;
			}
			try {
				// 2003版本的excel，用.xls结尾
				wookbook = new HSSFWorkbook(fis);// 得到工作簿
			} catch (Exception ex) {
				// ex.printStackTrace();
				try {
					// 这里需要重新获取流对象，因为前面的异常导致了流的关闭
					fis = file.getInputStream();
					// 2007版本的excel，用.xlsx结尾
					wookbook = new XSSFWorkbook(fis);// 得到工作簿
				} catch (IOException e) {
					// TODO Auto-generated catch block
					logger.error(e.getMessage(), e);
					rs.put("error", true);
					rs.put("code", "解析工作簿异常");
					return rs;
				}
			}
			// 查询项目是否存在
			List<Map<String, Object>> forList = randomQualityEditDAO.getDataList("V_PERF_T_RANDOMCOMMENT_PROJ", "t.pro_code = '"+nameSplit[0]+"'");
			if(forList.size() > 0){
				Map proj = (Map) forList.get(0);
				String bustype = (String) proj.get("bustype");
		    	String mainguid =(String) proj.get("selfguid");
				// 获取第一个sheet 自评质量
				/*Sheet sheet1 = wookbook.getSheetAt(0);
				if(sheet1 != null){
					List<Map<String, Object>>  qualityList = new ArrayList();
			    	String wheresql = " t.menuid = '"+menuid+"' and t.bustype = '"+bustype+"' ";
					// 获取质量模板
					List<Map<String, Object>> quality = randomQualityEditDAO.getDataList("PERF_T_RANDOMQUALITY_MENU", wheresql);
					if(quality.size() > 0){
			        	Map<String, Object> map = quality.get(0);
			        	String code = (String) map.get("code");
			        	String wheresq2 = " t.code = '"+code+"' and t.bustype = '"+bustype+"'";
			        	qualityList = randomQualityEditDAO.getDatas("PERF_V_RANDOMQUALITY_TYPE", wheresq2, "order by ordernum");
					} else {
						rs.put("error", true);
						rs.put("code", "未配置质量模板！");
						return rs;
					}
					if(qualityList.size() > 0){
						HashMap<String, Object> params = new HashMap<String, Object>();
						List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
						params.put("tablecode","PERF_T_RANDOMQUALITY_SCORE");
						params.put("mainguid",mainguid);
						params.put("busguid",null);
						for (int i = 0; i < qualityList.size(); i++) {
							Map<String, Object> map = qualityList.get(i);
							// 过滤 只拿叶子节点匹配
							if("1".equals(map.get("isleaf"))){
								//sheet1.getPhysicalNumberOfRows();//得到所有的行
								// 忽略表头，从第一行开始
//								int rows = sheet1.getPhysicalNumberOfRows();
								for (int j = 1; j < sheet1.getPhysicalNumberOfRows(); j++) {
									XSSFRow row = (XSSFRow) sheet1.getRow(j);
									String scroe = "0";
									String buckle = "";
									if(row.getCell(4,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK)!=null){
										row.getCell(4,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
										scroe = row.getCell(4,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
									}
									if(row.getCell(5,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK)!=null){
										row.getCell(5,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
										buckle = row.getCell(5,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
									}
									if(row.getCell(1,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK)!=null){
								        row.getCell(1,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
										String cellValue = row.getCell(1,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
										String qualityname = (String) map.get("qualityname");
										if(cellValue == null || "".equals(cellValue)){
											Map<String, Object> qualityMap = new HashMap<String, Object>();
											qualityMap.put("guid", (String)map.get("guid"));
											qualityMap.put("mainguid", (String)map.get("guid"));
											qualityMap.put("scroe", scroe);
											qualityMap.put("buckle", buckle);
											qualityMap.put("bustype", bustype);
											datas.add(qualityMap);
										}else {
											if((qualityname).equals(cellValue)){
												Map<String, Object> qualityMap = new HashMap<String, Object>();
												qualityMap.put("guid", (String)map.get("guid"));
												qualityMap.put("mainguid", (String)map.get("guid"));
												qualityMap.put("scroe", scroe);
												qualityMap.put("buckle", buckle);
												qualityMap.put("bustype", bustype);
												datas.add(qualityMap);
												break;
											}
										}
									}
								}
							} else {
								Map<String, Object> qualityMap = new HashMap<String, Object>();
								qualityMap.put("guid", (String)map.get("guid"));
								qualityMap.put("mainguid", (String)map.get("guid"));
								qualityMap.put("scroe", null);
								qualityMap.put("buckle", null);
								qualityMap.put("bustype", bustype);
								datas.add(qualityMap);
							}
							
						}
						params.put("datas",datas);
						try {
							Map<String, Object> saveQual = randomQualityEditBO.saveQual(params);
						} catch (AppException e) {
							// TODO Auto-generated catch block
							logger.error(e.getMessage(), e);
							rs.put("error", true);
							rs.put("code", "自评质量保存异常！");
							return rs;
						}
						
					} else {
						rs.put("error", true);
						rs.put("code", "配置的质量模板为空！");
						return rs;
					}

				} else {
					rs.put("error", true);
					rs.put("code", "自评质量sheet页为空");
				}

				// 获取第一个sheet 实际绩效
				Sheet sheet2 = wookbook.getSheetAt(1);
				if(sheet2 != null){
					HashMap<String, Object> params = new HashMap<String, Object>();
					List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
					params.put("tablecode","PERF_T_RANDOMINDEX");
					params.put("mainguid",mainguid);
					params.put("busguid",null);
					//sheet2.getPhysicalNumberOfRows();//得到所有的行
					// 忽略表头，从第一行开始
					int ofRows = sheet2.getPhysicalNumberOfRows();//得到所有的行
					logger.error("------------------"+ofRows);
					String iname = null; // 一级指标名称
					for (int i = 1; i < sheet2.getPhysicalNumberOfRows(); i++) {
						XSSFRow row = (XSSFRow) sheet2.getRow(i);
						if (row != null) { 
							if(row.getCell(0,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
								row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
							}
								String aname = row.getCell(0,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
							// 如果一级指标为空，不做操作
							if(!StringUtil.isEmpty(aname)){
								String superid = null;
								String tname = null;  // 二级指标名称
								
								// 循环一到三级指标
								for (int j = 0; j < 3; j++) {
									
									Map<String, Object> indexMap = new HashMap<String, Object>();
									String guid = null;
									String indexName = null;
									logger.error("-------------"+j);
									if(row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
										row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
									}
										indexName = row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
									List<Map<String, Object>> indexList = randomQualityEditDAO.getDataList("PERF_T_PROJPERFINDEX", "name = '"+indexName+"'");
							    	// 指标是否存在，存在取指标id否则生成指标id
							    	if(indexList.size() > 0){
							    		Map map = (Map) indexList.get(0);
							    		guid = (String) map.get("guid");
							    	} else {
							    		guid = StringUtil.createUUID();
							    	}
							    	if(row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK)!=null){
										String name = null; // 指标名称
										String computesign = null;
										String indexval = null;
										String meterunit = null;
										int weight = 0;
										String actualvalue = null;
										String score = null;
										String indexremark = null;
										String sname = null; // 二级指标名称
										
										if(row.getCell(2,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
											row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
										}
											sname = row.getCell(2,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
										// 三级指标不存在的情况，不处理数据
										if(!StringUtil.isEmpty(sname)){
											if (row.getCell(3,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {//CREATE_NULL_AS_BLANK
												row.getCell(3, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												computesign = row.getCell(3,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
											if (row.getCell(4,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(4, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												indexval = row.getCell(4,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();

											if (row.getCell(5,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(5, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												meterunit = row.getCell(5,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();

											if (row.getCell(6,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(6, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.NUMERIC);
											}
												weight = (int) row.getCell(6,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getNumericCellValue();

											if (row.getCell(7,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(7, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												actualvalue = row.getCell(7,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();

											if (row.getCell(8,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(8, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												score = row.getCell(8,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();

											if (row.getCell(9,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(9, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												indexremark = row.getCell(9,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
										}
										if(j==0){
											if(row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
											name = row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
											// 多个相同的一级级指标只存一次
											if(!name.equals(iname)){
												indexMap.put("guid", guid);
												indexMap.put("name", name);
												indexMap.put("sindex", "");
												indexMap.put("superid", "");
												indexMap.put("status", 1);
												indexMap.put("groupkey", "superid");
												indexMap.put("isleaf", "0");
												indexMap.put("levelno", "1");
												indexMap.put("indexval", "");
												indexMap.put("computesign", "");
												indexMap.put("meterunit", "");
												indexMap.put("actualvalue", "");
												indexMap.put("weight", 0.00);
												indexMap.put("score", "");
												indexMap.put("indexremark", "");
												superid = guid;
												iname = name;
												datas.add(indexMap);
											}
										}else if(j==1){
											if(row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												name = row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
											// 多个相同的二级指标只存一次
											if(!name.equals(tname)){
												// 判断二级指标是否存在下级指标，存在不可录入，不存在可录入数据
												if(sname != null && !"".equals(sname)){
													indexMap.put("groupkey", "superid");
													indexMap.put("isleaf", "0");
													indexMap.put("indexval", "");
													indexMap.put("computesign", "");
													indexMap.put("meterunit", "");
													indexMap.put("actualvalue", "");
													indexMap.put("weight", 0.00);
													indexMap.put("score", "");
													indexMap.put("indexremark", "");
												} else {
													indexMap.put("groupkey", "");
													indexMap.put("isleaf", "1");
													indexMap.put("indexval", indexval);
													indexMap.put("computesign", computesign);
													indexMap.put("meterunit", meterunit);
													indexMap.put("actualvalue", actualvalue);
													indexMap.put("weight", weight);
													indexMap.put("score", score);
													indexMap.put("indexremark", indexremark);
												}
												indexMap.put("guid", guid);
												indexMap.put("name", name);
												indexMap.put("sindex", superid);
												indexMap.put("superid", superid);
												indexMap.put("levelno", "2");
												indexMap.put("status", 1);
												superid = guid;
												tname = name;
												datas.add(indexMap);
											}
										}else if(j==2){
											if(row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
												row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
											}
												name = row.getCell(j,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
											if(StringUtil.isEmpty(name)){
												indexMap.put("guid", guid);
												indexMap.put("name", name);
												indexMap.put("sindex", superid);
												indexMap.put("superid", superid);
												indexMap.put("levelno", "3");
												indexMap.put("status", 1);
												indexMap.put("groupkey", "");
												indexMap.put("isleaf", "1");
												indexMap.put("indexval", indexval);
												indexMap.put("computesign", computesign);
												indexMap.put("meterunit", meterunit);
												indexMap.put("actualvalue", actualvalue);
												indexMap.put("weight", weight);
												indexMap.put("score", score);
												indexMap.put("indexremark", indexremark);
												datas.add(indexMap);
											}
										}
									}
								}	
							}	
						}
					}
					params.put("datas", datas);
					try {
						Map<String, Object> saveIndex = randomIndexEditBO.saveIndex(params);
					} catch (AppException e) {
						// TODO Auto-generated catch block
						logger.error(e.getMessage(), e);
						rs.put("error", true);
						rs.put("code", "实际绩效保存异常！");
						return rs;
					}
				} else {
					rs.put("error", true);
					rs.put("code", "实际绩效sheet页为空");
				}
				*/

				// 获取第一个sheet 抽评发现的问题
				Sheet sheet3 = wookbook.getSheetAt(0);
				if(sheet3 != null){
					XSSFRow row = (XSSFRow) sheet3.getRow(1);
					HashMap<String, Object> params = new HashMap<String, Object>();
					List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
					params.put("tablecode","PERF_T_RANDOMPROBLEM");
					params.put("mainguid",mainguid);
					params.put("busguid",null);
					if(row != null){
						String cellValue = null;
						String cellValue1 = "0";
						String cellValue2 = "";
						if (row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
							row.getCell(0, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
						}
						cellValue = row.getCell(0,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
						if (row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
							row.getCell(1, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
						}
						cellValue1 = row.getCell(1,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
						if (row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK) != null) {
							row.getCell(2, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).setCellType(CellType.STRING);
						}
						cellValue2 = row.getCell(2,Row.MissingCellPolicy.CREATE_NULL_AS_BLANK).getStringCellValue();
						Map<String, Object> proMap = new HashMap<String, Object>();
						proMap.put("guid", null);
						proMap.put("vcol1", cellValue);
						proMap.put("vcol2", cellValue1);
						proMap.put("vcol3", cellValue2);
						datas.add(proMap);
						params.put("datas", datas);
					}
					try {
						Map<String, Object> savePro = randomProblemEditBO.savePro(params);
					} catch (AppException e) {
						// TODO Auto-generated catch block
						logger.error(e.getMessage(), e);
						rs.put("error", true);
						rs.put("code", "抽评发现的问题保存异常！");
						return rs;
					}
				} else {
					rs.put("error", true);
					rs.put("code", "抽评发现的问题sheet页为空");
					return rs;
				}
			} else {
				rs.put("error", true);
				rs.put("code", "项目不存在");
				return rs;
			}

		}
		rs.put("success", true);
		rs.put("code", "完成导入");
		return rs;
		
	}
  
}
