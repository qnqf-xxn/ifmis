package gov.mof.fasp2.pmkpi.setting.perfcarryover;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class PerfCarryOverDAO extends PmkpiDAO  {

    /**
     * 项目目标表
     */
    public static final String PMKPI_TABLE_PM_GOAL = "PM_PERF_GOAL_INFO";

    /**
     * 项目指标表
     */
    public static final String PMKPI_TABLE_PM_INDICATOR = "PM_PERF_INDICATOR";

    /**
     * 未结转来源
     */
    public static final String PMKPI_TABLE_PROJECTSOURCE = "V_PERF_PROJECT_CARRYOVER_CHECK";

    /**
     * 结转表
     */
    public static final String PMKPI_TABLE_CARRYOVERTABLE = "V_PERF_PROJECT_CARRYOVER";



}
