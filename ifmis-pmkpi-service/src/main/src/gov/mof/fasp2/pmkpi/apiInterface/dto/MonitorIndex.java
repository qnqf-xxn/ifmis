
package gov.mof.fasp2.pmkpi.apiInterface.dto;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: MonitorIndex
 * 绩效监控指标完成情况
 */
public class MonitorIndex {
    private String mainguid;            // 监控信息主键
    private String findexName;          // 一级指标名称
    private String sindexName;          // 二级指标名称
    private String indiName;            // 三级指标名称
    private String computesign;         // 计算符号
    private String meterunit;           // 计量单位
    private String targetvalue;         // 年度指标值
    private String indexval;            // 当前完成值
    private String completeanalysis;    // 完成可能性分析
    private String completeanalyscon;   // 全年预计完成情况
    private String deviationanalysis;   // 偏差原因分析
    private String warn;                // 序时进度预警
    private String remark;              // 备注


    // Getters and Setters
    public String getMainguid() {
        return mainguid;
    }

    public void setMainguid(String mainguid) {
        this.mainguid = mainguid;
    }

    public String getFindexName() {
        return findexName;
    }

    public void setFindexName(String findexName) {
        this.findexName = findexName;
    }

    public String getSindexName() {
        return sindexName;
    }

    public void setSindexName(String sindexName) {
        this.sindexName = sindexName;
    }

    public String getIndiName() {
        return indiName;
    }

    public void setIndiName(String indiName) {
        this.indiName = indiName;
    }

    public String getComputesign() {
        return computesign;
    }

    public void setComputesign(String computesign) {
        this.computesign = computesign;
    }

    public String getMeterunit() {
        return meterunit;
    }

    public void setMeterunit(String meterunit) {
        this.meterunit = meterunit;
    }

    public String getTargetvalue() {
        return targetvalue;
    }

    public void setTargetvalue(String targetvalue) {
        this.targetvalue = targetvalue;
    }

    public String getIndexval() {
        return indexval;
    }

    public void setIndexval(String indexval) {
        this.indexval = indexval;
    }

    public String getCompleteanalysis() {
        return completeanalysis;
    }

    public void setCompleteanalysis(String completeanalysis) {
        this.completeanalysis = completeanalysis;
    }

    public String getCompleteanalyscon() {
        return completeanalyscon;
    }

    public void setCompleteanalyscon(String completeanalyscon) {
        this.completeanalyscon = completeanalyscon;
    }

    public String getDeviationanalysis() {
        return deviationanalysis;
    }

    public void setDeviationanalysis(String deviationanalysis) {
        this.deviationanalysis = deviationanalysis;
    }

    public String getWarn() {
        return warn;
    }

    public void setWarn(String warn) {
        this.warn = warn;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
