package gov.mof.fasp2.pmkpi.evaluate.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluate.dao.PreEvaluateOpinionDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreEvaluateOpinionBo extends PmkpiBO {

    private PreEvaluateOpinionDAO preEvaluateOpinionDAO;

    public void setPreEvaluateOpinionDAO(PreEvaluateOpinionDAO preEvaluateOpinionDAO) {
        this.preEvaluateOpinionDAO = preEvaluateOpinionDAO;
    }

    /**
     * 获取目标数据
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByGuid(String proguid){
        return preEvaluateOpinionDAO.getDatas("perf_preevaluate_opinion", " mainguid='" + proguid + "'", null);
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String workflow = (String) params.get("workflow");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String wheresql = " mainguid='" + proguid + "'";
        int i = preEvaluateOpinionDAO.getDataCount("PERF_PREEVALUATE_OPINION", wheresql);
        editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
        if (i > 0) {
            List<String> cols = new ArrayList<String>(editinfo.keySet());
            preEvaluateOpinionDAO.update(cols, editinfo, "PERF_PREEVALUATE_OPINION");
        } else {
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("mainguid", proguid);
            editinfo.put("creater", SecureUtil.getCurrentUserID());
            editinfo.put("province", SecureUtil.getUserSelectProvince());
            editinfo.put("year", CommonUtil.getYear());
            editinfo.put("createtime", PerfUtil.getServerTimeStamp());
            editinfo.put("mainguid", proguid);
            preEvaluateOpinionDAO.save(editinfo, "PERF_PREEVALUATE_OPINION");
        }
        wheresql = " t.guid='"+proguid+"'";
        List<Map<String, Object>> list = preEvaluateOpinionDAO.getDatas("v_perf_t_review",wheresql, null);
        this.workflow("audit",workflow, "", "v_perf_t_review", list);
        Map remap = new HashMap();
        remap.put("redata",new ArrayList());
        remap.put("success", true);
        return remap;
    }
}
