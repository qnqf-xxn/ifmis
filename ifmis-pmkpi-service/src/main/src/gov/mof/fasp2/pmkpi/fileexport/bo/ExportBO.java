
package gov.mof.fasp2.pmkpi.fileexport.bo;

import gov.mof.fasp2.buscore.framework.daosupport.CommonJdbcDaoSupport;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busdic.dataset.appexception.DataSetAppException;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.appexception.DicTableAppException;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busfw.ui.datatable.IUIDatatableCacheInit;
import gov.mof.fasp2.busfw.ui.dto.DataColumnsDTO;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExportBO extends CommonJdbcDaoSupport {

	private final static String APPID = "common";
	
    public List<Map> loadData(int page, Map config) {
        // 根据page和config查询出要导出的数据
        // 判断当前导出方式，根据导出方式决定是前台导出还是sql查询。
    	
    	if("1".equals(config.get("hassql").toString())){
    		
    		//根据key查询出tablecode和columns信息拼装sql语句(全部导出)
    		String key = (String) config.get("key");
            IUIDatatableCacheInit cache = this.getRemoteDatatableCacheBean();
            DatatableDTO tableDTO = null;
			try {
				tableDTO = (DatatableDTO) cache.get(key).get(0);
			} catch (AppException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            
            //创建sql语句
            String sql = CreateExcelSql(tableDTO);
            
            //查询导出数据
            List dataList = queryAllData(sql);
            
            //拼装EXCEL数据
            //在这翻译
            //后台导出翻译
            //Map<dsguid,集合<dsrangecode>> map;
            if (page < 1) {
            	List<Map> ret = new ArrayList<Map>();
            	//Map fyMap = new HashMap();
            	for(int i = 0;i<dataList.size();i++){
            		Map m = new HashMap();
            		List colList = (List)config.get("columns");
            		Map dataMap = (Map)dataList.get(i);
            		for (int j = 0; j < colList.size(); j++) {
            			Map colMap = (Map)colList.get(j);
            			//根据tablecode和columncode查询数据字典对应字段
            			if("1".equals(colMap.get("issource"))){
            				try {
								DicColumnDTO colDTO = PerfServiceFactory.getIDicTableQueryService().getDicColumnDTO((String.valueOf(config.get("tablecode"))), String.valueOf(colMap.get("colcode")));
								if(colDTO.getCsid()!=null){
		            				//根据CSID和GUID查询值域DTO
		            				try {
		            					if(dataMap.get(colMap.get("colcode"))!=null){
		            						DicRangeDTO rangeDTO = (DicRangeDTO) PerfServiceFactory.getIDataSetService().getRangeByGuid(colDTO.getCsid(), String.valueOf(dataMap.get(colMap.get("colcode"))));
											m.put(colMap.get("colcode"), rangeDTO.getName());
		            					}else{
		            						m.put(colMap.get("colcode"), dataMap.get(colMap.get("colcode")));
		            					}
										
									} catch (DataSetAppException e) {
										// TODO Auto-generated catch block
										logger.error(e.getMessage(), e);
									} catch (AppException e) {
										// TODO Auto-generated catch block
										logger.error(e.getMessage(), e);
									}
		            			}else{
		            				m.put(colMap.get("colcode"), dataMap.get(colMap.get("colcode")));
		            			}
							} catch (DicTableAppException e) {
								// TODO Auto-generated catch block
								logger.error(e.getMessage(), e);
							} catch (AppException e) {
								// TODO Auto-generated catch block
								logger.error(e.getMessage(), e);
							}
            			}else{
            				m.put(colMap.get("colcode"), dataMap.get(colMap.get("colcode")));
            			}
            			
            			
            		}
            		ret.add(m);
            	}
            	return ret;
            }
            
    		
    	}else if("3".equals(config.get("hassql"))){
    		//导出模板 空数据集
    		return null;
    		
    	}else if("2".equals(config.get("hassql"))){
    		//选择导出(前台导出，所见即所得)
    		
    		
    	}
    	
        return null;
    }
    
    public List<Map> loadData(int page, Map config,List dataList) {
        // 根据page和config查询出要导出的数据
        // 判断当前导出方式，根据导出方式决定是前台导出还是sql查询。
    	if("2".equals(config.get("hassql").toString())){
    		
            //拼装EXCEL数据
            if (page < 1) {
            	List<Map> ret = new ArrayList<Map>();
            	for(int i = 0;i<dataList.size();i++){
            		Map m = new HashMap();
            		List colList = (List)config.get("columns");
            		Map dataMap = (Map)dataList.get(i);
            		for (int j = 0; j < colList.size(); j++) {
            			Map colMap = (Map)colList.get(j);
            			m.put(colMap.get("name"), dataMap.get(colMap.get("name")));
            		}
            		ret.add(m);
            	}
            	return ret;
            }
            
    		
    	}
    	
        return null;
    }

    public void setTitle() {
        // 判断title设置，设置title
    	
    }

    public String getFileName(Map config) {
        return config.get("titleflag").toString();
    }
    
    private IUIDatatableCacheInit getRemoteDatatableCacheBean(){
        IUIDatatableCacheInit cache = null;
        //分域部署 业务系统暴露该接口
        Object obj = ServiceFactory.getBean("busfw.cacheinit.uicacheinit.uidatatable");
        if(obj!=null){
            cache = (IUIDatatableCacheInit)obj;
        }
        return cache;
    }
    
    //创建SQL语句
    public String CreateExcelSql(DatatableDTO tableDTO){
    	List colList = tableDTO.getCols();
    	StringBuffer sb = new StringBuffer();
    	sb.append("select ");
    	for(int i=0;i<colList.size();i++){
    		DataColumnsDTO coldto = (DataColumnsDTO)colList.get(i);
    		sb.append(coldto.getColcode());
    		if(i!=colList.size()-1){
    			sb.append(",");
    		}
    	}
    	sb.append(" from ");
    	sb.append(tableDTO.getTablecode());
    	
    	String sql = sb.toString();
    	
    	
		return sql;
    }
    
    //全部导出查询所有数据
    public List queryAllData(String wheresql) {
    	//List l = new ArrayList();
        return this.queryForList(wheresql);
    }
}