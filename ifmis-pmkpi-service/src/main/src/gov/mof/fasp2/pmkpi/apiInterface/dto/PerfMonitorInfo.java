
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfMonitorInfo
 * 监控基本信息
 */
public class PerfMonitorInfo {
    private String guid;              // 监控信息主键
    private String proCode;           // 项目编码
    private String proName;           // 项目名称
    private String agencyCode;        // 单位编码
    private String agencyName;        // 单位名称
    private String taskstage;         // 监控阶段
    private String createTime;        // 创建时间
    private String updateTime;        // 更新时间
    private String yeargoaltion;      // 年度绩效目标
    private String yeargoalExecution; // 绩效目标执行情况
    private BigDecimal proTotalAmt;   // 项目总额
    private List<BudgetExecutionTrace> protracebgtlist; // 预算执行情况
    private List<MonitorIndex> protraceindexlist;  // 绩效监控指标
    private List<AnnualIndex> proindexlist;        // 年度绩效指标

    // Getters and Setters

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getProCode() {
        return proCode;
    }

    public void setProCode(String proCode) {
        this.proCode = proCode;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getAgencyCode() {
        return agencyCode;
    }

    public void setAgencyCode(String agencyCode) {
        this.agencyCode = agencyCode;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getTaskstage() {
        return taskstage;
    }

    public void setTaskstage(String taskstage) {
        this.taskstage = taskstage;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getYeargoaltion() {
        return yeargoaltion;
    }

    public void setYeargoaltion(String yeargoaltion) {
        this.yeargoaltion = yeargoaltion;
    }

    public String getYeargoalExecution() {
        return yeargoalExecution;
    }

    public void setYeargoalExecution(String yeargoalExecution) {
        this.yeargoalExecution = yeargoalExecution;
    }

    public BigDecimal getProTotalAmt() {
        return proTotalAmt;
    }

    public void setProTotalAmt(BigDecimal proTotalAmt) {
        this.proTotalAmt = proTotalAmt;
    }

    public List<BudgetExecutionTrace> getProtracebgtlist() {
        return protracebgtlist;
    }

    public void setProtracebgtlist(List<BudgetExecutionTrace> protracebgtlist) {
        this.protracebgtlist = protracebgtlist;
    }

    public List<MonitorIndex> getProtraceindexlist() {
        return protraceindexlist;
    }

    public void setProtraceindexlist(List<MonitorIndex> protraceindexlist) {
        this.protraceindexlist = protraceindexlist;
    }

    public List<AnnualIndex> getProindexlist() {
        return proindexlist;
    }

    public void setProindexlist(List<AnnualIndex> proindexlist) {
        this.proindexlist = proindexlist;
    }
}
