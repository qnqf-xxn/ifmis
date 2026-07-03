package gov.mof.fasp2.pmkpi.setting.indexlib.finagive;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class IndFinaGiveDAO extends PmkpiDAO {
    /**
     * 查询部门对应的分类.
     * @param deptcode -- 部门编码
     * @return
     */
    public List findDeptEles(String deptcode) {
        String sql = "select * from v_perf_t_indexfinagive t where t.agencycode = ? order by t.eltwocode";
        return  this.queryForList(sql,new String[]{deptcode});
    }

}
