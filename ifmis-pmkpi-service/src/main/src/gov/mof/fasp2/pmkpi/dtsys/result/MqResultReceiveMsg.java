package gov.mof.fasp2.pmkpi.dtsys.result;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import net.sf.json.JSONObject;

import java.io.Serializable;

/**
 * @description:
 * @author: timor
 */
public class MqResultReceiveMsg<T> implements Serializable {
    /**
     * 报文编号
     */
    @JsonProperty( "DTG_CODE")
    private String DTG_CODE;
    /**
     * 区划
     */
    @JsonProperty( "MOF_DIV_CODE")
    private String MOF_DIV_CODE;
    /**
     * 年度
     */
    @JsonProperty( "FISCAL_YEAR")
    private String FISCAL_YEAR;
    /**
     * 预算单位，标识该接口数据属于哪个部门端系统
     */
    @JsonProperty( "AGENCY_CODE")
    private String AGENCY_CODE;
    /**
     * 业务标识
     */
    @JsonProperty( "BS_LOGO")
    private String BS_LOGO;
    /**
     * 业务数据
     */
    private T DATA;

    @JsonIgnore
    public String getDTG_CODE() {
        return DTG_CODE;
    }

    public void setDTG_CODE(String DTG_CODE) {
        this.DTG_CODE = DTG_CODE;
    }

    @JsonIgnore
    public String getMOF_DIV_CODE() {
        return MOF_DIV_CODE;
    }

    public void setMOF_DIV_CODE(String MOF_DIV_CODE) {
        this.MOF_DIV_CODE = MOF_DIV_CODE;
    }

    @JsonIgnore
    public String getFISCAL_YEAR() {
        return FISCAL_YEAR;
    }

    public void setFISCAL_YEAR(String FISCAL_YEAR) {
        this.FISCAL_YEAR = FISCAL_YEAR;
    }

    @JsonIgnore
    public String getAGENCY_CODE() {
        return AGENCY_CODE;
    }

    public void setAGENCY_CODE(String AGENCY_CODE) {
        this.AGENCY_CODE = AGENCY_CODE;
    }

    @JsonIgnore
    public String getBS_LOGO() {
        return BS_LOGO;
    }

    public void setBS_LOGO(String BS_LOGO) {
        this.BS_LOGO = BS_LOGO;
    }

    public T getDATA() {
        return DATA;
    }

    public void setDATA(T DATA) {
        this.DATA = DATA;
    }

    @Override
    public String toString() {
        return JSONObject.fromObject(this).toString();
//        return "MqResultReceiveMsg{" +
//                "DTG_CODE='" + DTG_CODE + '\'' +
//                ", MOF_DIV_CODE='" + MOF_DIV_CODE + '\'' +
//                ", FISCAL_YEAR='" + FISCAL_YEAR + '\'' +
//                ", AGENCY_CODE='" + AGENCY_CODE + '\'' +
//                ", BS_LOGO='" + BS_LOGO + '\'' +
//                ", DATA=" + data +
//                '}';
    }

    public MqResultReceiveMsg() {
    }
}
