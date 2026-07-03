package gov.mof.fasp2.pmkpi.perfmidsave;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfMidsaveBO extends PmkpiBO {

    public static final String MIDSAVE_TABLE = "PERF_MIDSAVE";

    private PmkpiDAO pmkpiDAO;

    public PmkpiDAO getPmkpiDAO() {
        if(pmkpiDAO == null){
            pmkpiDAO = (PmkpiDAO) ServiceFactory.getBean("pmkpi.common.PmkpiDAO");
        }
        return pmkpiDAO;
    }

    /**
     * 暂存数据查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String compconfigid = (String) params.get("compconfigid");
        String url = (String) params.get("url");
        String wheresql = " t.url = '"+ url +"' and t.mainguid = '"+mainguid+"' and t.compconfigid = '"+compconfigid+"' and t.userid = '"+ SecureUtil.getCurrentUser().getGuid() + "' " +PerfUtil.yearProvinceSql("t");
        List<Map<String, Object>> midsavedatas = getPmkpiDAO().getDatas(MIDSAVE_TABLE, wheresql, "order by t.createtime");
        if(midsavedatas!=null && midsavedatas.size()>0){
            backMap = midsavedatas.get(0);
        }
        return backMap;
    }

    /**
     * 暂存数据查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getMidData(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String compconfigid = (String) params.get("compconfigid");
        String url = (String) params.get("url");
        String wheresql = " t.url = '"+ url +"' and t.mainguid = '"+mainguid+"' and t.compconfigid = '"+compconfigid+"' and t.userid = '"+ SecureUtil.getCurrentUser().getGuid() + "' " +PerfUtil.yearProvinceSql("t");
        List<Map<String, Object>> midsavedatas = getPmkpiDAO().getDatas(MIDSAVE_TABLE, wheresql, "order by t.createtime");
        if(midsavedatas!=null && midsavedatas.size()>0){
            backMap = midsavedatas.get(0);
            if(compconfigid.endsWith("table")){
                List<Map> midtablelist = JSONObject.parseArray(backMap.get("data").toString(),Map.class);
                List<Map<String, Object>> returnlist = new ArrayList<>();
                if(midtablelist!=null && midtablelist.size()>0){
                    for (Map modtable:midtablelist) {
                        modtable.put("rowtype","add");//暂存的列表数据默认为新增
                        modtable.put("updatetime",backMap.get("lastupdatetime"));
                        modtable.put("update_time",backMap.get("lastupdatetime"));
                        returnlist.add(modtable);
                    }
                    backMap.put("result",returnlist);
                }
            }else if(compconfigid.endsWith("editform")){
                Map midtablemap = (Map) JSONObject.parse(backMap.get("data").toString());
                midtablemap.put("updatetime",backMap.get("lastupdatetime"));
                midtablemap.put("update_time",backMap.get("lastupdatetime"));
                backMap.put("result",midtablemap);

            }else if(compconfigid.endsWith("map")){
                Map midtablemap = (Map) JSONObject.parse(backMap.get("data").toString());
                backMap.put("result",midtablemap);

            } if(compconfigid.endsWith("list")) {
                List<Map> midtablelist = JSONObject.parseArray(backMap.get("data").toString(),Map.class);
                List<Map<String, Object>> returnlist = new ArrayList<>();
                if(midtablelist!=null && midtablelist.size()>0){
                    for (Map modtable:midtablelist) {
                        modtable.put("updatetime",backMap.get("lastupdatetime"));
                        modtable.put("update_time",backMap.get("lastupdatetime"));
                        returnlist.add(modtable);
                    }
                    backMap.put("result",returnlist);
                }
            }
        }
        return backMap;
    }

    /**
     * 暂存数据保存.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map saveData(Map params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String url = (String) params.get("url");
        String mainguid = (String) params.get("mainguid");
        String componentid = (String) params.get("componentid");
        String compconfigid = (String) params.get("compconfigid");
        String menueguid = (String) params.get("menueguid");
        Object dataList = params.get("data");
        String dataStr = JSON.toJSONString(dataList);
        String wheresql = " t.url = '"+ url +"' and t.mainguid = '"+mainguid+"' and t.compconfigid = '"+compconfigid+"' and t.userid = '"+ SecureUtil.getCurrentUser().getGuid() + "' " +PerfUtil.yearProvinceSql("t");
        String timestamp = PerfUtil.getServerTimeStamp();
        List<Map<String, Object>> midsavedatas = getPmkpiDAO().getDatas(MIDSAVE_TABLE, wheresql, "order by t.createtime");
        if(midsavedatas == null || midsavedatas.size()==0) {//新增
            //处理大字段
            String sql = "insert into PERF_MIDSAVE (GUID,URL,MAINGUID,USERID,MENUEGUID,CREATETIME,LASTUPDATETIME,PROVINCE,YEAR,COMPONENTID,COMPCONFIGID,DATA) values (?,?,?,?,?,?,?,?,?,?,?,?)";
            Map<Integer,String> paramMap = new HashMap<Integer, String>();
            paramMap.put(1,StringUtil.createUUID());
            paramMap.put(2,url);
            paramMap.put(3,mainguid);
            paramMap.put(4,SecureUtil.getCurrentUser().getGuid());
            paramMap.put(5,menueguid);
            paramMap.put(6,timestamp);
            paramMap.put(7,timestamp);
            paramMap.put(8,SecureUtil.getUserSelectProvince());
            paramMap.put(9,CommonUtil.getYear());
            paramMap.put(10,componentid);
            paramMap.put(11,compconfigid);
            LobHandler lobHandler = new DefaultLobHandler();
            PerfSelfLobCreating perfSelfLobCreating = new PerfSelfLobCreating(lobHandler);
            perfSelfLobCreating.setParamMap(paramMap);
            perfSelfLobCreating.setClobData(dataStr);
            perfSelfLobCreating.setClobInt(12);
            int res  = getPmkpiDAO().getJdbcTemplate().execute(sql,perfSelfLobCreating);
            if(res != 1){
                backMap.put("errmsg", "暂存失败，失败原因数据库");
            }else {
                backMap.put("success", true);
            }
        }else{
            //处理大字段
            String sql = "update PERF_MIDSAVE t set t.lastupdatetime = ?,t.data = ? where" + wheresql;
            Map<Integer,String> paramMap = new HashMap<Integer, String>();
            paramMap.put(1,timestamp);
            LobHandler lobHandler = new DefaultLobHandler();
            PerfSelfLobCreating perfSelfLobCreating = new PerfSelfLobCreating(lobHandler);
            perfSelfLobCreating.setParamMap(paramMap);
            perfSelfLobCreating.setClobData(dataStr);
            perfSelfLobCreating.setClobInt(2);
            int res  = getPmkpiDAO().getJdbcTemplate().execute(sql,perfSelfLobCreating);
            if(res != 1){
                backMap.put("errmsg", "暂存失败，失败原因数据库");
            }else {
                backMap.put("success", true);
            }
        }
        return backMap;
    }

    /**
     * 暂存(两个组件)
     * @param config --
     * @return
     * @throws AppException
     */
    public Map saveData2(HashMap config) throws AppException {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> param1 = new HashMap<>();
        param1.put("mainguid",config.get("mainguid"));
        param1.put("menueguid",config.get("menueguid"));
        param1.put("url",config.get("url1"));
        param1.put("componentid",config.get("componentid1"));
        param1.put("compconfigid",config.get("compconfigid1"));
        param1.put("data",config.get("data1"));
        result.putAll(this.saveData(param1));
        Map<String, Object> param2 = new HashMap<>();
        param2.put("mainguid",config.get("mainguid"));
        param2.put("menueguid",config.get("menueguid"));
        param2.put("url",config.get("url2"));
        param2.put("componentid",config.get("componentid2"));
        param2.put("compconfigid",config.get("compconfigid2"));
        param2.put("data",config.get("data2"));
        result.putAll(this.saveData(param2));
        return result;
    }

    public void delData(Map params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String delsql = (String) params.get("delsql");
        String wheresql = !StringUtil.isEmpty(delsql) ? delsql : "' t.mainguid = '"+mainguid+"' "+PerfUtil.yearProvinceSql("t");
        getPmkpiDAO().delDatas(MIDSAVE_TABLE,wheresql);
    }


    public Map delTabData(Map params) throws AppException {
        Map<String, Object> result = new HashMap<>();
        String url = (String) params.get("url");
        String mainguid = (String) params.get("mainguid");
        String compconfigid = (String) params.get("compconfigid");
        String wheresql = " t.url = '"+ url +"' and t.mainguid = '"+mainguid+"' and t.compconfigid = '"+compconfigid+"' and t.userid = '"+ SecureUtil.getCurrentUser().getGuid() + "' " +PerfUtil.yearProvinceSql("t");
        getPmkpiDAO().delDatas(MIDSAVE_TABLE,wheresql);
        result.put("success", true);
        return result;
    }

    public Map delTabData2(Map params) throws AppException {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> param1 = new HashMap<>();
        param1.put("mainguid",params.get("mainguid"));
        param1.put("url",params.get("url1"));
        param1.put("compconfigid",params.get("compconfigid1"));
        result.putAll(this.delTabData(param1));
        Map<String, Object> param2 = new HashMap<>();
        param2.put("mainguid",params.get("mainguid"));
        param2.put("url",params.get("url2"));
        param2.put("compconfigid",params.get("compconfigid2"));
        result.putAll(this.delTabData(param2));
        result.put("success", true);
        return result;
    }

}
