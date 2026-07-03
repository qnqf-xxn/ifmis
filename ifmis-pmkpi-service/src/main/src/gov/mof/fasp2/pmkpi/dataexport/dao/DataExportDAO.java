package gov.mof.fasp2.pmkpi.dataexport.dao;

import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.dataexport.dto.ExportTemplateDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataExportDAO extends Fasp2DaoSupport implements IDataExportDAO {

	public static final String EXPORTTABLE = "FW_T_EXPORTTEMPLATE";
	public static final String DICCOLUMN = "fasp_t_diccolumn";
	public static final String EXPORTCOLSETTABLE = "FW_T_EXPORTCOLSET";

	@Override
	public boolean saveTemp(ExportTemplateDTO exportTemplateDTO)
			throws AppException {
		this.save(exportTemplateDTO, EXPORTTABLE);
		return true;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public ExportTemplateDTO getExportTemplateDTO(String guid) {
		String sql = "select * from " + EXPORTTABLE + " where guid = '" + guid
				+ "'";
		List list = this.queryForList(sql);
		if (list.size() > 0) {
			Map map = (Map) list.get(0);
			ExportTemplateDTO dto = new ExportTemplateDTO();
			dto.putAll(map);
			return dto;
		}

		return null;
	}

	@Override
	public boolean updateTemp(ExportTemplateDTO exportTemplateDTO)
			throws AppException {
		
		this.updateByPK(exportTemplateDTO, "guid", EXPORTTABLE);
		return true;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean checkRepeat(HashMap<String, Object> map) throws AppException {
		String sql = "select * from " + EXPORTTABLE + " where code = '"
				+ map.get("code").toString() + "'";
		List list = this.queryForList(sql);
		if (list.size() > 0) {// 表明模板ID已经存在了
			return true;
		}
		return false;
	}

	@Override
	public void deleteTemp(String guids) throws AppException {
		guids = "'" + guids.replaceAll(",", "','") + "'";
		this.update("DELETE  " + EXPORTTABLE + " WHERE GUID IN (" + guids + ")");
		this.update("DELETE  " + EXPORTCOLSETTABLE + " WHERE TEMPID IN ("
				+ guids + ")");
	}

	@SuppressWarnings({ "rawtypes" })
	public ExportTemplateDTO findExportTemplateDTO2(String rs) {
		String sql = "select * from " + EXPORTTABLE + " where code = '" + rs
				+ "'";
		List list = this.queryForList(sql);
		if (list.size() > 0) {
			Map map = (Map) list.get(0);
			ExportTemplateDTO dto = new ExportTemplateDTO();
			dto.putAll(map);
			return dto;
		}

		return null;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Object> findDBtable(ExportTemplateDTO dto) {
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
				StringBuffer sbsql=new StringBuffer();
				sbsql.append("select " + sb + " from " + dto.get("datasource"));
				if(dto.get("condition")!=null&&!StringUtils.isEmpty(dto.get("condition").toString().trim())){
					sbsql.append(" where "+dto.get("condition"));
				}
				List list2 = this.queryForList(sbsql.toString());
				if (list2.size() > 0) {
					return list2;

				}
			}
		}
		return null;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public Object[] findAllCol(ExportTemplateDTO dto) {
		if (dto != null) {
			String sql = "select ftd.name from " + DICCOLUMN + " ftd , "
			+ EXPORTCOLSETTABLE
			+ " fte where fte.columnid=ftd.columnid and fte.tempid='"
			+ dto.get("guid") + "' order by fte.ordernum";
			List list = this.queryForList(sql);
			if (list != null && list.size() != 0) {
				String []obj=new String[list.size()];
				Map map = null;
				for (int i = 0; i < list.size(); i++) {
					map = (Map) list.get(i);
					obj[i]=(String) map.get("name");
				}
				return obj;
			}
		}
		return null;
	}

}