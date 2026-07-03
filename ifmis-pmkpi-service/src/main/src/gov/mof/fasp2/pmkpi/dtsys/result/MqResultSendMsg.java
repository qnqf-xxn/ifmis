package gov.mof.fasp2.pmkpi.dtsys.result;

import java.io.Serializable;

/**
 * @description:
 * @author: timor
 */

public class MqResultSendMsg<T> implements Serializable {
    public static final String OK = "000";
    public static final String ERROR = "001";
    public static final String OK_MESSAGE = "请求成功";
    public static final String ERROR_MESSAGE = "请求失败";

    /**
     * 返回code码
     */
    private String resultCode;
    /**
     * 返回结果信息
     */
    private String resultMessage;

    public MqResultSendMsg() {
    }

    public String getResultCode() {
        return resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    @Override
    public String toString() {
        return "resultCode=" + resultCode +
                ", resultMessage='" + resultMessage;
    }
}
