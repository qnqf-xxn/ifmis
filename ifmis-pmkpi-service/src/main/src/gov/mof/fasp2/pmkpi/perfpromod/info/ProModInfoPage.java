package gov.mof.fasp2.pmkpi.perfpromod.info;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 17:41 2020/9/9  chongdayong
 */
public class ProModInfoPage extends PmkpiPage {
    /**
     * 基本信息
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map editInfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
