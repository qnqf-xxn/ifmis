package gov.mof.fasp2.pmkpi.setting.question;

import gov.mof.fasp2.buscore.framework.daosupport.rowmapper.FaspDTORowMapper;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowPlanDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PmkpiQuestionDAO extends PmkpiDAO {
	
	/**
     * 流程表
     */
    public static final String WORKFLOWPLAN_TABLE = "BUSFW_T_DCWORKFLOWPLAN";

    /**
     * 流程节点表
     */
    public static final String WORKFLOWSTEP_TABLE = "BUSFW_T_DCWORKFLOWSTEP";
    
    public static final String QUESTION_TABLE = "PERF_T_QUESTION";

    /**
     * 查询所有启用的方案
     * @return　启用的方案
     */
    @SuppressWarnings("unchecked")
    public List<WorkflowPlanDTO> queryWorkflowPlans() {
        String sql = "select m.*, '00' superguid,'0' isleaf, '1' as levelno from  BUSFW_T_DCWORKFLOWPLAN m "
        	+" where m.TYPE in(select guid from  busfw_t_dctasktype where code='pmkpi') order by m.code";
        List<WorkflowPlanDTO> datas = this.query(sql, new FaspDTORowMapper(WorkflowPlanDTO.class, null));
        return datas;
    }

	public List<Map<String, Object>> getWfNodes(String wfid) {
		String sql = "select t.*,t.wfid superguid, '1' as isleaf,'2' as levelno  from "+ WORKFLOWSTEP_TABLE +" " +
				" t where t.WFID in (select m.guid from BUSFW_T_DCWORKFLOWPLAN m " +
				" where m.TYPE in(select guid from  busfw_t_dctasktype where code='pmkpi')) ";
		return this.queryForList(sql);
	}

	/**
     * 查询数据.
     * @param wfid --
     * @return --
     */
	public List<Map<String, Object>> getQuestion(String wfid) {
		String sql = "select * from "+ QUESTION_TABLE +" t " +
        " where t.nodeguid='" + wfid + "' order by t.ordernum";
		return this.queryForList(sql);
	}

	public void deldata(String nodeguid) {
		String sql = "delete from " + QUESTION_TABLE + " t where t.nodeguid = '" + nodeguid + "'";
		this.execute(sql);
	}

}
