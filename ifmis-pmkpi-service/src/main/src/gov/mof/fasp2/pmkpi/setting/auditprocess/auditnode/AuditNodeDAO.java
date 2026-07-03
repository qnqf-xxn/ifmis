package gov.mof.fasp2.pmkpi.setting.auditprocess.auditnode;

import gov.mof.fasp2.buscore.framework.daosupport.rowmapper.FaspDTORowMapper;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowPlanDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 12:02 2020/8/14  chongdayong
 */
public class AuditNodeDAO extends PmkpiDAO {
    /**
     * 流程表
     */
    public static final String WORKFLOWPLAN_TABLE = "BUSFW_T_DCWORKFLOWPLAN";

    /**
     * 流程节点表
     */
    public static final String WORKFLOWSTEP_TABLE = "BUSFW_T_DCWORKFLOWSTEP";

    /**
     * 查询所有启用的方案
     * @return　启用的方案
     */
    @SuppressWarnings("unchecked")
    public List<WorkflowPlanDTO> queryWorkflowPlans() {
        String sql = "select t.*,t.type superguid, '1' as isleaf from " + WORKFLOWPLAN_TABLE + " t where status = '1' order by code";
        List<WorkflowPlanDTO> datas = this.query(sql, new FaspDTORowMapper(WorkflowPlanDTO.class, null));
        return datas;
    }

    /**
     * 获取列表节点数据
     * @param wfid --
     * @return
     */
    public List<Map<String, Object>> getWfNodes(String wfid) {
        String sql = "select w.guid nodeguid,w.wfid,w.name,w.orderno,w.stage,t.audittype  from "+ WORKFLOWSTEP_TABLE +" w " +
                "left join v_perf_t_audittypecfg t on w.wfid=t.wfid and w.guid=t.nodeguid where w.wfid='" + wfid + "' order by w.orderno";
        return this.queryForList(sql);
    }
}
