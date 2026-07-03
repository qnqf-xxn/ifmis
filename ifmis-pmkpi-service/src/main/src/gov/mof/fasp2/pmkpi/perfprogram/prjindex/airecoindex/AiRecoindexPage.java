/**
 * @Title: PrjIndexPage.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.prjindex.airecoindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;


/**
 * @ClassName: PrjIndexPage
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:40:42
 */

public class AiRecoindexPage extends PmkpiPage {
    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> pickpage(HttpServletRequest request, HttpServletResponse response,
                                        Map<String, Object> config) throws Exception {
        return config;
    }
}
