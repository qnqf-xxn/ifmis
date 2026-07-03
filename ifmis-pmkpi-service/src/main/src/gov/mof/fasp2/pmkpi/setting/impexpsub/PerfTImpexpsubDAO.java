package gov.mof.fasp2.pmkpi.setting.impexpsub;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.*;

public class PerfTImpexpsubDAO extends PmkpiDAO {
    public static  final String PERF_T_IMPEXPSUB="PERF_T_IMPEXPSUB";
    public static  final String V_PERF_T_IMPEXPMAIN="V_PERF_T_IMPEXPMAIN";
    /**
     * 将2016年度，87区划的数据赋值一份到当前年度，当前区划
     * @param
     */
    public Boolean initset(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        if(year==null||year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province==null||province.isEmpty()){
            province = SecureUtil.getCurrentUser().getProvince();
        }
        //查询2016年度87区划的数据
        String sql = "select t.* from " + PERF_T_IMPEXPSUB + " t where t.year = '2016' and t.province = '87'";
        List<Map<String, Object>> datas = this.queryForList(sql);
        String sql1 = "select guid from "+ PERF_T_IMPEXPSUB + " t where t.year= '"+year+"' and t.province = '"+province+"'";
        List<Map<String,Object>> already = this.queryForList(sql1);
        List<String> resultlist = new ArrayList<>();
        for (Map map:already) {
            resultlist.add((String) map.get("guid"));
        }
        //将每一条数据的年度改为当前年度，区划改为当前区划
        Iterator<Map<String,Object>> li = datas.iterator();
        while (li.hasNext()){
            Map<String,Object> map =  li.next();
            map.put("year",year);
            map.put("province",province);
            if(resultlist.contains(map.get("guid"))){
                li.remove();
            }
        }
        try{
            this.saveAll(datas,tablecode);
            return true;
        }catch (Exception e){
            return false;
        }
    }

    public List<Map<String, Object>> getLeftTree(String lefttablecode) {
        StringBuffer sql = new StringBuffer();//,code as guid
        sql.append(" select t.guid,t.code,t.tablecode as superguid,t.name from ").append(lefttablecode).append(" t ");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }

}
