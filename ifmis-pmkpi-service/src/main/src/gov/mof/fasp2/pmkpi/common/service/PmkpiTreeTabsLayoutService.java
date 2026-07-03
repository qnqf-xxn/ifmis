package gov.mof.fasp2.pmkpi.common.service;


import gov.mof.fasp2.buscommon.bill.dto.BillDTO;
import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.bo.PmkpiTabsCommonBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PageComponent(serviceid = "pmkpi.PmkpiTreeTabsLayoutService", viewid = "budget.BudgetTreeTabLayoutService"
,jsLib = "/busfw/common/ui/ui_toolbuttonbar.js," +
		"/busfw/common/busui/bus_toolbuttonbar.js"
		+ ",/busfw/ltext/datatable3.0.js," +
		"/busfw/ltext/editdatatable.js," +
		"/busfw/common/busui/bus_datatable.js"
		+ ",/busfw/ltext/formulas.js," +
		"/datacommon/common/formulasdatatable.js," +
		"/datacommon/common/common.js"
		+ ",/datacommon/fill/baseedittable.js," +
		"/datacommon/fill/formulasedittable.js," +
		"/datacommon/fill/infoedittable.js"	
		+ ",/busfw/common/ui/ui_poptree.js," +
		"/busfw/common/ui/ui_editpanel.js," +
			"/busfw/common/ui/ui_editformpanel.js," +
			"/busfw/common/busui/bus_editformpanel.js"
		+ ",/busfw/common/ui/ui_querypanel.js," +
		"/busfw/common/busui/bus_querypanel.js"
		+ ",/busfw/common/ui/ui_tabpanelbutton.js"
		+ ",/pmkpi/common/editformpanel.js," +
		"/busfw/common/busui/bus_commondatatable.js," +
		"/busfw/common/busui/bus_treelistdatatable.js," +
		"/busfw/ltext/groupbydatatable.js,/busfw/common/busui/bus_treelistcolumn.js,/datacommon/fill/halfinfoedittable.js,/datacommon/fill/halfformulasedittable.js,/datacommon/fill/rowtocoledittable.js,/datacommon/fill/dcdatatable.js,"+
		"/datacommon/base/datacommon.js," +
		"/pmkpi/common/commondsbutton.js?V=10001," + 
		"/pmkpi/common/pmkpitreetabslayout.js",
		jsObjectName = "Ext.lt.pmkpitreetabs.layout.index")
public class PmkpiTreeTabsLayoutService extends AbstractComponentService {

	private PmkpiTabsCommonBO pmkpiTabsCommonBO;

	protected PmkpiTabsCommonBO getPmkpiTabsCommonBO() {
		if (pmkpiTabsCommonBO == null) {
			pmkpiTabsCommonBO  = (PmkpiTabsCommonBO) ServiceFactory.getBean("pmkpi.PmkpiTabsCommonBO");
		}
		return pmkpiTabsCommonBO;
	}

	@Override
	@SuppressWarnings("rawtypes")
	public Map loadComponent(HttpServletRequest request,
			HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
		return config;
	}
	
	public List<BillDTO> findTabs(HashMap param) throws AppException{
		String tabs = (String) param.get("tabs");
		return this.getPmkpiTabsCommonBO().findTabs(tabs);
	}	
	
	public Map findForm(HashMap param) throws AppException{
		String formid = (String) param.get("formid");
		Map map = new HashMap();
		List list = this.getPmkpiTabsCommonBO().findForm(formid);
		if(list!=null && list.size() > 0){
			map = (Map)list.get(0);
		}
		return map;
	}
	
	public Map findField(HashMap param) throws AppException{
		String formid = (String) param.get("formid");
		Map map = this.getPmkpiTabsCommonBO().findField(formid);
		return map;
	}
	
	public List selWpInfo(HashMap param){
		String keyguid = (String) param.get("keyguid");
		String formid = (String) param.get("formid");
		return this.getPmkpiTabsCommonBO().selWpInfo(keyguid,formid);
		
	}
	
	/**
	 * 保存项目绩效目标信息
	 * @param config
	 * @return
	 * @throws AppException
	 */
	public Map save(HashMap config) throws AppException{
		return this.getPmkpiTabsCommonBO().save(config);
	}
}
