/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:42:14
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 */

public class FundCalIndexDAO extends PmkpiDAO {
    public static final String PMKPI_TABLE_TMP_AGENCY = "PERF_TMP_AGENCY";
    //部门绩效指标的menuid，用来获取数据权限
    public static final String PMKPI_PRJ_MENUID = "deptperformancehide";

    //模板库的表
    public static final String PMKPI_PERF_T_CASEMODELINDEX = "PERF_T_CASEMODELINDEX";

    /**
     * 指标表.
     */
    public static final String PMKPI_TABLE_PM_INDEX = "V_PM_PERF_INDICATOR";

    /**
     * 项目表.
     */
    public static final String PMKPI_TABLE_PROJECT = "V_PERF_PROJECT_INFO";


    /**
     * 根据项目，年度，查询年度明细指标.
     *
     * @param proGuid   -- 项目guid.
     * @param tableCode -- 查询案例表或项目指标表
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String proGuid, String tableCode) {
//        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        StringBuffer sql = new StringBuffer();
        sql.append("select * from ").append(tableCode).append(" t where t.procode = '");
        sql.append(proGuid).append("' ");
        sql.append(" order by t.xmmxnr,t.sindex,t.findex,t.ordernum");
        logger.debug("-------------指标查询sql-------------" + sql.toString());
        return this.queryForList(sql.toString());
    }

}
