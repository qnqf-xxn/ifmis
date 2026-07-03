package gov.mof.fasp2.pmkpi.setting.typicalcase;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:46 2020/8/18  chongdayong
 */
public class TypicalCaseDAO extends PmkpiDAO {

    /**
     * 模板/案例指标表
     */
    public final String TABLE_PERF_TYPICALCASE= "V_PERF_T_TYPICALCASE";

    public final String TABLE_PERF_TYPICALCASEALL= "V_PERF_T_TYPICALCASEALL";

    public final String CASETYEP_SOURCE = "PERFTYPICALCASETYPE";//左侧树数据源

}
