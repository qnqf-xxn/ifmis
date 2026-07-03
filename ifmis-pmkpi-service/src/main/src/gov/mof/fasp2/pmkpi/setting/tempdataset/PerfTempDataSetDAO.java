package gov.mof.fasp2.pmkpi.setting.tempdataset;


import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.appexception.DaoAppException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.*;
import java.util.stream.Collectors;

public class PerfTempDataSetDAO extends PmkpiDAO  {

    /**
     * 指标体系层级.
     */
    public static final String PERFSYSTEM_TABLE = "V_PERF_T_FRAMESYSTEM";

    /**
     * 临时表.
     */
    public static final String PERF_TABLE_FRAME = "V_PERF_T_FRAME";

    /**
     * 临时表.
     */
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";

    /**
     * 查询指标层级.
     * @param wheresql -- 过滤条件
     * @return
     */
    public List<Map<String, Object>> getData(String wheresql, String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append("select * from ");
        sql.append(tablecode);
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" t where ").append(wheresql);
        }
        sql.append(" order by ordernum");
        return this.queryForList(sql.toString());
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
//        String year = CommonUtil.getYear();//年度
//        String province = SecureUtil.getUserSelectProvince();//区划
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
    public List<Map<String, Object>> initleftset(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String leftcode = (String) params.get("leftcoe");
        String leftcodevalue = (String) params.get("leftcodevalue");
        String[] leftvalue = leftcodevalue.split(",");
        //查询2016年度87区划的数据
        String sql = "select t.* from " + tablecode + " t where t.year = '2016' and t.province = '87'";
        List<Map<String, Object>> indexs = this.queryForList(sql);
        List<Map<String, Object>> alldatas = new ArrayList<>();
        for (String province : leftvalue) {
            //查询选中区划的数据
            String sql1 = "select guid,elementcode from "+ tablecode + " t where t."+leftcode+" in("+province+")";
            List<Map<String,Object>> already = this.queryForList(sql1);
            for (Map map:already) {
                String guid = map.get("guid")+"@-@"+map.get("elementcode");
                //过滤要复制的数据(过滤掉重复的数据)
                indexs = indexs.stream().filter(map1 -> !guid.equals(map1.get("guid")+"@-@"+map1.get("elementcode"))).collect(Collectors.toList());
            }
            Iterator<Map<String,Object>> li = indexs.iterator();
            while (li.hasNext()){
                Map<String,Object> map =  li.next();
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put(leftcode,province);
            }
            alldatas.addAll(indexs);
        }
        return alldatas;
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
    /**
     * 查询数据.
     * @param tablecode --表名
     * @param wheresql --查询条件
     * @param orderby --排序
     * @return --
     */
    public List<Map<String, Object>> getTableDatas(String tablecode, String wheresql, String orderby) {
        String sql = "select t.* from " + tablecode + " t " ;
        if (wheresql != null && !wheresql.isEmpty()){
            sql += " where " + wheresql;
        }
        if (orderby != null && !orderby.isEmpty()){
            sql += " " + orderby;
        } else {
            sql += " order by t.updatetime";
        }
        logger.debug(sql);
        return this.queryForList(sql);
    }
}
