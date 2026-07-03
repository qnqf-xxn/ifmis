/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;



public class FundCalIndexService extends PmkpiService {
    /**
     * fundCalIndexBO.
     */
    private FundCalIndexBO fundCalIndexBO;
    /**
     * 注入bo.
     * @param fundCalIndexBO -- bo.
     * @throws
     */
    public void setFundCalIndexBO(FundCalIndexBO fundCalIndexBO) {
        this.fundCalIndexBO = fundCalIndexBO;
    }
    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String procode = request.getParameter("procode");
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isfundcal = request.getParameter("isfundcal");
        config.put("proguid", proguid);
        config.put("prolev", prolev);
        config.put("procode", procode);
        config.put("showtab", showtab);
        config.put("isfundcal", isfundcal);
        Map indexdata = new HashMap();
        indexdata.put("#year",new ArrayList<>());
        indexdata.put("#total",new ArrayList<>());
        config.put("indexdata", indexdata);
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        if (isprogramiframe == null ||isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        return config;
    }

    /**
     * @description:
     * @param: 查询项目指标集合
     * @return:  tabComps
     * @author: zhangxutao
     * @date: 2021/9/1 16:58
     */
    public Map<String, Object> findIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> tabComps = fundCalIndexBO.findYearIndexs(params);
        return tabComps;
    }
}
