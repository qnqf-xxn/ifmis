package gov.mof.fasp2.pmkpi.setting.impexpsub;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfTImpexpsubPage extends PmkpiPage {
    /**
     * 配置表需根据是否根据当前年度，当前区划来进行配置，当defprovince=1的时候默认当前区划，defyear=1的时候默认当前年度。
     * 当都为空的时候，查询的时候不根据province和year当条件来查询。
     * 单主键增加的时候则根据当前年度，当前区划来增加，更新删除的时候则以guid为主键更新删除，
     * 多主键增删改的时候，暂时分为了两种情况，第一种直接根据年度，区划，guid来更新删除增加，如果没有默认的年度，区划则直接是当前年度当前区划。
     * 第二种这是根据guid和配置表的删除delcols来确定，年度、区划也是根据有没有默认的年度区划来确定。当左侧树的code是年度和区划的其中一个，则用左侧树的code
     * 来覆盖年度、区划
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map<String,Object> index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        PerfTImpexpsubBO perfTImpexpsubBO = (PerfTImpexpsubBO) ServiceFactory.getBean("pmkpi.setting.impexpsub.PerfTImpexpsubBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", perfTImpexpsubBO.getLeftTree());
        config.put("leftcode","mainguid");
        config.put("lefttablecode","V_PERF_T_IMPEXPMAIN");
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
       return config;
    }

    /**
     * 编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editimpexp(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
