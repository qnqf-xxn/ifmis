package gov.mof.fasp2.pmkpi.dataexport.bo;

import gov.mof.fasp2.buscommon.ui.datatable.BusDataTableBO;
import gov.mof.fasp2.buscore.framework.daosupport.CommonJdbcDaoSupport;
import gov.mof.fasp2.buscore.framework.daosupport.RecordSet;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DateTimeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busfw.ui.busdr.IBusinessDataRight;
import gov.mof.fasp2.busfw.ui.datatable.IDatatableUIconfig;
import gov.mof.fasp2.busfw.ui.datatable.IUIDatatableCacheInit;
import gov.mof.fasp2.busfw.ui.dto.DataColumnsDTO;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataExportSupport extends CommonJdbcDaoSupport {

	private String querySql = "";
	
	private static BusDataTableBO busDataTableBO;
	private static IDatatableUIconfig datatableUIconfig;
	protected IBusinessDataRight bdr = null;

	public IBusinessDataRight getBdr() {
		return bdr;
	}

	public void setBdr(IBusinessDataRight bdr) {
		this.bdr = bdr;
	}
	
    public BusDataTableBO getBusDataTableBO() {
        if (busDataTableBO == null) {
            busDataTableBO = (BusDataTableBO) ServiceFactory.getBean("buscommon.ui.datatable.BusDataTableBOTX");
        }
        return busDataTableBO;
    }
    
      public IDatatableUIconfig getDatatableUIconfig() {
        if (datatableUIconfig == null) {
            datatableUIconfig = PerfServiceFactory.getIDatatableUIconfig();
        }
        return datatableUIconfig;
    }
      
    private int getMappercolumnIndex(String[] mappercolumns,String columnname) throws AppException{
        for (int i = 0; i < mappercolumns.length; i++) {
            if(columnname.equals(mappercolumns[i])){
                return i;
            }
            
        }
       throw new AppException("无数据值集的该列"+columnname);
    }
      

	public List<Map> loadData(int page, Map config) {
		// 根据page和config查询出要导出的数据
		// 判断当前导出方式，根据导出方式决定是前台导出还是sql查询。

		if ("1".equals(config.get("hassql").toString())) {

			try {
                // 根据key查询出tablecode和columns信息拼装sql语句(全部导出)
                String key = (String) config.get("key");
                Map pageobj = (Map) config.get("pageobj");
                int rows = 0;
                try {
                    rows = Integer.parseInt(pageobj.get("rows").toString());
                } catch (Exception e) {
                    rows = 0;
                }
                if(rows == 0 && page >0){ //不分页
                    return null;
                }
                if (rows > 0 || rows == -1) { // 如果有分页，则分面50000一页导出
                    pageobj.put("rows", 50000);
                    pageobj.put("currpage", page + 1);
                }
                logger.info("进入查询数据方法");
                long f1 = System.currentTimeMillis();
                List uitable = this.getDatatableUIconfig().get(key);
                Map<String, Object> result = getBusDataTableBO().queryData((HashMap)config, uitable);
                logger.info("查询数据方法结束："+(System.currentTimeMillis()-f1));
                List dataList = ((RecordSet)result.get("datalist"));
                if(dataList.size() == 0){
                    return null;
                }
                Map<String, Map> mapperdata = (Map<String, Map>)result.get("mapperdata");
                
            	List<Map> ret = new ArrayList<Map>(dataList.size());
            	Map fyMap = new HashMap();
            	List colList = (List) config.get("columns");
                String colcode = null;
                Object value = null;
                List mapperdatas = null;
            	for (int i = 0; i < dataList.size(); i++) {
            		Map m = new HashMap();
            		Map dataMap = (Map) dataList.get(i);
            		for (int j = 0; j < colList.size(); j++) {
            			Map colMap = (Map) colList.get(j);
                        colcode = (String) colMap.get("colcode");
                        value = dataMap.get(colcode);
                        if(value != null){
                            if ("1".equals(colMap.get("issource")) && !"attach".equals(colcode)) {// 有来源 标识
                                Map mapper = mapperdata.get(colcode);
                                String format = (String) colMap.get("format");
                                String[] mappercolumns = (String[]) mapper.get("columns");
                                mapperdatas = (List) mapper.get("datas");
                                int guidi = getMappercolumnIndex(mappercolumns, "guid");
                                Object[] dicRange = null;
                                for (int k = 0; k < mapperdatas.size(); k++) {
                                    dicRange = (Object[]) mapperdatas.get(k);
                                    String guid = (String) dicRange[guidi];
                                    if (guid.equals(value)) {
                                        break;
                                    }
                                }
                                if (dicRange != null) {
                                    if (format == null) {
                                        format = "#code-#name";
                                    }
                                    format = format.replace("#guid", value + "");// 替换GUID
                                    format = format.replace("#code",
                                            (String) dicRange[getMappercolumnIndex(mappercolumns, "code")]);// 替换CODE
                                    value = format.replace("#name",
                                            (String) dicRange[getMappercolumnIndex(mappercolumns, "name")]);// 替换name
                                }
                            } else if ("d".equals(colMap.get("type"))) {
                                if (value != null) {
                                    try {
                                        if (value instanceof java.sql.Timestamp) {
                                            value = new java.util.Date(((java.sql.Timestamp) value).getTime());
                                        } else if (value instanceof java.sql.Date) {
                                            value = new java.util.Date(((java.sql.Date) value).getTime());
                                        } else {
                                            value = DateTimeUtil.getDateBySimpleDateFormat("yyyyMMddHHmmssSSS",
                                                    String.valueOf(value));
                                        }
                                        if (value instanceof java.util.Date) {
                                            String format = (String) colMap.get("format");
                                            if (format == null) {
                                                format = "yyyyMMdd HH:mm:ss";
                                            }
                                            SimpleDateFormat sf = new SimpleDateFormat(format);
                                            value = sf.format(value);
                                        }
                                    } catch (Exception e) {
                                        value = String.valueOf(value);
                                    }
                                }
                            }
                        }
            			m.put(colcode, value);
            		}
            		ret.add(m);
            	}
            	return ret;
            } catch (AppException e) {
                logger.error(e.getMessage(), e);
                throw new RuntimeException(e);
            }

		} else if ("3".equals(config.get("hassql"))) {
			// 导出模板 空数据集
			return null;

		} else if ("2".equals(config.get("hassql"))) {
			// 选择导出(前台导出，所见即所得)

		}

		return null;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map> loadData(int page, Map config, List dataList) {
	    // 根据page和config查询出要导出的数据
	    // 判断当前导出方式，根据导出方式决定是前台导出还是sql查询。
			// 拼装EXCEL数据
	        if (page < 1) {
	            List<Map> ret = new ArrayList<Map>();
	            for (int i = 0; i < dataList.size(); i++) {
					Map m = new HashMap();
					List colList = (List) config.get("columns");
					Map dataMap = (Map) dataList.get(i);
					for (int j = 0; j < colList.size(); j++) {
						Map colMap = (Map) colList.get(j);
						String value = dataMap.get(colMap.get("colcode")) + "";
						value = value.replaceAll("<br>", "\r\n");
						m.put(colMap.get("colcode"), value); // 多表头
					}
					//edited by zhangkai ,170816
			        //bug52254 【业务公用-系统检测】系统检测执行页面导出excel，导出数据excel的序号和页面的序号不一致 
			        //使用前台传入的_locationposition作为序号的值
					if (dataMap.get("_locationposition") != null) {
						m.put("_locationposition", dataMap.get("_locationposition"));
					}
					if (dataMap.get("_sortid") != null) {
						m.put("_sortid", dataMap.get("_sortid"));
					}
					ret.add(m);
				}
				return ret;
			}
		return null;
	}

	public void setTitle() {
		// 判断title设置，设置title

	}

	public String getFileName(Map config) {
		return config.get("titleflag").toString();
	}

	private IUIDatatableCacheInit getRemoteDatatableCacheBean() {
		IUIDatatableCacheInit cache = null;
		// 分域部署 业务系统暴露该接口
		Object obj = ServiceFactory
				.getBean("busfw.cacheinit.uicacheinit.uidatatable");
		if (obj != null) {
			cache = (IUIDatatableCacheInit) obj;
		}
		return cache;
	}

	/**
	 * 获取 sql
	 * 
	 * @return
	 */
	public String getSql() {
		return querySql;
	}

	/**
	 * 设定sql
	 * 
	 * @param sql
	 */
	public void setSql(String sql) {
		this.querySql = sql;
	}

	// 创建SQL语句
	public String CreateExcelSql(DatatableDTO tableDTO) {
		List colList = tableDTO.getCols();
		StringBuffer sb = new StringBuffer();
		sb.append("select ");
		for (int i = 0; i < colList.size(); i++) {
			DataColumnsDTO coldto = (DataColumnsDTO) colList.get(i);
			sb.append(coldto.getColcode());
			if (i != colList.size() - 1) {
				sb.append(",");
			}
		}
		sb.append(" from ");
		sb.append(tableDTO.getTablecode());

		String sql = sb.toString();

		return sql;
	}

	// 全部导出查询所有数据
	public List queryAllData(String wheresql) {
//		List l = new ArrayList();
		return this.queryForList(wheresql);
	}
}