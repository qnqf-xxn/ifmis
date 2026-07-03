
package gov.mof.fasp2.pmkpi.apiInterface.dto;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: AnnualIndex
 * 年度绩效指标
 */
public class AnnualIndex {
    private String findexName;   // 一级指标名称
    private String sindexName;   // 二级指标名称
    private String indiName;     // 三级指标名称
    private String computesign;  // 计算符号
    private String meterunit;    // 计量单位
    private String indexval;     // 年度指标值

    // Getters and Setters
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

    public String getIndexval() {
        return indexval;
    }

    public void setIndexval(String indexval) {
        this.indexval = indexval;
    }
}
