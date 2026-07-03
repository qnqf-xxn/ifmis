package gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine;

import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:24 2020/9/19  chongdayong
 */
public class BusAuditDefineDAO extends PmkpiDAO {

    /**
     * 获取菜单树数据.
     * @return --
     */
    public List<Map<String, Object>> getMenuTree() {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from (select t.guid,t.code,t.name,t.parentid superguid,t.levelno,0 isleaf,t.menuorder as ordernum, url from fasp_t_pubmenu t where t.appid like '%pmkpi%' " +
                " union all " +
                "select a.guid,a.code,a.name,a.superid superguid,a.levelno,a.isleaf,a.ordernum, '' as url from perf_t_auditdefinemenu a ) order by code,ordernum ");
        return this.queryForList(sql.toString());
    }

    /**
     * 获取工作流数据.
     * @return --
     */
    public List<Map<String, Object>> getWfStatusTree() {
        String sql = "select t.code guid,t.code,t.name,t.superguid,t.levelno,t.isleaf from fasp_t_pubwfstatus t order by t.code";
        return this.queryForList(sql);
    }

    /**
     * 删除扩展菜单.
     * @param menuid --菜单guid
     */
    public void delMenuByGuid(String menuid) throws PerfAppException {
        String sql = "delete from perf_t_auditdefinemenu t where t.guid='" + menuid + "'";
        this.execute(sql);
    }
}
