package gov.mof.fasp2.pmkpi.dataexport.service;

import gov.mof.fasp2.pmkpi.dataexport.component.AbstractExport;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.List;
import java.util.Map;

public class TestExport extends AbstractExport {
	public static final String DICCOLUMN = "fasp_t_diccolumn";
	public static final String EXPORTCOLSETTABLE = "FW_T_EXPORTCOLSET";

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Object> findData(ExportTemplateDTO dto) {

		if (dto != null) {
			String sql = "select ftd.columncode from " + DICCOLUMN + " ftd , "
					+ EXPORTCOLSETTABLE
					+ " fte where fte.columnid=ftd.columnid and fte.tempid='"
					+ dto.get("guid") + "' order by fte.ordernum";
			List list = this.queryForList(sql);

			if (list != null && list.size() != 0) {
				StringBuffer sb = new StringBuffer();
				Map map = null;
				for (int i = 0; i < list.size(); i++) {
					map = (Map) list.get(i);
					sb.append((String) map.get("columncode"));
					sb.append(",");
				}
				sb.replace((sb.length() - 1), sb.length(), "");
				String sql2 = "select " + sb + " from " + dto.get("datasource")
						+ " where rownum<=3";
				List list2 = this.queryForList(sql2);
				if (list2.size() > 0) {
					return list2;

				}
			}
		}
		return null;

	}

}
