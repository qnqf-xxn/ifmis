package gov.mof.fasp2.pmkpi.deptperformance.task;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptTaskPage extends PmkpiPage {

    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
