package gov.mof.fasp2.pmkpi.perfself.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfApplyBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfApplyPage extends PmkpiPage {

    /**
     * 下达页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfApplyBO perfSelfApplyBO = (PerfSelfApplyBO) ServiceFactory.getBean("pmkpi.perfSelf.PerfSelfApplyBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfSelfApplyBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 编辑
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }

    /**
     * 项目基本信息
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map projinfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 资金使用情况.
     *
     * @param request  -- 请求
     * @param response -- 响应
     * @param config   -- 配置
     * @return
     * @throws Exception -- 异常
     */
    public Map selffund(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 资金使用情况.
     *
     * @param request  -- 请求.
     * @param response -- 响应
     * @param config   -- 配置.
     * @return
     * @throws Exception -- 自定义异常.
     */
    public Map payindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标完成情况
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map selfindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("menutype","perfmenu");
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 自评补充信息
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map selfdesc(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标完成情况(湖北)
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map hbindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }


    /**
     * 湖北项目支出绩效自评--绩效完成情况
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map hbgoalindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 评价基本信息
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map selfinfo (HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 资金管理情况.
     *
     * @param request  -- 请求.
     * @param response -- 响应
     * @param config   -- 配置.
     * @return
     * @throws Exception -- 自定义异常.
     */
    public Map fundmanag(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
