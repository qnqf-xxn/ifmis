package gov.mof.fasp2.pmkpi.rectification.page;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationBO;
import gov.mof.fasp2.pmkpi.rectification.checkpro.RectificationCheckProjBO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class RectificationPage extends PmkpiPage {


    /**
     * 整改通知首页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", rectificationBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 整改通知审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map auditIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", rectificationBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 整改情况反馈
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map feedbackIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", rectificationBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 反馈信息填报
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map feedbackEdit(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        super.loadComponent(request, response, config);
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length >= 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }

    /**
     * 整改列表查询
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map queryIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", rectificationBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 页签(反馈信息详情)
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map feedbackInfo(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        config.put("menuid", menuId);
        //this.getHeadTitle(config,menuId);
        return config;
    }


    /**
     * 整改情况审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map feedbackAuditIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", rectificationBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }


    public Map rectifyAdd(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        super.loadComponent(request, response, config);
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length >= 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }

    /**
     * 项目基本信息
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map projinfo(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 整改通知详情
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map rectification(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        return config;
    }

    /**
     * 选择下发项目范围
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map selectPorj(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String tokenid=request.getParameter("tokenid");
        config.put("tokenid", tokenid);
        return config;
    }

    /**
     * 选择下发项目范围(通版)
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map selectPorjLeft(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationCheckProjBO rectificationCheckProjBO = (RectificationCheckProjBO) ServiceFactory.getBean("pmkpi.rectification.checkpro.RectificationCheckProjBOTX");
        String tokenid=request.getParameter("tokenid");
        String menuId = request.getParameter("menuId");
        String lefttabtype = request.getParameter("lefttabtype");
        request.setAttribute("leftconfig", rectificationCheckProjBO.getTreeData(lefttabtype));
        config.put("left", "lefttree");
        config.put("tokenid", tokenid);
        config.put("menuid", menuId);
        return config;
    }

    /**
     * 页签(财政重点评价反馈信息详情)
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map finfeedbackInfo(HttpServletRequest request, HttpServletResponse response,Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 单独的自评整改反馈详情页面
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * /pmkpi/rectification/program/edit.page
     * ?tokenid=2ABB1E119E395E6EEC48EFA9D6ABB0CDJ5veeOsl
     * &tablecode=V_PERF_PROJECT_INFO
     * &pro_code=?
     * &mainguid=?
     * &rectype=rectifyperfself
     * &bustype=1
     * &viewtype=query
     * @throws Exception
     */
    public Map<String, Object> selfrectProj(HttpServletRequest request, HttpServletResponse response,Map<String, Object> config) throws Exception {
        String pro_code = request.getParameter("pro_code");//项目编码
        String queryYear = request.getParameter("queryYear");//跨年查询查询年度
        String queryProvince = request.getParameter("queryProvince");//跨年查询查询区划
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        Map<String, Object> rec = rectificationBO.getRectificationByProcode(pro_code, queryYear, queryProvince);//通过项目code查询整改主数据
        List<Map<String, Object>> list = (List<Map<String, Object>>) rec.get("list");
        String mainguid = "";//自评价整改guid
        String finmainguid = "";//财政评价整改guid
        for (Map<String, Object> map : list) {
            String rectype = (String) map.get("rectype");
            if ("rectifyperfself".equals(rectype)) {
                mainguid = (String) map.get("guid");
            } else if ("rectifyfinancialeval".equals(rectype)) {
                finmainguid = (String) map.get("guid");
            }
        }
        String params = request.getQueryString();
        params += "&tablecode=V_PERF_PROJECT_INFO&rectype=rectifyperfself&bustype=1&viewtype=query";
        params += "&mainguid=" + mainguid + "&finmainguid=" + finmainguid;//查询不到项目整改主数据会拼null
        String domain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                + request.getContextPath() + request.getServletPath();
        response.sendRedirect(domain.replace("/pmkpi/rectification/selfpro","/pmkpi/rectification/programquery") + "?"+params);
        return config;
    }

    /**
     * 结果应用意见
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map resultopinionedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        String str = PerfUtil.getSystemSet("RECTIFYRESULTOPINION");
        Map<String, Object> mm = PerfUtil.parseString2Map(str);
        String isedit = mm.get("isedit") == null ? "" : (String) mm.get("isedit");
        String[] editrole = isedit.split(",");
        UserDTO user = SecureUtil.getCurrentUser();
        List roles = (List) user.get("roles");
        if (!Collections.disjoint(roles, Arrays.asList(editrole))) {
            config.put("viewtype", "mod"); //页面可编辑
        }else{
            config.put("viewtype", "query"); //页面不可编辑
        }
        return config;
    }

}


