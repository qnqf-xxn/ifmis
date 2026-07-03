package gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class MidProgramPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        MidProgramBO midProgramBO  = (MidProgramBO) PerfServiceFactory.getBean("pmkpi.midperfprogram.MidProgramBOTX");
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        request.setAttribute("leftconfig", midProgramBO.getTreeData(menuId,prolev));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 指标新增页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map addindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    /**
     * 选择项目列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String saveAgency = request.getParameter("saveAgency");
        String nodeguid = request.getParameter("nodeguid");
        String bustype = request.getParameter("bustype");
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("nodeguid", nodeguid);
        config.put("bustype", bustype);
        return config;
    }
}
