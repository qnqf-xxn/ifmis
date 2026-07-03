package gov.mof.fasp2.pmkpi.evaluation.financial.relation;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProRelationPage extends PmkpiPage {
    /**
     * <p>财政评价关联项目</p >
     *
     * @param
     * @author hw
     * @date 2022/3/31 14:41
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.remove("amtflag"); // 去除页签内金额万元切换
        return config;
    }

    /**
     * <p>选择关联项目列表</p >
     *
     * @param
     * @author hw
     * @date 2022/4/8 16:00
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProRelationBO proRelationBO = (ProRelationBO) PerfServiceFactory.getBean("pmkpi.financial.relation.ProRelationBOTX");
        String leftmenuid = request.getParameter("leftmenuid");
        request.setAttribute("leftconfig", proRelationBO.getTreeData(leftmenuid));
        config.put("left", "lefttree");
        return config;
    }

}
