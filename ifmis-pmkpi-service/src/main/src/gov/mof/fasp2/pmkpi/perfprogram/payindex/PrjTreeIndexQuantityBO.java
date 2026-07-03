
package gov.mof.fasp2.pmkpi.perfprogram.payindex;

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

public class PrjTreeIndexQuantityBO extends PmkpiBO {

    private PrjTreeIndexQuantityDAO prjTreeIndexQuantityDAO;

    /**
     * 注入dao.
     * @param prjTreeIndexQuantityDAO
     * @throws
     */
    public void setPrjTreeIndexQuantityDAO(PrjTreeIndexQuantityDAO prjTreeIndexQuantityDAO) {
        this.prjTreeIndexQuantityDAO = prjTreeIndexQuantityDAO;
    }

    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) params.get("tablecode");
        String procode = (String)params.get("procode");
        String payid = (String)params.get("payid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            prjTreeIndexQuantityDAO.setYearAndProvince(queryYear, queryProvince);
        }
        // 根据项目编码和支付ID查询业务数据
        List<Map<String, Object>> datas = prjTreeIndexQuantityDAO.getDatas(tablecode, " t.pro_code = ? and t.payid = ? ","",new String[]{procode,payid});
        if (datas == null || datas.size() == 0) {
            // 业务数据为空获取本项目的年度绩效数量指标
            datas = prjTreeIndexQuantityDAO.getDatas("V_PM_PERF_INDICATOR", " t.pro_code = ? and yearflag = '0' and sindex ='11' ","",new String[]{procode});
            datas.forEach(m -> {m.put("targetvalue",m.get("indexval"));m.put("indexval","");});
        }
        backMap.put("datas", datas);
        return backMap;
    }

    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String procode = (String) params.get("procode");
        String payid = (String)params.get("payid");
        String busguid = (String) params.get("busguid");
        List<Map<String, Object>> templist = new ArrayList<Map<String, Object>>();
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> map : datas) {
            map.put("pro_code", procode);
            map.put("payid", payid);
            map.put("guid", this.getCreateguid());
            map.put("province", CommonUtil.getProvince());
            map.put("year", CommonUtil.getYear());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("createtime", PerfUtil.getServerTimeStamp());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            this.getBasMap(map,"add");
            templist.add(map);
        }
        //删除保存
        String delsql = " pro_code='" + procode + "' and t.payid ='" + payid + "' ";
        prjTreeIndexQuantityDAO.updateIsDeleteDatas(tablecode, delsql);
        prjTreeIndexQuantityDAO.saveAll(datas, tablecode);
        return this.auditdefine(templist, busguid, "perf", null);
    }
}
