package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.DeptPerfInfoDAO;

import java.util.*;

public class DeptPerfFunctionProjBO extends PmkpiBO {
    private DeptPerfInfoDAO deptPerfInfoDAO;

    public void setDeptPerfInfoDAO(DeptPerfInfoDAO deptPerfInfoDAO) {
        this.deptPerfInfoDAO = deptPerfInfoDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String wheresql = (String) params.get("querySql");
        StringBuffer sql = new StringBuffer();
        sql.append(" t.agencyguid = '" + agency + "'");
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and (").append(wheresql).append(")");
        }
        List<Map<String, Object>>  data = deptPerfInfoDAO.getDatas(tablecode, sql.toString(), "order by guid");
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 保存对应项目
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> map = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        StringBuffer projects = new StringBuffer();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> ma : datas) {
            projects.append(ma.get("guid"));
            projects.append(",");
        }
        String projectstr = projects.substring(0,projects.length()-1);
        deptPerfInfoDAO.update("update PERF_T_DEPTPERFFUNCTION set projects = '"+projectstr+"' where guid ='"+ mainguid +"'");
        return map;
    }

}
