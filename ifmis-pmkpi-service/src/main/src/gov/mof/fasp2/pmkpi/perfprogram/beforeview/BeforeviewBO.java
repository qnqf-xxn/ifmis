package gov.mof.fasp2.pmkpi.perfprogram.beforeview;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BeforeviewBO extends PmkpiBO {
    private BeforeviewDAO beforeviewDAO;

    public void setBeforeviewDAO(BeforeviewDAO beforeviewDAO) {
        this.beforeviewDAO = beforeviewDAO;
    }

    /**
     * 查询编辑区数据
     * @param proguid
     * @param adjadd
     * @param selectbillguid
     * @return
     */
    public Map<String, Object> getBeforeview(String proguid, String adjadd, String selectbillguid){
        String wheresql = "mainguid=?";
        Map<String, Object> beforeviewMap = beforeviewDAO.getDataMap(beforeviewDAO.PERF_VIEW_BEFOREVIEW, wheresql, new String[]{proguid});
        //调整阶段，调整数据没有时，查询调整前数据
        if ("1".equals(adjadd) && beforeviewMap.isEmpty()) {
            logger.debug("调整数据不存在，查询调整前数据：调整前项目guid:" + proguid + "，调整后项目guid:" + selectbillguid);
            //不存在调整数据，查询调整前数据
            beforeviewMap = beforeviewDAO.getDataMap(beforeviewDAO.PERF_VIEW_BEFOREVIEW, wheresql, new String[]{selectbillguid});
        }
        return beforeviewMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String pro_code = (String) params.get("pro_code");
        List<Map<String, Object>> list = new ArrayList<>(); //指标集合
        Map<String, Object> edifinfo = (Map<String, Object>) params.get("edifinfo");
        //删除保存
        String wheresql = " mainguid = ?";
        if (edifinfo != null && !edifinfo.isEmpty()) {
            Map<String, Object> infodata = beforeviewDAO.getDataMap(beforeviewDAO.PERF_VIEW_BEFOREVIEW, wheresql, new String[]{proguid});
            if (infodata.isEmpty()) {
                edifinfo.put("pro_code", pro_code);
                edifinfo.put("province", CommonUtil.getProvince());
                edifinfo.put("guid", CommonUtil.createGUID());
                edifinfo.put("createtime", PerfUtil.getServerTimeStamp());
                edifinfo.put("updatetime", PerfUtil.getServerTimeStamp());
                edifinfo.put("creater", SecureUtil.getCurrentUser().getGuid());
                edifinfo.put("year", CommonUtil.getYear());
                edifinfo.put("agencyguid", saveAgency);
                edifinfo.put("mainguid", proguid);
                edifinfo.put("is_deleted", 2);
                beforeviewDAO.save(edifinfo, beforeviewDAO.PERF_VIEW_BEFOREVIEW);
            } else {
                infodata.putAll(edifinfo);
                infodata.put("mainguid", proguid);
                infodata.put("pro_code", pro_code);
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                beforeviewDAO.update(infodata, beforeviewDAO.PERF_VIEW_BEFOREVIEW);
            }
        }
        return this.auditdefine(list, busguid,"perf", null);
    }
}
