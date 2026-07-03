package gov.mof.fasp2.pmkpi.evaluation.dept.third;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p></p >
 *
 * @author hw
 * @date 2022/12/6 15:32
 */
public class ThirdPartyBO extends PmkpiBO {
    private ThirdPartyDAO thirdPartyDAO;

    public void setThirdPartyDAO(ThirdPartyDAO thirdPartyDAO) {
        this.thirdPartyDAO = thirdPartyDAO;
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
        String tablesql = (String)params.get("tablesql");
        String orderby = (String)params.get("orderby");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            wheresql += " and " + tablesql;
        }
        List<Map<String, Object>>  data = thirdPartyDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode"); //表名
        String busguid = (String) params.get("busguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas"); //全部数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas"); //删除数据
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("guid", this.getCreateguid());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("create_time", StringUtil.getSysDBDate());
                map.put("update_time", StringUtil.getSysDBDate());
                map.put("is_deleted", "2");
                map.put("year", CommonUtil.getYear());
                map.put("province", SecureUtil.getUserSelectProvince());
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            thirdPartyDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            thirdPartyDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deldatas.forEach(map ->{
                map.put("is_deleted","1");
            });
            thirdPartyDAO.updateAllByPK(deldatas, "guid", tablecode);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

}
