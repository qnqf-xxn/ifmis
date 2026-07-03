package gov.mof.fasp2.pmkpi.deptperformance.deptquery;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DeptQueryBO extends PmkpiBO {

    private DeptQueryDAO deptQueryDAO;

    public void setDeptQueryDAO(DeptQueryDAO deptQueryDAO) {
        this.deptQueryDAO = deptQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tablesql");
        String tabcode = (String) sqlmap.get("tabcode");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where isleaf = 0 and length(guid) = 3");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            sql.append(" and ").append(tabfilter);
        }
        if ("waitaudit".equals(tabcode)) {//待选部门
            sql.append(" and not exists (select 1 from v_perf_t_deptperformancedp dp where dp.code = t.CODE)");
        } else {//已选部门
            sql.append(" and exists (select 1 from v_perf_t_deptperformancedp dp where dp.code = t.CODE)");
        }
        return sql.toString();
    }




    /**
     * 列表保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = deptQueryDAO.PERF_T_DEPTPERFORMANCEDP;
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            map.put("guid",this.getCreateguid());
            map.put("status","1");
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            addlist.add(map);
        }
        if (addlist.size() > 0) {
            deptQueryDAO.saveAll(addlist, tablecode);
        }
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = deptQueryDAO.PERF_T_DEPTPERFORMANCEDP;
        List list = new ArrayList();
        for (Map<String, Object> map : deldatas) {
            Map m = new HashMap();
            m.put("guid", map.get("code"));
            list.add(m);
        }
        try {
             //删除已选择数据
             deptQueryDAO.saveAll(list, deptQueryDAO.PMKPI_TABLE_TMP_GUIDS);
             String delsql = " exists(select 1 from " + deptQueryDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.code)";
             deptQueryDAO.delDatas(tablecode, delsql);
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
