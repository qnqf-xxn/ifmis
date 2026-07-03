package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:46 2020/8/18  chongdayong
 */
public class ModelCaseDAO extends PmkpiDAO {

    /**
     * 模板/案例指标表
     */
    public final String TABLE_PERF_CASEMODELINDEX = "perf_t_casemodelindex";

    /**
     * 左侧树.
     * @return list.
     */
    public List<Map<String, Object>> getLeftTree() {
        String province = SecureUtil.getUserSelectProvince();
        String year = CommonUtil.getYear();
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from v_perf_t_framesystem t where t.province='")
        .append(province).append("' and t.year=").append(year);
        return this.queryForList(sql.toString());
    }

    /**
     * 获取层次分类
     *
     * @param framesystem --绩效体系
     * @return
     */
    public List<Map<String, Object>> getFrame(String framesystem) {
        String sql = "select t.guid itemid,t.name,t.code,t.levelno,t.isleaf,t.superid superitemid from " + PMKPI_TABLE_T_FRAME + " t where t.frametype='" + framesystem + "' order by code";
        return this.queryForList(sql);
    }

    /**
     * 获取最大排序
     * @param tablecode
     * @param mainguid
     * @return
     */
    public int getOrdernum(String mainguid, String tablecode) {
        String sql = "select case when max(ordernum) is null then 0 else max(ordernum) end  ordernum from " + tablecode + " where mainguid='" + mainguid + "'";
        return this.queryForInt(sql);
    }
}
