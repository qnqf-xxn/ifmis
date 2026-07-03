
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import java.math.BigDecimal;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: BudgetExecutionTrace
 * 预算执行情况
 */
public class BudgetExecutionTrace {
    private String mainguid;   // 监控信息主键
    private String name;       // 资金来源
    private BigDecimal amt1;   // 年初预算
    private BigDecimal amt2;   // 调整预算数
    private BigDecimal amt3;   // 调整后预算数
    private BigDecimal amt4;   // 预算执行数
    private BigDecimal amt6;   // 预算执行数(其他)
    private BigDecimal bgtget; // 预算执行率(%)

    // Getters and Setters

    public String getMainguid() {
        return mainguid;
    }

    public void setMainguid(String mainguid) {
        this.mainguid = mainguid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getAmt1() {
        return amt1;
    }

    public void setAmt1(BigDecimal amt1) {
        this.amt1 = amt1;
    }

    public BigDecimal getAmt2() {
        return amt2;
    }

    public void setAmt2(BigDecimal amt2) {
        this.amt2 = amt2;
    }

    public BigDecimal getAmt3() {
        return amt3;
    }

    public void setAmt3(BigDecimal amt3) {
        this.amt3 = amt3;
    }

    public BigDecimal getAmt4() {
        return amt4;
    }

    public void setAmt4(BigDecimal amt4) {
        this.amt4 = amt4;
    }

    public BigDecimal getAmt6() {
        return amt6;
    }

    public void setAmt6(BigDecimal amt6) {
        this.amt6 = amt6;
    }

    public BigDecimal getBgtget() {
        return bgtget;
    }

    public void setBgtget(BigDecimal bgtget) {
        this.bgtget = bgtget;
    }
}
