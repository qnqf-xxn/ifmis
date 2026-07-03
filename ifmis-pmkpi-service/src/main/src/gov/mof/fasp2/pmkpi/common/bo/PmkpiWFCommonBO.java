package gov.mof.fasp2.pmkpi.common.bo;

import gov.mof.fasp2.buscommon.bill.bo.CommonBO;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.datacommon.workflow.dao.WorkflowStepDAO;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowStepDTO;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

public class PmkpiWFCommonBO extends CommonBO{

	/**
	 * 日志.
	 */
	protected Logger logger = Logger.getLogger(PmkpiWFCommonBO.class);

	@Resource(name = "datacommon.wf.WorkflowStepDAO")
	private WorkflowStepDAO dao;
	
	public String getWfidByBilltypeid(String billtypeid){
		String wfid = "";
		String getWfidSql = "select guid from BUSFW_T_DCWORKFLOWPLAN where code ='" + billtypeid + "'";
		List mapwfids = dao.queryForList(getWfidSql);//List<Map>类型的流程方案ids
		//List<String> wfids = new ArrayList<String>();
		if(null!=mapwfids&&mapwfids.size()>0){
			wfid = (String)((Map)mapwfids.get(0)).get("guid");
		}
		return wfid;
	}
	
	public List<WorkflowStepDTO> queryWorkflowStepByWfId(String wfid){
		try {
			return dao.queryWorkflowStepByWfId(wfid);
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}
	
	public List<WorkflowBranchDTO> queryWorkflowBranchsByWfIds(List<String> wfids, String userid) throws AppException {
		return dao.queryWorkflowBranchsByWfIds(wfids, userid);
    }
	
	public WorkflowStepDTO getWorkflowStep(String stepid) {
		return dao.getWorkflowStep(stepid);
    }

	public String getWfstatus(String wfid, String wfstatus, String tabnum, String billid) {
		UserDTO user = CommonUtil.getCurrentUser();
		String sql = "select * from BUSFW_T_DCWORKFLOWLOGS where wfid='"+wfid+"' and billid='"+billid+"' and userid = '"+user.getGuid()+"' order by createtime desc";
		List<Map> list = dao.queryForList(sql);
		String done ="done";
		String ever ="ever";
		if (tabnum.equals(done)){
			wfstatus = (String) list.get(0).get("prevwfstatus");
		} else if (tabnum.equals(ever)){
			wfstatus = (String) list.get(0).get("wfstatus");
		}
		return wfstatus;
	}

	public boolean getRoleCount(String userguid, String roleName) {
		boolean tags = false;
		String sql = "select count(*) from fasp_t_causerrole where userguid = '"+userguid+"' and roleguid in (select guid from fasp_t_carole where name = '"+roleName+"')";
		int rolecount = this.dao.queryForInt(sql);
		if(rolecount > 0){
			tags = true;
		}
		return tags;
	}
}
