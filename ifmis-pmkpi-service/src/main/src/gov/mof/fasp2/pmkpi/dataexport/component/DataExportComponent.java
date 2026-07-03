package gov.mof.fasp2.pmkpi.dataexport.component;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.dataexport.common.GlobalVariables;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;
import gov.mof.fasp2.pmkpi.dataexport.service.IDataExportService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: DataExportComponent
 * @Description: Description of this class
 * @author <a href="mailto:kangjinshun@szlongtu.com">康金顺</a>于 2015-8-3
 */
@PageComponent(serviceid = "busfw.dataexport.dataExportComponent", viewid = "busfw.dataexport.dataExportComponent", id = "dataExportComponent", jsLib = "/buscommon/dataexport/dataexport.js", jsObjectName = "Ext.lt.dataexport.dataChange")
public class DataExportComponent extends AbstractComponentService {

	private IDataExportService iDataExportService;

	private IDataExportService getDataExportService() {
		if (iDataExportService == null) {
			return (IDataExportService) ServiceFactory.getBean("busfw.dataexport.dataExportService");
		}
		return iDataExportService;
	}

	/**
	 * 保存模板
	 */
	public boolean saveTemp(HashMap<String, Object> map) throws AppException {

		// 新增之前检查模板ID是否存在，如果存在则不能进行添加
		if (getDataExportService().checkRepeat(map)) {
			return false;
		} else {
			ExportTemplateDTO exportTemplateDTO = new ExportTemplateDTO();
			exportTemplateDTO.putAll(map);
			String guid = StringUtil.createUUID();
			exportTemplateDTO.setGuid(guid);
			getDataExportService().saveTemp(exportTemplateDTO);
			return true;
		}

	}

	public boolean updateTemp(HashMap<String, Object> map) throws AppException {
		String guid = (String) map.get("guid");
		ExportTemplateDTO dto = getDataExportService().getExportTemplateDTO(
				guid);
		String code1 = map.get("code").toString();// 页面传
		String code2 = dto.get("code").toString();// 通过guid查
		// 修改之前检查模板ID是否存在，如果存在则不能进行添加
		if (getDataExportService().checkRepeat(map) && !code1.equals(code2)) {
			return false;
		} else {
			dto.putAll(map);
			getDataExportService().updateTemp(dto);
			return true;
		}

	}

	public void deleteTemp(HashMap<String, Object> map) throws AppException {
		getDataExportService().deleteTemp(map.get("guids").toString());
	}

	/**
	 * 导出
	 * 
	 * @param rs
	 * @throws Exception
	 */
	public void downFile(HashMap rs) throws Exception {
		// 根据config传入的模板id找到对应的记录保存到dto对象中
		ExportTemplateDTO dto = new ExportTemplateDTO();
		dto.putAll(rs);
		dto.putAll(getDataExportService().findExportTemplate((String) rs.get("tempid")));
//		dto = getDataExportService().findExportTemplate((String) rs.get("tempid"));
		if (dto != null) {
			// 获得所有列字段
			Object[] allCol = getDataExportService().findAllCol(dto);
			// 获得要导出的数据保存在dataList集合中
			List<Object> dataList = null;
			// 在此处判断是否有导出条件以及beanid,如果有beanid 则按照给出的beanid 来取数据dataList
			String beanid = String.valueOf(dto.get("resultset"));
			if ("null".equals(beanid) || StringUtils.isEmpty(beanid.trim())) {
				dataList = getDataExportService().findDBtable(dto);
			} else {
				AbstractExport abstractexport = (AbstractExport) ServiceFactory
						.getBean(beanid);
				if (abstractexport != null) {
					dataList = abstractexport.findData(dto);
				}
			}
			// 获得所有为是的标题
			HttpServletResponse response = this.getResponse();
			response.setCharacterEncoding("UTF-8");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			OutputStream os = response.getOutputStream();// 取得输出流
			if (dto.get("datasource") != null) {
				String name = String.valueOf(dto.get("name"));
				String newNname = new String(name.getBytes("gb2312"),
						"iso8859-1");
				if ("TXT".equalsIgnoreCase(dto.get("type").toString())) {
					// 假设导出类型为TXT
					response.setContentType("text/plain");
					response.setHeader(
							"Content-Disposition",
							"attachment; filename=" + newNname + "-"
									+ sdf.format(new Date()) + ".txt");
					exportTxt(os, dataList, allCol, dto);

				} else if ("EXCEL".equalsIgnoreCase(dto.get("type").toString())) {

					// 导出类型为Excel
					response.setHeader(
							"Content-Disposition",
							"attachment; filename=\"" + newNname + "-"
									+ sdf.format(new Date()) + ".xls\"");
					response.setContentType("application/vnd.ms-excel");
					exportExcel(os, dataList, allCol, dto);
				}
			}
			os.flush();
			os.close();

		}

	}

	// 导出Excel表格
	@SuppressWarnings("rawtypes")
	public void exportExcel(OutputStream os, List<Object> dataList,
			Object[] allCol, ExportTemplateDTO dto) throws Exception {
		HSSFWorkbook wb = new HSSFWorkbook();
		try {
			HSSFSheet sheet = wb.createSheet();
			HSSFRow row = null;
			HSSFCell cell = null;
			Map map = new HashMap();
			boolean flag = false;
			String title = String.valueOf(dto.get("title"));
			if ("是".equals(title)) {
				// 创建标题
				flag = true;
				if (allCol != null) {
					row = sheet.createRow(0);
					for (int k = 0; k < allCol.length; k++) {
						cell = row.createCell(k);
						cell.setCellValue(String.valueOf(allCol[k]));
					}
				}

			}
			// 创建表格数据
			if (dataList != null) {
				for (int i = 0; i < dataList.size(); i++) {
					map = (Map) dataList.get(i);
					// 有标题则从第一行创建，否则从第0行开始创建
					row = sheet.createRow(flag ? i + 1 : i);
					Object[] key = map.keySet().toArray();

					for (int j = 0; j < key.length; j++) {
						cell = row.createCell(j);
						cell.setCellValue(String.valueOf(map.get(key[j])));
					}
				}

			}
			wb.write(os);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(wb != null){
				wb.close();
			}
		}

	}

	// 导出Txt格式
	@SuppressWarnings("rawtypes")
	public void exportTxt(OutputStream os, List<Object> dataList,
			Object[] allCol, ExportTemplateDTO dto) throws Exception {
		BufferedOutputStream buff = null;
		Map map = new HashMap();
		StringBuffer write = new StringBuffer();
 		buff = new BufferedOutputStream(os);
		String signs = String.valueOf(dto.get("sign"));
		String sign= GlobalVariables.translate(Integer.parseInt(signs));
		String title = String.valueOf(dto.get("title"));
		String islock = String.valueOf(dto.get("encryption"));
		if ("是".equals(title)) {
			// 创建字段名称
			if (allCol != null) {
				for (int k = 0; k < allCol.length; k++) {
					write.append(allCol[k] + sign);
				}
				write.replace((write.length() - sign.length()), write.length(),
						"");
				write.append("\r\n");
			}
		}
		if (dataList != null) {
			// 创建数据
			for (int i = 0; i < dataList.size(); i++) {
				map = (Map) dataList.get(i);
				Object[] key2 = map.keySet().toArray();

				for (int j = 0; j < key2.length; j++) {
					String str = ""+ map.get(key2[j]) ;
					if("NULL".equals(str.toUpperCase()) ) {
						str = "";//null 转  ''
					}
					str = str.replaceAll(" ", "");//去除空格
					write.append(str+ sign);
//					write.append(map.get(key2[j]) + sign);
				}
				write.replace((write.length() - sign.length()), write.length(),
						"");
				write.append("\r\n");
			}
		}
		if(islock==null||"否".equals(islock.trim())){
			buff.write(write.toString().getBytes("UTF-8"));
		}else{
			//否则按照加密算法进行加密
			buff.write(write.toString().getBytes("UTF-8"));
		}
		buff.flush();
		buff.close();

	}

}