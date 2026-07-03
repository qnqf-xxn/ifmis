package gov.mof.fasp2.pmkpi.probleamtask;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class ProblemTaskDAO extends PmkpiDAO  {
    /**
     * 临时表.
     */
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";

    /**
     * 任务主表.
     */
    public static final String PERF_TABLE_PROBLEMTASK = "V_PERF_T_PROBLEMTASK";

    /**
     * 反馈主表.
     */
    public static final String PERF_TABLE_PROBLEMFEEDBACK = "V_PERF_T_PROBLEMFEEDBACK";

    /**
     * 业务查询视图，带附件.
     */
    public static final String PERF_TABLE_PROBLEMTASKQUERY = "V_PERF_T_PROBLEMTASKQUERY";

    /**
     * 附件表.
     */
    public static final String PERF_TABLE_FILE = "V_PERF_FILE";

}
