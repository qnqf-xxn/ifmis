
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import java.math.BigDecimal;


/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: MonitorIndex
 * 自评指标完成情况
 */
public class SelfEvalIndex {
    private String mainguid;        // 自评信息主键
    private String findexName;      // 一级指标名称
    private String sindexName;      // 二级指标名称
    private String indiName;        // 三级指标名称
    private String computesign;     // 计算符号
    private String meterunit;       // 计量单位
    private String indexval;        // 年度指标值
    private String actualvalue;     // 实际完成值
    private BigDecimal actualweight;// 权重
    private BigDecimal score;       // 实际得分
    private String kpiRemark;       // 偏差原因及改进措施
    private String indRemark;       // 指标情况完成说明

    public String getMainguid() {return mainguid;}
    public void setMainguid(String mainguid) {this.mainguid = mainguid;}

    public String getFindexName() { return findexName; }
    public void setFindexName(String findexName) { this.findexName = findexName; }

    public String getSindexName() { return sindexName; }
    public void setSindexName(String sindexName) { this.sindexName = sindexName; }

    public String getIndiName() { return indiName; }
    public void setIndiName(String indiName) { this.indiName = indiName; }

    public BigDecimal getScore() { return score; }
    public void setScore(BigDecimal score) { this.score = score; }

    public String getKpiRemark() { return kpiRemark; }
    public void setKpiRemark(String kpiRemark) { this.kpiRemark = kpiRemark; }

    public String getIndRemark() { return indRemark; }
    public void setIndRemark(String indRemark) { this.indRemark = indRemark; }

    public String getComputesign() {return computesign;}
    public void setComputesign(String computesign) {this.computesign = computesign;}

    public String getMeterunit() {return meterunit;}
    public void setMeterunit(String meterunit) {this.meterunit = meterunit;}

    public String getIndexval() {return indexval;}
    public void setIndexval(String indexval) {this.indexval = indexval;}

    public String getActualvalue() {return actualvalue;}
    public void setActualvalue(String actualvalue) {this.actualvalue = actualvalue;}

    public BigDecimal getActualweight() {return actualweight;}
    public void setActualweight(BigDecimal actualweight) {this.actualweight = actualweight;}
}
