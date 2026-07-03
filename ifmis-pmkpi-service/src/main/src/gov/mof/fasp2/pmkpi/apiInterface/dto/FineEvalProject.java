
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: FineEvalProject
 * 财政评价关联项目明细
 */
public class FineEvalProject {
    private String mainguid;            // 财政评价信息主键
    private String proCode;             // 项目编码
    private String proName;             // 项目名称
    private String agencyCode;          // 单位编码
    private String agencyName;          // 单位名称
    private List<PerfMonitorInfo> protraceinfolist;      // 监控信息列表
    @JsonProperty("proselfevalinfomap")
    private SelfEvalInfo selfEvalInfo; // 自评信息

    public String getMainguid() { return mainguid; }
    public void setMainguid(String mainguid) { this.mainguid = mainguid; }

    public String getProCode() { return proCode; }
    public void setProCode(String proCode) { this.proCode = proCode; }

    public String getProName() { return proName; }
    public void setProName(String proName) { this.proName = proName; }

    public String getAgencyCode() { return agencyCode; }
    public void setAgencyCode(String agencyCode) { this.agencyCode = agencyCode; }

    public String getAgencyName() { return agencyName; }
    public void setAgencyName(String agencyName) { this.agencyName = agencyName; }

    public List<PerfMonitorInfo> getProtraceinfolist() { return protraceinfolist; }
    public void setProtraceinfolist(List<PerfMonitorInfo> protraceinfolist) { this.protraceinfolist = protraceinfolist; }

    public SelfEvalInfo getSelfEvalInfo() {return selfEvalInfo;}
    public void setSelfEvalInfo(SelfEvalInfo selfEvalInfo) {this.selfEvalInfo = selfEvalInfo;}

}
