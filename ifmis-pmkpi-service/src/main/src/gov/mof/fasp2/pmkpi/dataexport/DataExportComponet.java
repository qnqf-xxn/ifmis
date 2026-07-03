/**
 * 
 */

package gov.mof.fasp2.pmkpi.dataexport;

import gov.mof.fasp2.buscommon.bill.dao.CommonDAO;
import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.reportexcel.ReportDownComponent;
import gov.mof.fasp2.buscore.framework.rpcfw.mapper.ObjectWriter;
import gov.mof.fasp2.buscore.framework.rpcfw.termial.RCPConsoleManager;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busfw.ui.datatable.IUIDatatableCacheInit;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.pmkpi.dataexport.bo.DataExportFactory;
import gov.mof.fasp2.pmkpi.fileexport.ExcelExportComponet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName: FileUploadService
 * @Description: Description of this class
 * @author <a href="mailto:ranwei@szlongtu.com">冉伟</a>于 2015年7月8日 09:45:46
 */

@PageComponent(serviceid = "busfw.dataexport", viewid = "busfw.dataexport", jsLib = "/busfw/common/ui/ui_dataexport.js", jsObjectName = "Ext.lt.ui.dataexport")
public class DataExportComponet extends ExcelExportComponet {

	@Override
	public Map loadComponent(HttpServletRequest request,
			HttpServletResponse response, Map config) throws Exception {
		// return super.loadComponent(request, response, config);
		return config;
	}

	private static Map<String, Boolean> downFileStatus = new Hashtable<String, Boolean>();

	public boolean getFileStatus(HashMap config) {
		String fileguid = config.get("fileguid").toString();
		return downFileStatus.get(fileguid) == null ? true : downFileStatus
				.get(fileguid);
	}

	/**
	 * 通过导出配置信息 获取菜单 信息
	 *
	 * @param config
	 * @return
	 * @throws Exception
	 */
	private Map getMuniue(HashMap config) throws Exception {
		Map rem = new HashMap();
		Map pageobj = (Map) config.get("pageobj");
		if (pageobj != null && pageobj.get("queryMap") != null) {
			Map queryMap = (Map) pageobj.get("queryMap");
			if (queryMap != null && queryMap.get("urlparameters") != null) {
				Map urlparameters = (Map) queryMap.get("urlparameters");// 获取菜单
				if (urlparameters != null
						&& urlparameters.get("submenu") != null) {
					String submenu = (String) urlparameters.get("submenu");// 获取菜单
																			// 名称
					if (submenu != null
							&& !StringUtils.isEmpty(submenu)) {
						CommonDAO dao = (CommonDAO) ServiceFactory
								.getBean("buscommon.CommonDAO");
						String sql = "select t.* from FASP_T_PUBMENU t where t.guid =? ";
						List list = dao.queryForList(sql,
								new Object[] { urlparameters.get("submenu") });
						if (list.size() == 1) {
							rem = (Map) list.get(0);
						}
					}
				}
			}
		}
		return rem;
	}

	/**
	 * 导出全部
	 */
	@Override
	public InputStream down(HashMap config) throws Exception {
		// added by zhangkai，记录文件id，用于更新文件下载的状态
		if (config.get("fileguid") != null) {// 开始下载时，状态为false
			downFileStatus.put(config.get("fileguid").toString(), false);
		}
		List columnList = (List) config.get("columns");
		// 根据设置的导出类型调用不同的导出方法
		ReportDownComponent ard = (ReportDownComponent) DataExportFactory
				.getDowType((String) config.get("downtype"), this.getRequest(),
						this.getResponse());
		// 设置下载文件名
		ard.setConsole("application/vnd.ms-excel");
		String istitleflag = (String) config.get("istitleflag");
		if (istitleflag!= null
				&& !StringUtils.isEmpty(istitleflag)) {
			StringBuffer title = new StringBuffer();
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
			Map pageobj = this.getMuniue(config);
			title.append(pageobj.get("name"));
			title.append(df.format(new Date()));
			ard.setDowInfo(title.toString());
			config.put("titleflag", title.toString());// 已设置导出文件名标识
		} else if (config.get("titleflag") != null
				&& !"".equals(config.get("titleflag"))) {
			ard.setDowInfo(config.get("titleflag").toString());
			// config.put("titleflag",config.get("titleflag").toString()
			// );//已设置导出文件名标识
		} else {
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
			ard.setDowInfo(df.format(new Date()));
			config.put("titleflag", df.format(new Date()));// 已设置导出文件名标识
		}

		// 获取列配置信息
		// 这里改成缓存取不到直接取数据库
		String key = (String) config.get("key");
		IUIDatatableCacheInit cache = getRemoteDatatableCacheBean();
		List colList = null;
		if (cache != null && cache.get(key) != null
				&& cache.get(key).size() < 0) {
			DatatableDTO tableDTO = (DatatableDTO) cache.get(key).get(0);
			colList = tableDTO.getCols();
			config.put("tablecode", tableDTO.getTablecode());
		} else {
			// 数据库查询UI配置
			List list2 = getUiconfig().query(key);
			DatatableDTO tableDTO1 = (DatatableDTO) list2.get(0);
			colList = tableDTO1.getCols();
			config.put("tablecode", tableDTO1.getTablecode());
		}
		colList = this.reList(colList, columnList);// 根据显示顺序调整排列顺序

		config.put("columns", colList);
		ard.down("", config);
		if (config.get("fileguid") != null) {// 下载完成时，状态为true
			downFileStatus.put(config.get("fileguid").toString(), true);
		}
		return RCPConsoleManager.getConsole(this.getRequest())
				.getFileInputStream();
	}

	/**
	 * 排序（根据显示顺序调整排列顺序）
	 *
	 * @param relist
	 *            排序返回list（数据库字段配置）
	 * @param bylist
	 *            排序根据list（显示顺序)
	 * @return
	 * @throws Exception
	 */
	private List reList(List relist, List bylist) throws Exception {
		if (bylist != null) {
			List list = new ArrayList();
			for (int i = 0; i < bylist.size(); i++) {
				String column = (String) ((Map) bylist.get(i)).get("colcode");
				if ("attach".equals(column)) {
					continue;
				}
				for (int j = 0; j < relist.size(); j++) {
					String col = (String) ((Map) relist.get(j)).get("colcode");
					if (col != null && col.equals(column)) {// 是否相等
						String config = (((Map) relist.get(j)).get("config")).toString();
						if (null != config && !"".equals(config)) {
							ObjectWriter write = new ObjectWriter();
							Map configObj = (Map) write
									.getObjectWithOutStructure(config);
							if (configObj.get("alias") != null
									&& !"".equals(configObj.get("alias")
											.toString())) {
								((Map) relist.get(j)).put("alias", configObj
										.get("alias").toString());
							}
						}

						//把宽度写上
						((Map) relist.get(j)).put("exportwidth",((Map) bylist.get(i)).get("exportwidth"));
						list.add(relist.get(j));
						break;
					}
				}
			}
			relist = list;
		}
		return relist;
	}

	/**
	 * 导出选中
	 */
	@Override
	public InputStream down2(HashMap config) throws Exception {// 导出选中
		// added by zhangkai，记录文件id，用于更新文件下载的状态
		if (config.get("fileguid") != null) {// 开始下载时，状态为false
			downFileStatus.put(config.get("fileguid").toString(), false);
		}

		// 获取前台参数
		Map configMap = (Map) config.get("exportinfo");
		List columnList = (List) config.get("columns");
		List dataList = (List) config.get("datas");
		String tablecode = (String) config.get("tablecode");
		List colList = (List) config.get("colList");

		// 根据设置的导出类型调用不同的导出方法
		ReportDownComponent ard = (ReportDownComponent) DataExportFactory
				.getDowType((String) configMap.get("downtype"),
						this.getRequest(), this.getResponse());
		// 设置下载文件名
		ard.setConsole("application/vnd.ms-excel");
		if (config.get("istitleflag") != null
				&& !"".equals(config.get("istitleflag"))) {
			StringBuffer title = new StringBuffer();
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
			Map pageobj = this.getMuniue(config);
			title.append(pageobj.get("name"));
			title.append(df.format(new Date()));
			ard.setDowInfo(title.toString());
			config.put("titleflag", title.toString());// 已设置导出文件名标识
		} else if (configMap.get("titleflag") != null
				&& !"".equals(configMap.get("titleflag"))) {
			ard.setDowInfo(configMap.get("titleflag").toString());
		} else {
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
			ard.setDowInfo(df.format(new Date()));
			config.put("titleflag", df.format(new Date()));// 已设置导出文件名标识
		}

		// 获取列配置信息
		// 这里改成缓存取不到直接取数据库
		String key = (String) configMap.get("key");// 和 导出全部参数不一样
		IUIDatatableCacheInit cache = getRemoteDatatableCacheBean();
/*
		List colList = null;
		if (cache != null && cache.get(key).size() < 0) {
			DatatableDTO tableDTO = (DatatableDTO) cache.get(key).get(0);
			colList = tableDTO.getCols();
			config.put("tablecode", tableDTO.getTablecode());
		} else {
			// 数据库查询UI配置
			List list2 = getUiconfig().query(key);
			DatatableDTO tableDTO1 = (DatatableDTO) list2.get(0);
			colList = tableDTO1.getCols();
			config.put("tablecode", tableDTO1.getTablecode());
		}
*/
		colList = this.reList(colList, columnList);// 根据显示顺序调整排列顺序

		configMap.put("columns", colList);
		ard.down("", (HashMap) configMap, dataList);
		if (config.get("fileguid") != null) {// 下载完成时，状态为true
			downFileStatus.put(config.get("fileguid").toString(), true);
		}
		return RCPConsoleManager.getConsole(this.getRequest())
				.getFileInputStream();
	}


	public IUIDatatableCacheInit getRemoteDatatableCacheBean() {
		IUIDatatableCacheInit cache = null;
		// 分域部署 业务系统暴露该接口
		Object obj = ServiceFactory
				.getBean("busfw.cacheinit.uicacheinit.uidatatable");
		if (obj != null) {
			cache = (IUIDatatableCacheInit) obj;
		}
		return cache;
	}

}