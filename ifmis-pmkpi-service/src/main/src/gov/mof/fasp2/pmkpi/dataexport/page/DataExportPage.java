package gov.mof.fasp2.pmkpi.dataexport.page;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.server.AbstractPageService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busdic.dataset.appexception.DataSetAppException;
import gov.mof.fasp2.pmkpi.dataexport.dto.SysappDTO;
import gov.mof.fasp2.pmkpi.dataexport.service.ISysappService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: DataImportPage
 * @Description: Description of this class
 * @author <a href="mailto:kangjinshun@szlongtu.com">康金顺</a>于 2015-8-3
 */
public class DataExportPage extends AbstractPageService {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PageConsole(appid = "common", url = "/common/dataexport/index", page = "/busfw/common/template/template_defautl.jsp", pageTempltate = @PageTemplate(funcShow = "Ext.lt.ui.template"), region = "maindiv", config = "{header:[header],main:[toolbutton,queryform,uidatatable,dataExportComponent],heights:[38,null,null,0]}", component = {
			@PageComponent(serviceid = "header", id = "header", config = "{location:'系统管理>>数据导出'}"),
			@PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
			@PageComponent(serviceid = "buslefttree", id = "lefttree"),
			@PageComponent(serviceid = "busqueryform", id = "queryform"),
			@PageComponent(serviceid = "busuidatatable", id = "uidatatable", config = "{title:'数据导出管理',edit:false,checkbox:true}"),
			@PageComponent(serviceid = "buseditform", id = "editform", config = "{columnsize:1}"),
			@PageComponent(serviceid = "busfw.dataexport.dataExportComponent", id = "dataExportComponent") }, jslib = "/busfw/common/ui/ui_tabpanelbutton.js,/busfw/ltext/kindeditor/kindeditor-min.js,/busfw/ltext/kindeditor/lang/zh_CN.js", csslib = "/busfw/ltext/kindeditor/themes/default/default.css")
	public Map dataExportManageIndex(HttpServletRequest request,
			HttpServletResponse response, Map config) throws Exception {
		request.setAttribute("leftconfig", getTreeConfig());
		config.put("left", "lefttree");
		return config;
	}

	/*
	 * 设置列
	 */
	@SuppressWarnings("rawtypes")
	@PageConsole(appid = "common", url = "/common/dataexport/setcol", page = "/busfw/common/template/template_defautl.jsp", pageTempltate = @PageTemplate(funcShow = "Ext.lt.ui.template"), region = "maindiv", config = "{main:[toolbutton,uidatatable,colSetComponent],heights:[38,null,0]}", component = {
			@PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
			@PageComponent(serviceid = "busuidatatable", id = "uidatatable", config = "{edit:false,checkbox:true}"),
			@PageComponent(serviceid = "busfw.dataexport.colSetComponent", id = "colSetComponent") }, jslib = "/busfw/common/ui/ui_tabpanelbutton.js,/busfw/ltext/kindeditor/kindeditor-min.js,/busfw/ltext/kindeditor/lang/zh_CN.js", csslib = "/busfw/ltext/kindeditor/themes/default/default.css")
	public Map addIndi2(HttpServletRequest request,
			HttpServletResponse response, Map config) throws Exception {
		return config;
	}

	/**
	 * @Description:获取树的设置
	 * @return Map<String, Object>
	 * @throws AppException
	 *             异常信息
	 */

	private Map<String, Object> getTreeConfig() throws DataSetAppException,
			AppException {
		Map<String, Object> leftconfig = new HashMap<String, Object>();
		List<Object> list = new ArrayList<Object>();

		ISysappService sysappService = (ISysappService) ServiceFactory
				.getBean("busfw.dataexport.sysappService");

		List<SysappDTO> sysapp = sysappService.getAllSysapps();
		if (sysapp != null) {
			for (SysappDTO sys : sysapp) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("guid", sys.get("appid"));
				map.put("name", sys.get("appname"));
				list.add(map);
			}
		}
		leftconfig.put("dosearch", Boolean.FALSE);
		leftconfig.put("showRootNode", Boolean.TRUE);
		leftconfig.put("name", "业务类型");
		leftconfig.put("datas", list);
		leftconfig.put("linkchild", true);
		leftconfig.put("clickexpand", Boolean.TRUE);
		leftconfig.put("outformart", "#code-#name");
		return leftconfig;
	}

}