package gov.mof.fasp2.pmkpi.deptperformance.func;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class DeptFuncBO extends PmkpiBO {
    private DeptFuncDAO deptFuncDAO;

    public void setDeptFuncDAO(DeptFuncDAO deptFuncDAO) {
        this.deptFuncDAO = deptFuncDAO;
    }

    /**
     * 表格的查询语句.
     *
     * @param sqlmap -- map.
     * @return
     * @throws AppException -- 自定义异常.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String sql = this.queryByFunctional(sqlmap);
        return sql;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String orderby = (String) params.get("orderby");
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid");
        String tablecode = (String)params.get("tablecode");
        String isadj = (String) params.get("isadj");  //是否调整  1是  0否
        String tablesql = (String)params.get("tablesql");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            wheresql += " and " + tablesql;
        }
        List<Map<String, Object>>  data;
        //是否是调整查询，是调整查调整表
        if (isadj != null && "1".equals(isadj)){
            data = deptFuncDAO.getDatas("v_perf_t_adjustfunction", wheresql, orderby);
            if (data.size() == 0){
                wheresql =" t.mainguid = '" + proguid + "'";
                if (!StringUtil.isEmpty(tablesql)) {
                    wheresql += " and " + tablesql;
                }
                data = deptFuncDAO.getDatas(tablecode, wheresql, orderby);
            }
        } else {
            data = deptFuncDAO.getDatas(tablecode, wheresql, orderby);
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 查询职能职责
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public String queryByFunctional(Map params) throws AppException {
        //页面类型
        String orderby = (String) params.get("orderby");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.bgt_dept_code=").append(saveAgency);
        sql.append(" and t.is_deleted = 2 ");
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
        return sql.toString();
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String isadj = (String) params.get("isadj");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> addlist = new ArrayList<>();
        int i = 1;
        if ("1".equals(isadj) && isadj != null){
            tablecode = "v_perf_t_adjustfunction";
        }
        for (Map<String, Object> map : datas) {
            map.put("ordernum", i++);
            map.put("mainguid", mainguid);
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("guid", this.getCreateguid());
            addlist.add(map);
        }
        String delsql = "mainguid = '" + mainguid + "'";
        deptFuncDAO.delDatas(tablecode, delsql);
        deptFuncDAO.saveAll(addlist, tablecode);
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
