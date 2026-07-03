/**
 * @ClassName: BusTreelistAgencyTableComponet.java
 * @Description: Description of this class
 * @author <a href="mailto:kangjinshun@szlongtu.com">康金顺</a>于 2017年11月20日下午3:43:51
 */
package gov.mof.fasp2.pmkpi.common.componet;

import gov.mof.fasp2.buscommon.ui.datatable.BusTreelistDataTableComponet;
import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PageComponent(serviceid = "busuigencytreelistadatatable", viewid = "busuigencytreelistadatatable", 
					jsLib = "/busfw/ltext/datatable3.0.js," +
							"/busfw/ltext/editdatatable.js," +
							"/busfw/common/busui/bus_datatable.js," +
							"/busfw/common/busui/bus_commondatatable.js," +
							"/busfw/common/busui/bus_treelistdatatable.js", jsObjectName = "Ext.lt.bus.ui.treelistdatatable")
public class BusAgencyTreelistTableComponet extends
		BusTreelistDataTableComponet {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map queryData(HashMap paramMap) throws AppException {
		Map<String, Object> result = super.queryData(paramMap);
		List datalist = (List) result.get("datalist");
//		Map<Integer, String> agencyLevelMap = new HashMap<Integer, String>();
		paramMap.put("datas", datalist);
		Map<String, Map> mapperdata = getMapperData(paramMap);
		return mapperdata;
	}

}
