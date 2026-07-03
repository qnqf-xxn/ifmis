package gov.mof.fasp2.pmkpi.doubleprocess.dpaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DoubleProcessPage extends PmkpiPage {

    /**
     * <p></p >
     *
     * @author hw
     * @date 2021/5/14 14:30
     * @param
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }

}
