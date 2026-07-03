package gov.mof.fasp2.pmkpi.appexception;

import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.Map;

public class PerfAppException extends AppException {
    private String code = null;
    private String msg = null;
    private Map remap = null;

    public PerfAppException(Exception e) {
        super(e);
    }

    public PerfAppException(String exceptionCode, String msg) {
        this.code = exceptionCode;
        this.msg = msg;
    }

    public PerfAppException(String exceptionCode, String msg, Map remap) {
        this.code = exceptionCode;
        this.msg = msg;
        this.remap = remap;
        setMessage(msg);
        setExceptionCode(exceptionCode);
        setRemap(remap);
    }

    public PerfAppException(String exceptionCode) {
        this.code = exceptionCode;
    }

    public Map setRemap(Map remap) {
        return this.remap = remap;
    }

    public void setExceptionCode(String exceptionCode) {
        this.code = exceptionCode;
    }

    public String getRealMessage() {
        return this.msg;
    }

    public String getCode() {
        return this.code;
    }

    public String getMessage() {
        return "hq-999".equals(this.code) ? this.code : this.code + "-" + this.msg;
    }

    public String getSuperMessage() {
        return super.getMessage();
    }

    public Map getRemap() {
        return this.remap;
    }
}
