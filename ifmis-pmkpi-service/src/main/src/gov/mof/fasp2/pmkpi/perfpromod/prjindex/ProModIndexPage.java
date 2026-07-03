/**
 * @Title: PrjIndexPage.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfpromod.prjindex;

import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexPage
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:40:42
 */

public class ProModIndexPage extends PmkpiPage {
    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> index(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    /**
     * 精准推荐.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> cmpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        //leftconfig.put("name", "案例");
        List<DicRangeDTO> value = new ArrayList<DicRangeDTO>();
        leftconfig.put("datas", value);
        request.setAttribute("leftconfig", leftconfig);
        config.put("left", "lefttree");
        return config;
    }
    /**
     * 挑选指标.
     * @param request --请求
     * @param response --响应
     * @param config -- 配置
     * @return
     * @throws Exception
     * @throws
     */
    public Map<String, Object> pickpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    
    /**
     * 编辑指标.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置
     * @return
     * @throws Exception -- 异常。
     * @throws
     */
    public Map<String, Object> editpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
}
