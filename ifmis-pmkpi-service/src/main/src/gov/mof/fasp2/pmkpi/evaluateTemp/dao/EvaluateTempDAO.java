package gov.mof.fasp2.pmkpi.evaluateTemp.dao;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateTempDAO extends PmkpiDAO  {

    //评价类型表
    public static final String TABLE_CODE = "V_PERF_T_RANDOMQUALITY_TYPE";

    //评价模板表
    private static final String EVAL_TEMP_TABLE = "V_PERF_T_RANDOMQUALITY";

    /**
     * 评价模板临时表.
     */
    public static final String PERF_TABLE_EVALTEMPINFO = "PERF_TMP_EVALTEMPINFO";

    /**
     * 评价类型数据查询
     * @param parms --
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String,Object> parms) {
        String sql = "select * from "+ TABLE_CODE +" t";
        return this.queryForList(sql);
    }

    /**
     * 评价模板数据查询
     * @param mainguid
     * @return
     */
    public List<Map<String, Object>> dataByMainGuid(String mainguid) {
        String sql = "select * from "+ EVAL_TEMP_TABLE +" t where t.mainguid='" + mainguid + "'";
        return this.queryForList(sql);
    }

    public List<Map> getDataByMainguid(String tablecode, String mainguid, String guid) {
        String sql = "select * from "+ EVAL_TEMP_TABLE +" t where t.mainguid='" + mainguid + "' and guid = '"+guid+"'";
        return this.queryForList(sql);
    }

    /**
     * 查询评价模板和菜单的关系
     * @param code
     * @param tablecode
     * @return
     */
    public List<Map> getDateByCode(String code,String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where code = '").append(code).append("'");
        return this.queryForList(sql.toString());
    }

    /**
     * 修改
     * @param map
     * @param tablecode
     */
    public void updateData(Map map, String tablecode) {
        String sql = "update "+tablecode+" set name ='"+map.get("name")+"' , bustype = '"+map.get("bustype")+"' where guid ='"+map.get("guid")+"'";
        this.execute(sql);
    }

    /**
     * 新增
     * @param map
     * @param tablecode
     */
    public void saveData(Map map, String tablecode) throws AppException {
        String sql = "insert into "+tablecode+" (GUID,NAME,YEAR,DELSTATUS,CREATETIME,STATUS,CREATER,WFSTATUS,PROVINCE,WFID,BUSTYPE,UPDATETIME,CODE) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";

        this.update(sql, new Object[]{map.get("guid"),map.get("name"),map.get("year"),map.get("delstatus"),map.get("createtime"),map.get("status"),map.get("creater"),map.get("wfstatus"),map.get("province"),map.get("wfid"),map.get("bustype"),map.get("updatetime"),map.get("code")});
    }
}
