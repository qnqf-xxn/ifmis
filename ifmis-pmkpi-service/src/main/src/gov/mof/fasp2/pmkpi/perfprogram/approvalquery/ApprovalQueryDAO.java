package gov.mof.fasp2.pmkpi.perfprogram.approvalquery;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ApprovalQueryDAO extends PmkpiDAO {

    /**
     * 根据权限获取单位
     *
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select a.* from PMKPI_FASP_T_PUBAGENCY a where exists (select 1 from "
                + tablecode + " t where " + wheresql + " and a.guid = t.agencyguid) order by code";
        logger.info("---根据权限查询单位：" + sql);
        return this.queryForList(sql);
    }
}
