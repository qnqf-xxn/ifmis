package gov.mof.fasp2.pmkpi.evaluation.financial.additonalinfo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdditionalInfoBO extends PmkpiBO {
    private AdditionalInfoDAO additionalInfoDAO;

    public void setAdditionalInfoDAO(AdditionalInfoDAO additionalInfoDAO) {
        this.additionalInfoDAO = additionalInfoDAO;
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
        Map<String, Object> data = this.getDataMap(tablecode, wheresql);
        backMap.put("data", data);
        return backMap;
    }
    
    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> datas = (Map<String, Object>) params.get("datas"); //全部数据
        String tablecode = (String)params.get("tablecode"); //保存的数据表
        String mainguid = (String)params.get("mainguid");
        String busguid = (String) params.get("busguid");
        Map map = null;
        List<Map> updatas = additionalInfoDAO.getByGuid(tablecode, mainguid);
		if (updatas != null && updatas.size() > 0) {//修改
			map = updatas.get(0);
			map.putAll(datas);
			map.put("updatetime", PerfUtil.getServerTimeStamp());
            additionalInfoDAO.update(map, tablecode);
		} else { //新增
            datas.put("guid", this.getCreateguid());
            datas.put("mainguid", mainguid);
            datas.put("is_deleted", 2);
            datas.put("creater", SecureUtil.getCurrentUserID());
            datas.put("createtime", PerfUtil.getServerTimeStamp());
            datas.put("updatetime", PerfUtil.getServerTimeStamp());
            datas.put("year", CommonUtil.getYear());
            datas.put("province", SecureUtil.getUserSelectProvince());
            additionalInfoDAO.save(datas, tablecode);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }

}
