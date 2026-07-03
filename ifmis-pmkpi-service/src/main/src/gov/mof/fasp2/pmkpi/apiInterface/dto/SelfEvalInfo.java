
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import java.util.List;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: MonitorIndex
 * 自评基本信息
 */
public class SelfEvalInfo {
    private String guid;              // 自评信息主键
    private String proCode;           // 项目编码
    private String proName;           // 项目名称
    private String agencyCode;        // 单位编码
    private String agencyName;        // 单位名称
    private String yeargoaltion;      // 年度绩效目标
    private String yeargoalExecution; // 绩效目标执行情况
    private List<BudgetExecutionSelf> proselfevalbgtlist;   // 自评预算执行情况
    private List<SelfEvalIndex> proselfevalindexlist;       // 自评指标完成情况

    public String getGuid() { return guid; }
    public void setGuid(String guid) { this.guid = guid; }

    public String getProCode() { return proCode; }
    public void setProCode(String proCode) { this.proCode = proCode; }

    public String getProName() { return proName; }
    public void setProName(String proName) { this.proName = proName; }

    public String getAgencyCode() { return agencyCode; }
    public void setAgencyCode(String agencyCode) { this.agencyCode = agencyCode; }

    public String getAgencyName() { return agencyName; }
    public void setAgencyName(String agencyName) { this.agencyName = agencyName; }

    public String getYeargoaltion() {return yeargoaltion;}
    public void setYeargoaltion(String yeargoaltion) {this.yeargoaltion = yeargoaltion;}

    public String getYeargoalExecution() {return yeargoalExecution;}
    public void setYeargoalExecution(String yeargoalExecution) {this.yeargoalExecution = yeargoalExecution;}

    public List<BudgetExecutionSelf> getProselfevalbgtlist() { return proselfevalbgtlist; }
    public void setProselfevalbgtlist(List<BudgetExecutionSelf> proselfevalbgtlist) { this.proselfevalbgtlist = proselfevalbgtlist; }

    public List<SelfEvalIndex> getProselfevalindexlist() { return proselfevalindexlist; }
    public void setProselfevalindexlist(List<SelfEvalIndex> proselfevalindexlist) { this.proselfevalindexlist = proselfevalindexlist; }
}
