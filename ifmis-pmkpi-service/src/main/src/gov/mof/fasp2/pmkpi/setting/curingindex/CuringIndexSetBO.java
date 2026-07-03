package gov.mof.fasp2.pmkpi.setting.curingindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class CuringIndexSetBO extends PmkpiBO {

    private CuringIndexSetDAO curingIndexSetDAO;

    public void setCuringIndexSetDAO(CuringIndexSetDAO curingIndexSetDAO) {
        this.curingIndexSetDAO = curingIndexSetDAO;
    }

    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public void savemajorkey(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        List<String> updatecols = (List)params.get("updatecols");
        String leftcode = (String)params.get("leftcode");
        String leftcodevalue = (String)params.get("leftcodevalue");
        if(updatecols==null){
            updatecols = new ArrayList<>();
        }
        if(year==null||year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province==null||province.isEmpty()){
            province = SecureUtil.getUserSelectProvince();
        }
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("create_time", PerfUtil.getServerTimeStamp());
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("province", province);
                map.put("is_deleted", "2");
                map.put("year", year);
                map.put("status", 1);
                if(leftcode!=null&&!"".equals(leftcode)){
                    map.put(leftcode,leftcodevalue);
                }
                if (StringUtil.isNullOrEmpty(map.get("frametype"))) {
                    map.put("frametype", "PM001");
                }
                addlist.add(map);
            } else {
                map.put("update_time", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            curingIndexSetDAO.setIndexCode(addlist);
            curingIndexSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            curingIndexSetDAO.setIndexCode(uplist);
            curingIndexSetDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode),uplist, "guid", tablecode,updatecols);
        }
        if (deldatas.size() > 0) {
            StringBuffer delsql = new StringBuffer();
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> map : deldatas) {
                delguids.add((String) map.get("guid"));
            }
            delsql.append(curingIndexSetDAO.createInSql("guid", delguids));
            curingIndexSetDAO.delDatas(tablecode, delsql.toString());
        }
    }

    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String querySql = (String)params.get("querySql");
        String wheresql = "";
        if(tablesql != null && !tablesql.isEmpty()){
            wheresql += tablesql + " and ";
        }
        if(querySql != null && !querySql.isEmpty()){
            wheresql += querySql + " and ";
        }
        if (!StringUtil.isEmpty(wheresql)) {
            wheresql = wheresql.substring(0, wheresql.length() - 4);
        }
        List<Map<String, Object>> data = curingIndexSetDAO.getDatas(tablecode, wheresql, "order by frametype,ordernum");
        backMap.put("data", data);
        return backMap;
    }
}
