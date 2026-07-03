
package gov.mof.fasp2.pmkpi.apiInterface.dto;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfQueryRequest
 * 绩效查询请求参数
 */
public class PerfQueryRequest {

    private String province; // 财政区划

    private String year;     // 预算年度

    private String updatetime; // 数据修改时间

    // Getters and Setters
    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }
}
