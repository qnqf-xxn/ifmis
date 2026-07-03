package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomIndexEditBO extends PmkpiBO {

    private RandomIndexEditDAO randomIndexEditDAO;

    public void setRandomIndexEditDAO(RandomIndexEditDAO randomIndexEditDAO) {
        this.randomIndexEditDAO = randomIndexEditDAO;
    }
    

    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String projguid = (String)params.get("projguid");
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String procode = (String)params.get("procode");
        String tabcode = (String)params.get("tabcode");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        logger.error("抽评指标完成情况："+wheresql);
        List<Map<String, Object>>  data = randomIndexEditDAO.getDatas(tablecode, wheresql, "order by ordernum");
        if(data.size() <= 0){
            data = this.getPerfDataIndex(tabcode, procode);
        }
        List<Map<String, Object>> nullTemp = randomIndexEditDAO.getTempdatas(projguid, "PM001"); //空指标模板
        data.addAll(nullTemp);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 查询项目绩效指标，年度根据pro_code来查询
     * @param tabcode
     * @param procode
     * @return
     */
    public List<Map<String, Object>> getPerfDataIndex(String tabcode,String procode){
    	List<Map<String, Object>> data = new ArrayList<Map<String,Object>>();
    	StringBuffer wheresql = new StringBuffer("exists(select guid from v_perf_project_info a where t.pro_code = a.pro_code and a.pro_code ='");
    	wheresql.append(procode).append("')");
    	wheresql.append(" and t.yearflag = '0'");
    	//String wheresql = " exists(select guid from v_perf_project_info a where t.MAINGUID = a.GUID and a.PRO_ID ='" + projguid + "')";
    	logger.error("抽评指标-----查询条件sql----------" + wheresql);
    	data = randomIndexEditDAO.getDatas(tabcode, wheresql.toString(), "order by ordernum");
    	for (Map map1: data) {
            map1.put("isleaf","1");
        }
    	return data;
    }
    
    public Map<String, Object> saveIndex(HashMap<String, Object> params) throws AppException {
    	 //表名
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        String projguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        String procode = (String) params.get("procode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String delsql = " t.mainguid = '"+mainguid+"'";
        randomIndexEditDAO.delDatas(tablecode, delsql);
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String levelno = map.get("levelno").toString();
            //三级的保存，一二级不保存
            if("3".equals(levelno)){
                map.put("ordernum", i++);
                map.put("mainguid", mainguid);
                map.put("pro_code", procode);
                map.put("projguid", projguid);
                map.put("indexguid", this.getCreateguid());
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("isleaf","1");
                addlist.add(map);
            }
        }
        if (addlist.size() > 0) {
        	randomIndexEditDAO.saveAll(addlist, tablecode);
        }
    	return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 导入指标
     *
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void impRandomIndexData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            errorlist.addAll(this.checkIndexFrame(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {//pmkpi.randomcomment.RandomIndexEditBOTX
                RandomIndexEditBO randomIndexEditBO = (RandomIndexEditBO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomIndexEditBOTX");
                randomIndexEditBO.impIndex(randomIndexEditBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex(RandomIndexEditBO randomIndexEditBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        RandomIndexEditDAO randomIndexEditDAO = (RandomIndexEditDAO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomIndexEditDAO");
        String mainguid = (String) busParams.get("mainguid");
        String procode = (String) busParams.get("procode");
        List<Map<String, Object>> indexList = new ArrayList<>();
        int i = 0;
        List<Map<String, Object>>  dataList = randomIndexEditDAO.getDatas("v_perf_project_info", " t.pro_code = '" + procode + "'", "");
        String agency_code = (String) dataList.get(0).get("agency_code");
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            data.put("guid", this.getCreateguid());
            data.put("name", data.get("name"));
            data.put("indexguid", data.get("name"));
            data.put("findex", data.get("findex"));
            data.put("sindex", data.get("sindex"));
            data.put("isleaf", "1");
            data.put("superid", data.get("sindex"));
            data.put("levelno", "3");
            data.put("mainguid", mainguid);
            data.put("agencyguid", agency_code);
            data.put("status", 0);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("updatetime", PerfUtil.getServerTimeStamp());
            data.put("ordernum", i++);
            data.put("creater", SecureUtil.getCurrentUserID());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("year", CommonUtil.getYear());
            data.put("indexval", data.get("indexval"));
            data.put("computesign", data.get("computesign"));
            data.put("meterunit", data.get("meterunit"));
            data.put("actualvalue", data.get("actualvalue"));
            data.put("weight", data.get("weight"));
            data.put("score", data.get("score"));
            //基础规范字段赋值
            //this.getBasMap(data, "add");
            indexList.add(data);
        }
        randomIndexEditDAO.delDatas(randomIndexEditDAO.PMKPI_TABLE_INDEX," t.mainguid = '" + mainguid + "'");
        randomIndexEditDAO.saveAll(indexList, randomIndexEditDAO.PMKPI_TABLE_INDEX);
        //三级指标编码赋值
        //randomIndexEditDAO.setIndexCode(indexList);

    }


}
