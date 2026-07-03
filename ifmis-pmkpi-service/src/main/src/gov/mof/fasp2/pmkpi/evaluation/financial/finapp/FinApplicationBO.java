package gov.mof.fasp2.pmkpi.evaluation.financial.finapp;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinApplicationBO extends PmkpiBO {
    private FinApplicationDAO finApplicationDAO;

    public void setFinApplicationDAO(FinApplicationDAO finApplicationDAO) {
        this.finApplicationDAO = finApplicationDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return null;
    }


    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String)params.get("tablecode");

        String mainguid = (String)params.get("mainguid");
        String bustype = (String)params.get("bustype");
        String wheresql = " t.mainguid = '" + mainguid + "";
        List<Map<String, Object>> finList = finApplicationDAO.getDatas(tablecode, wheresql, "");
        //存在业务数据直接进行返回
        if (finList != null && finList.size() > 0) {
            backMap.put("data", finList);
            return backMap;
        }
        List<Map<String, Object>> list = finApplicationDAO.queryForList("select sys_guid() as guid,'" + mainguid + "' as finguid,code from V_PERF_T_FINAPP where bustype = '" + bustype + "'");
        backMap.put("data", list);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = new ArrayList<>();
        int i = 1;
        for (Map<String, Object> map : datas) {
                map.put("contents", map.get("contents"));
                map.put("province", SecureUtil.getCurrentUser().getProvince());
                map.put("year", CommonUtil.getYear());
                list.add(map);
        }
        String delsql = " finguid ='" + mainguid + "' ";
        finApplicationDAO.delDatas(tablecode, delsql);
        finApplicationDAO.saveAll(list, tablecode);
        
        return this.auditdefine(list, busguid,"perf", null);
    }



}
