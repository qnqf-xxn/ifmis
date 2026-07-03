package gov.mof.fasp2.pmkpi.transpaypro;


import gov.mof.fasp2.buscore.framework.daosupport.appexception.DaoAppException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.*;

public class TranspayProIndexDAO extends PmkpiDAO  {
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
            sql.append(" t where 1=1 ").append(wheresql);
        }
        sql.append(" order by ordernum");
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
        String sql = "select t.* from " + tablecode + " t where 1=1 " ;
        if (wheresql != null && !wheresql.isEmpty()){
            sql += " and " + wheresql;
        }
        if (orderby != null && !orderby.isEmpty()){
            sql += " " + orderby;
        } else {
            sql += " order by t.updatetime";
        }
        logger.debug(sql);
        return this.queryForList(sql);
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
}
