package gov.mof.fasp2.pmkpi.setting.auditprocess.auditnode;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.appexception.DataSetAppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowPlanDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 12:02 2020/8/14  chongdayong
 */
public class AuditNodeB0 extends PmkpiBO {
    private AuditNodeDAO auditNodeDAO;

    public void setAuditNodeDAO(AuditNodeDAO auditNodeDAO) {
        this.auditNodeDAO = auditNodeDAO;
    }

    /**
     * @Description: 流程方案.
     * @return Map<String, Object>
     * @throws AppException 异常信息
     */
    @SuppressWarnings("rawtypes")
    public Map<String, Object> getLeftTree() throws DataSetAppException, AppException {
        List value = this.queryProcessPlans();
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "流程方案");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", value);
        return leftconfig;
    }

    /**
     * 查询所有启用的方案
     * @return　启用的方案
     * @throws AppException
     * @throws DataSetAppException
     */
    public List<WorkflowPlanDTO> queryProcessPlans() throws AppException {
        List<WorkflowPlanDTO> list = auditNodeDAO.queryWorkflowPlans();
        List tasktype = getTaskTypeLeftTree();
        list.addAll(tasktype);
        return list;
    }

    /**
     * 获取业务系统(树).
     * @return
     * @throws
     * @throws AppException
     * @throws DataSetAppException
     */
    public List getTaskTypeLeftTree() throws AppException {
        IDataSetService ds = PerfServiceFactory.getIDataSetService();
        return ds.getRangesByElementcode("TASKTYPE");
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = "v_perf_t_audittypecfg";
        String wfid = (String)params.get("wfid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> map : datas) {
//            String audittype = (String) map.get("audittype");
//            if (audittype == null || "".equals(audittype)) {
//                map.put("audittype", "opinion");
//            }
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("guid", this.getCreateguid());
        }
        String delsql = " t.wfid='" + wfid + "'";
        auditNodeDAO.delDatas(tablecode, delsql);
        auditNodeDAO.saveAll(datas, tablecode);

    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String wfid = (String)params.get("wfid");
        List<Map<String, Object>> wfdata = auditNodeDAO.getWfNodes(wfid);
        backMap.put("data", wfdata);
        return backMap;
    }
}
