package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.DeptPerfInfoDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptPerfInfoBO extends PmkpiBO {
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
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        List<Map<String, Object>>  data = deptPerfInfoDAO.getDatas(tablecode, wheresql, "order by guid");
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String guid = (String) datas.get("guid");
        Map map = null;
        List<Map> updatas = deptPerfInfoDAO.getByGuid(tablecode, guid);
        if (updatas != null && updatas.size() > 0) {//修改
            map = updatas.get(0);
            map.putAll(datas);
            map.put("updatetime", StringUtil.getSysDBDate());
            deptPerfInfoDAO.update(map, tablecode);
        }else {
            map = new HashMap<String, Object>();
            map.put("guid", StringUtil.createUUID());
            map.put("status", 0);
            map.put("mainguid", mainguid);
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            deptPerfInfoDAO.save(map, tablecode);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }
}
