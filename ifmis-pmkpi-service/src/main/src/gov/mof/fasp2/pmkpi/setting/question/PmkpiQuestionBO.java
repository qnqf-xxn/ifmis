package gov.mof.fasp2.pmkpi.setting.question;

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

public class PmkpiQuestionBO extends PmkpiBO {
	
	private PmkpiQuestionDAO pmkpiQuestionDAO;

	public void setPmkpiQuestionDAO(PmkpiQuestionDAO pmkpiQuestionDAO) {
		this.pmkpiQuestionDAO = pmkpiQuestionDAO;
	}

	public Object getLeftTree() throws DataSetAppException, AppException {
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
	@SuppressWarnings("rawtypes")
    public List<WorkflowPlanDTO> queryProcessPlans() throws DataSetAppException, AppException {
        List<WorkflowPlanDTO> list = pmkpiQuestionDAO.queryWorkflowPlans();
		List nodelist = pmkpiQuestionDAO.getWfNodes(null);
        list.addAll(nodelist);
        return list;
    }
    
    /**
     * 获取业务系统(树).
     * @return
     * @throws
     * @throws AppException
     * @throws DataSetAppException
     */
    public List getTaskTypeLeftTree() throws DataSetAppException, AppException {
        IDataSetService ds = PerfServiceFactory.getIDataSetService();
        return ds.getRangesByElementcode("TASKTYPE");
    }

	public Map<String, Object> getTableTree(String wfid) {
		 Map<String, Object> backMap = new HashMap<String, Object>();
	     List<Map<String, Object>> wfdata = pmkpiQuestionDAO.getWfNodes(wfid);
	     backMap.put("data", wfdata);
	     return backMap;
	}
	
	/**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String nodeguid = (String) params.get("nodeguid");
        String wfid = (String) params.get("wfid");
        int i = 1;
        pmkpiQuestionDAO.deldata(nodeguid);
        for (Map<String, Object> map : datas) {
            map.put("ordernum", i++);
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("status", 1);
            map.put("nodeguid", nodeguid);
            map.put("wfid", wfid);
        }
        pmkpiQuestionDAO.saveAll(datas, tablecode);
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
	public Map<String, Object> getData(HashMap<String, Object> params) {
		Map<String, Object> backMap = new HashMap<String, Object>();
        String wfid = (String)params.get("wfid");
        List<Map<String, Object>> wfdata = pmkpiQuestionDAO.getQuestion(wfid);
        backMap.put("data", wfdata);
        return backMap;
	}
	
}
