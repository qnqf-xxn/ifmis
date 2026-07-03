package gov.mof.fasp2.pmkpi.perfprotrace.dept.task;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.Map;

public class DeptTaskBO extends PmkpiBO {
    private DeptTaskDAO deptTaskDAO;

    public void setDeptTaskDAO(DeptTaskDAO deptTaskDAO) {
        this.deptTaskDAO = deptTaskDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //页签过滤sql
        String proguid = (String) sqlmap.get("proguid");
        String sql = "select t.* from " + tablecode + " t where mainguid='" + proguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            sql += " and " + tablesql;
        }
        return sql;
    }

}
