package gov.mof.fasp2.pmkpi.perfself.opinion;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SelfOpinionBO extends PmkpiBO {
    private SelfOpinionDAO selfOpinionDAO;

    public void setSelfOpinionDAO(SelfOpinionDAO selfOpinionDAO) {
        this.selfOpinionDAO = selfOpinionDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String)params.get("mainguid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            selfOpinionDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String tablecode = "v_perf_t_selfperfopinion";
        String wheresql = " t.mainguid = '" + mainguid + "'";
        return this.getDataMap(tablecode, wheresql);
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String busguid = (String) params.get("busguid");
        String mainguid = (String)params.get("mainguid");
        String tablecode = "v_perf_t_selfperfopinion";
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        Map<String, Object> updatas = this.getData(params);
        if (!updatas.isEmpty()) {//修改
            updatas.putAll(datas);
            updatas.put("updatetime", PerfUtil.getServerTimeStamp());
            selfOpinionDAO.update(updatas, tablecode);
        } else { //新增
            datas.put("guid", this.getCreateguid());
            datas.put("creater", SecureUtil.getCurrentUserID());
            datas.put("province", SecureUtil.getUserSelectProvince());
            datas.put("year", CommonUtil.getYear());
            datas.put("create_time", PerfUtil.getServerTimeStamp());
            datas.put("update_time", PerfUtil.getServerTimeStamp());
            datas.put("mainguid", mainguid);
            datas.put("is_deleted", 2);
            selfOpinionDAO.save(datas, tablecode);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }
}
