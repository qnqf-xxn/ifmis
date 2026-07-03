package gov.mof.fasp2.pmkpi.componentAllot;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PerfComponentRuleDAO extends PmkpiDAO {

    public static final String PERF_TABLE_COMPONET_POWER = "v_perf_componet_power";

    /**
     * 获取左侧树数据.
     * @return --
     */
    public List getTreeData(String roleguid, String wheresql) {
        StringBuffer sql = new StringBuffer();
        sql.append("select * from (select guid,code,name,substr (t.url,0, instr(t.url, '.page', 1, 1) - 1) uikey,");
        sql.append("parentid superguid,levelno,isleaf,t.menuorder ordernum,'' menutype from fasp_t_pubmenu t where t.appid='pmkpi'");
        sql.append("and guid in (select menuguid from FASP_T_CAROLEMENU t1 where t1.roleguid = '"+roleguid+"') ");
        sql.append("and name not like'%(隐藏)' and name not like'%（隐藏）'");
        sql.append(" union all ");
        sql.append("select guid,code,name,uikey,superguid,levelno,isleaf,ordernum,'perfmenu' menutype from perf_t_pagemenu t "+wheresql+") order by code,ordernum");
        List list = this.queryForList(sql.toString());
        return list;
    }

    /**
     * 查询角色已经分配的菜单.
     * @return
     * @throws
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getUIMenuByRoleId(String roleid) {
        String sql = "select distinct * from (select a.guid, url, code, name,parentid from fasp_t_pubmenu a where a.appid='pmkpi' union " +
                " select a.guid, uikey, code, name,superguid as parentid from perf_t_pagemenu a) b" +
                " start with exists (select 1 from " + this.PERF_TABLE_COMPONET_POWER + " t where t.roleguid = '" + roleid + "'" +
                " and t.menuguid = b.guid) connect by prior b.parentid = b.guid order by code";
        logger.info("---查询角色已经分配组件数据权限的菜单sql：" + sql);
        return this.queryForList(sql);
    }

    public List<Map<String, Object>> getUiDatas(String key, String tablecode, String cols) {
        String sql = "select t.* " + cols + " from "+ tablecode +" t where t.key = '" + key + "' order by t.ordernum asc";
        return this.queryForList(sql);
    }

    public void delDataOpe(String roleid, String menuguid, String componentid) throws AppException {
        String sql = "delete from " + this.PERF_TABLE_COMPONET_POWER + " t where t.roleguid = '" + roleid + "' and t.menuguid = '" + menuguid + "'" + " and componentid='" + componentid + "'";
        this.execute(sql);
    }

}
