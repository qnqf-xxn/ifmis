package gov.mof.fasp2.pmkpi.randomComment.controller;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomIndexEditBO;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomProblemEditBO;
import gov.mof.fasp2.pmkpi.randomComment.tab.RandomQualityEditBO;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

;

@Controller
@RequestMapping("/pmkpi/expFileController")
public class ExcelExportController {

	private final static Logger logger = Logger.getLogger(ExcelExportController.class);
	
	@Resource(name = "pmkpi.randomcomment.RandomQualityEditBOTX")
    private RandomQualityEditBO randomQualityEditBO;

    public void setRandomQualityEditBO(RandomQualityEditBO randomQualityEditBO) {
        this.randomQualityEditBO = randomQualityEditBO;
    }
    
    @Resource(name = "pmkpi.randomcomment.RandomIndexEditBOTX")
    private RandomIndexEditBO randomIndexEditBO;

    public void setRandomIndexEditBO(RandomIndexEditBO randomIndexEditBO) {
        this.randomIndexEditBO = randomIndexEditBO;
    }
    
    
    @Resource(name = "pmkpi.randomcomment.RandomProblemEditBOTX")
    private RandomProblemEditBO randomProblemEditBO;

    public void setRandomProblemEditBO(RandomProblemEditBO randomProblemEditBO) {
        this.randomProblemEditBO = randomProblemEditBO;
    }
    
	@RequestMapping(value = "/expFile",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> zipDownload(String[] ids,HttpServletResponse response) throws Exception{
		Map resultmap = new HashMap();
		
		List< Map<String,Object>> datas = new ArrayList<Map<String,Object>>();
		if (ids.length>0){
			for (int i = 0;i<ids.length;i++){
				String data = ids[i];
				data = data.replace("&", ",");
				logger.error("data:"+data);
				if (data!= null && data != ""){
					data = data.substring(1, data.length() - 1);
					data = data.replaceAll("\\\\","");
					 List<Object> lists =JSON.parseArray(data);
				        for (Object object : lists){
				        Map <String,Object> ret = (Map<String, Object>) object;//取出list里面的值转为map
				        datas.add(ret);
				        }
				}
			}
		}


		List<XSSFWorkbook> list = CrateExcel(datas);
		ServletOutputStream outputStream = null;
		ZipOutputStream zipOutputStream = null;
		ByteArrayOutputStream bos = null;
		try {
			
			
/*			String fileName = "xxx表"+".zip";
			response.setContentType( "application/octet-stream ");
			response.setHeader( "Content-Disposition ", "attachment;filename=\""+new String((fileName).getBytes( "UTF-8"), "ISO-8859-1")+"\"");
			outputStream = response.getOutputStream();
*/			
			FileSystemView fsv = FileSystemView.getFileSystemView();
			File com=fsv.getHomeDirectory();
			logger.error(com.getPath());
			File f=new File(com.getPath()+"\\评价结果"+ PerfUtil.getServerTimeStamp() + ".zip");
			zipOutputStream = new ZipOutputStream(f);
			for (int i = 0; i < list.size(); i++) {
				String code = String.valueOf(datas.get(i).get("code"));
				String name = String.valueOf(datas.get(i).get("name"));
				SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		        String data = format.format(new Date());
				ZipEntry zipEntry = new ZipEntry(code+"&"+name+"&"+data+".xlsx");
				zipOutputStream.putNextEntry(zipEntry);
				XSSFWorkbook xss = list.get(i);
				bos = new ByteArrayOutputStream();
				xss.write(bos);
				bos.writeTo(zipOutputStream);
			}
			zipOutputStream.flush();
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} finally {
			if (bos!=null){
				bos.close();
			}
			if (outputStream!=null){
				outputStream.close();
			}
			if (zipOutputStream!=null){
				zipOutputStream.close();
			}
		}
		resultmap.put("success", true);
		return resultmap;
	}
    

	public List<XSSFWorkbook> CrateExcel(List< Map<String,Object>> datas)  throws Exception{
		List<XSSFWorkbook> list = new ArrayList();
		if(datas!= null && datas.size()>0){
			for(int i = 0;i<datas.size();i++){
				Map<String,Object> map = datas.get(i);
				HashMap<String,Object> params = new HashMap<String,Object>();
				params.putAll(map);
				// 创建工作簿
				XSSFWorkbook workbook = new XSSFWorkbook();
				//样式
				XSSFCellStyle style = workbook.createCellStyle();//设置列样式
				XSSFCellStyle style1 = workbook.createCellStyle();//设置列样式
				style.setAlignment(HorizontalAlignment.CENTER);// 水平居中  
				style.setVerticalAlignment(VerticalAlignment.CENTER);// 垂直居中
				//设置边框
				style.setBorderBottom(BorderStyle.THIN); //下边框
				style.setBorderLeft(BorderStyle.THIN);//左边框
				style.setBorderTop(BorderStyle.THIN);//上边框
				style.setBorderRight(BorderStyle.THIN);//右边框
				style.setWrapText(true);//设置自动换行
				//设置背景颜色
				style1.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.getIndex());
				style1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				// 创建sheet页
				XSSFSheet sheet1 = workbook.createSheet("自评质量");
				// 合并列头
				sheet1.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
				// 创建行，存放列名
				XSSFRow row1 = sheet1.createRow(0);
				//设置列宽
				sheet1.setColumnWidth(0, 256*20);
				sheet1.setColumnWidth(1, 256*20);
				sheet1.setColumnWidth(2, 256*6);
				sheet1.setColumnWidth(3, 256*100);
				sheet1.setColumnWidth(4, 256*6);
				sheet1.setColumnWidth(5, 256*50);
				String[] cellName1 = {"评价内容","","分值","评分标准","得分","扣分原因"};
				//设置行高
				row1.setHeight((short)500); 
				for (int y = 0; y < cellName1.length; y++) {
					XSSFCell cell = row1.createCell(y);
					cell.setCellValue(cellName1[y]);
					cell.setCellStyle(style);
				}
				HashMap<String,Object> randomQualityparams = new HashMap<String,Object>();
				randomQualityparams.putAll(params);
				randomQualityparams.put("tablecode", "PERF_V_RANDOMQUALITY");
				randomQualityparams.put("tabcode", "PERF_V_RANDOMQUALITY_TYPE");
				randomQualityparams.put("tabcode1", "PERF_T_RANDOMQUALITY_MENU");
				Map<String, Object> dataMaps = randomQualityEditBO.getDatas(randomQualityparams);
				if(dataMaps != null && dataMaps.size()>0){
					List data = (List) dataMaps.get("data");
					logger.error("ffff"+data);
					//循环写入数据
					String name = null;
					int rownum = 1;
					for(int a = 0;a<data.size();a++){
						XSSFRow row = sheet1.createRow(rownum);
						//设置行高
						row.setHeight((short)1000); 
						//单条数据
						Map dataMap = (Map) data.get(a);
						if(dataMap.size()> 0 &&dataMap!= null){
							String isleaf = (String) dataMap.get("isleaf");
							if(("0").equals(isleaf)){
								//评价内容一级
								name = (String) dataMap.get("qualityname");
								continue;
							}
							String[] cellName = new String[6];
							cellName[0] = name;
							cellName[1] = String.valueOf(dataMap.get("qualityname")).equals("null") ? "":String.valueOf(dataMap.get("qualityname"));
							cellName[2] = String.valueOf(dataMap.get("qualityweight")).equals("null") ? "":String.valueOf(dataMap.get("qualityweight"));
							cellName[3] = String.valueOf(dataMap.get("qualitystand")).equals("null") ? "":String.valueOf(dataMap.get("qualitystand"));
							cellName[4] = String.valueOf(dataMap.get("scroe")).equals("null") ? "":String.valueOf(dataMap.get("scroe"));
							cellName[5] = String.valueOf(dataMap.get("buckle")).equals("null") ? "":String.valueOf(dataMap.get("buckle"));
							for (int y = 0; y < cellName.length; y++) {
								XSSFCell cell = row.createCell(y);
								cell.setCellValue(cellName[y]);
								cell.setCellStyle(style);
								if(y == 4 || y == 5){
									style1.cloneStyleFrom(style);
									style1.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.getIndex());
									style1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
									cell.setCellStyle(style1);
								}
							}
							rownum++;
						}
					}
				}
				XSSFSheet sheet2 = workbook.createSheet("实际绩效");
				// 创建行，存放列名
				XSSFRow row2 = sheet2.createRow(0);
				//设置行高
				row2.setHeight((short)500); 
				String[] cellName2 = {"一级指标","二级指标","三级指标","指标性质","指标值","计量单位","指标权重","抽评核实完成值","抽评得分","备注"};
				for (int y = 0; y < cellName2.length; y++) {
					XSSFCell cell = row2.createCell(y);
					cell.setCellValue(cellName2[y]);
					cell.setCellStyle(style);
				}
				HashMap<String,Object> randomIndexparams = new HashMap<String,Object>();
				randomIndexparams.putAll(params);
				randomIndexparams.put("tablecode", "PERF_T_RANDOMINDEX");
				randomIndexparams.put("tabcode", "PERF_T_PROJPERFINDEX");
				Map<String, Object> randomIndexMaps = randomIndexEditBO.getDatas(randomIndexparams);
				if(randomIndexMaps != null && randomIndexMaps.size()>0){
					List data = (List) randomIndexMaps.get("data");
					logger.error("ffff"+data);
					//循环写入数据
					int rownum = 1;
					String findex = null;
					String sindex = null;
					String name = null;
					for(int a = 0;a<data.size();a++){
						XSSFRow row = sheet2.createRow(rownum);
						//设置行高
						row.setHeight((short)500); 
						//单条数据
						Map dataMap = (Map) data.get(a);
						if(dataMap.size()> 0 &&dataMap!= null){
							Integer levelno = Integer.parseInt(dataMap.get("levelno").toString());
							logger.error("级次"+levelno);
							if(levelno == 1){
								//一级指标
								findex = (String) dataMap.get("name");
								sindex = null;
								name = null;
							}else if(levelno == 2){
								//二级指标
								sindex = (String) dataMap.get("name");
								name = null;
							}else{
								name = (String) dataMap.get("name");
							}
							String[] cellName = new String[10];
							cellName[0] = findex;
							cellName[1] = sindex;
							cellName[2] = name;
							cellName[3] = String.valueOf(dataMap.get("COMPUTESIGN")).equals("null") ? "":String.valueOf(dataMap.get("COMPUTESIGN"));
							cellName[4] = String.valueOf(dataMap.get("INDEXVAL")).equals("null") ? "":String.valueOf(dataMap.get("INDEXVAL"));
							cellName[5] = String.valueOf(dataMap.get("METERUNIT")).equals("null") ? "":String.valueOf(dataMap.get("METERUNIT"));
							cellName[6] = String.valueOf(dataMap.get("WEIGHT")).equals("null") ? "":String.valueOf(dataMap.get("WEIGHT"));
							cellName[7] = String.valueOf(dataMap.get("ACTUALVALUE")).equals("null") ? "":String.valueOf(dataMap.get("ACTUALVALUE"));
							cellName[8] = String.valueOf(dataMap.get("SCORE")).equals("null") ? "":String.valueOf(dataMap.get("SCORE"));
							cellName[9] = String.valueOf(dataMap.get("REMARKS")).equals("null") ? "":String.valueOf(dataMap.get("REMARKS"));
							for (int y = 0; y < cellName.length; y++) {
								//设置列宽
								sheet2.setColumnWidth(y, 256*10);
								XSSFCell cell = row.createCell(y);
								cell.setCellValue(cellName[y]);
								cell.setCellStyle(style);
							}
							rownum++;
						}
					}
				}
				XSSFSheet sheet3 = workbook.createSheet("抽评发现的问题");
				//设置列宽
				sheet3.setColumnWidth(0, 256*25);
				sheet3.setColumnWidth(1, 256*100);
				// 创建行，存放列名
				XSSFRow row3 = sheet3.createRow(0);
				//设置行高
				row3.setHeight((short)1500); 
				XSSFCell cell = row3.createCell(0);
				cell.setCellValue("抽评发现的问题");
				cell.setCellStyle(style);
				Map<String, Object> randomProblemMaps = randomProblemEditBO.getDatas(params);
				XSSFCell cell1 = row3.createCell(1);
				if(randomProblemMaps != null && randomProblemMaps.size()>0){
					cell1.setCellValue(String.valueOf(randomProblemMaps.get("REMARKS")).equals("null") ? "":String.valueOf(randomProblemMaps.get("REMARKS")));
					cell1.setCellStyle(style);
				}
				/**
				 * 写文件
				 */
				//获取电脑桌面位置
				list.add(workbook);
				
//				FileSystemView fsv = FileSystemView.getFileSystemView();
//				File com=fsv.getHomeDirectory();
//				logger.error(com.getPath());
//				File f=new File(com.getPath()+"\\aaaaaaaaaaaaaaaaaa.xlsx");
//				FileOutputStream fos;
//				try {
//					fos = new FileOutputStream(f);
//					workbook.write(fos);
//					fos.close();
//					} catch (FileNotFoundException e) {
//					logger.error(e.getMessage(), e);
//					} catch (IOException e) {
//					logger.error(e.getMessage(), e);
//					}
			}
		}
		//resultmap.put("success", true);
		return list;

	}
	
	


}
