package gov.mof.fasp2.pmkpi.dataexport.bo;

import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.reportexcel.ReportDownComponent;
import org.apache.poi.ss.usermodel.Sheet;

import java.io.File;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 导出实现类
 * @ClassName: ExportTxt
 * @Description: Description of this class
 * @author <a href="mailto:ranwei@szlongtu.com">冉伟</a>于 2015年7月8日 21:26:11
 */
//public class ExportTxt extends AbstractReportDown {
public class DataExportTxt extends ReportDownComponent {

	protected static Logger logger = Logger.getLogger(DataExportTxt.class);

	public static final String SUFFIX = ".txt";

	@Override
	public List<Map> loadData(int page, Map config) {

		return null;
	}

	@Override
	public String getFileSuffix() {
		return SUFFIX;
	}

	/**
	 * 数据 载入及 处理()
	 * 
	 * @param page
	 * @param config
	 * @param dataList
	 * @return
	 */
	public List<Map> loadData(int page, Map config, List dataList) {

		return null;
	}

	/**
	 * 
	 * @param code
	 * @param w
	 * @param datalist
	 * @throws Exception
	 */
	public void down(String code, HashMap w, List datalist) throws Exception {
		final double process = 0.01;
		consoleSetProcess(process);
		consolePrintln("正在初始化数据");
		Map m = getConfig(code, w);
		String filename = this.getFileName(m);
		this.setDowInfo(filename);

		consolePrintln("获取文件路径");
		File docFile = this.getPathFile();
		exportFile(docFile, filename, m, datalist);
		consolePrintln("文件压缩完成");
		consolePrintln("删除Excel文件");
		consoleSetProcess(1);
		consolePrintln("创建File文件完成");
	}

	/**
	 * 创建导出文件
	 * 
	 * @param docFile
	 * @param filename
	 * @param config
	 * @param dataList
	 * @return
	 * @throws Exception
	 */
	public File exportFile(File docFile, String filename, Map config,
			List dataList) throws Exception {
		consolePrintln("开始创建Excel文件");
//		File file = createFile();
		OutputStream out = this.getConsoleOutputStream();
		consolePrintln("开始压缩数据文件");
		substitute(out, config, dataList);
		out.flush();
		out.close();
		return null;
	}

	public void substitute(OutputStream out, Map config, List dataList)
			throws Exception {
		// 列间隔符
		String colspacing = ",";
		if (config.get("colspacing") != null) {
			colspacing = (String) config.get("colspacing");
		}
		// 行间隔符
		String rowspacing = ".";
		if (config.get("rowspacing") != null) {
			rowspacing = (String) config.get("rowspacing");
		}
		List<Map> allCol = (List<Map>) config.get("columns");
		{
			String sb = this.setCol(allCol, config);
			out.write(sb.getBytes());
		}
		int rn = 0;
		List<Map> data = dataList;
		for(Map contentMap : data) {
			rn++;
			StringBuffer sbu = new StringBuffer();
			for (int i = 0; i < allCol.size(); i++) {
				Map col = (Map) allCol.get(i);
				String v = contentMap.get(col.get("name")) != null ? contentMap.get(col.get("name")).toString() : "";
				sbu.append(v);
				sbu.append( colspacing );
			}
			sbu.append( rowspacing );
			out.write(sbu.toString().getBytes());
		}
		logger.error("共导出数据："+rn+"条");
		consolePrintln("共导出数据："+rn+"条");
		/*
		int page = 0;
		List<Map> data = null;
		while ((data = this.loadData(page, config, dataList)) != null) {
			page++;
			rn = this.setData(sheet, data, allCol, rn, config);

		}*/
	}

	// 设置列头
	public String setCol(List<Map> allCol, Map config) {
		// 列间隔符
		String colspacing = ",";
		if (config.get("colspacing") != null) {
			colspacing = (String) config.get("colspacing");
		}
		// 行间隔符
		String rowspacing = ".";
		if (config.get("rowspacing") != null) {
			rowspacing = (String) config.get("rowspacing");
		}
		StringBuffer sb = new StringBuffer();
		for (Map col : allCol) {
			if (col.get("alias") != null && col.get("alias").toString().length() > 0) {
				sb.append((String) col.get("alias"));
			} else {
				sb.append((String) col.get("colcode"));
			}
			sb.append(colspacing);
		}
		sb.append(rowspacing);
		return sb.toString();
	}

	/**
	 * 新建文件方法
	 * 
	 * @return
	 * @throws Exception
	 */
	public File createFile() throws Exception {
		return null;
	}

	/**
	 * 
	 * @param docFile
	 * @param filename
	 * @param config
	 * @param dataList
	 * @return
	 * @throws Exception
	 */
	public File afterCreateFile(File docFile, String filename, Map config,
			List dataList) throws Exception {

		return null;
	}

	@Override
	public void setValuelSingle(Sheet sheet, Map config, List allCol,
			Map contentMap, int rownum) throws Exception {
		
		super.setValuelSingle(sheet, config, allCol, contentMap, rownum);
	}

}