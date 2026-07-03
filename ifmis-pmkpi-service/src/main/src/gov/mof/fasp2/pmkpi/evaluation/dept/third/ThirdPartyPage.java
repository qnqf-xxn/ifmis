package gov.mof.fasp2.pmkpi.evaluation.dept.third;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p></p >
 *
 * @author hw
 * @date 2022/12/6 15:32
 */
public class ThirdPartyPage extends PmkpiPage {

    /**
     * 编辑
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
