
package gov.mof.fasp2.pmkpi.dataexport.bo;

import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.reportexcel.ReportDown2007Component4XML;
import gov.mof.fasp2.buscore.framework.reportexcel.ReportDownComponent;
import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.busfw.fileexport.bo.IExcelExport;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;

;

public class DataExport2003 extends ReportDownComponent implements IExcelExport {

	/**
	 * @Fields logger : Description
	 */
	private static final Logger LOGGER = Logger.getLogger(ReportDown2007Component4XML.class);

	public DataExportSupport dataExportSupport = new DataExportSupport();

	@Override
	public List<Map> loadData(int page, Map config) {
		return dataExportSupport.loadData(page, config);
	}

	@Override
	public String getFileName(Map config) {
		return dataExportSupport.getFileName(config);
	}

	@Override
	public List<Map> loadData(int page, Map config, List dataList) {
		return dataExportSupport.loadData(page, config, dataList);
	}

	/**
	 * 设置 表头
	 */
	@Override
	public int setCol(Sheet sheet, List allCol, Map config) {
		int num = 0;
		num = dealHead(sheet, allCol, config);
		config.put("headnum", num);
		headN = num;
		return num;
	}

	public int dealHead(Sheet sheet, List colsList) {
		return dealHead(sheet, colsList, new HashMap());
	}

	public static void setCellBorder(CellStyle style) {
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());

		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());

		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());

		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	}
	
	private static Map<Workbook, CellStyle> emptyCellStyle = new HashMap<Workbook, CellStyle>();


	public static void setCellBorder(Cell cell) {
		if(emptyCellStyle.get(cell.getSheet().getWorkbook())==null) {
			emptyCellStyle.put(cell.getSheet().getWorkbook(), cell.getSheet().getWorkbook().createCellStyle());
		}
		CellStyle style = emptyCellStyle.get(cell.getSheet().getWorkbook());
		setCellBorder(style);
		cell.setCellStyle(style);
	}

	/**
	 * @Description: 处理表头 @param sheet 页签对象 @param colsList 列集合 @return
	 *               返回表头层数 @throws
	 */
	public int dealHead(Sheet sheet, List colsList, Map config) {
		int size = 0;// 表头行数
		// 最大的 表头行数
		for (int i = 0; i < colsList.size(); i++) {
			Map col = (Map) colsList.get(i);
			Object obj = col.get("head");// 表头
			if (obj != null) {
				String[] head = obj.toString().split(",");// 表头
				if (head.length > size) {
					size = head.length;
				}
			}
		}
		size++;// 添加一条简单表头
		for (int i = 0; i < size; i++) {// 创建行对象
			sheet.createRow(i);//
		}
		{
			Row r = sheet.getRow(size - 1);// 表头最后一行
			for (int i = 0; i < colsList.size(); i++) {
				Map row = (Map) colsList.get(i);
				String alias = (String) row.get("alias");
				Cell cell = r.createCell(i + 1);
				setCellBorder(cell);
				cell.setCellValue(new HSSFRichTextString(alias));
				String rowstr = row.get("exportwidth") == null ? null : row.get("exportwidth").toString();
				if (StringUtils.isNotEmpty(rowstr)) {
					LOGGER.info("列" + alias + "的宽度为" + rowstr);
					if (!"0".equals(rowstr)) {
						int width = Integer.parseInt(rowstr);
						if (width > 8 * 255) {
							width = 8 * 255;
						}
						int poiWidth = width / 8 * 256;
						sheet.setColumnWidth(i + 1, poiWidth);
					}

				}
			}
		}
		for (int i = 0; i < size; i++) {// 补充序号头
			Row r = sheet.getRow(i);
			Cell c = r.createCell(0);
			setCellBorder(c);
			c.setCellValue("序号");
		}
		if (size > 1) {// 多条头
			for (int i = 0; i < colsList.size(); i++) {
//                List head = (List) ((Map) colsList.get(i)).get("head");
				List head = new ArrayList();
				Object obj = ((Map) colsList.get(i)).get("head");
				if (obj != null) {
					String str = obj.toString();
					str = str.replaceAll("'", "");
					str = str.replace("[", "");
					str = str.replace("]", "");
					head.addAll(Arrays.asList(str.split(",")));// 获取表头数据 输出 list
				}
				if (head.size() < size - 1) {// 当前表头行数少于 多表头最大值
					for (int h = head.size(); h < size - 1; h++) {// 补齐表头
						if (head.size() == 0)// 当前列 没有多表头设置
							head.add(((Map) colsList.get(i)).get("alias"));// 添加列名
						else {
//                    		head.add(head.get(head.size()-1));//添加上一级表头名称
							// 增加最后一级表头
							Row r = sheet.getRow(size - 1);// 表头最后一行
							Cell cell = r.getCell(i + 1);
							head.add(0, cell.getRichStringCellValue().toString());
						}
					}
				}
				for (int j = 0; j < head.size(); j++) {
					Row r = sheet.getRow(size - j - 2);
					Cell cell = r.createCell(i + 1);
					setCellBorder(cell);
					cell.setCellValue(new HSSFRichTextString((String) head.get(j)));
				}
			}
			merger(sheet, colsList, size);
		}
		boolean showTotal = Boolean.parseBoolean(GlobalConfig.getConfigData("BUSCOMMON_EXPORT_TOTAL", "false"));
		if (showTotal) {
			// 检查是否有合计行
			if (config.get("totalamt") != null) {
				Map totalamt = (Map) config.get("totalamt");
				sheet.createRow(size);
				Row r = sheet.getRow(size);
				Cell c = r.createCell(0);
				setCellBorder(c);
				c.setCellValue("合计");
				CellStyle cellStyle = makeDoubleCellStyle(sheet.getWorkbook());
				for (int i = 0; i < colsList.size(); i++) {
					Map row = (Map) colsList.get(i);
					String alias = (String) row.get("alias");
					Cell cell = r.createCell(i + 1);
					setCellBorder(cell);
					// colcode=tjamt,totaltag=0
					if ("1".equals(row.get("totaltag") + "")) {
						if (totalamt.containsKey(row.get("colcode").toString())) {
							setDoubleCell(totalamt.get(row.get("colcode").toString()).toString(), cell, cellStyle);
						}
					}
				}
				size++;
			}
		}
		sheet.createFreezePane(0, sheet.getPhysicalNumberOfRows());// 锁定 表头 （从0到表头结束）
		return size;
	}

	private void merger(Sheet sheet, List colsList, int size) {
//    	boolean[][] cells = new boolean[colsList.size()][size-1];
		// colsList.size()+1是由于多了一列序号
		// size是表头行数
		boolean[][] cells = new boolean[colsList.size() + 1][size];
		for (int i = 0; i < cells.length; i++) {
			for (int j = 0; j < cells[i].length; j++) {
				if (cells[i][j] == false) {
					merger(sheet, cells, i, j);
				}
			}
		}
	}

	private void merger(Sheet sheet, boolean[][] cells, int column, int row) {
		// 当前点的数据
		String value = sheet.getRow(row).getCell(column).getRichStringCellValue().toString();
		// 查看当前点右侧的数据
		int heng = 0;
		if (column + heng + 1 < cells.length) {// 右侧还有点
			String hengValue = sheet.getRow(row).getCell(column + heng + 1).getRichStringCellValue().toString();
			while (value.equals(hengValue)) {
				heng++;
				if (row + heng + 1 < cells.length) {// 右侧还有点
					hengValue = sheet.getRow(row).getCell(column + heng + 1) == null ? null
							: sheet.getRow(row).getCell(column + heng + 1).getRichStringCellValue().toString();
				} else {
					break;
				}
			}
		}

		// 查看当前点下侧的数据
		int shu = 0;
		if (row + shu + 1 < cells[row].length) {// 下侧还有点
			String shuValue = sheet.getRow(row + shu + 1).getCell(column).getRichStringCellValue().toString();
			while (value.equals(shuValue)) {
				shu++;
				if (row + shu + 1 < cells[row].length) {// 下侧还有点
					shuValue = sheet.getRow(row + shu + 1).getCell(column) == null ? null
							: sheet.getRow(row + shu + 1).getCell(column).getRichStringCellValue().toString();
				} else {
					break;
				}
			}
		}

		// 合并单元格，
		if (heng != 0 || shu != 0) {
			sheet.addMergedRegion(new CellRangeAddress(row, row + shu, column, column + heng));
			// added by zhangkai 重新设置合并行的值
			Cell cell = sheet.getRow(row).getCell(column);
			cell.setCellValue(value);
			// 设置居中样式
			cell.getCellStyle().setAlignment(HorizontalAlignment.CENTER);
			cell.getCellStyle().setVerticalAlignment(VerticalAlignment.CENTER);
			// 将cells设置为ture
			for (int i = 0; i <= heng; i++) {
				for (int j = 0; j <= shu; j++) {
					// 设置为已经处理
					cells[column + i][row + j] = true;
				}
			}
		} else {
			// 设置为已经处理
			cells[column][row] = true;
		}
	}

	@SuppressWarnings({ "rawtypes", "unused" })
	@Override
	public int setData(Sheet sheet, List<Map> list, List allCol, int rn, Map config) throws Exception {
		int headnum = Integer.valueOf(config.get("headnum").toString());
		// added by zhk,271026,
		// Bug 53276 - 政府采购>>采购计划>>直接支付计划>>编辑
		// 增加表格居右的设置
		CellStyle numcellstyle = sheet.getWorkbook().createCellStyle();
		numcellstyle.setAlignment(HorizontalAlignment.CENTER);
		if (list != null && list.size() > 0) {
			for (Map m : list) {
				rn++;
				// if(true){//编号
				// Row row = sheet.createRow(rn-1);
				// Cell cell = row.createCell(0);
				// cell.setCellValue(rn-headnum);
				// }
				this.setValuelSingle(sheet, config, allCol, m, rn);
			}
		}
		return rn;
	}

	/**
	 * 表头的行数
	 */
	private int headN = 0;

	private void setDoubleCell(String v, Cell c, CellStyle cellStyle) {
		c.setCellStyle(cellStyle);
		if (v == null ||"null".equalsIgnoreCase(v)|| v.length() == 0) {
			c.setCellValue(0d);
			return;
		}
//        	v="24691357802469.87";
		String number = "" + v;
		if (number.indexOf(".") < 0) {
			number = v + ".00";
		} else if (number.indexOf(".") == number.length() - 2) {
			// edited by zhangkai,对于v="60843420.1"时出现的bug， Double.parseDouble(v)得到的结果为科学记数法
			double d = Double.parseDouble(v);
			String s = new DecimalFormat("#.0").format(d);
			number = s + "0";
//                number = Double.parseDouble(v)+ "0";
		}
		BigDecimal b = new BigDecimal(number);
		// 置成千分位
//            DecimalFormat df = new DecimalFormat("#,##0.00");
//            c.setCellValue(df.format(b).toString());
		// edited by zhangkai,使用double数值，这样生成表格列可以合计
		c.setCellValue(b.doubleValue());
	}

	private CellStyle makeDoubleCellStyle(Workbook workbook) {
		CellStyle cellStype = workbook.createCellStyle();
		// 设置单元格样式为数值形式
		cellStype.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		cellStype.setAlignment(HorizontalAlignment.RIGHT);// 靠右
		return cellStype;
	}

	/**
	 * 设置 EXCEL中每行 数据
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void setValuelSingle(Sheet sheet, Map config, List allCol, Map contentMap, int rownum) throws Exception {
		Row row = sheet.createRow(rownum - 1);
		Workbook workbook = (Workbook) sheet.getWorkbook();
		CellStyle[] cellStyles = (CellStyle[]) config.get("cellStyles");
		if (cellStyles == null) {
			cellStyles = new CellStyle[allCol.size()];
			config.put("cellStyles", cellStyles);
		}

		Cell cell = row.createCell(0);
		setCellBorder(cell);
		// edited by zhangkai ,170816
		// bug52254 【业务公用-系统检测】系统检测执行页面导出excel，导出数据excel的序号和页面的序号不一致
		// 使用前台传入的_locationposition作为序号的值
		if (contentMap.get("_sortid") != null) {
			try {
				// 前台序号从0开始传入，故需要+1
				cell.setCellValue(Integer.parseInt(contentMap.get("_sortid").toString()) + 1);
			} catch (RuntimeException e) {
				LOGGER.error("导出时获取的序号_sortid值有误:" + contentMap.get("_sortid").toString());
				cell.setCellValue(rownum - headN);
			}
		} else if (contentMap.get("_locationposition") != null) {
			try {
				// 前台序号从0开始传入，故需要+1
				cell.setCellValue(Integer.parseInt(contentMap.get("_locationposition").toString()) + 1);
			} catch (RuntimeException e) {
				LOGGER.error("导出时获取的序号_locationposition值有误:" + contentMap.get("_locationposition").toString());
				cell.setCellValue(rownum - headN);
			}
		} else {
			cell.setCellValue(rownum - headN);
		}
		for (int i = 0; i < allCol.size(); i++) {
			Map col = (Map) allCol.get(i);
			Cell c = row.createCell(i + 1);
			String v = contentMap.get(col.get("colcode")) != null ? contentMap.get(col.get("colcode")).toString() : "";
			if ("N".equals(col.get("datatype"))) {
				// 金额类型的表格使用居右样式
				if (v == null || v.length() == 0) {
					c.setCellValue(0d);
				}

				CellStyle cellStype = cellStyles[i];
				if (cellStype == null) {
					cellStype = workbook.createCellStyle();
					cellStype.setAlignment(HorizontalAlignment.RIGHT);// 靠右
					setCellBorder(cellStype);
					cellStyles[i] = cellStype;
				}
				c.setCellStyle(cellStype);
				try {
					c.setCellValue(Double.parseDouble(v));
				} catch (Exception e) {
					c.setCellValue(0d);
//                    LOGGER.error("rownum:" + rownum + " colname:" + col.get("name") + " value:" + v, e);
				}
			} else if ("amt".equals(col.get("datatype")) || "A".equals(col.get("datatype"))
					|| "amt".equals(col.get("type"))) {// 数据类型：资金类型(2015年12月7日16:31:36)
				CellStyle cellStype = null;
				if (cellStyles[i] == null) {
					cellStype = makeDoubleCellStyle(workbook);
					setCellBorder(cellStype);
					cellStyles[i] = cellStype;
				}
				cellStype = cellStyles[i];
				try {
					setDoubleCell(v, c, cellStype);
				} catch (Exception e) {
					c.setCellValue(0d);
					LOGGER.error("rownum:" + rownum + " colname:" + col.get("name") + " value:" + v, e);
				}
			} else {
				if (v != null && v.indexOf("\r\n") > -1) {
					CellStyle cellStype = cellStyles[i];
					if (cellStype == null) {
						cellStype = workbook.createCellStyle();
						cellStype.setWrapText(true);
						setCellBorder(cellStype);
						cellStyles[i] = cellStype;
					}
					c.setCellStyle(cellStype);
				} else {
					setCellBorder(c);
				}
				c.setCellType(CellType.STRING);
				if (v == null || StringUtils.isEmpty(v.trim()) || "null".equals(v.trim())) {
					c.setCellValue("");
				} else {
					c.setCellValue(v);
				}
			}
		}
	}
}