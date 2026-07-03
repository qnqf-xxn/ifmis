package gov.mof.fasp2.pmkpi.setting.dataset;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.appexception.DaoAppException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.*;

public class PerfDataSetDAO extends PmkpiDAO {
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";
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
        String sql = "select t.* from " + tablecode + " t where t.year = '2016' and t.province = '87'";
        List<Map<String, Object>> datas = this.queryForList(sql);
        String sql1 = "select guid from "+ tablecode + " t where t.year= '"+year+"' and t.province = '"+province+"'";
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
        //保存数据，成功返回success，失败返回error
        try{
            this.saveAll(datas,tablecode);
            return true;
        }catch (Exception e){
            return false;
        }
    }
    public Boolean initleftset(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String leftcode = (String) params.get("leftcoe");
        String leftcodevalue = (String) params.get("leftcodevalue");
        //查询2016年度87区划的数据
        String sql = "select t.* from " + tablecode + " t where t.year = '2016' and t.province = '87'";
        List<Map<String, Object>> indexs = this.queryForList(sql);
        String sql1 = "select guid from "+ tablecode + " t where t."+leftcode+"= '"+leftcodevalue+"'";
        List<Map<String,Object>> already = this.queryForList(sql1);
        List<String> resultlist = new ArrayList<>();
        for (Map map:already) {
            resultlist.add((String) map.get("guid"));
        }
        Iterator<Map<String,Object>> li = indexs.iterator();
        while (li.hasNext()){
            Map<String,Object> map =  li.next();
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put(leftcode,leftcodevalue);
            if(resultlist.contains(map.get("guid"))) {
                li.remove();
            }
        }
        try{
            this.saveAll(indexs,tablecode);
            return true;
        }catch (Exception e){
            return false;
        }
    }
    /**
     * 重写更改方法，通过guid、年度和区划为主键去更改数据，不再是通过guid
     * @param columns
     * @param dto
     * @param pkcolumn
     * @param tabcode
     * @return
     * @throws AppException
     */
    public int updateAllByMajorPK(Collection<String> columns, Collection<? extends Map> dto, String pkcolumn, String tabcode,List<String> updatecols)
            throws AppException {
        if (tabcode == null) {
            throw new AppException(DaoAppException.C11000200, DaoAppException.M11000200);
        }
        StringBuilder sb = new StringBuilder("update ");
        sb.append(this.getTableName(tabcode));
        List<List> arr = new ArrayList<List>();
        int index = 0;
        sb.append(" set ");
        updatecols.remove(pkcolumn);
        //当数据条数大于0的时候
        Map<String,Object> map1 = new HashMap<>();
        if(dto.size()>0){
            map1 = (Map)(((List)dto).get(0));
        }

        // dbversion = sysdate
        for (String c : columns) {
            if (!pkcolumn.equalsIgnoreCase(c)) {
                sb.append(" ").append(c).append("=?,");
                index = 0;
                for (Map m : dto) {
                    if (arr.size() == index) {
                        arr.add(new ArrayList());
                    }
                    List l = arr.get(index);
                    Object o = m.get(c.toLowerCase());
                    if (o instanceof Enum) {
                        l.add(o.toString());
                    } else {
                        l.add(o);
                    }
                    index++;
                }
            }
        }
        sb.delete(sb.length() - 1, sb.length());
        sb.append(" where " + pkcolumn + "=? ");
        for (String str:updatecols) {
            sb.append(" and ").append(str).append(" = '").append(map1.get(str)).append("'");
        }
        index = 0;
        for (Map m : dto) {
            List l = arr.get(index++);
            l.add(m.get(pkcolumn));
        }
        this.batchSingnalUpdate(sb.toString(), arr);
        return arr.size();
    }
    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public List<Map<String, Object>> getLeftTree(String lefttablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.*,code as guid from ").append(lefttablecode).append(" t ");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }
}
