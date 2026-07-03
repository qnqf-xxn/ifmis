
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import java.util.List;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: FineEvalInfo
 * 财政评价基本信息
 */
public class FineEvalInfo {
    private String guid;              // 财政评价信息主键
    private String proCode;           // 项目编码
    private String proName;           // 项目名称
    private String agencyCode;        // 单位编码
    private String agencyName;        // 单位名称
    private String createTime;        // 创建时间
    private String updateTime;        // 更新时间
    private List<FineEvalProject> finevalprolist; // 财政评价关联项目明细

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

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }

    public List<FineEvalProject> getFinevalprolist() { return finevalprolist; }
    public void setFinevalprolist(List<FineEvalProject> finevalprolist) { this.finevalprolist = finevalprolist; }
}
